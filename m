Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WujUd-0004r8-0j
	for ltp-list@lists.sourceforge.net; Wed, 11 Jun 2014 14:27:11 +0000
Date: Wed, 11 Jun 2014 16:26:58 +0200
From: chrubis@suse.cz
Message-ID: <20140611142658.GA15522@rei.suse.cz>
References: <538EE9A6.3030707@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <538EE9A6.3030707@oracle.com>
Subject: Re: [LTP] runtest/ipv6 tests
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Looking at the runtest/ipv6, ipv6_expect (empty file) and 
> runtest/ipv6_noexpect files, I didn't find any working ipv6 tests. If 
> you run those testruns (for example ipv6) some of the tests from there 
> will fail because there is no corresponding script/binary, another just 
> duplicate tcp_cmds groups and not related to ipv6.
> 
> My suggestion is to remove ipv6_expect, ipv6_noexpect groups, clean ipv6 
> (we can keep it for ipv6 tests).
> 
> Have I missed something here, any suggestions?

Sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
