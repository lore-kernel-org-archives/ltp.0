Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UIIpG-0007bH-9B
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 13:13:06 +0000
Date: Wed, 20 Mar 2013 14:13:46 +0100
From: chrubis@suse.cz
Message-ID: <20130320131346.GA11619@rei.suse.cz>
References: <165189158.21613313.1363773111224.JavaMail.root@redhat.com>
	<1973851267.21619084.1363773460784.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1973851267.21619084.1363773460784.JavaMail.root@redhat.com>
Subject: Re: [LTP] Coverity report for ltp-20130320
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> This run is with LTP git snapshot from 20130320 (on top of RHEL6.4),
> the results now include also Open Posix testcases:
> http://jan.stancek.eu/coverity/ltp-20130320-1.el6.err.xz

Looking at the results for open posix testsuite some of the reports
should have been reported as compilation warnings. I've commited a patch
that enables warnings in the open posix testsuite. Patches to make it
less noisy and to fix obvious problems will follow.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
