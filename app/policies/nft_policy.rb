class NftPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  private

  def is_owner?
    user && user == record.user
  end
end
