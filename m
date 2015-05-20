Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Yv0PH-0004FB-Ab
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 09:35:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yv0PG-0003B1-6T
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 09:35:19 +0000
Message-ID: <1432114555.16347.31.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 20 May 2015 17:35:55 +0800
In-Reply-To: <555C4220.7010602@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1431944048.27486.14.camel@G08FNSTD140232>
	<5559F134.7040705@oracle.com>
	<1432025422.16347.6.camel@G08FNSTD140232>
	<1273450911.1653813.1432034294768.JavaMail.zimbra@redhat.com>
	<1432086442.16347.24.camel@G08FNSTD140232>
	<555C4220.7010602@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] fallocate04: another check if SEEK_HOLE is not
 supported
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi, Alexey and Jan

On Wed, 2015-05-20 at 11:13 +0300, Alexey Kodanev wrote:
> Hi,
> On 05/20/2015 04:47 AM, Zeng Linggang wrote:
> > Hi!
> >
> > On Tue, 2015-05-19 at 07:18 -0400, Jan Stancek wrote:
> [ ... ]
> >> Wouldn't it be enough to turn that warning into TINFO, for kernels < 3.1?
> >>
> >> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> >> index 911bbe8..45d9827 100644
> >> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> >> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> >> @@ -158,9 +158,12 @@ static void test02(void)
> >>                          tst_brkm(TFAIL | TERRNO, cleanup,
> >>                                   "fallocate() or lseek() failed");
> >>                  }
> >> -               tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
> >> +               if (tst_kvercmp(3, 1, 0) < 0)
> > How about put them before lseek(SEEK_HOLE) ?
> >
> > if (tst_kvercmp(3, 1, 0) < 0) {
> > 	fill_tst_buf();
> > 	memset();
> > 	check_file_data();
> > } else {
> > 	lseek(SEEK_HOLE);
> > 	...
> > }
> 
> Please don't complicate the test-case with this, I agree with Jan, it is 
> enough to add the kernel version check. It can be as follows:

OK. I will do as that.

Thank both of you.

Best regards,
Zeng

> 
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -158,7 +158,8 @@ static void test02(void)
>                          tst_brkm(TFAIL | TERRNO, cleanup,
>                                   "fallocate() or lseek() failed");
>                  }
> -               tst_resm(TWARN | TERRNO, "lseek() doesn't support 
> SEEK_HOLE");
> +               tst_resm((tst_kvercmp(3, 1, 0) < 0) ? TINFO : (TWARN | 
> TERRNO),
> +                        "lseek() doesn't support SEEK_HOLE");
>          }
>          tst_resm(TINFO, "found a hole at '%ld' offset", ret);
> 
> 
> Best regards,
> Alexey
> 



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
