Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YAVDs-0006UN-PJ
	for ltp-list@lists.sourceforge.net; Mon, 12 Jan 2015 02:59:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YAVDr-0007YS-70
	for ltp-list@lists.sourceforge.net; Mon, 12 Jan 2015 02:59:20 +0000
Message-ID: <1421031479.13049.15.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 12 Jan 2015 10:57:59 +0800
In-Reply-To: <1420885229-25636-1-git-send-email-jstancek@redhat.com>
References: <1420885229-25636-1-git-send-email-jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] skip MSG_ERRQUEUE+tcp test on kernels < 3.17
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
Cc: ltp-list@lists.sourceforge.net

Hi,

On Sat, 2015-01-10 at 11:20 +0100, Jan Stancek wrote:
> MSG_ERRQUEUE support for tcp has been added in 3.17. [1][2][3]
> Skip testing this combination on prior kernels.
> 
> [1] https://lkml.org/lkml/2006/9/18/182
> [2] f4713a3dfad045d46afcb9c2a7d0bba288920ed4
> [3] 4ed2d765dfaccff5ebdac68e2064b59125033a3b
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/recv/recv01.c         |    9 ++++++++-
>  testcases/kernel/syscalls/recvfrom/recvfrom01.c |    9 ++++++++-
>  testcases/kernel/syscalls/recvmsg/recvmsg01.c   |    9 ++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
> index 3dc7a91..ad5f9f8 100644
> --- a/testcases/kernel/syscalls/recv/recv01.c
> +++ b/testcases/kernel/syscalls/recv/recv01.c
> @@ -130,8 +130,15 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			tdat[testno].setup();
> +			if ((tst_kvercmp(3, 17, 0) < 0)
> +			    && (tdat[testno].flags & MSG_ERRQUEUE)
> +			    && (tdat[testno].type & SOCK_STREAM)) {
> +				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "

I think TCONF should be more suitable.
Others looks good to me.

Thanks,
Zeng

> +						"it's supported from 3.17");
> +				continue;
> +			}
>  
> +			tdat[testno].setup();
>  			TEST(recv(s, tdat[testno].buf, tdat[testno].buflen,
>  				  tdat[testno].flags));
>  			if (TEST_RETURN > 0)
> diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> index 8d0a2ee..843dfb1 100644
> --- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> +++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> @@ -152,8 +152,15 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			tdat[testno].setup();
> +			if ((tst_kvercmp(3, 17, 0) < 0)
> +			    && (tdat[testno].flags & MSG_ERRQUEUE)
> +			    && (tdat[testno].type & SOCK_STREAM)) {
> +				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "
> +						"it's supported from 3.17");
> +				continue;
> +			}
>  
> +			tdat[testno].setup();
>  			TEST(recvfrom(s, tdat[testno].buf, tdat[testno].buflen,
>  				      tdat[testno].flags, tdat[testno].from,
>  				      tdat[testno].salen));
> diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> index 42d4968..1216935 100644
> --- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> @@ -208,10 +208,17 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; ++testno) {
> +			if ((tst_kvercmp(3, 17, 0) < 0)
> +			    && (tdat[testno].flags & MSG_ERRQUEUE)
> +			    && (tdat[testno].type & SOCK_STREAM)) {
> +				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "
> +						"it's supported from 3.17");
> +				continue;
> +			}
> +
>  			tdat[testno].setup();
>  
>  			/* setup common to all tests */
> -
>  			iov[0].iov_base = tdat[testno].buf;
>  			iov[0].iov_len = tdat[testno].buflen;
>  			msgdat.msg_name = tdat[testno].from;



------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
vanity: www.gigenet.com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
