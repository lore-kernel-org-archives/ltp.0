Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UkFfj-0004zv-Jw
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 15:30:47 +0000
Date: Wed, 5 Jun 2013 17:32:05 +0200
From: chrubis@suse.cz
Message-ID: <20130605153204.GA611@rei>
References: <009401ce6193$609aaf40$21d00dc0$@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <009401ce6193$609aaf40$21d00dc0$@lge.com>
Subject: Re: [LTP] [PATCH] syscalls/chmod02: Fix wrong address of buf for
 write()
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
> ---
>  testcases/kernel/syscalls/chmod/chmod02.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod02.c
> b/testcases/kernel/syscalls/chmod/chmod02.c
> index 242cbd3..904c5e8 100644
> --- a/testcases/kernel/syscalls/chmod/chmod02.c
> +++ b/testcases/kernel/syscalls/chmod/chmod02.c
> @@ -187,9 +187,9 @@ void setup()
>  	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
> -	} else if (write(fd, &buf, strlen(buf)) == -1) {
> +	} else if (write(fd, buf, strlen(buf)) == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "write(%s, &buf, strlen(buf)) failed", fname);
> +			 "write(%s, buf, strlen(buf)) failed", fname);
>  	} else if (close(fd) == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
> fname);

I've replaced the the code that creates the file with single
SAFE_FILE_PRINTF(). Thanks for the report.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
