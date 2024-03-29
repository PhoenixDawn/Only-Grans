class ListingPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.has_role?(:grandma)
  end

  def new?
    create?
  end

  def update?
    @record.user_id == @user.id
  end

  def edit?
    update?
  end

  def destroy?
    @record.user_id == @user.id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
