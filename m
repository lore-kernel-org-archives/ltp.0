Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYGio-0002qY-Sw
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 11:31:06 +0000
Date: Thu, 30 Dec 2010 12:46:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230114630.GA18817@saboteur.suse.cz>
References: <1108110757.253081291707011009.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<672887900.253121291707014153.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <672887900.253121291707014153.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v6] overcommit libhugetlbfs and check the
 statistics
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

> +#define PROTECTION		(PROT_READ | PROT_WRITE)
> +#define _PATH_MEMINFO		"/proc/meminfo"
> +#define _PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
> +#define _PATH_SYS_2M		_PATH_SYS_HUGE "/hugepages-2048kB/"
> +#define _PATH_SYS_2M_OVER	_PATH_SYS_2M "nr_overcommit_hugepages"
> +#define _PATH_SYS_2M_FREE	_PATH_SYS_2M "free_hugepages"
> +#define _PATH_SYS_2M_RESV	_PATH_SYS_2M "resv_hugepages"
> +#define _PATH_SYS_2M_SURP	_PATH_SYS_2M "surplus_hugepages"
> +#define _PATH_SYS_2M_HUGE	_PATH_SYS_2M "nr_hugepages"
> +#define _PATH_PROC_VM		"/proc/sys/vm/"
> +#define _PATH_PROC_OVER		_PATH_PROC_VM "nr_overcommit_hugepages"
> +#define _PATH_PROC_HUGE		_PATH_PROC_VM "nr_hugepages"
> +#define _PATH_SHMMAX		"/proc/sys/kernel/shmmax"
> +#define MB			(1024 * 1024)

As I said before, names starting with uderscore are reserved for
compiler/standard library implementation and should not be used unless
you are writing compiler/standard library ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
