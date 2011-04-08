Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q8CNS-0003yb-Dn
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 14:09:34 +0000
Date: Fri, 8 Apr 2011 16:33:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110408143324.GA21327@saboteur.suse.cz>
References: <1302173275-19016-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1302173275-19016-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH] mem: mbind01: not work in 32bit system
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
Could you, pretty please, split this into patch that fixes 32bit systems
and patch that moves the testcase (as it is now, it's hard to pinpoint
the actuall change without comparing these two files by hand).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
