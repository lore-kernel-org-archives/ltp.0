From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 09:48:35 +0100
Subject: [LTP] [PATCH V6 10/10] syscalls/open_tree: New tests
In-Reply-To: <6648a9106e367d370012c8ee1d0d81c369779ba8.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <6648a9106e367d370012c8ee1d0d81c369779ba8.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <20200313084835.GA15154@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
...
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +	SAFE_MKDIR(OT_MNTPOINT, 0777);
This fails, because setup (and cleanup) is run fo each filesystem. Therefore it
needs to be created just once.
safe_macros.c:172: BROK: open_tree01.c:27: mkdir(ot_mntpoint,0777) failed: EEXIST (17)

Kind regards,
Petr
