class CashDispenserFacade
  def self.nearby_atms(lat, lon)
    details = TomTomService.cash_dispensers(lat,lon)[:results]
    details.map do |detail|
      Atm.new(detail)
    end
  end
end
