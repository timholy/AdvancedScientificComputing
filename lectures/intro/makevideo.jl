using VideoIO
using NRRD
using FileIO
using ImageCore
using AxisArrays: Axis

mov = openvideo(joinpath("videos", "Nature Beautiful short video 720p HD.mp4"))
nframes = counttotalframes(mov)
img = read(mov)   # get one frame so we know what we're writing

# Create the header file (.nhdr)
axyx = map((:y, :x), axes(img)) do name, ax
    Axis{name}(ax)
end
axt = Axis{:time}(Base.OneTo(nframes))
header = NRRD.headerinfo(eltype(img), (axyx..., axt))
header["datafile"] = "nature.raw"
open(joinpath("videos", "nature.nhdr"), "w") do io
    write(io, magic(format"NRRD"))
    NRRD.write_header(io, "0004", header)
end

# Write the raw data
open(joinpath("videos", "nature.raw"), "w") do io
    write(io, rawview(channelview(img)))
    for i = 2:nframes
        write(io, rawview(channelview(read(mov))))
    end
end
