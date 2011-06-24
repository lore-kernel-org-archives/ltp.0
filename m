Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qa7HC-0003ic-OW
	for ltp-list@lists.sourceforge.net; Fri, 24 Jun 2011 14:22:30 +0000
Date: Fri, 24 Jun 2011 16:22:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110624142223.GA26378@saboteur.suse.cz>
References: <mailman.181450.1307593246.21896.ltp-list@lists.sourceforge.net>
	<BANLkTikpV2jpTJ8_N3FhV0Y1S5p_8n-fPA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTikpV2jpTJ8_N3FhV0Y1S5p_8n-fPA@mail.gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 61, Issue 3
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
To: Shubham Goyal <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, hake huang <hakehuang@gmail.com>

Hi!
> I am rebasing my local git repository with ltp May release from
> git://ltp.git.sourceforge.net/gitroot/ltp/ltp, but I see no tag for
> May release. which commit is the last one for May release?

I've taken the liberty and tagged this release. Do we have a history of
release <-> last commit so I could tag older releases too?

And for the future we should add some kind of dummy commit with Release
XXXX commit message (The linux kernel usually changes VERSION or
EXTRAVERSION in Makefile). I could assist with that if you ask.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a 
definitive record of customers, application performance, security 
threats, fraudulent activity and more. Splunk takes this data and makes 
sense of it. Business sense. IT sense. Common sense.. 
http://p.sf.net/sfu/splunk-d2d-c1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
