Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VgsrU-0002Se-Ct
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 09:05:16 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VgsrS-0006Zp-So
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 09:05:16 +0000
Date: Thu, 14 Nov 2013 04:05:07 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1211202783.31243222.1384419907160.JavaMail.root@redhat.com>
In-Reply-To: <1384411077-26013-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20131113175008.GE12406@rei.Home>
	<1384411077-26013-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3 2/2] tst_checkpoint_signal_child:
	implemented	timeout
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Thursday, 14 November, 2013 7:37:57 AM
> Subject: [LTP] [PATCH V3 2/2] tst_checkpoint_signal_child: implemented	timeout
> 
> If a child exits before opening TST_CHECKPOINT_FIFO
> for reading, tst_checkpoint_signal_child() issued from the parent
> will block forever.
> 
> To handle such situations added timeout logic to
> tst_checkpoint_signal_child();
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

One small nit: the comment should say ">= 0", other than that, it looks good to me:
Reviewed-by: Jan Stancek <jstancek@redhat.com>

I'm sending a follow-up patch (tst_checkpoint_child_exits2), which I used to verify this one.

Regards,
Jan

> ---
>  lib/tst_checkpoint.c |   36 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 56c86b5..e53c499 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -33,6 +33,40 @@
>  
>  #include "tst_checkpoint.h"
>  
> +/*
> + * Issue open() on 'path' fifo with O_WRONLY flag and wait for
> + * a reader up to 'timeout' ms.
> + *
> + * Returns:
> + *   > 0 - file descriptor
> + *   -1  - an error has occurred (errno is set accordingly)
> + *
> + */
> +int open_wronly_timed(const char *path, unsigned int timeout)
> +{
> +	int fd;
> +	int i;
> +	int interval = 1; /* how often issue open(O_NONBLOCK), in ms */
> +
> +	for (i = 0; i < timeout; i += interval) {
> +		fd = open(path, O_WRONLY | O_NONBLOCK);
> +		if (fd < 0) {
> +			if ((errno == ENXIO) || (errno == EINTR)) {
> +				usleep(interval * 1000);
> +
> +				continue;
> +			}
> +
> +			return -1;
> +		}
> +
> +		return fd;
> +	}
> +
> +	errno = ETIMEDOUT;
> +	return -1;
> +}
> +
>  void tst_checkpoint_init(const char *file, const int lineno,
>                           struct tst_checkpoint *self)
>  {
> @@ -195,7 +229,7 @@ void tst_checkpoint_signal_child(const char *file, const
> int lineno,
>  {
>  	int ret, fd;
>  	
> -	fd = open(TST_CHECKPOINT_FIFO, O_WRONLY);
> +	fd = open_wronly_timed(TST_CHECKPOINT_FIFO, self->timeout);
>  
>  	if (fd < 0) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
> OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
> Free app hosting. Or install the open source package on any LAMP server.
> Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
> http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
