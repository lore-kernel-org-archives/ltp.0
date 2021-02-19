From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 19 Feb 2021 15:57:59 +0000
Subject: [LTP] [PATCH 2/2] netns_netlink: Rewrite into new API
In-Reply-To: <20210219144704.20433-3-pvorel@suse.cz>
References: <20210219144704.20433-1-pvorel@suse.cz>
 <20210219144704.20433-3-pvorel@suse.cz>
Message-ID: <878s7k59tk.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> From: Richard Palethorpe <rpalethorpe@suse.com>

I don't remember this :-)

>
> This also require to rewrite netns_helper.h.
> New test still uses legacy libclone.h.

> ...

>  	pclose(ipf);
> @@ -67,14 +53,14 @@ static void check_netns(void)
>  	int pid, status;
>  	/* Checking if the kernel supports unshare with netns capabilities. */
>  	if (CLONE_NEWNS == -1)
> -		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS (%d) not supported",
> +		tst_brk(TCONF | TERRNO, "CLONE_NEWNS (%d) not supported",
>  			 CLONE_NEWNS);
>  
>  	pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS,
>  	                            dummy, NULL);

I guess you are considering replacing this with something that uses
SAFE_CLONE?

This should be quite easy as this function is not cloning with CLONE_VM
or anything special. It is just fork() with CLONE_NEWNET | CLONE_NEWNS,
so we probably don't need most of the wierdness in libclone.

-- 
Thank you,
Richard.
