Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YvFFF-0001aS-P2
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 01:25:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvFFE-0004KW-MK
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 01:25:57 +0000
Message-ID: <1432171597.16347.53.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 May 2015 09:26:37 +0800
In-Reply-To: <1089771258.2559286.1432121544985.JavaMail.zimbra@redhat.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1431944048.27486.14.camel@G08FNSTD140232>
	<5559F134.7040705@oracle.com>
	<1432025422.16347.6.camel@G08FNSTD140232>
	<1273450911.1653813.1432034294768.JavaMail.zimbra@redhat.com>
	<1432086442.16347.24.camel@G08FNSTD140232>
	<1312891014.2427183.1432104744478.JavaMail.zimbra@redhat.com>
	<1432115881.16347.41.camel@G08FNSTD140232>
	<1089771258.2559286.1432121544985.JavaMail.zimbra@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

On Wed, 2015-05-20 at 07:32 -0400, Jan Stancek wrote:

[...]
> > > > How about put them before lseek(SEEK_HOLE) ?
> > > 
> > > I think we should do the check on all kernels. lseek() can only check that
> > > the
> > > hole exists, but current check also verifies that hole has correct size and
> > > content.
> > > 
> > 
> > Right. It is the strict way we need to do. But it would make the test
> > complex.
> 
> I think we already check it strictly, see line 172-177. This covers blocks 1,2,3.
> The patch you proposed _adds_ one more check only for zero-ed block 2.
> My objection was that this seems redundant, because we already have
> a check (line 172-177), which covers all 3 blocks. Am I missing something?
> 

Oh, I see. I misunderstand your reply previous. Right, the patch is
redundant.
Thank you.

> > Now, "turn that warning into TINFO" looks simple but effective.
> > If nobody reject, I will send new patch like:
> 
> Looks OK to me, though maybe it should TBROK on kernels > 3.1 even when
> errno is EINVAL.

OK. I will fix it at the same time.

Thanks.

Best regards,
Zeng

> 
> Regards,
> Jan
> 
> > 
> > -               tst_resm(TWARN | TERRNO, "lseek() doesn't support
> > SEEK_HOLE");
> > +               if (tst_kvercmp(3, 1, 0) < 0)
> > +                       tst_resm(TINFO, "lseek() doesn't support SEEK_HOLE, "
> > +                               "this is expected for < 3.1 kernels");
> > +       } else {
> > +               tst_resm(TINFO, "found a hole at '%ld' offset", ret);
> >         }
> > -       tst_resm(TINFO, "found a hole at '%ld' offset", ret);
> > 
> > Thank you.
> > 
> > Best regards,
> > Zeng
> > 
> > 
> > > Regards,
> > > Jan
> > [...]
> > 
> > 



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
