# frozen_string_literal: true

module Db
  class OrganizationsController < Db::ApplicationController
    permits :name, :name_kana, :url, :wikipedia_url, :twitter_username

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index(page: nil)
      @organizations = Organization.order(id: :desc).page(page)
    end

    def new
      @organization = Organization.new
      authorize @organization, :new?
    end

    def create(organization)
      @organization = Organization.new(organization)
      authorize @organization, :create?

      if @organization.save_and_create_db_activity(current_user, "organizations.create")
        redirect_to edit_db_organization_path(@organization), notice: "登録しました"
      else
        render :new
      end
    end

    def edit(id)
      @organization = Organization.find(id)
      authorize @organization, :edit?
    end

    def update(id, organization)
      @organization = Organization.find(id)
      authorize @organization, :update?

      @organization.attributes = organization
      if @organization.save_and_create_db_activity(current_user, "organizations.update")
        redirect_to edit_db_organization_path(@organization), notice: "更新しました"
      else
        render :edit
      end
    end

    def hide(id)
      @organization = Organization.find(id)
      authorize @organization, :hide?

      @organization.hide!

      redirect_to :back, notice: "非公開にしました"
    end

    def destroy(id)
      @organization = Organization.find(id)
      authorize @organization, :destroy?

      @organization.destroy

      redirect_to :back, notice: "削除しました"
    end
  end
end
