From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 15:49:17 +0100
Subject: [LTP] [PATCH] change /test/aiodio to TMPDIR in
 runtest/ltp-aio-stress.partX
In-Reply-To: <563C3B3D.1060809@jp.fujitsu.com>
References: <563C3B3D.1060809@jp.fujitsu.com>
Message-ID: <20151110144916.GI23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The changes looks good but the patch is corrupted and could not be
applied.

> +ADS1048 aio-stress -I500  -o1 -O -r64   -t8   $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
> +ADS1049 aio-stress -I500  -o1 -O -r128  -t8   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
> +ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMPDIR/junkfile $TMPDIR/file2

Here we miss the three lines of unchanged content. Have you modified the
patch by hand?

> diff --git a/runtest/ltp-aio-stress.part2 b/runtest/ltp-aio-stress.part2
> index 92b501c..d72f538 100644
> --- a/runtest/ltp-aio-stress.part2
> +++ b/runtest/ltp-aio-stress.part2
> @@ -2,7 +2,7 @@
>  #
>  # aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
>  #                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
> -#                 file1 [/test/aiodio/file2 ...]
> +#                 file1 [file2 ...]
>  #       -a size in KB at which to align buffers
>  #       -b max number of iocbs to give io_submit at once
>  #       -c number of io contexts per file
> @@ -26,13 +26,13 @@
>  #       -x turn off thread stonewalling
>  #       -h this message
>  #
> -ADS2001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
> -ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
> -ADS2006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
> -ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
> -ADS2010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
> +ADS2001 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2002 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2003 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2004 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
> +ADS2005 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
> +ADS2006 aio-stress -I500  -o2 -O -r32  -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2007 aio-stress -I500  -o3 -O -r8   -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2008 aio-stress -I500  -o3 -O -r16  -t2  $TMPDIR/junkfile $TMPDIR2/file2
> +ADS2009 aio-stress -I500  -o3 -O -r32  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4
> +ADS2010 aio-stress -I500  -o3 -O -r64  -t4  $TMPDIR/junkfile $TMPDIR2/file2 $TMPDIR/file3 $TMPDIR2/file4

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
