From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 22:33:38 +0100
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <20200317213338.GB4871@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TERRNO, "fsopen() failed");
Just a note all these tst_brk/tst_res after TEST() should use TTERRNO, not TERRNO.
Although TERRNO will probably work in this case as well, it'd be better to use
TTERRNO (see lib/tst_res.c).

Kind regards,
Petr
