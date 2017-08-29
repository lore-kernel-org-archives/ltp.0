From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 11:08:25 +0200
Subject: [LTP] [PATCH v2] android: pty01: Fix pty01 test for Android.
In-Reply-To: <20170829002637.25643-1-sspatil@google.com>
References: <20170829002637.25643-1-sspatil@google.com>
Message-ID: <20170829090825.lgjzm5kqnnbhldhr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> The test fails because 'grantpt()' is a no-op in bionic and doesn't set
> the /dev/pts/X mode to '020600' as expected by the test. The change
> skips that check if __BIONIC__ is defined so the rest of the test(s)
> can proceed and detect other failures if any.

> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
> v1->v2
> ------
> - Change the check from __ANDROID__ to __BIONIC__

>  testcases/kernel/pty/pty01.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
> index cbcc65c97..283612d55 100644
> --- a/testcases/kernel/pty/pty01.c
> +++ b/testcases/kernel/pty/pty01.c
> @@ -99,9 +99,12 @@ static int test1(void)
>  		tst_brkm(TBROK, NULL, "uid mismatch");
>  	}

> +	 /* grantpt() is a no-op in bionic. */
> +#ifndef __BIONIC__
>  	if (st.st_mode != (S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP)) {
>  		tst_brkm(TBROK, NULL, "mode mismatch (mode=%o)", st.st_mode);
>  	}
> +#endif

>  	slavefd = open(slavename, O_RDWR);
>  	if (slavefd >= 0) {

LGTM (tested on Android API level 16).

I wonder, whether it's really better to use __BIONIC__ instead of __ANDROID__ (works with
both), but assume it is if it's really bionic specific.


Kind regards,
Petr
