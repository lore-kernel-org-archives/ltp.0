Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vljjo-0004jv-SK
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 18:21:24 +0000
Date: Wed, 27 Nov 2013 19:20:56 +0100
From: chrubis@suse.cz
Message-ID: <20131127182055.GB8163@rei>
References: <1384853285-14025-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384853285-14025-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] device-drivers: acpi: add new test for
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
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"disable overclocking required Linux 3.7+");
> +	}

I wonder if we need to compare kernel version, becasuse we disable the
test if the boost sysfs file is missing anyway...

If you agree to remove it I will do that while applying the patch, no
need to send a new version.

> +	if (access(boost, R_OK | W_OK)) {
> +		tst_brkm(TCONF, NULL,
> +			"acpi-cpufreq not loaded or overclock not supported");
> +	}
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	SAFE_FILE_SCANF(NULL, boost, "%d", &boost_value);
> +
> +	SAFE_FILE_SCANF(NULL, up_limit, "%d", &threshold);
> +
> +	/* change cpu0 scaling governor */
> +	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
> +	SAFE_FILE_PRINTF(cleanup, governor, "%s", "userspace");
> +
> +	/* use only cpu0 */
> +	cpu_set_t set;
> +	CPU_ZERO(&set);
> +	CPU_SET(0, &set);
> +	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
> +
> +	SAFE_FILE_PRINTF(cleanup, up_limit, "11");
> +}

Otherwise it looks good but has to wait for the first ACPI patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
