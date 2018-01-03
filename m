From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Jan 2018 15:38:36 +0100
Subject: [LTP] [PATCH v2] syscalls/migrate_pages03.c: Add new regression
	test
In-Reply-To: <1514198251-8249-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171130152005.GH2924@rei>
 <1514198251-8249-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180103143836.GA7370@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/* Wait at least two full scans to guarantee merging */
> +static void wait_ksmd_full_scan(void)
> +{
> +	unsigned long exp_scans, get_scans;
> +	int count = 0;
> +
> +	SAFE_FILE_SCANF(KSM_PATH "full_scans", "%lu", &get_scans);
> +	exp_scans = get_scans + 3;
> +	while (get_scans < exp_scans) {
> +		sleep(1);
> +		count++;
> +		SAFE_FILE_SCANF(KSM_PATH "full_scans", "%lu", &get_scans);
> +	}
> +
> +	tst_res(TINFO, "ksmd takes %ds to run two full scans", count);
> +}

I do not like that this piece of code has been copied from the lib/mem.c.

Cleaner solution will move the function to testcases/kernel/lib/ksm.c
and create accompanying testcases/kernel/include/ksm.h header so that we
can link againts it here and in the ksm testcases as well in order to
retain only one copy of the function in the source tree.

-- 
Cyril Hrubis
chrubis@suse.cz
