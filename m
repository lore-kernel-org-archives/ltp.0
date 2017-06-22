From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jun 2017 16:25:06 +0200
Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
In-Reply-To: <1763007177.41308824.1498139900018.JavaMail.zimbra@redhat.com>
References: <20170620134218.13461-1-chrubis@suse.cz>
 <20170620134218.13461-2-chrubis@suse.cz>
 <1505342784.40797880.1498048926551.JavaMail.zimbra@redhat.com>
 <432037044.41235917.1498127551219.JavaMail.zimbra@redhat.com>
 <20170622134512.GB8678@rei.suse.de>
 <1763007177.41308824.1498139900018.JavaMail.zimbra@redhat.com>
Message-ID: <20170622142506.GA28231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> No, nothing at the time nanosleep01 was running.
> 
> We carry patch below in our tests, so it's easier to link some dmesg
> output with testcases.
> 
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index cee71aa..79dc3fa 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -1360,6 +1360,12 @@ static void write_test_start(struct tag_pgrp *running)
>  		     running->cmd->cmdline, "", "exit", "<<<test_output>>>");
>  	}
>  	fflush(stdout);
> +
> +	FILE *f = fopen("/dev/kmsg", "w");
> +	if (f) {
> +		fprintf(f, "ltptest %s start\n", running->cmd->name);
> +		fclose(f);
> +	}
>  }

That sounds reasonable. Maybe we can add an option to ltp-pan and runltp
to enable this.

-- 
Cyril Hrubis
chrubis@suse.cz
