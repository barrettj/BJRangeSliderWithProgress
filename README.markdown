# Summary
A "progress bar" that also allows you to select a range.

I use it to indicate progress of recording audio, represent trimming it, and then playing back only the selected range.

# Screenshot
![](https://github.com/barrettj/BJRangeSliderWithProgress/blob/master/screenshot.png?raw=true) 


# Quick Tips
To be notified when either slider changes, register for UIControlEventValueChanged:
`[mySlider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];`

# License
MIT License

If you use it, I'd love to hear from you: @barrettjacosbsen


