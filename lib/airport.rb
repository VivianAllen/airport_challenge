require_relative 'plane.rb'
require_relative 'weather.rb'

class Airport

  DEFAULT_CAPACITY = 5

  def initialize
    @parked_planes = []
    @plane_capacity = DEFAULT_CAPACITY
  end

  def land(plane, weather)
    fail 'Weather is too stormy to land!' unless clear_weather?(weather)
    fail 'Airport cannot land any more planes at present!' if full?
    plane.land(self)
  end

  def takeoff(plane, weather)
    fail 'Weather is too stormy to take off!' unless clear_weather?(weather)
    plane.takeoff(self)
  end

  def park_plane(plane)
    @parked_planes.push(plane) if plane.parked
  end

  def confirm_arrived(plane)
    @parked_planes.include?(plane)
  end

  def launch_plane(plane)
    @parked_planes.delete_at(find_plane(plane)) if plane.parked
  end

  def confirm_departure(plane)
    !confirm_arrived(plane)
  end

  def override_capacity(new_capacity)
    @plane_capacity = new_capacity
  end

  private

  def find_plane(plane)
    @parked_planes.index(plane)
  end

  def clear_weather?(weather)
    weather.report == :clear
  end

  def full?
    @parked_planes.count >= @plane_capacity
  end

end
