From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 15:50:38 +0100
Subject: [LTP] [PATCH] change /test/aiodio to TMPDIR in
 runtest/ltp-aio-stress.partX
In-Reply-To: <20151110144916.GI23947@rei>
References: <563C3B3D.1060809@jp.fujitsu.com>
 <20151110144916.GI23947@rei>
Message-ID: <20151110145037.GJ23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The changes looks good but the patch is corrupted and could not be
> applied.
> 
> > +ADS1048 aio-stress -I500  -o1 -O -r64   -t8   $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
> > +ADS1049 aio-stress -I500  -o1 -O -r128  -t8   $TMPDIR/junkfile $TMPDIR/file2        $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
> > +ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMPDIR/junkfile $TMPDIR/file2
> 
> Here we miss the three lines of unchanged content. Have you modified the
> patch by hand?

Hmm, the file ends here. Then I have no idea why it couldn't be applied.
:(

-- 
Cyril Hrubis
chrubis@suse.cz
