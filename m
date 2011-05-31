Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QRR3v-0000a6-TE
	for ltp-list@lists.sourceforge.net; Tue, 31 May 2011 15:40:55 +0000
Date: Tue, 31 May 2011 17:37:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110531153741.GB1901@saboteur.suse.cz>
References: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
	<5004B0F2-AD73-437F-995E-71B88F329A8E@gmail.com>
	<BANLkTik9irk3Yket8uK79H4d2X-5a8bYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTik9irk3Yket8uK79H4d2X-5a8bYcg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscall: sockioctl: fix except return
 val
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
To: Bob Liu <lliubbo@gmail.com>
Cc: ltp-list@lists.sf.net

Hi!
> Whether using tst_kvercmp() can be accepted ?

Sure. Ideally please add pointer to kernel commit that caused this
change in the test souce as a comment.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger. 
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today. 
http://p.sf.net/sfu/quest-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
