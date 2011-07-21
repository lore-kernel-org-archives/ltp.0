Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QjwbA-0007gN-FD
	for ltp-list@lists.sourceforge.net; Thu, 21 Jul 2011 16:59:44 +0000
Date: Thu, 21 Jul 2011 19:01:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110721170155.GC7179@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-7-git-send-email-yanpai.chen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309414787-2022-7-git-send-email-yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH 7/7] testcases: syscalls: close file descriptors
 before unlinking
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
> Ensure file descriptors are closed before unlinking them, or we cannot
> remove the generated directories after these tests. The leftover
> directories may cause tests failed in latter runs once the directory
> names are hit.

Basically all the patches but this one looks reasonably. Could you
please fix and resend the rest of the patches. Also have you tried to
change the setup to create files in TMP insted of PWD?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
