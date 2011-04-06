Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q7UpS-0001eU-ET
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 15:39:34 +0000
Date: Wed, 6 Apr 2011 18:03:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110406160314.GA13126@saboteur.suse.cz>
References: <4D7895BE.4050307@cn.fujitsu.com>
	<AANLkTikE75c=cxO_Gfqmf5bZn6mGG19qi+2EmxBk_q-s@mail.gmail.com>
	<4D9930D4.7000102@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D9930D4.7000102@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pidns05.c: fix suspend due to call waitpid()
 wrongly and wrong return code
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
I'll commit this to fix the test hang.

But still the pidns05.c code would need to be reviewed.

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
