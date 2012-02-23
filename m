Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0beD-0006kd-S1
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 16:36:01 +0000
Date: Thu, 23 Feb 2012 17:36:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223163631.GD20855@saboteur.suse.cz>
References: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] hugeshmat01 isn't adapt to mips with 64bit ELF
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Haotian.Zhang@windriver.com

Hi!
> Because userspace memory in mips with 64bit ELF is lower than 2^40,
> so shmat failed.
> 
> signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>

For now commited as it is, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
