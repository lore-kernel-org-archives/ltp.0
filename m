From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 May 2020 03:40:51 -0400 (EDT)
Subject: [LTP] [PATCH v1 1/4] lib: add new cgroup test API
In-Reply-To: <20200527031430.22144-1-liwang@redhat.com>
References: <20200527031430.22144-1-liwang@redhat.com>
Message-ID: <535677442.13762982.1590565251771.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> +
> +void tst_cgroup_mem_set_maxbytes(long memsz)
> +{
> +	tst_cgroup_move_current(TST_CGROUP_MEMCG);

It seems a bit unexpected, that setting a limit also moves current
process to cgroup. If test forks two processes, it has to set maxbytes
twice, to get the desired side-effect.

> +
> +	if (tst_cg_ver & TST_CGROUP_V1)
> +		SAFE_FILE_PRINTF(PATH_CG1_MEM_LTP "/memory.limit_in_bytes", "%ld", memsz);
> +
> +	if (tst_cg_ver & TST_CGROUP_V2)
> +		SAFE_FILE_PRINTF(PATH_TMP_CG2_LTP "/memory.max", "%ld", memsz);
> +}
> +
> +void tst_cgroup_mem_set_maxswap(long memsz)
> +{
> +	tst_cgroup_move_current(TST_CGROUP_MEMCG);
> +
> +	if (tst_cg_ver & TST_CGROUP_V1)
> +		SAFE_FILE_PRINTF(PATH_CG1_MEM_LTP "/memory.memsw.limit_in_bytes", "%ld",
> memsz);
> +	if (tst_cg_ver & TST_CGROUP_V2)
> +		SAFE_FILE_PRINTF(PATH_TMP_CG2_LTP "/memory.swap.max", "%ld", memsz);
> +}
> --
> 2.21.1
> 
> 

