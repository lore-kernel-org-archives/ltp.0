Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WAg4a-0002PF-Dj
	for ltp-list@lists.sourceforge.net; Tue, 04 Feb 2014 13:29:56 +0000
Date: Tue, 4 Feb 2014 14:29:22 +0100
From: chrubis@suse.cz
Message-ID: <20140204132922.GA6597@rei>
References: <1387171228-505-1-git-send-email-xu.simon@oracle.com>
	<52BA3898.3050909@oracle.com> <52DDD0ED.6040702@oracle.com>
	<2085388669.1674106.1391081515715.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2085388669.1674106.1391081515715.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] sctp: Avoid using file descriptor 0 to
	get	ENOTSOCK
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Given that this is identical to c43ead6daa0b9ae5763d6cf3d21357a789651417 from
> https://github.com/borkmann/lksctp-tools :
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>

I would be tempted to put the repeated code fragemnts into single place
(header included by all of the testcases). But given that the patch is
in upstream I'm OK with applying it in LTP as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
