Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDsfJ-0005A4-TQ
	for ltp-list@lists.sourceforge.net; Wed, 21 Jan 2015 10:37:37 +0000
Date: Wed, 21 Jan 2015 11:36:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150121103640.GA23155@rei>
References: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
	<20150120144403.GC15452@rei>
	<1705158126.11277852.1421766771922.JavaMail.zimbra@redhat.com>
	<54BF77F1.4050007@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54BF77F1.4050007@redhat.com>
Subject: Re: [LTP] [PATCH] runltp: export initialized LTP_DEV
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, liwan@redhat.com

Hi!
> So, it looks like this is not bug after all, but udev rule that keeps
> firing "blkid":
> 
> /lib/udev/rules.d/60-persistent-storage.rules:84
>   KERNEL!="xvd*|sr*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
>     /sbin/blkid -o udev -p /dev/loop0
> 
> If attach/detach happens too quickly, blkid might still hold reference
> and loop_clr_fd() then complains with EBUSY:
>         if (lo->lo_refcnt > 1)  /* we needed one fd for the ioctl */
>                 return -EBUSY;
>
> The only idea I have is to sleep/retry for a short period - see attached patch.

Sounds reasonable to me.

I'm thinking of fixing the umount problem with the gvfsd-trash the same
way.

> From 0ae0f16500cc48795287076edb2b725025466a0f Mon Sep 17 00:00:00 2001
> Message-Id: <0ae0f16500cc48795287076edb2b725025466a0f.1421834144.git.jstancek@redhat.com>
> From: Jan Stancek <jstancek@redhat.com>
> Date: Tue, 20 Jan 2015 14:35:49 +0100
> Subject: [PATCH] tst_device: sleep/retry if LOOP_CLR_FD fails with EBUSY
> 
> Rapid succession of device attach/detach may lead to EBUSY
> from ioctl(LOOP_CLR_FD), because udev rules might still be
> running.
> 
> Sleep/retry for a short period if LOOP_CLR_FD fails with EBUSY.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_device.c |   25 ++++++++++++++++++-------
>  1 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 6dff1ba..edf0bb4 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -144,19 +144,30 @@ static void attach_device(void (*cleanup_fn)(void),
>  
>  static void detach_device(void (*cleanup_fn)(void), const char *dev)
>  {
> -	int dev_fd, err;
> +	int dev_fd, err, i;
>  
>  	dev_fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
>  
> -	if (ioctl(dev_fd, LOOP_CLR_FD, 0) < 0) {
> -		err = errno;
> -		close(dev_fd);
> -		tst_brkm(TBROK, cleanup_fn,
> -		         "ioctl(%s, LOOP_CLR_FD, 0) failed: %s",
> -			 dev, tst_strerrno(err));
> +	/* keep trying to clear LOOPDEV fd if EBUSY, a quick succession
> +	 * of attach/detach might not give udev enough time to complete */
> +	for (i = 0; i < 40; i++) {
> +		if (ioctl(dev_fd, LOOP_CLR_FD, 0) == 0) {
> +			close(dev_fd);
> +			return;
> +		}
> +		if (errno != EBUSY) {
> +			err = errno;
> +			close(dev_fd);
> +			tst_brkm(TBROK, cleanup_fn,
> +				"ioctl(%s, LOOP_CLR_FD, 0) failed: %s",
> +				dev, tst_strerrno(err));
> +		}
> +		usleep(50000);
>  	}
>  
>  	close(dev_fd);
> +	tst_brkm(TBROK, cleanup_fn,
> +		"ioctl(%s, LOOP_CLR_FD, 0) EBUSY for too long",	dev);
>  }

Looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
