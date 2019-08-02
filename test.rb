def find_for_oauth(auth, current_user)
  if current_user.nil?
    user = User.new(name: auth.info.name, email: email ? auth.info.email : "#{auth.uid}@#{auth.provider}.com", password: Devise.friendly_token[0, 20])
    user.save!

    return user
  end

  # 이미 있는 계정인지 확인한다.
  email = auth.info.email
  user = User.where(:email => email).first unless self.where(email: auth.info.email).exists?

  user
end