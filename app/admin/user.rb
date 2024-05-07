# app/admin/user.rb

ActiveAdmin.register User do
  permit_params :username, :email, :password, :password_confirmation, :role, :status

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :role
    column :status
    actions
  end

  filter :username
  filter :email
  filter :role
  filter :status

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :status
    end
    f.actions
  end
end
