Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N0JjU-0003gb-AD
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 18:46:56 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N0JjM-0007Yp-9B
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 18:46:56 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 20 Oct 2009 11:48:49 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153D9BB@svexch01.mvista.com>
In-Reply-To: <1255890117.5359.17.camel@subratamodak.linux.ibm.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
	<364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
	<1255890117.5359.17.camel@subratamodak.linux.ibm.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][fs tests] modify tests to honor tmpdirectory
	passed into runltp, convert to LTP format
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
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Subrata, 

Yes, please ignore the linker01.patch. I had created it before I realized there was a later check-in. It was accidentally included in my haste.

I've attached the lftest patch that should apply to CVS. I had an issue with my eclipse IDE mangling the patches that I need to address.


> -----Original Message-----
> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> Sent: Sunday, October 18, 2009 11:22 AM
> To: Henry Yei
> Cc: LTP Mailing List; Garrett Cooper
> Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor
> tmpdirectory passed into runltp, convert to LTP format
> 
> 
> On Fri, 2009-10-16 at 22:17 -0700, Garrett Cooper wrote:
> > On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> wrote:
> > > This is a set of patches for tests in the fs runtest file which
> make use of tst_tmpdir functions or alternatively, the base tmpdir set
> by the user. Some of the tests have been converted to LTP test format
> as well.
> > >
> > > Tests that are changed:
> > > fs_di
> > > fs_perms
> > > lftest
> > > linker01
> > > quota_remount_test01
> > > writetest
> >
> > Note: linker01 is a bourne shell script now.
> 
> And as Garret said, and apart from that, the lftest.patch fails too:
> 
> patching file testcases/kernel/fs/lftest/lftest.c
> patch: **** malformed patch at line 94:
> 
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |--- ltp-20090531/testcases/kernel/fs/linktest/linktest.pl
> 2008-07-30 06:18:22.000000000 -0700
> |+++ ltp-wdir/testcases/kernel/fs/linktest/linktest.pl  2009-07-27
> 20:59:55.370039414 -0700
> --------------------------
> File to patch:
> 
> Regards--
> Subrata
> 
> > HTH,
> > -Garrett
> >
> > ---------------------------------------------------------------------
> ---------
> > Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> > is the only developer event you need to attend this year. Jumpstart
> your
> > developing skills, take BlackBerry mobile applications to market and
> stay
> > ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> > http://p.sf.net/sfu/devconference
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
