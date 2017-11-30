From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Nov 2017 14:12:59 +0100
Subject: [LTP] [PATCH v2 10/13] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171114155929.24237-11-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-11-punit.agrawal@arm.com>
Message-ID: <20171130131259.GB2924@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  //Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
>  
> -	if (count > 0)
> -		close(count);
>  	if (count == (max_val_opfiles - 1))
>  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));

We may also check for EMFILE here.

> +	else if (fd < 0 && errno == ENFILE)
> +		tst_brkm(TBROK, cleanup, "Reached maximum number of open files for the system");
                           ^
			   This should rather be TCONF i.e. skipped.

>  	else
>  		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
>  
> +	if (count > 0)
> +		close(count);
> +
>  	cleanup();
>  	tst_exit();
>  }
> -- 
> 2.14.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz
