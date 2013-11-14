Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgw6g-0005Iq-0t
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 12:33:10 +0000
Date: Thu, 14 Nov 2013 13:32:55 +0100
From: chrubis@suse.cz
Message-ID: <20131114123255.GB13348@rei>
References: <1383910521-12669-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383910521-12669-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: acpi: add new test for
 acpi-cpufreq driver
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
> +void *thread_fn(void *val)
> +{
> +	struct timeval tv_start;
> +	struct timeval tv_end;
> +	int i, res = 0;
> +	intptr_t timeout = (intptr_t) val;
> +
> +	gettimeofday(&tv_start, NULL);
> +	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
> +
> +	do {
> +		for (i = 1; i < 1000; ++i)
> +			res += i * i;
> +		gettimeofday(&tv_end, NULL);

One more thing, you should probably add sched_yield() here to make sure
the load_cpu() is executed after the sleep() has finished.

> +	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
> +
> +	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
> +
> +	return NULL;
> +}
> +
> +static int load_cpu(intptr_t timeout)
> +{
> +	pthread_t thread_id;
> +
> +	if (pthread_create(&thread_id, 0, thread_fn,
> +		(intptr_t *) timeout) != 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"pthread_create failed at %s:%d",
> +			__FILE__, __LINE__);
> +	}
> +
> +	sleep(2 * timeout / 3);
> +
> +	int cur_freq;
> +	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
> +	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
> +
> +	pthread_join(thread_id, NULL);
> +
> +	return cur_freq;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
