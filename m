Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QRREn-0007H0-Q2
	for ltp-list@lists.sourceforge.net; Tue, 31 May 2011 15:52:09 +0000
Date: Tue, 31 May 2011 17:48:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110531154853.GG7092@saboteur.suse.cz>
References: <4DE3011A.5000108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DE3011A.5000108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Add kernel tag checking to oom testcases.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> cgroup filesystem is used in testcases oom03 and oom04, but cgroup
> filesystem is not supported in kernel older than 2.6.24. So we should
> check the kernel tag first.

Still this doesn't help on kernels where cgroups are not compiled in.

What about changing the mount_mem() to exit the test with TCONF when
mount() returned ENODEV.

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
