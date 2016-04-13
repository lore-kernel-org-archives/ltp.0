From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 14:55:35 +0200
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160413065818.GF17476@localhost.localdomain>
References: <20160412132256.GA7441@localhost.localdomain>
 <20160412155230.GB2917@rei.suse.cz>
 <20160413065818.GF17476@localhost.localdomain>
Message-ID: <20160413125535.GF10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>  testcases/kernel/syscalls/waitpid/waitpid03.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
> index 2599a92..7e9d45c 100644
> --- a/testcases/kernel/syscalls/waitpid/waitpid03.c
> +++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
> @@ -106,7 +106,16 @@ int main(int argc, char **argv)
>  				if (DEBUG)
>  					tst_resm(TINFO, "child # %d", ikids);
>  			} else if (pid[ikids] == -1) {
> -				tst_resm(TFAIL, "cannot open fork #%d", ikids);
> +				int i;
> +
> +				tst_resm(TBROK|TERRNO, "cannot open fork #%d",
> +					 ikids);
> +
> +				for (i = 1; i < ikids; i++)
> +					kill(pid[i], 9);
> +
> +				cleanup();
> +				tst_exit();

This one is ugly. Why don't we kill the children in the test cleanup()
here as well. This should be easy, just store the number of allready
forked kids in a global variable and reset it to zero right after they
were killed in the main loop.

-- 
Cyril Hrubis
chrubis@suse.cz
