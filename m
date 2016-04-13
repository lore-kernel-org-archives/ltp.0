From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 14:36:25 +0200
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
In-Reply-To: <20160413071111.GA26897@localhost.localdomain>
References: <20160413071111.GA26897@localhost.localdomain>
Message-ID: <20160413123625.GD10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +static void kill_children();
                           ^
			   missing void
>  static int fail;
> +static int fork_kid_pid[MAXKIDS] = { 0 };
                                        ^
					global variables are
					initialized to 0 automatically,
					no need for explicit
					initialization.

>  #ifdef UCLINUX
>  static char *argv0;
> @@ -92,7 +94,7 @@ int main(int ac, char **av)
>  {
>  	int kid_count, ret_val, status, nkids;
>  	int i, j, k, found;
> -	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
> +	int wait_kid_pid[MAXKIDS];
>  	int runtime;		/* time(sec) to run this process */
>  
>  	int lc;
> @@ -178,7 +180,8 @@ int main(int ac, char **av)
>  #endif
>  			}
>  			if (ret_val < 0) {
> -				tst_resm(TFAIL, "Fork kid 0 failed. errno = "
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					 "Fork kid 0 failed. errno = "
>  					 "%d", errno);
>  
>  			}
> @@ -196,8 +199,10 @@ int main(int ac, char **av)
>  #endif
>  			}
>  			if (ret_val < 0) {
> -				tst_resm(TFAIL, "Fork kid 1 failed. errno = "
> -					 "%d", errno);
> +				tst_resm(TBROK|TERRNO, "Fork kid 1 failed");
> +				kill_children();
> +				cleanup();
> +				tst_exit();

This is too ugly. What about killing the children in the test cleanup()
instead and zeroing the array that stores the pids at end of the test
iteration. We have to zero it anyway so that this works correctly when
test is executed with -i or -I. Then we could simply do
tst_brkm(TBROK|TERRNO, cleanup, "fork() failed"); here instead.

-- 
Cyril Hrubis
chrubis@suse.cz
