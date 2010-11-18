Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <takahash@us.ibm.com>) id 1PItWv-00078z-Bs
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 01:43:17 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PItWu-0007dF-Gv
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 01:43:17 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAI1Vo0J024967
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Nov 2010 18:31:50 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oAI1h7n3224688
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Nov 2010 18:43:07 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAI1h7fD031636
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Nov 2010 18:43:07 -0700
Date: Wed, 17 Nov 2010 17:43:03 -0800
From: James Takahashi <takahash@us.ibm.com>
Message-ID: <20101118014303.GA30825@us.ibm.com>
References: <AANLkTik8zF-X21KAUjYWeB2FhNVX61oc5ptMffXBnukJ@mail.gmail.com>
	<AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>
	<4CDAA3CA020000E80006AF93@novprvoes0310.provo.novell.com>
	<AANLkTimOfSA_9ixATpX32a_7ytz8zdYLjLr_PZiegcmf@mail.gmail.com>
	<1289458673.5622.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
To: LTP list <ltp-list@lists.sourceforge.net>
Cc: "iranna.ankad" <iranna.ankad@in.ibm.com>, takahash <takahash@us.ibm.com>

> > On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> > 
> > Answering my own question:
> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html
> > , I asked this earlier on this year and someone replied saying "don't
> > remove it". If it's not removed and serves a particular purpose, maybe
> > it should be moved to a different section of the tree to avoid
> > confusion in the future (in particular if it's a framework and not
> > actually a test / test suite).

Yeah, that was me.

I now understand that the LTP Makefile reorganization from earlier in
the year attempts to recursively build everything that lives under
'testcases' due to the (reasonable) assumption that everything in
'testcases' is a subtest to be executed under LTP control.

'pounder', however, is not a subtest to be executed under LTP control.
It is a separate test execution framework, and in fact, executes LTP's
'runltp' as a subtest within that framework.  This allows us to run
other standalone tests, test suites, and/or benchmarks along side LTP.

I agree that it would make sense to move pounder21 to some other place
in the tree.  At first glance, 'utils' looks like a reasonable spot.
Thoughts?

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
