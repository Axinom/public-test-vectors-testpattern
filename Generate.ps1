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

    # If a color is specified, we remove other colors from the mix.
    if ($color) {
        $colorSource = "[video] chromahold=color=$($color):similarity=0.2 [out]"

        $videoA = $videoA + " [video];" + $colorSource
        $videoB = $videoB + " [video];" + $colorSource
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

$redcolor = $redcolor
$greencolor = "limegreen"
$bluecolor = "blue"

# 360p

CreateTestPatterns "1m" (60) 30 640 360
CreateTestPatterns "1m_red" (60) 30 640 360 $redcolor
CreateTestPatterns "1m_green" (60) 30 640 360 $greencolor
CreateTestPatterns "1m_blue" (60) 30 640 360 $bluecolor

CreateTestPatterns "3h" (3 * 3600) 30 640 360
CreateTestPatterns "3h_red" (3 * 3600) 30 640 360 $redcolor
CreateTestPatterns "3h_green" (3 * 3600) 30 640 360 $greencolor
CreateTestPatterns "3h_blue" (3 * 3600) 30 640 360 $bluecolor

CreateTestPatterns "24h" (24 * 3600) 30 640 360
CreateTestPatterns "24h_red" (24 * 3600) 30 640 360 $redcolor
CreateTestPatterns "24h_green" (24 * 3600) 30 640 360 $greencolor
CreateTestPatterns "24h_blue" (24 * 3600) 30 640 360 $bluecolor

# 1080p

CreateTestPatterns "1m" (60) 30 1920 1080
CreateTestPatterns "1m_red" (60) 30 1920 1080 $redcolor
CreateTestPatterns "1m_green" (60) 30 1920 1080 $greencolor
CreateTestPatterns "1m_blue" (60) 30 1920 1080 $bluecolor

CreateTestPatterns "3h" (3 * 3600) 30 1920 1080
CreateTestPatterns "3h_red" (3 * 3600) 30 1920 1080 $redcolor
CreateTestPatterns "3h_green" (3 * 3600) 30 1920 1080 $greencolor
CreateTestPatterns "3h_blue" (3 * 3600) 30 1920 1080 $bluecolor

CreateTestPatterns "24h" (24 * 3600) 30 1920 1080
CreateTestPatterns "24h_red" (24 * 3600) 30 1920 1080 $redcolor
CreateTestPatterns "24h_green" (24 * 3600) 30 1920 1080 $greencolor
CreateTestPatterns "24h_blue" (24 * 3600) 30 1920 1080 $bluecolor

# We skip the 24h variants, because storage is cheap but not that cheap.
# 2160p

CreateTestPatterns "1m" (60) 30 3840 2160
CreateTestPatterns "1m_red" (60) 30 3840 2160 $redcolor
CreateTestPatterns "1m_green" (60) 30 3840 2160 $greencolor
CreateTestPatterns "1m_blue" (60) 30 3840 2160 $bluecolor

CreateTestPatterns "3h" (3 * 3600) 30 3840 2160
CreateTestPatterns "3h_red" (3 * 3600) 30 3840 2160 $redcolor
CreateTestPatterns "3h_green" (3 * 3600) 30 3840 2160 $greencolor
CreateTestPatterns "3h_blue" (3 * 3600) 30 3840 2160 $bluecolor