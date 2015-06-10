Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2cxD-0002WE-Lw
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:09:51 +0000
Date: Wed, 10 Jun 2015 12:08:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150610100845.GA31366@rei.suse.de>
References: <1433923871-10933-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433923871-10933-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] detach_device: Wait until the kernel frees the
 loop device
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  lib/tst_device.c |   17 ++++++-----------
>  1 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 3bded53..9a92fc8 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -150,30 +150,25 @@ static void attach_device(void (*cleanup_fn)(void),
>  
>  static void detach_device(void (*cleanup_fn)(void), const char *dev)
>  {
> -	int dev_fd, err, i;
> +	int dev_fd, ret, i;
>  
>  	dev_fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
>  
> -	/* keep trying to clear LOOPDEV fd if EBUSY, a quick succession
> +	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
>  	 * of attach/detach might not give udev enough time to complete */
>  	for (i = 0; i < 40; i++) {
> -		if (ioctl(dev_fd, LOOP_CLR_FD, 0) == 0) {
> +		ret = ioctl(dev_fd, LOOP_CLR_FD, 0);
> +
> +		if (ret && (errno == ENXIO)) {
>  			close(dev_fd);
>  			return;
>  		}
> -		if (errno != EBUSY) {
> -			err = errno;
> -			close(dev_fd);
> -			tst_brkm(TBROK, cleanup_fn,
> -				"ioctl(%s, LOOP_CLR_FD, 0) failed: %s",
> -				dev, tst_strerrno(err));
> -		}

I would be a bit more verbose and would print an TINFO or TWARN message
if we get error different from the expected EBUSY or ENXIO.

Otherwise it looks fine, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
