object SampleUILPlugin: TSampleUILPlugin
  OldCreateOrder = False
  Author = 'Tim Sullivan XE8'
  Commands = <>
  Description = 
    'Sample Plugin One: A simple plugin with 3 commands. It will also' +
    ' respond (simply) to messages.'
  Copyright = '(c) 1999, Unlimited Intelligence Limited'
  PluginID = 'UIL.Sample Plugin One'
  PluginVersion = '2.0'
  OnPluginMessage = uilPlugin1PluginMessage
  OnConfigure = uilPlugin1Configure
  Height = 150
  Width = 215
end
