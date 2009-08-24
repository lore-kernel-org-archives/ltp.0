Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MfYxL-0000oT-DA
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 12:47:27 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MfYxF-0003N5-66
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 12:47:27 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MfYx9-0004Wg-4q
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 13:47:15 +0100
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MfYx8-0004f9-UQ
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 13:47:15 +0100
Message-ID: <4A928BD0.4000508@canonical.com>
Date: Mon, 24 Aug 2009 07:47:12 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 00/02] Integrate Valgrind Memory Check Tool to LTP
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

Subrata Modak wrote:
> ./runltp -f <your-command-file> -M [1,2,3]
Due to runltp already becoming fairly bloated, and the fact that this is
really just to "test the tests", would it make sense to put it under
/scratch or /testscripts as a separate script, rather than just include
it as yet-another-option for runltp?

Thanks,
Paul Larson


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
