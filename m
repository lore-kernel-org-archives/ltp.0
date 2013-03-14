Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGBHK-0004Xg-BM
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:45:18 +0000
Date: Thu, 14 Mar 2013 17:45:58 +0100
From: chrubis@suse.cz
Message-ID: <20130314164557.GC8894@rei.suse.cz>
References: <cover.1363246555.git.zliu@redhat.com>
	<054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/5] lib/mem: modified _gather_cpus() as
 _gather_node_cpus()
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> -static void _gather_cpus(char *cpus, long nd)
> +static void _gather_node_cpus(char *cpus, long nd)

I know that the function name starting with underscore was there
allready but can we please get rid of them (idealy in separate patch
either before or after this patch).

>  {
>  	int ncpus = 0;
> -	int i;
> +	int fd, i;
> +	long online;
>  	char buf[BUFSIZ];
> +	char path[BUFSIZ], path1[BUFSIZ];
>  
>  	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
>  		ncpus++;
>  
> -	for (i = 0; i < ncpus; i++)
> -		if (path_exist(PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i)) {
> +	for (i = 0; i < ncpus; i++) {
> +		snprintf(path, BUFSIZ,
> +			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
> +		if (path_exist(path, nd, i)) {
> +			snprintf(path1, BUFSIZ, "%s/online", path);
> +			/*
> +			 * No cpu0/online knob, as it can't support to
> +			 * on/offline cpu0, so if the 'nd' node contains
> +			 * cpu0, it should skip to check cpu0/online's value.
> +			 */
> +			if (i == 0)
> +				goto  next;

There are two spaces before the next.

> +			fd = open(path1, O_RDONLY);
> +			if (fd == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					 "open %s", path1);
> +			read_file(path1, buf);
> +			online = SAFE_STRTOL(cleanup, buf, 0, 1);
> +			if (online == 0)
> +				continue;

This part can be done with SAFE_FILE_SCANF() see include/safe_file_ops.h

> +next:
>  			sprintf(buf, "%d,", i);
>  			strcat(cpus, buf);
>  		}
> +	}
>  	/* Remove the trailing comma. */
>  	cpus[strlen(cpus) - 1] = '\0';
>  }
> @@ -563,7 +585,7 @@ void write_cpusets(long nd)
>  	snprintf(buf, BUFSIZ, "%ld", nd);
>  	write_cpuset_files(CPATH_NEW, "mems", buf);
>  
> -	_gather_cpus(cpus, nd);
> +	_gather_node_cpus(cpus, nd);
>  	write_cpuset_files(CPATH_NEW, "cpus", cpus);
>  
>  	snprintf(buf, BUFSIZ, "%d", getpid());

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
