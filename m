Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RQgJa-0005Ns-L6
	for ltp-list@lists.sourceforge.net; Wed, 16 Nov 2011 14:18:14 +0000
Date: Wed, 16 Nov 2011 15:24:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111116142448.GA344@saboteur.suse.cz>
References: <4EB7D4D6.5000704@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EB7D4D6.5000704@redhat.com>
Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
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
> If start_server() fails, then pid will end up with -1 and
> cleanup() will do kill(-1, SIGKILL), which kills everything
> this process can kill.
> 
> Change the test to kill pid (child) only when it successfully
> creates one.

Good catch, commited.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
