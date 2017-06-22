From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jun 2017 17:09:32 +0200
Subject: [LTP] [PATCH v2 2/2] clone09: add a test for CLONE_NEWNET flag
In-Reply-To: <1496915851-5222-2-git-send-email-alexey.kodanev@oracle.com>
References: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
 <1496915851-5222-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170622150932.GC28231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void do_test(void)
> +{
> +	int def_val;
> +
> +	tst_res(TINFO, "create clone in a new netns with 'CLONE_NEWNET' flag");
> +
> +	SAFE_FILE_SCANF(sysctl_path, "%d", &sysctl_net);
> +	SAFE_FILE_PRINTF(sysctl_path, "%d", sysctl_net + 1);
> +
> +	clone_child();
> +	tst_reap_children();
> +
> +	if (sysctl_net_new == (sysctl_net + 1)) {
> +		tst_res(TFAIL, "sysctl params equal: %s=%d",
> +			sysctl_path, sysctl_net_new);
> +	}
> +
> +	SAFE_FILE_SCANF(sysctl_path_def, "%d", &def_val);
> +
> +	if (sysctl_net_new != def_val) {
> +		tst_res(TFAIL, "netns param init to non-default value %d",
> +			sysctl_net_new);
> +	}

We should restore the sysctl_path value here, in a case that we are
looping (the -i or -I options).

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
