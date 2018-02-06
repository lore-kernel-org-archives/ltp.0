From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Feb 2018 12:41:12 +0100
Subject: [LTP] [PATCH] syscalls/keyctl07: skip test if syscall
	unavailable
In-Reply-To: <20180201190733.6935-1-smuckle.linux@gmail.com>
References: <20180201190733.6935-1-smuckle.linux@gmail.com>
Message-ID: <20180206114112.g2n4mmsku5inon22@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> If the child is unable to run the test because the syscall is
> unavailable TBROK is currently reported. Look for TCONF from the
> child and report that in this scenario instead.

> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> ---
>  testcases/kernel/syscalls/keyctl/keyctl07.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
> index 39f07eb5fbce..08a585b6c956 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl07.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
> @@ -106,6 +106,9 @@ static void do_test(void)
>  		return;
>  	}

> +	if (WIFEXITED(status) && WEXITSTATUS(status) == TCONF)
> +		tst_brk(TCONF, "syscall not implemented");
> +
>  	tst_brk(TBROK, "Child %s", tst_strstatus(status));
>  }

Pushed, thanks.

Kind regards,
Petr
