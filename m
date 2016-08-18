From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 13:33:39 +0200
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160818110822.GA12076@gmail.com>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan> <20160815092508.GB22440@gmail.com>
 <20160815123959.GD20680@rei.lan> <20160816032416.GA28657@gmail.com>
 <20160816121552.GC25092@rei.lan> <20160817033946.GA6430@gmail.com>
 <20160817111841.GA10343@rei.lan> <20160818110822.GA12076@gmail.com>
Message-ID: <20160818113339.GD24254@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Ok, this sounds better. I misunderstand you point at first.
> 
> As this we can get the right(aligned) size of the device by add:
> 
> # cat mkswap01.sh
> ...
> setup()
> {
> 	...
> 
> 	# Here get the size of the device and align it down to be the
> 	# multiple of $PAGE_SIZE and use that as the size for testing.
> 	device_real=`blockdev --getsize64 $TST_DEVICE`
> 	device_resi=$((${device_real} % ${PAGE_SIZE}))
> 
> 	DEVICE_SIZE=$(((${device_real} - ${device_resi})/1024))

You can also use and integer division, which is a bit shorter:

DEVICE_SIZE=$((($real_size/$PAGE_SIZE * $PAGE_SIZE)/1024))

-- 
Cyril Hrubis
chrubis@suse.cz
