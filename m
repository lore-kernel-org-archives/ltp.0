Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WajQo-0001fu-HS
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:20:34 +0000
Date: Thu, 17 Apr 2014 12:19:47 +0200
From: chrubis@suse.cz
Message-ID: <20140417101947.GB6558@rei.suse.cz>
References: <20140417114711.4268c826@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417114711.4268c826@mats-desktop>
Subject: Re: [LTP] How to handle background load
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> There are several options to runltp for creating background loads, e.g.
> -n, -i and -m. For some test cases this is valuable, for others it
> doesn't (or at least shouldn't) matter for yet others they are a big
> no-no.
> 
> Is there any way a test case can express what kinds of load that is
> recommended and/or not compatible with the test case?

Not at the moment.

There are also other metadata that are currently missing, for example
per test timeouts.

> It would be nice if runltp could dynamically adapt the load being used
> depending on which test case that is scheduled. Does it do this
> already, or are there any plans in this area?

The part of LTP that executes testcases (runltp, ltp-pan, etc..) didn't
get much updates (nothing apart for a few fixes) and I consider these in
a state where complete rewrite would be easier than trying to fix and
enhance what we have at the moment.

I've started to desing new system and prototype a code to replace runltp
and ltp-pan but so far haven't had time to make it good enough to be
usable (mostly because fixing testcase failures has greater priority).

What I have in the plan is to create a bit more complicated runtest
files that would include timeouts, labels, etc. We can add the
background load requirements there too. However I cannot promise that
the new system will be ready anytime soon.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
