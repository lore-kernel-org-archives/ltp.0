From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 15:14:15 +0100
Subject: [LTP] [PATCH] syscalls/fchmodat: fix test,
 don't use test current directory
In-Reply-To: <1454408074-3149-1-git-send-email-alexey.kodanev@oracle.com>
References: <1454408074-3149-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160202141415.GB19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -73,6 +73,7 @@ int main(int ac, char **av)
>  {
>  	int lc;
>  	int i;
> +	size_t k;
>  
>  	/* Disable test if the version of the kernel is less than 2.6.16 */
>  	if ((tst_kvercmp(2, 6, 16)) < 0) {
> @@ -104,6 +105,12 @@ int main(int ac, char **av)
>  			}
>  		}
>  
> +		for (k = 0; k < ARRAY_SIZE(tst_fds); ++k)
> +			SAFE_CLOSE(cleanup, tst_fds[k]);
> +
> +		SAFE_UNLINK(cleanup, testfile);
> +		SAFE_UNLINK(cleanup, testfile3);
> +		SAFE_RMDIR(cleanup, pathname);

Is there any reason why we call the setup_every_copy() for each
iteration instead of doing it once in the setup()?


Otherwise the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
