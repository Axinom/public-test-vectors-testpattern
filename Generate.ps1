$ErrorActionPreference = "Stop"

# Audio does a little ladder from 90 to 240 Hz, moving up by 30 Hz every 1s and looping every 5s.
$volume = "0.1"
$carrierFreq = "(90+mod(floor(t), 5)*30)"
$channelSweepFreq = "60"

$leftAudio = "$volume*sin(2*PI*($carrierFreq-$channelSweepFreq/2)*t)"
$rightAudio = "$volume*sin(2*PI*($carrierFreq+$channelSweepFreq/2)*t)"

function CreateTestPatterns($namePrefix, $durationSeconds, $fps, $width, $height, $color) {
    # Video is some test pattern type of thing from FFmpeg
    $videoA = "testsrc2=r=$($fps):s=$($width)x$($height)"
    $videoB = "testsrc=r=$($fps):s=$($width)x$($height):n=3"

    $outA = "$($namePrefix)_TestPatternA_$($fps)fps_$($height)p.mp4"
    $outB = "$($namePrefix)_TestPatternB_$($fps)fps_$($height)p.mp4"

    # If a color is specified, we create an overlay in the given color to uniquely identify a variant of the test pattern.
    if ($color) {
        $colorOpacity = "0.6"
        $colorSource = "color=color=$($color)@$($colorOpacity):r=$($fps):s=$($width)x$($height) [color]"

        $merge = "[video][color] overlay [out]"

        $videoA = $videoA + " [video];" + $colorSource + ";" + $merge
        $videoB = $videoB + " [video];" + $colorSource + ";" + $merge
    }

    ffmpeg -f lavfi -i "aevalsrc='$($leftAudio) | $($rightAudio):s=48000'" -f lavfi -i "$videoA" -pix_fmt yuv420p -acodec aac -ab 64k -t $durationSeconds -vcodec libx264 -tune animation $outA
    if ($LASTEXITCODE -ne 0){
        Write-Error "Failed with exit code $LASTEXITCODE"
    }

    ffmpeg -f lavfi -i "aevalsrc='$($leftAudio) | $($rightAudio):s=48000'" -f lavfi -i "$videoB" -pix_fmt yuv420p -acodec aac -ab 64k -t $durationSeconds -vcodec libx264 -tune animation $outB
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed with exit code $LASTEXITCODE"
    }
}

# 360p

CreateTestPatterns "1m" (60) 30 640 360
CreateTestPatterns "1m_red" (60) 30 640 360 "red"
CreateTestPatterns "1m_green" (60) 30 640 360 "green"
CreateTestPatterns "1m_blue" (60) 30 640 360 "blue"

CreateTestPatterns "1h" (3600) 30 640 360
CreateTestPatterns "1h_red" (3600) 30 640 360 "red"
CreateTestPatterns "1h_green" (3600) 30 640 360 "green"
CreateTestPatterns "1h_blue" (3600) 30 640 360 "blue"

CreateTestPatterns "3h" (3 * 3600) 30 640 360
CreateTestPatterns "3h_red" (3 * 3600) 30 640 360 "red"
CreateTestPatterns "3h_green" (3 * 3600) 30 640 360 "green"
CreateTestPatterns "3h_blue" (3 * 3600) 30 640 360 "blue"

CreateTestPatterns "24h" (24 * 3600) 30 640 360
CreateTestPatterns "24h_red" (24 * 3600) 30 640 360 "red"
CreateTestPatterns "24h_green" (24 * 3600) 30 640 360 "green"
CreateTestPatterns "24h_blue" (24 * 3600) 30 640 360 "blue"

# 1080p

CreateTestPatterns "1m" (60) 30 1920 1080
CreateTestPatterns "1m_red" (60) 30 1920 1080 "red"
CreateTestPatterns "1m_green" (60) 30 1920 1080 "green"
CreateTestPatterns "1m_blue" (60) 30 1920 1080 "blue"

CreateTestPatterns "1h" (3600) 30 1920 1080
CreateTestPatterns "1h_red" (3600) 30 1920 1080 "red"
CreateTestPatterns "1h_green" (3600) 30 1920 1080 "green"
CreateTestPatterns "1h_blue" (3600) 30 1920 1080 "blue"

CreateTestPatterns "3h" (3 * 3600) 30 1920 1080
CreateTestPatterns "3h_red" (3 * 3600) 30 1920 1080 "red"
CreateTestPatterns "3h_green" (3 * 3600) 30 1920 1080 "green"
CreateTestPatterns "3h_blue" (3 * 3600) 30 1920 1080 "blue"

CreateTestPatterns "24h" (24 * 3600) 30 1920 1080
CreateTestPatterns "24h_red" (24 * 3600) 30 1920 1080 "red"
CreateTestPatterns "24h_green" (24 * 3600) 30 1920 1080 "green"
CreateTestPatterns "24h_blue" (24 * 3600) 30 1920 1080 "blue"

# We skip the 24h variants, because storage is cheap but not that cheap.
# 2160p

CreateTestPatterns "1m" (60) 30 3840 2160
CreateTestPatterns "1m_red" (60) 30 3840 2160 "red"
CreateTestPatterns "1m_green" (60) 30 3840 2160 "green"
CreateTestPatterns "1m_blue" (60) 30 3840 2160 "blue"

CreateTestPatterns "1h" (3600) 30 3840 2160
CreateTestPatterns "1h_red" (3600) 30 3840 2160 "red"
CreateTestPatterns "1h_green" (3600) 30 3840 2160 "green"
CreateTestPatterns "1h_blue" (3600) 30 3840 2160 "blue"

CreateTestPatterns "3h" (3 * 3600) 30 3840 2160
CreateTestPatterns "3h_red" (3 * 3600) 30 3840 2160 "red"
CreateTestPatterns "3h_green" (3 * 3600) 30 3840 2160 "green"
CreateTestPatterns "3h_blue" (3 * 3600) 30 3840 2160 "blue"