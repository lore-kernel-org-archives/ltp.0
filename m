From: Enji Cooper <yaneurabeya@gmail.com>
Date: Mon, 25 Feb 2019 09:33:30 -0800
Subject: [LTP] [PATCH] setregid01: Fix security warning for string
	formatting
In-Reply-To: <20190225171220.5827-1-daniel.diaz@linaro.org>
References: <20190225171220.5827-1-daniel.diaz@linaro.org>
Message-ID: <7D6A5A37-20BB-4B57-B590-4A5AD0F4AEF1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


> On Feb 25, 2019, at 09:12, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> 
> GCC 8.2.0 complains with the following:
>  setregid01.c: In function 'run':
>  setregid01.c:47:3: error: format not a string literal and no format arguments [-Werror=format-security]
>     tst_res(TFAIL | TTERRNO, tc->msg);
>     ^~~~~~~
> because there is no string formatting in the message. This can
> be seen with CFLAGS set to:
>  -Wformat -Wformat-security -Werror=format-security
> as Yocto Project's Poky does, e.g.:
>  http://errors.yoctoproject.org/Errors/Details/230043/
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
> testcases/kernel/syscalls/setregid/setregid01.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
> index f2e41e134..8c9e11918 100644
> --- a/testcases/kernel/syscalls/setregid/setregid01.c
> +++ b/testcases/kernel/syscalls/setregid/setregid01.c
> @@ -44,9 +44,9 @@ static void run(unsigned int n)
>    TEST(SETREGID(*tc->arg1, *tc->arg2));
> 
>    if (TST_RET == -1)
> -        tst_res(TFAIL | TTERRNO, tc->msg);
> +        tst_res(TFAIL | TTERRNO, "%s", tc->msg);
>    else
> -        tst_res(TPASS, tc->msg);
> +        tst_res(TPASS, "%s", tc->msg);
> }
> 
> static void setup(void)
> -- 
> 2.17.1

LGTM!
