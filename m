From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Mar 2021 15:14:58 +0100
Subject: [LTP] [PATCH] open_posix: Add all logfiles to gitignore
In-Reply-To: <20210316065542.1221203-1-lkml@jv-coder.de>
References: <20210316065542.1221203-1-lkml@jv-coder.de>
Message-ID: <YFC9YpMiYqYnRY2W@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/open_posix_testsuite/.gitignore b/testcases/open_posix_testsuite/.gitignore
> index 7ddf3cd90..ad281df14 100644
> --- a/testcases/open_posix_testsuite/.gitignore
> +++ b/testcases/open_posix_testsuite/.gitignore
> @@ -13,3 +13,5 @@
>  
>  /bin/t0
>  run.sh
> +
> +logfile
> \ No newline at end of file

Can you please setup your $EDITOR to add newline at the end of the files?

-- 
Cyril Hrubis
chrubis@suse.cz
