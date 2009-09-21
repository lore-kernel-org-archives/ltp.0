Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MpbQo-0001LD-OK
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 05:27:22 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpbQg-0002WM-7s
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 05:27:22 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8L5Q6BB003347
	for <ltp-list@lists.sourceforge.net>; Sun, 20 Sep 2009 23:26:06 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L5R4ZZ204530
	for <ltp-list@lists.sourceforge.net>; Sun, 20 Sep 2009 23:27:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8L5R3tE018928
	for <ltp-list@lists.sourceforge.net>; Sun, 20 Sep 2009 23:27:04 -0600
Date: Mon, 21 Sep 2009 00:26:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090921052647.GA32556@us.ibm.com>
References: <20090916212856.GB19295@us.ibm.com>
	<1253449605.7736.7.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1253449605.7736.7.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [LTP PATCH] Create testcase for p9auth kernel module
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Ashwin Ganti <ashwin.ganti@gmail.com>

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> On Wed, 2009-09-16 at 16:28 -0500, Serge E. Hallyn wrote:
> > The p9auth module is a driver in the staging/ directory, which
> > implements kernel functionality supporting plan 9-style setuid.
> > Programs can be completely unprivileged, authorize themselves
> > to a privileged server, and obtain a token which they can use to
> > authorize a single setuid to a single specified new uid.
> > 
> > This testcase runs three tests:
> > 	1. make sure we can't setuid without a hash
> > 		(this is actually short-cut in the kernel code
> > 		so it might be worthwhile having a separate
> > 		test for having a hash, but an invalid one)
> > 	2. make sure we can setuid when there is a valid hash
> > 	3. make sure we cannot setuid if there is a valid hash,
> > 		but our original uid isn't the one specified
> > 		in the token.
> > 
> > Run the testcase using
> > 
> > 	./runltp -f p9auth
> > 
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> Thanks Serge. The patch seems to be fine except that the following
> script:
> 
> 		runp9auth.sh
> 
> make[4]: Entering directory
> `/root/subrata/ltp/ltp-full-20090831/testcases/kernel/security/p9auth'
> make[4]: *** No rule to make target `runp9auth.sh', needed by `install'.
> Stop.
> make[4]: Leaving directory
> `/root/subrata/ltp/ltp-full-20090831/testcases/kernel/security/p9auth'
> make[3]: *** [install] Error 2
> make[3]: Leaving directory
> `/root/subrata/ltp/ltp-full-20090831/testcases/kernel/security'
> make[2]: *** [install] Error 2
> make[2]: Leaving directory
> `/root/subrata/ltp/ltp-full-20090831/testcases/kernel'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory
> `/root/subrata/ltp/ltp-full-20090831/testcases'
> make: *** [install] Error 2

Oops.

> is missing from the patch. So, i was not able to test this. Can you
> please fix this and resend again. In your new patch, can you also
> include mentioning the following .config file options for enabling
> PLAN9AUTH in kernel, through ltp/README:
> 
> CONFIG_CRYPTO=y
> CONFIG_STAGING=y
> # CONFIG_STAGING_EXCLUDE_BUILD is not set
> CONFIG_PLAN9AUTH=m

After I sent it I remembered I didn't address the TODO about
checking for openssl and figured i'd get yelled at for that :)

I'll fix those up and resend when I can.

thanks,
-serge

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
