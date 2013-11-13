Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgea6-0001k5-5t
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 17:50:22 +0000
Date: Wed, 13 Nov 2013 18:50:08 +0100
From: chrubis@suse.cz
Message-ID: <20131113175008.GE12406@rei.Home>
References: <52833F4F.7090303@oracle.com>
	<1384334113-11205-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384334113-11205-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC PATCH V2] tst_checkpoint_signal_child: implemented
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> If a child exits before opening TST_CHECKPOINT_FIFO
> for reading, tst_checkpoint_signal_child() issued from the parent
> will block forever.
> 
> To handle such situations added timeout logic to tst_checkpoint_signal_child();
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  lib/tst_checkpoint.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 56c86b5..842ac74 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -30,9 +30,52 @@
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
> + *   > 0 - file descriptor
> + *   -1  - an error has occurred (errno is set accordingly)
> + *
> + */
> +int open_wronly_timed(const char *path, unsigned int timeout)
> +{
> +	int fd;
> +	int interval_ms = 1; /* how often issue open(O_NONBLOCK) */
> +	long timeleft = timeout;
> +
> +	struct timespec interval;
> +	interval.tv_sec = 0;
> +	interval.tv_nsec = interval_ms * 1000000; /* in ns */
> +
> +	for (;;) {

What about using

	for (i = 0; i < timeout; i += interval) {

> +		fd = open(path, O_WRONLY | O_NONBLOCK);
> +		if (fd < 0) {
> +			if ((errno == ENXIO) || (errno == EINTR)) {
> +				if (timeleft <= 0) {
> +					errno = ETIMEDOUT;
> +
> +					return -1;
> +				}
> +
> +				timeleft -= interval_ms;
> +				nanosleep(&interval, NULL);

What about using usleep() which has simplier interface instead?

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
> @@ -195,12 +238,18 @@ void tst_checkpoint_signal_child(const char *file, const int lineno,
>  {
>  	int ret, fd;
>  	
> -	fd = open(TST_CHECKPOINT_FIFO, O_WRONLY);
> +	fd = open_wronly_timed(TST_CHECKPOINT_FIFO, self->timeout);
>  
>  	if (fd < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -		         "Failed to open fifo '%s' at %s:%d",
> -		         TST_CHECKPOINT_FIFO, file, lineno);
> +		if (errno == ETIMEDOUT) {
> +			tst_brkm(TBROK, cleanup_fn,
> +				"Checkpoint timeouted after %u msecs at %s:%d",
> +				self->timeout, file, lineno);
> +		} else {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				"Failed to open fifo '%s' at %s:%d",
> +				TST_CHECKPOINT_FIFO, file, lineno);
> +		}

Hmm, there is no need to complicate this part, if you have set the errno
to ETIMEOUTED the tst_brkm() will include the errno and will look like:

foo01	1  TBROK  :  Failed to open fifo 'tst_checkpoint_fifo' at tst_checkopoint.c:211: ERRNO=ETIMEDOUT(110): Connection timed out

Which is in my opinion descriptive enough.


But we need to add EDTIMEDOUT into the tst_res.c fist, actually there are still
some errno values missing, so I will add them them there beforehand.

diff --git a/lib/tst_res.c b/lib/tst_res.c
index f73022b..7d87492 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -255,6 +255,7 @@ static const char *strerrnodef(int err)
                    PAIR(ENOSYS)
                    PAIR(ENOTEMPTY)
                    PAIR(ELOOP)
+                   PAIR(ETIMEDOUT)
        };
        return pair_lookup(errno_pairs, err);
 }


-- 
Cyril Hrubis
chrubis@suse.cz

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
