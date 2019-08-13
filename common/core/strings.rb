class String
  def is(value)
    expect(self.to_f).to eq(value.to_f)
  end

  def is_displayed_as(value)
    expect(self.to_s).to eq(value.to_s)
  end

  def is_roughly(value, threshold=1.9)
    expect(self.to_i).to be_within(threshold).of(value)
  end

  def as_list
    self.gsub("\n", "\n\n")
  end

  def as_element
    tr(' ', '_')
  end
end
