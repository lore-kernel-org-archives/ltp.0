From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Tue, 13 Oct 2020 13:22:51 +0900
Subject: [LTP] [PATCH] syscalls/mq_notify: Don't fail if mq_notify is
 not supported
In-Reply-To: <20201005092029.3482531-1-punit1.agrawal@toshiba.co.jp> (Punit
 Agrawal's message of "Mon, 5 Oct 2020 18:20:29 +0900")
References: <20201005092029.3482531-1-punit1.agrawal@toshiba.co.jp>
Message-ID: <87d01mdaas.fsf@kokedama.swc.toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[ cc'ing Petr and Cyril ]

Punit Agrawal <punit1.agrawal@toshiba.co.jp> writes:

> When CONFIG_POSIX_MQUEUE is configured off, the mq_notify02 test
> erroneously reports a failure rather than a missing configuration.
>
> Update the test case to call this out separate to the failure case.
>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
> Hi,
>
> Noticed the issue while analysing test report on a system with
> CONFIG_POSIX_MQUEUE turned off.
>
> Please cc me on comments as I'm not subscribed to the list.
>
> Thanks,
> Punit
>
>  testcases/kernel/syscalls/mq_notify/mq_notify02.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify02.c b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
> index fe59b5a11..e2269cd8e 100644
> --- a/testcases/kernel/syscalls/mq_notify/mq_notify02.c
> +++ b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
> @@ -77,6 +77,8 @@ static void mq_notify_verify(struct test_case_t *test)
>  
>  	if (TEST_ERRNO == test->exp_errno) {
>  		tst_resm(TPASS | TTERRNO, "mq_notify failed as expected");
> +	} else if (TEST_ERRNO == ENOSYS) {
> +		tst_resm(TCONF | TTERRNO, "mq_notify not available (ENOSYS)");
>  	} else {
>  		tst_resm(TFAIL | TTERRNO,
>  			 "mq_notify failed unexpectedly; expected: %d - %s",

If there are no issues with the patch, it would be great to get this
patch merged.

Thanks,
Punit
