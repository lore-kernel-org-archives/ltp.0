Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jungsoo.son@lge.com>) id 1Uk3Lz-0000dG-UH
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 02:21:35 +0000
Received: from lgemrelse1q.lge.com ([156.147.1.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uk3Lv-0003Ke-Iv
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 02:21:35 +0000
From: "Jungsoo Son" <jungsoo.son@lge.com>
Date: Wed, 5 Jun 2013 11:21:24 +0900
Message-ID: <009401ce6193$609aaf40$21d00dc0$@lge.com>
MIME-Version: 1.0
Content-Language: ko
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
To: ltp-list@lists.sourceforge.net


Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
---
 testcases/kernel/syscalls/chmod/chmod02.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod02.c
b/testcases/kernel/syscalls/chmod/chmod02.c
index 242cbd3..904c5e8 100644
--- a/testcases/kernel/syscalls/chmod/chmod02.c
+++ b/testcases/kernel/syscalls/chmod/chmod02.c
@@ -187,9 +187,9 @@ void setup()
 	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	} else if (write(fd, &buf, strlen(buf)) == -1) {
+	} else if (write(fd, buf, strlen(buf)) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-			 "write(%s, &buf, strlen(buf)) failed", fname);
+			 "write(%s, buf, strlen(buf)) failed", fname);
 	} else if (close(fd) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
fname);
 	}
-- 
1.7.9.5

> -----Original Message-----
> From: Jungsoo Son [mailto:jungsoo.son@lge.com]
> Sent: Wednesday, June 05, 2013 11:09 AM
> To: 'ltp-list@lists.sourceforge.net'
> Subject: [PATCH] syscalls/chmod02: Fix wrong address of buf as write()
> argument
> 
> 
> Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
> ---
>  testcases/kernel/syscalls/chmod/chmod02.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod02.c
> b/testcases/kernel/syscalls/chmod/chmod02.c
> index 242cbd3..b1c331a 100644
> --- a/testcases/kernel/syscalls/chmod/chmod02.c
> +++ b/testcases/kernel/syscalls/chmod/chmod02.c
> @@ -187,7 +187,7 @@ void setup()
>  	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
> -	} else if (write(fd, &buf, strlen(buf)) == -1) {
> +	} else if (write(fd, buf, strlen(buf)) == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "write(%s, &buf, strlen(buf)) failed", fname);
>  	} else if (close(fd) == -1) {
> --
> 1.7.9.5


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
