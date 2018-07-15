module PolicyManager
  module UserTermsConcern

    extend ActiveSupport::Concern

    def handle_term_accept
      if current_user
        @user_term = current_user.handle_policy_for(@term)
        if @user_term.accept!
          @term.rule.on_accept.call(self) if @term.rule.on_accept.is_a?(Proc)
        end
      end

      cookies["policy_rule_#{@term.rule.name}"] = {
          :value => "accepted",
          :expires => 1.year.from_now
      }
    end

    def handle_term_reject
      if current_user
        @user_term = current_user.handle_policy_for(@term)
        if @user_term.reject!
          @term.rule.on_reject.call(self) if @term.rule.on_reject.is_a?(Proc)
        end
      end

      cookies.delete("policy_rule_#{@term.rule.name}")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user_term
      @category = PolicyManager::Config.rules.find{|o| o.name == params[:id]}
      @term = @category.terms.last
    end


  end
end
