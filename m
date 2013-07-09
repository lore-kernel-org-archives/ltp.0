Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwZKy-0005Q6-7X
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 14:56:16 +0000
Date: Tue, 9 Jul 2013 16:57:53 +0200
From: chrubis@suse.cz
Message-ID: <20130709145753.GA760@rei.Home>
References: <51D27187.2060003@cn.fujitsu.com> <51D274BD.5070707@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D274BD.5070707@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2 v2] mount/mount03.c: Test feature MS_NOATIME
 of mount(2)
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
> Additional test for features MS_NOATIME.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
> +	case 6:
> +		/* Validate MS_NOATIME flag of mount call */
> +
> +		snprintf(file, PATH_MAX, "%satime", path_name);
> +		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
> +		if (fd == -1) {
> +			tst_resm(TWARN | TERRNO, "opening %s failed", file);
> +			return 1;
> +		}
> +
> +		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
> +			tst_resm(TWARN | TERRNO, "write %s failed", file);
> +			return 1;
> +		}
> +
> +		if (fstat(fd, &file_stat) == -1) {
> +			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
> +			return 1;
> +		}
> +
> +		atime = file_stat.st_atime;
> +
> +		sleep(1);
> +
> +		if (read(fd, NULL, 20) == -1) {
> +			tst_resm(TWARN | TERRNO, "read %s failed", file);
> +			return 1;
> +		}
> +
> +		if (fstat(fd, &file_stat) == -1) {
> +			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
> +			return 1;
> +		}
> +		close(fd);
> +
> +		if (file_stat.st_atime != atime) {
> +			tst_resm(TWARN, "access time is updated");
> +			return 1;
> +		}
> +		return 0;
>  	}

This version looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
