From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 13:13:50 +0200
Subject: [LTP] [PATCH v4] Test for CVE-2017-5669 in shmat
In-Reply-To: <20170720100927.996-1-rpalethorpe@suse.com>
References: <20170719145054.GK1015@rei.lan>
 <20170720100927.996-1-rpalethorpe@suse.com>
Message-ID: <20170720111349.GA32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int shm_id;
> +static void *shm_addr;
> +
> +static void setup(void)
> +{
> +	shm_id = SAFE_SHMGET(IPC_PRIVATE, getpagesize(), 0777);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (shm_addr)
> +		SAFE_SHMDT(shm_addr);
> +	shm_addr = 0;
> +
> +	if (shm_id)
> +		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
> +	shm_id = 0;
> +}

I've removed the assignments from here, since these were useless.

> +static void run(void)
> +{
> +	tst_res(TINFO, "Attempting to attach shared memory to null page");
> +	shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
> +	if (shm_addr == (void *)-1) {
> +		shm_addr = 0;
> +		if (errno == EINVAL) {
> +			tst_res(TPASS, "shmat returned EINVAL");
> +			return;
> +		}
> +		tst_brk(TBROK | TERRNO,
> +			"The bug was not triggered, but the shmat error is unexpected");
> +	}
> +
> +	tst_res(TINFO, "Mapped shared memory to %p", shm_addr);
> +
> +	if (!((size_t)shm_addr & (~0U << 16)))
> +		tst_res(TFAIL,
> +			"We have mapped a VM address within the first 64Kb");
> +	else
> +		tst_res(TPASS,
> +			"The kernel assigned a different VM address");
> +
> +	tst_res(TINFO,
> +		"Touching shared memory to see if anything strange happens");
> +	((char *)shm_addr)[0] = 'P';
> +
> +	SAFE_SHMDT(shm_addr);
> +	shm_addr = 0;
> +}

And used NULL for shm_addr ones and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
