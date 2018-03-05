From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Mar 2018 10:21:44 +0100
Subject: [LTP] [PATCH 3/3] syscalls/mknod*: Fix compiler warnings
In-Reply-To: <1519977744-1595-3-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1519977744-1595-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1519977744-1595-3-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180305092144.rjz2armav2w2zrn6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mknod/mknod02.c | 2 +-
>  testcases/kernel/syscalls/mknod/mknod03.c | 2 +-
>  testcases/kernel/syscalls/mknod/mknod04.c | 2 +-
>  testcases/kernel/syscalls/mknod/mknod05.c | 2 +-
>  testcases/kernel/syscalls/mknod/mknod08.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

> diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
> index e5741c3..594473e 100644
> --- a/testcases/kernel/syscalls/mknod/mknod02.c
> +++ b/testcases/kernel/syscalls/mknod/mknod02.c
> @@ -173,7 +173,7 @@ int main(int ac, char **av)
>  	}

>  	/* Change the directory back to temporary directory */
> -	chdir("..");
> +	SAFE_CHDIR(cleanup, "..");

>  	/*
>  	 * Invoke cleanup() to delete the test directories created
> diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
> index fc34686..2af66f7 100644
> --- a/testcases/kernel/syscalls/mknod/mknod03.c
> +++ b/testcases/kernel/syscalls/mknod/mknod03.c
> @@ -172,7 +172,7 @@ int main(int ac, char **av)
>  	}

>  	/* Change the directory back to temporary directory */
> -	chdir("..");
> +	SAFE_CHDIR(cleanup, "..");

>  	/*
>  	 * Invoke cleanup() to delete the test directories created
> diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
> index 6a8e08e..e0123ec 100644
> --- a/testcases/kernel/syscalls/mknod/mknod04.c
> +++ b/testcases/kernel/syscalls/mknod/mknod04.c
> @@ -172,7 +172,7 @@ int main(int ac, char **av)
>  	}

>  	/* Change the directory back to temporary directory */
> -	chdir("..");
> +	SAFE_CHDIR(cleanup, "..");

>  	/*
>  	 * Invoke cleanup() to delete the test directories created
> diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
> index a00a0e4..fbc5575 100644
> --- a/testcases/kernel/syscalls/mknod/mknod05.c
> +++ b/testcases/kernel/syscalls/mknod/mknod05.c
> @@ -171,7 +171,7 @@ int main(int ac, char **av)
>  	}

>  	/* change the directory back to temporary directory */
> -	chdir("..");
> +	SAFE_CHDIR(cleanup, "..");

>  	/*
>  	 * Invoke cleanup() to delete the test directories created
> diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
> index 3cc24ab..8647fde 100644
> --- a/testcases/kernel/syscalls/mknod/mknod08.c
> +++ b/testcases/kernel/syscalls/mknod/mknod08.c
> @@ -170,7 +170,7 @@ int main(int ac, char **av)
>  	}

>  	/* Change the directory back to temporary directory */
> -	chdir("..");
> +	SAFE_CHDIR(cleanup, "..");

>  	/*
>  	 * Invoke cleanup() to delete the test directories created

Pushed, thanks!

Kind regards,
Petr
