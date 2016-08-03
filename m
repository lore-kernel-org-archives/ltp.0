From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 18:01:36 +0200
Subject: [LTP] [PATCH V2 1/4] waitpid06: use the new API
In-Reply-To: <1468940141-4342-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20160718130536.GC18221@rei.suse.cz>
 <1468940141-4342-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160803160136.GD25589@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This version looks very good, a few minor comment below.

> +	if (reap_children(-1, 0, fork_kid_pid, MAXKIDS)) {
> +		tst_res(TFAIL, "reap_children() failed");
> +		return;
>  	}

We already failed the test in the reap_children(), so this message is
redundand and we can just return here.

> +static void waitpid_test(void)
> +{
> +	int status;
> +
> +	child_1_pid = SAFE_FORK();
> +	if (child_1_pid == 0) {
> +		do_child_1();
> +	} else {
> +		SAFE_WAITPID(child_1_pid, &status, 0);
> +
> +		child_1_pid = 0;
> +
> +		if (!WIFEXITED(status))
> +			tst_brk(TBROK, "Child 1 exited abnormally");
> +
> +		if (WEXITSTATUS(status) != 0)
> +			tst_res(TFAIL, "Child 1 returned bad status");

This does not correctly propagate TBROK.

What we should do here is similar to the check_child_status() in the
tst_test.c.

I guess that the best course of action would be renaming reap_children()
to tst_reap_children() and remove static so that we can use it in the
tests as well.

-- 
Cyril Hrubis
chrubis@suse.cz
