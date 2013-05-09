Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UaQwU-0000xj-Fc
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 13:31:30 +0000
Date: Thu, 9 May 2013 15:32:32 +0200
From: chrubis@suse.cz
Message-ID: <20130509133232.GC4255@rei.suse.cz>
References: <518B618F.80400@cn.fujitsu.com> <518B6271.2030707@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <518B6271.2030707@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2]semctl/semctl01.c: Test features IPC_INFO,
 SEM_INFO and SEM_STAT
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +#ifdef __linux__
> +int TST_TOTAL = 13;
> +#else
>  int TST_TOTAL = 10;
> +#endif
> 
>  static int sem_id_1 = -1;
> 
> @@ -57,8 +65,14 @@ static void func_sval(void);
>  static void func_rmid(void);
>  static void child_cnt(void);
>  static void child_pid(void);
> +#ifdef __linux__
> +static void func_iinfo(int);
> +static void func_sinfo(void);
> +static void func_sstat(int);
> +#endif

Well the only part of the LTP that we promise that will build and run on
anything else than Linux is Open Posix Testsuite, so in my opinion these
ifdefs are not needed. Has anybody different opinion?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
