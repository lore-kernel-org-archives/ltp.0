From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Jul 2018 11:10:57 +0200
Subject: [LTP] [PATCH] verify_caps_exec: Replace index() with strchr()
In-Reply-To: <20180624203456.30476-1-astrachan@google.com>
References: <20180624203456.30476-1-astrachan@google.com>
Message-ID: <20180703091057.pfvdfxelb2u6cewi@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> The index() function was removed in POSIX.2008. It is not implemented by
> Android's bionic C library for 64-bit platforms.

> Use the more portable strchr() function from C89.

> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
>  testcases/kernel/security/filecaps/verify_caps_exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
> index 2c5cc0b2a..7183d8b4a 100644
> --- a/testcases/kernel/security/filecaps/verify_caps_exec.c
> +++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
> @@ -186,7 +186,7 @@ static int fork_drop_and_exec(int keepperms, cap_t expected_caps)
>  				 "got a bad seqno (c=%d, s=%d, seqno=%d)", c, s,
>  				 seqno);
>  		}
> -		p = index(buf, '.');
> +		p = strchr(buf, '.');
>  		if (!p)
>  			tst_brkm(TFAIL, NULL,
>  				 "got a bad message from print_caps\n");

Thanks for your patch, merged.

BTW there are more uses of index() / rindex() in the project.


Kind regards,
Petr
