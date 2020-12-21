From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Dec 2020 22:25:01 +0100
Subject: [LTP] [PATCH] ltp-pan: Use long long int to print time_t
In-Reply-To: <20201221061415.2540216-1-raj.khem@gmail.com>
References: <20201221061415.2540216-1-raj.khem@gmail.com>
Message-ID: <20201221212501.GB4453@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> Some newer 32bit architectures ( e.g. riscv32 ) uses 64bit time_t so
> using %ld is not sufficient to print time_t, this also fixes a crash in
> ltp-pan on riscv32

> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, thank you!

Kind regards,
Petr

> ---
>  pan/ltp-pan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index 8b9fbe5594..54b7cb8f26 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -1389,8 +1389,8 @@ static void write_test_start(struct tag_pgrp *running, int no_kmsg)
>  	if (!strcmp(reporttype, "rts")) {

>  		printf
> -		    ("%s\ntag=%s stime=%ld\ncmdline=\"%s\"\ncontacts=\"%s\"\nanalysis=%s\n%s\n",
> -		     "<<<test_start>>>", running->cmd->name, running->mystime,
> +		    ("%s\ntag=%s stime=%lld\ncmdline=\"%s\"\ncontacts=\"%s\"\nanalysis=%s\n%s\n",
> +		     "<<<test_start>>>", running->cmd->name, (long long)running->mystime,
>  		     running->cmd->cmdline, "", "exit", "<<<test_output>>>");
>  	}
>  	fflush(stdout);
