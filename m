From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 17:57:59 +0200
Subject: [LTP] [PATCH v5 4/7] Add new CGroups API library tests
In-Reply-To: <20210430112649.16302-5-rpalethorpe@suse.com>
References: <20210430112649.16302-1-rpalethorpe@suse.com>
 <20210430112649.16302-5-rpalethorpe@suse.com>
Message-ID: <YIwpB45c8K8QpR2N@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	SAFE_CGROUP_PRINTF(cg, "memory.max", "%zu", (1UL << 24) - 1);
> +	SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> +	SAFE_CGROUP_SCANF(cg, "memory.current", "%zu", &mem);
> +	tst_res(TPASS, "memory.current = %zu", mem);
> +
> +	tst_reap_children();
> +	SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
> +	cg_child = tst_cgroup_group_rm(cg_child);

I'm not sure that we want to cleanup the pointer like this, the more
usuall way would be passing &cg_child to the function, but this is very
minor.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
