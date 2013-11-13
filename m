Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VgW5d-0004hG-7G
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 08:46:21 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VgW5b-0002JI-R1
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 08:46:21 +0000
Date: Wed, 13 Nov 2013 03:46:12 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2000015083.30028001.1384332372741.JavaMail.root@redhat.com>
In-Reply-To: <1384329162-8128-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20131107113029.GB28246@rei>
	<1384329162-8128-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [RFC PATCH] tst_checkpoint_signal_child: implemented
 timeout
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
> Sent: Wednesday, 13 November, 2013 8:52:42 AM
> Subject: [LTP] [RFC PATCH] tst_checkpoint_signal_child: implemented timeout
> 
> If a child exits before opening TST_CHECKPOINT_FIFO
> for reading, tst_checkpoint_signal_child() issued from the parent
> will block forever.
> 
> To handle such situations added timeout logic to
> tst_checkpoint_signal_child();
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  lib/tst_checkpoint.c |   56
>  ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 54 insertions(+), 2 deletions(-)

Hi,

I would go with just 2 return values:
  -1 - for error/timeout
  fd - otherwise

fd == 0 is a valid descriptor
we can tell if it was timeout or error by errno code 

Why do we need "saved_errno"?

Regards,
Jan

> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 56c86b5..a7936da 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -30,9 +30,54 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <poll.h>
> +#include <time.h>
>  
>  #include "tst_checkpoint.h"
>  
> +/*
> + * Issue open() on 'path' fifo with O_WRONLY flag and wait for
> + * a reader up to 'timeout' ms.
> + *
> + * Returns:
> + *   0   - timeout has happened
> + *   > 0 - file descriptor
> + *   -1  - an error has occurred (errno is set accordingly)
> + *
> + */
> +int open_wronly_timed(const char *path, unsigned int timeout)
> +{
> +	int fd;
> +	int interval_ms = 1; /* how often issue open(O_NONBLOCK) */
> +	long timeleft = timeout;
> +	int saved_errno = errno;
> +
> +	struct timespec interval;
> +	interval.tv_sec = 0;
> +	interval.tv_nsec = interval_ms * 1000000; /* in ns */
> +
> +	for (;;) {
> +		fd = open(path, O_WRONLY | O_NONBLOCK);
> +		if (fd < 0) {
> +			if ((errno == ENXIO) || (errno == EINTR)) {
> +				if (timeleft <= 0) {
> +					errno = saved_errno;
> +
> +				return 0;
> +				}
> +
> +				timeleft -= interval_ms;
> +				nanosleep(&interval, NULL);
> +
> +				continue;
> +			}
> +
> +			return -1;
> +		}
> +
> +		return fd;
> +	}
> +}
> +
>  void tst_checkpoint_init(const char *file, const int lineno,
>                           struct tst_checkpoint *self)
>  {
> @@ -195,12 +240,19 @@ void tst_checkpoint_signal_child(const char *file,
> const int lineno,
>  {
>  	int ret, fd;
>  	
> -	fd = open(TST_CHECKPOINT_FIFO, O_WRONLY);
> +	fd = open_wronly_timed(TST_CHECKPOINT_FIFO, self->timeout);
>  
> -	if (fd < 0) {
> +	switch (fd) {
> +	case 0:
> +		tst_brkm(TBROK, cleanup_fn,
> +			"Checkpoint timeouted after %u msecs at %s:%d",
> +			self->timeout, file, lineno);
> +	break;
> +	case -1:
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "Failed to open fifo '%s' at %s:%d",
>  		         TST_CHECKPOINT_FIFO, file, lineno);
> +	break;
>  	}
>  
>  	ret = write(fd, "p", 1);
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
