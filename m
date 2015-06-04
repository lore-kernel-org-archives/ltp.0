Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z0Thp-0005vV-3J
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 11:53:05 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z0Thn-00048Y-6Z
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 11:53:05 +0000
Date: Thu, 4 Jun 2015 07:52:39 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <146491579.10633998.1433418759561.JavaMail.zimbra@redhat.com>
In-Reply-To: <55703816.1040109@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1432186777.16347.56.camel@G08FNSTD140232>
	<1176648532.3847089.1432304474796.JavaMail.zimbra@redhat.com>
	<55703816.1040109@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] fallocate04: Use tst_kvercmp after
 lseek(SEEK_HOLE) return EINVAL
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>, Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: "Jan Stancek" <jstancek@redhat.com>, "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> Cc: ltp-list@lists.sourceforge.net, "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Thursday, 4 June, 2015 1:35:50 PM
> Subject: Re: [LTP] [PATCH] fallocate04: Use tst_kvercmp after lseek(SEEK_HOLE) return EINVAL
> 
> Hi,
> On 05/22/2015 05:21 PM, Jan Stancek wrote:
> > ----- Original Message -----
> >> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> >> To: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> >> Cc: ltp-list@lists.sourceforge.net, "vasily isaenko"
> >> <vasily.isaenko@oracle.com>
> >> Sent: Thursday, 21 May, 2015 7:39:37 AM
> >> Subject: [LTP] [PATCH] fallocate04: Use tst_kvercmp after lseek(SEEK_HOLE)
> >> return EINVAL
> >>
> >> SEEK_HOLE is only supported since version 3.1. Just print some
> >> information to remind users if kernel is before 3.1, if not print
> >> 'TBROK' and quit, instead of 'TWARN'.
> > Looks OK to me. Alexey, any objections from your side?
> 
> Sorry for the delay, looks good to me. There is stylistic comment below,
> but it is minor:
> 
> >> -		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
> >> +		if (tst_kvercmp(3, 1, 0) < 0)
> >> +			tst_resm(TINFO, "lseek() doesn't support SEEK_HOLE, "
> >> +				 "this is expected for < 3.1 kernels");
> >> +		else
> >> +			tst_brkm(TBROK | TERRNO, cleanup,
> >> +
> 
> It would be better to add curly braces around multiline 'if else' block.

Pushed with curly braces.

Regards,
Jan

> 
> Thanks,
> Alexey
> 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
