From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 17:37:18 +0100
Subject: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
In-Reply-To: <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
 <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
Message-ID: <YFDevk/wNwd3epod@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ruan,

> The logic is same as syscalls/getpid02, which is to check whether
> parent's pid equals child's ppid.
...

> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		ppid = getpid();
> -		pid = FORK_OR_VFORK();
> -		if (pid == -1)
> -			tst_brkm(TBROK, cleanup, "fork failed");
> -
> -		if (pid == 0) {
> -			TEST(getppid());
> -
> -			if (TEST_RETURN != ppid)
> -				errx(1, "getppid failed (%ld != %d)",
> -				     TEST_RETURN, ppid);
> -			else
> -				printf("return value and parent's pid "
> -				       "value match\n");
> -			exit(0);
> -		} else {
> -			SAFE_WAIT(cleanup, &status);
> -			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -				tst_resm(TFAIL,
> -					 "getppid functionality incorrect");
> -		}
Right, else part is safe to drop as it's being tested in fork_testrun(void).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
