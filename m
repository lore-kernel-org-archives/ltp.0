From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 11:58:33 +0200
Subject: [LTP] [PATCH] shmctl01: don't use hardcoded index == 0 for
 SHM_STAT test
In-Reply-To: <a5e65ca65d88177d9142cbd2d5a3ddf5dda174b5.1558379215.git.jstancek@redhat.com>
References: <a5e65ca65d88177d9142cbd2d5a3ddf5dda174b5.1558379215.git.jstancek@redhat.com>
Message-ID: <20190521095833.GA12205@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void func_sstat_setup(void)
> +{
> +	struct shm_info tmp;
> +	int ret;
> +
> +	ret = shmctl(shm_id_1, SHM_INFO, (void *)&tmp);
> +	if (ret < 0)
> +		tst_resm(TFAIL|TERRNO, "shmctl(SHM_INFO)");

I wonder if it makes sense to continue here if shmctl() has failed,
maybe we should do tst_brkm(TBROK ...) instead.

Otherwise it looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
