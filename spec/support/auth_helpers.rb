def generate_test_token
  payload = { user_id: 1 }
  JwtService.encode(payload)
end
