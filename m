From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 16:59:09 +0100
Subject: [LTP] [PATCH V2 07/32] replace SIGCLD with SIGCHLD
In-Reply-To: <1452302060-103643-7-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-7-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202155909.GH19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/connectors/pec/pec_listener.c
> +++ b/testcases/kernel/connectors/pec/pec_listener.c
> @@ -20,6 +20,7 @@
>  /*                                                                            */
>  /******************************************************************************/
>  
> +#define _GNU_SOURCE
>  #include <sys/socket.h>
>  #include <sys/poll.h>
>  #include <sys/types.h>

Why is the _GNU_SOURCE needed here. And moreover it should be in
separate patch anyway.

The rest of the patch is fine.

-- 
Cyril Hrubis
chrubis@suse.cz
