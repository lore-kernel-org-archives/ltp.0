From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Mar 2020 12:23:32 +0100
Subject: [LTP] [PATCH v3] syscalls/add_key05: add maxbytes/maxkeys test
 under unprivileged user
In-Reply-To: <1584527574-28177-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200317123203.GA21921@dell5510>
 <1584527574-28177-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200319112332.GB440@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> This case is designed to test whether we can reach maxbytes/maxkeys
> quota exactly under unprivileged users. It is a regression test for
> commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly").
> But this kenrel commit is a incomplete fix, it still fails on lastest
nit: typos: kenrel, lastest (will be fixed during merge).
> upstream kernel. Fix patch[1] is on linux-next branch.

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2e356101e72a
I guess this commit get's preserved when merged in mainline, so we don't have to
wait for it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM except one concern about ltpuser setup.

> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
...
> + * Test unprivileged user can support the number of keys and the
> + * number of bytes consumed in payloads of the keys. The defalut
> + * value is 200 and 20000.
> + * This is also a regresstion test for
nit: typos: defalut, regresstion (will be fixed during merge).

> + * commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
> + * commit 2e356101e72a ("KEYS: reaching the keys quotas correctly")
> + */

> +struct passwd *ltpuser;
...
> +static void add_user(void)
> +{
> +	if (user_added)
> +		return;
> +
> +	const char *const cmd_useradd[] = {"useradd", username, NULL};
> +	int rc;
> +
> +	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> +	case 0:
> +		user_added = 1;
> +		ltpuser = SAFE_GETPWNAM(username);
> +		break;
> +	case 1:
> +	case 255:
> +		break;
> +	default:
> +		tst_brk(TBROK, "Useradd failed (%d)", rc);
> +	}
> +	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
> +}
ltpuser is undefined for 1 and 255, therefore it gets SIGSEGV. It should either
require tst_run_cmd to exit 0 or use 0 as UID (root UID).

Kind regards,
Petr
