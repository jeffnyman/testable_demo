def countdown_has_finished(page)
  t1 = Time.now
  duration = perform_countdown(page)
  t2 = Time.now
  expect((t2 - t1).round).to eq(duration.to_i)
end

def perform_countdown(page)
  time_left = page.timer_value.value

  (time_left.to_i + 1).downto(1) do |n|
    puts n.to_s.yellow
    sleep 1
  end
end
