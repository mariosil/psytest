# Inspired on Bootstrap. Simulates the way as Bootstrap sets the elements width
# using an structure of 12 columns distributed horizontally in all screen width.

class Slotstrap
  @cols_size = 0

  def initialize(slot)
    @cols_size = slot.width / 12
  end

  def col_12
    @cols_size * 12
  end
  def col_11
    @cols_size * 11
  end
  def col_10
    @cols_size * 10
  end
  def col_9
    @cols_size * 9
  end
  def col_8
    @cols_size * 8
  end
  def col_7
    @cols_size * 7
  end
  def col_6
    @cols_size * 6
  end
  def col_5
    @cols_size * 5
  end
  def col_4
    @cols_size * 4
  end
  def col_3
    @cols_size * 3
  end
  def col_2
    @cols_size * 2
  end
  def col_1
    @cols_size * 1
  end
end
