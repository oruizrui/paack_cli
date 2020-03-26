class DataScience::Mean < Mutations::Command

  required do
    array :numbers, class: Numeric, min_length: 1
  end

  def execute
    (numbers_sumed.to_f / numbers_count)
  end

  private

  def numbers_count
    numbers.count
  end

  def numbers_sumed
    numbers.sum()
  end
end
