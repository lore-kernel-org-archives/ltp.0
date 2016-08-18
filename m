From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Aug 2016 19:08:22 +0800
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160817111841.GA10343@rei.lan>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan> <20160815092508.GB22440@gmail.com>
 <20160815123959.GD20680@rei.lan> <20160816032416.GA28657@gmail.com>
 <20160816121552.GC25092@rei.lan> <20160817033946.GA6430@gmail.com>
 <20160817111841.GA10343@rei.lan>
Message-ID: <20160818110822.GA12076@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 17, 2016 at 01:18:41PM +0200, Cyril Hrubis wrote:
> Hi!
> > > Now that makes sense.
> > > 
> > > But if that is the case we still have to align down the device size to
> > > the page size at the start of the test. Since the device can also be
> > > passed down to the runltp script as a parameter and we cannot make any
> > > assumptions about its size.
> > 
> > Hmm, yes, we have to face the problem.
> > 
> > A simple idea comes to my mind is that the loop device size should be
> > customized by specific testcase(mkswap01.sh).
> > 
> > That would be happy if function "tst_acquire_device() 'NUM'" can get
> > 'NUM' MB block device for testing.
> > 
> > It means we have to modify another path which about tst_acquire_device().
> 
> This is a bad idea for two reasons.
> 
> Fist one is that the reason the user passed block device to runltp may
> be that the kernel does not support loop devices. In this case the test
> would be skipped for no good reason.
> 
> The second is that there is another patch in flight that aims to add
> minimal size parameter to the tst_acquire_device(). Which is much more
> useful.
> 
> Why cannot we just simply take the size of the device at start of the
> test, align it down to be the multiple of $PAGE_SIZE and use that as the
> size for testing?

Ok, this sounds better. I misunderstand you point at first.

As this we can get the right(aligned) size of the device by add:

# cat mkswap01.sh
...
setup()
{
	...

	# Here get the size of the device and align it down to be the
	# multiple of $PAGE_SIZE and use that as the size for testing.
	device_real=`blockdev --getsize64 $TST_DEVICE`
	device_resi=$((${device_real} % ${PAGE_SIZE}))

	DEVICE_SIZE=$(((${device_real} - ${device_resi})/1024))
}

Am I right now?

Regards,
Li Wang
