module ApplicationHelper
  def textbox_classes
    'bg-white w-full px-3 py-1 border-gray-300 border-2 rounded focus:outline-none focus:border-blue-300'
  end

  def button_classes(**options)
    color = options.fetch(:color, 'blue')
    additional_classes = options.fetch(:class, '')

    "bg-#{color}-500 hover:bg-#{color}-600 cursor-pointer text-white font-bold px-4 py-2 rounded #{additional_classes}"
  end
end
