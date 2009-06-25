Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlqo-00048v-5H
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:06:38 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlqn-0003bO-6s
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:06:38 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <78aaeffc0906250000i150418e8k3637acb41976c1a0@mail.gmail.com>
References: <78aaeffc0906250000i150418e8k3637acb41976c1a0@mail.gmail.com>
Date: Thu, 25 Jun 2009 14:41:02 +0530
Message-Id: <1245921062.5542.51.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Can not run Test
Reply-To: subrata@linux.vnet.ibm.com
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
To: waqar afridi <afridi.waqar@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, 2009-06-25 at 13:00 +0600, waqar afridi wrote:
> Hi All
> 
> I have downloaded ltp-full-20090531.tgz and installed it using the
> commands make autotools, ./configure, make all, make install. but when
> I try to run a test like
> 
> # ./ima_tpm.sh 
> ./ima_tpm.sh: 163: source: not found
> ./ima_tpm.sh: 164: setup: not found
> 
> I get the error above. What could be the problem, Desperately need
> help.

Look through:
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/integrity/ima/README,
on instructions to setup before executing those tests.

Regards--
Subrata

> 
> -- 
> Waqar Afridi
> Research Associate
> Member: Security Engineering Research Group (SERG)
> IM | Sciences Peshawar 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
