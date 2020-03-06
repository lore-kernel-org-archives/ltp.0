From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Mar 2020 14:10:47 +0100
Subject: [LTP] [PATCH V5 04/10] syscalls/fsopen: New tests
In-Reply-To: <495a95969c63d67868b82d2b15bd663f19780d0e.1582779464.git.viresh.kumar@linaro.org>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <495a95969c63d67868b82d2b15bd663f19780d0e.1582779464.git.viresh.kumar@linaro.org>
Message-ID: <20200306131046.GC3375@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +			MOVE_MOUNT_F_EMPTY_PATH));
> +
> +	SAFE_CLOSE(fsmfd);
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "move_mount() failed");
> +		goto out;
> +	}
> +
> +	if (tst_is_mounted(MNTPOINT))
> +		tst_res(TPASS, "%s: fsopen() passed", tc->name);
> +
> +	SAFE_UMOUNT(MNTPOINT);

I gues sthat the SAFE_UMOUNT() should be inside of the if here and in
the rest of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
