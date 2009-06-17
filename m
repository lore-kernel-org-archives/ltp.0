Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MGvpX-0006qb-Gs
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:09:35 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGvpU-0000oX-Ax
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:09:35 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5HDabLg027634
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 07:36:37 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HDbEq3060254
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 07:37:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5HDbDiA008488
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 07:37:14 -0600
Date: Wed, 17 Jun 2009 08:31:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090617133149.GB18056@us.ibm.com>
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<20090616184148.GA3043@us.ibm.com>
	<49b7c2350906161642y1222c3e5h45f5912a01c77f06@mail.gmail.com>
	<200906170822.27961.sgrubb@redhat.com>
	<49b7c2350906170610q775cf031va3dd2e3ae8c868fc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49b7c2350906170610q775cf031va3dd2e3ae8c868fc@mail.gmail.com>
Subject: Re: [LTP] Report - make error of ltp-full-20090531.tgz
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
To: GeunSik Lim <leemgs1@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Steve Grubb <sgrubb@redhat.com>, Andrew Morgan <morgan@kernel.org>

Quoting GeunSik Lim (leemgs1@gmail.com):
> On Wed, Jun 17, 2009 at 9:22 PM, Steve Grubb<sgrubb@redhat.com> wrote:
> > I am not the maintainer, so I don't have that ability. I did record a
> > successful test message in bodhi on LTP's behalf to encourage the maintainer
> > to ask for it to be marked stable asap.
> Steve and Serge, Thanks.
> 
> Unfortunately,
> If ltp version will not upgrade  current ltp-full-20090531 version for
> Fedora11 support,
> or If libcap version of fedora11 will not upgrade,
> I have to modify some ltp files like belows.
> +//#include <sys/capability.h>
> +#include <linux/capability.h>

If you're free to make local modifications, why not just wget+install
the libcap-2.16-4 until it's updated in the f11 repos?  Or, remove
libcap and the test shouldn't try to compile.  (If it does, then that's
a bug in my stuff)

-serge

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
