Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XGrDK-0005ps-K5
	for ltp-list@lists.sourceforge.net; Mon, 11 Aug 2014 15:08:46 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XGrDI-0003DK-Mu
	for ltp-list@lists.sourceforge.net; Mon, 11 Aug 2014 15:08:46 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s7BF8cCE001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Aug 2014 15:08:38 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s7BF8bGe025688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Aug 2014 15:08:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s7BF8bVx014300
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Aug 2014 15:08:37 GMT
Message-ID: <53E8DC72.40000@oracle.com>
Date: Mon, 11 Aug 2014 19:08:34 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <23710388.18328282.1407740246999.JavaMail.zimbra@redhat.com>
In-Reply-To: <23710388.18328282.1407740246999.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] diotest4/fcntl16: Skip some dio/fcntl cases on NFS
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

Hi!

On 08/11/2014 10:57 AM, Xiong Zhou wrote:
> According to description of NFS and directIO in open(2), especially
> "The Linux NFS client places no alignment restrictions on
> O_DIRECT I/O", ignore some FAILs in diotest4.
>
> According to nfs(5), NLM supports advisory file locks only. So skip
> fcntl16 test if NFS.
>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>   testcases/kernel/io/direct_io/diotest4.c  | 14 ++++++++++----
>   testcases/kernel/syscalls/fcntl/fcntl16.c |  8 ++++++++
>   2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
> index 10281bf..506e34c 100644
> --- a/testcases/kernel/io/direct_io/diotest4.c
> +++ b/testcases/kernel/io/direct_io/diotest4.c
> @@ -71,9 +71,11 @@
>
>   #include "test.h"
>   #include "usctest.h"
> +#include "tst_fs_type.h"
>
>   char *TCID = "diotest4";	/* Test program identifier.    */
>   int TST_TOTAL = 17;		/* Total number of test conditions */
> +int NO_NFS = 1;			/* Test on NFS or not */
>
>   #ifdef O_DIRECT
>
> @@ -106,7 +108,7 @@ runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
>   		}
>   	} else {
>   		ret = read(fd, buf, count);
> -		if (ret >= 0 || errno != errnum) {
> +		if ((ret >= 0 || errno != errnum) && NO_NFS) {
>   			tst_resm(TFAIL, "read allows %s. returns %d: %s",
>   				 msg, ret, strerror(errno));
>   			l_fail = TRUE;
> @@ -120,7 +122,7 @@ runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
>   		}
>   	} else {
>   		ret = write(fd, buf, count);
> -		if (ret >= 0 || errno != errnum) {
> +		if ((ret >= 0 || errno != errnum) && NO_NFS) {
>   			tst_resm(TFAIL, "write allows %s.returns %d: %s",
>   				 msg, ret, strerror(errno));
>   			l_fail = TRUE;

You are modifying runtest_f() which is invoked in multiple test scenarios.
I suppose that not all the test cases should be excluded from the 
execution on NFS. For example, "negative fd".

I think we should disable only ones which don't work with NFS.

> @@ -206,6 +208,10 @@ int main(int argc, char *argv[])
>
>   	setup();
>
> +	/* On NFS or not */
> +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
> +		NO_NFS = 0;
> +
>   	/* Open file and fill, allocate for buffer */
>   	if ((fd = open(filename, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
>   		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
> @@ -459,7 +465,7 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   		l_fail = TRUE;
>   	} else {
> -		if ((ret = read(fd, buf2 + 1, count)) != -1) {
> +		if (((ret = read(fd, buf2 + 1, count)) != -1) && NO_NFS) {
>   			tst_resm(TFAIL,
>   				 "allows read nonaligned buf. returns %d: %s",
>   				 ret, strerror(errno));
> @@ -471,7 +477,7 @@ int main(int argc, char *argv[])
>   			 strerror(errno));
>   		l_fail = TRUE;
>   	} else {
> -		if ((ret = write(fd, buf2 + 1, count)) != -1) {
> +		if (((ret = write(fd, buf2 + 1, count)) != -1) && NO_NFS) {
>   			tst_resm(TFAIL,
>   				 "allows write nonaligned buf. returns %d: %s",
>   				 ret, strerror(errno));


Hmm. diotest4.c has many duplicated parts of code like 'open(O_DIRECT)' 
and tests like 'if (l_fail)' and 'if (ret != 0)'.

What do you think about cleaning these things up before doing functional 
changes? :)

Thanks.


> diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
> index 44b6a80..7dba6ea 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> @@ -51,6 +51,8 @@
>   #include <sys/types.h>
>   #include <sys/wait.h>
>
> +#include "tst_fs_type.h"
> +
>   #define SKIPVAL 0x0f00
>   //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
>   #define SKIP 0,0,0L,0L,0
> @@ -412,6 +414,12 @@ void setup(void)
>
>   	tst_tmpdir();
>
> +	/* On NFS or not */
> +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> +		tst_brkm(TCONF, cleanup, "Cannot test madatory locking "
> +			"on a file located on an NFS filesystem");
> +	}
> +
>   	/* set up temp filename */
>   	sprintf(tmpname, "fcntl4.%d", parent);
>
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
