Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ying.huang@intel.com>) id 1MaP7t-0005dO-DV
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 07:17:01 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaP7l-0002rE-Kh
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 07:17:01 +0000
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <1249648896.4851.40.camel@subratamodak.linux.ibm.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
Date: Mon, 10 Aug 2009 15:16:46 +0800
Message-Id: <1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
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
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Fri, 2009-08-07 at 20:41 +0800, Subrata Modak wrote:
> On Thu, 2009-08-06 at 09:18 +0800, Huang Ying wrote: 
> > On Thu, 2009-08-06 at 01:55 +0800, Subrata Modak wrote:
> > > Hi Huang Ying,
> > > 
> > > On Wed, 2009-08-05 at 16:25 +0530, Subrata Modak wrote:
> > > > Hi Huang Ying,
> > > > 
> > > > >On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> > > > >Hi, All,
> > > > > 
> > > > > We are working on a test suite to test the Linux kernel MCE handling
> > > > > logic named mce-test, which can be find at:
> > > > > git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> > > > > HOWTO for it, which is attached with the mail.
> > > > > 
> > > > > We think the testing target of mce-test is part of that of LTP, so it is
> > > > > better to integrate mce-test into LTP. Do you think so?
> > > > > 
> > > > > As for integration scheme, maybe we can first add mce-test into LTP as a
> > > > > separate test case, just as kdump test case. What's your opinions?
> > > > > 
> > > > > Any comment is welcome!
> > > > > 
> > > > 
> > > > Sorry for the very late response to your proposal. Please find below the
> > > > first patch which will integrate the existing mce-test to LTP. I had just
> > > > done a sanity checking of building it. The following patch will still need:
> > > > 
> > > > 1) Exclusive testing and sharing those results with the LTP community,
> > > 
> > > My initial first tests results are:
> > > 
> > > # uname -a
> > > Linux x206f 2.6.29-gcov #1 SMP Fri Jun 19 12:14:27 IST 2009 i686 i686
> > > i386 GNU/Linux
> > 
> > mce-test needs at least Linux kernel 2.6.31-rc? and some additional
> > injection related patches from:
> > http://ftp.kernel.org/pub/linux/kernel/people/yhuang/mce/. We are
> > working on pushing these additional patches into 2.6.32.
> > 
> 
> Can you please then provide this information inside mce-test/README, so
> that users are exactly aware of:
> 
>      1. Which kernel to pick up, 
>      2. Which additional patches to apply, 
>      3. Which config options to set,
> 
> before building and running these tests.

I have add these information into the HOWTO in mce-test/doc/howto.txt.
In README, there is a "pointer" to howto.txt in section test
instruction. Is it OK for you?

> Once mainline stable releases are through, you can then again update
> mce-test/README with similar information.

OK. I will update the document after upstream merging.

> I would like people to start doing some testing with your present
> mce-test as well. As suggested by Andi, please drop in:
> 
>      1. a minimal patch which adds the tests(you want) to LTP, 
>      2. update mce-test/README in the same patch with all the above
>         info, 
>      3. attach test results against the patches you have dropped to ltp,

OK. I will do this.

I will check the coding style with checkpatch.pl. Do you have other
comments about the code?

Best Regards,
Huang Ying



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
