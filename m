Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryIu-0005q8-Ih
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:17:00 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryIq-0007rm-04
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:17:00 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF9CA4BE88.68C4CD88-ON85257631.000FA62E-85257631.0010F38E@us.ibm.com>
References: <1252847784.5357.32.camel@subratamodak.linux.ibm.com>
	<OF9CA4BE88.68C4CD88-ON85257631.000FA62E-85257631.0010F38E@us.ibm.com>
Date: Sun, 27 Sep 2009 23:45:46 +0530
Message-Id: <1254075348.10457.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Testing 2.6.31] Minimal IMA policy and boot param for
	TCB IMA	policy
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
To: Mimi Zohar <zohar@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>

On Sun, 2009-09-13 at 23:05 -0400, Mimi Zohar wrote: 
> Subrata Modak <subrata@linux.vnet.ibm.com> wrote on 09/13/2009 09:16:22 
> AM:
> 
> > Hi Mimi,
> > 
> > I remember talking to you for IMA test cases evaluation during 2.6.30
> > release. Now, with the above changes in IMA policies under 2.6.31
> > kernel, would you like to submit some fresh patches for the LTP IMA test
> > cases ?
> > 
> > Regards--
> > Subrata 
> 
> Subrata,
> 
> The default IMA policy of 2.6.30 is enabled in 2.6.31 with the kernel
> boot parameter 'ima_tcb=1'.  The dependency section of the LTP 
> testcases/kernel/security/integrity/ima/README should be updated to
> reflect this change.  I'll post a patch with this change.

Mimi,

Any Patch before this month release ?

Regards--
Subrata

> 
> Mimi


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
