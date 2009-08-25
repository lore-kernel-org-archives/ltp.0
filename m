Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1Mg3Ta-0004Km-8c
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 21:22:46 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mg3TT-0007GY-L2
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 21:22:46 +0000
Message-ID: <4A945616.7000805@canonical.com>
Date: Tue, 25 Aug 2009 16:22:30 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>	
	<4A928BD0.4000508@canonical.com>
	<1251195139.5534.32.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1251195139.5534.32.camel@subratamodak.linux.ibm.com>
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
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Subrata Modak wrote:

>> really just to "test the tests", would it make sense to put it under
>> /scratch or /testscripts as a separate script, rather than just include
>> it as yet-another-option for runltp?
> 
> But, creating another script say under testscripts will be to duplicate
> again runltp code, as the same script should be able to parse all the
> options what we use with runltp. So, keeping it in runltp will just a
> little overhead. And, may be we can introduce some longoptions or
> manpage for ltp as suggested by people earlier !!

It doesn't need to have anywhere near the same options available as
under runltp.  Other than being able to specify a set of tests to run, I
can't really think of a need for many of the others.

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
