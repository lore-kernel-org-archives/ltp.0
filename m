Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WcZyd-0000QT-Qj
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 12:39:07 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcZya-0000uA-FE
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 12:39:07 +0000
Date: Tue, 22 Apr 2014 08:38:49 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <877838316.7741146.1398170329130.JavaMail.zimbra@redhat.com>
In-Reply-To: <1398159613.2772.7.camel@G08JYZSD130126>
References: <1398159613.2772.7.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] sbrk/sbrk01.c: cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, 22 April, 2014 11:40:13 AM
> Subject: [LTP] [PATCH 1/2] sbrk/sbrk01.c: cleanup
> 
> * Delete some useless commtents.
> * Move the test body from main() to sbrk_verify().
> * Remove tst_tmpdir().
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/sbrk/sbrk01.c | 236
>  +++++++-------------------------
>  1 file changed, 52 insertions(+), 184 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c
> b/testcases/kernel/syscalls/sbrk/sbrk01.c
> index b2db42c..f2b09f4 100644
> --- a/testcases/kernel/syscalls/sbrk/sbrk01.c
> +++ b/testcases/kernel/syscalls/sbrk/sbrk01.c

...

>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void sbrk_verify(const struct test_case_t *test)
>  {
> +	void *tret;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	tret = sbrk(test->increment);
> +	TEST_ERRNO = errno;
>  
> -	/* make a temp dir and cd to it */
> -	tst_tmpdir();
> +	if (tret == (void *)-1) {
> +		tst_resm(TFAIL | TTERRNO,
> +			 "sbrk - Increase by %ld bytes failed, errno=%d : %s",
> +			 test->increment, TEST_ERRNO, strerror(TEST_ERRNO));

This looks redundant. You are using TTERRNO and also printing TEST_ERRNO as decimal
and string again. You could just use TERRNO, errno shouldn't change between
call to sbrk() and if condition.

Regards,
Jan

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
