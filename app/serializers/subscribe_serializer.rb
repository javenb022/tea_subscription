class SubscribeSerializer
  include JSONAPI::Serializer
  set_type :subscription
  attributes :title, :price, :frequency, :status

  def self.serialize(sub, tea)
    {
      data: {
        id: sub.id,
        type: "subscription",
        attributes: {
          title: sub.title,
          price: sub.price,
          frequency: sub.frequency,
          status: sub.status,
        },
        tea_info: {
          tea_id: tea.id,
          tea_title: tea.title,
          tea_description: tea.description,
          tea_temperature: tea.temperature,
          tea_brew_time: tea.brew_time
        }
      }
    }
  end
end