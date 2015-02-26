Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQvQz-00050V-Nn
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 10:12:45 +0000
Date: Thu, 26 Feb 2015 11:12:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226101207.GC13639@rei.suse.de>
References: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
	<1424855586-9818-3-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424855586-9818-3-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 3/3] device-drivers/rcu/rcu_torture.sh: use
 default value for nreaders, fix types
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> * rcutorture module sets nreaders to twice the number of CPUs
> * fix rcutorture types, some of them were removed,
>   some merged together in commits 99f8891 (v3.11), 2ec1f2d (v3.12)

I guess that this change is not backward compatible, is it?

I guess that we should at least add a check to disable it on older
kernels.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
