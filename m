Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wddms-0001dq-Lv
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 10:55:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wddmq-0004E5-Rv
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 10:55:22 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3PAtEtb017905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 10:55:15 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3PAtDj2017464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 10:55:14 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3PAtD7S025024
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 10:55:13 GMT
Message-ID: <535A3F0F.7030404@oracle.com>
Date: Fri, 25 Apr 2014 14:55:11 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1398334546-5820-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1398334546-5820-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/fstatfs:using temporary file description
 to test the system call
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
To: shuang.qiu@oracle.com, ltp-list@lists.sourceforge.net

Hi!

It would be nice to have a cleanup patch beforehand (static vars, 
useless comments and etc).

I think It would be better to mark somehow inside definition of struct 
test_case_t TC, that for the second test case we don't use '1' as the 
file descriptor but use one opened on later.

And one small comment below.

On 04/24/2014 02:15 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> It does not make sense to use stdout as the file description to test the
> system call fstatfs().We may get unexpected result(i.e. erron38:Function
> not implemented) if redirect stdout when running ltp.
> Using ltp temporary file instead.
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>   testcases/kernel/syscalls/fstatfs/fstatfs02.c |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> index cee234f..652624b 100644
> --- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> +++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
> @@ -47,6 +47,7 @@
>
>   #include <sys/vfs.h>
>   #include <sys/types.h>
> +#include <sys/fcntl.h>
>   #include <sys/statfs.h>
>   #include <errno.h>
>   #include "test.h"
> @@ -59,6 +60,8 @@ char *TCID = "fstatfs02";
>
>   int exp_enos[] = { EBADF, EFAULT, 0 };
>
> +char fname[255];
> +int fd;
>   struct statfs buf;
>
>   struct test_case_t {
> @@ -91,6 +94,10 @@ int main(int ac, char **av)
>
>   	setup();
>
> +#ifndef UCLINUX
> +	TC[1].fd = fd;
> +#endif
> +
Maybe move it inside setup()?


>   	/* set up the expected errnos */
>   	TEST_EXP_ENOS(exp_enos);
>
> @@ -138,6 +145,10 @@ void setup(void)
>
>   	/* make a temporary directory and cd to it */
>   	tst_tmpdir();
> +
> +	sprintf(fname, "tfile_%d", getpid());
> +	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
>   }
>
>   /*
> @@ -152,6 +163,9 @@ void cleanup(void)
>   	 */
>   	TEST_CLEANUP;
>
> +	if (close(fd) == -1)
> +		tst_resm(TWARN | TERRNO, "close failed");
> +
>   	/* delete the test directory created in setup() */
>   	tst_rmdir();
>
>

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
