From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Dec 2017 14:18:37 +0100
Subject: [LTP] [PATCH v4 2/2] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171208140738.7985-2-punit.agrawal@arm.com>
References: <20171208140738.7985-1-punit.agrawal@arm.com>
 <20171208140738.7985-2-punit.agrawal@arm.com>
Message-ID: <20171211131837.GB10508@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -97,6 +98,8 @@ int main(void)
>  		close(count);
>  	if (count == (max_val_opfiles - 1))
>  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
> +	else if (fd < 0 && errno == ENFILE)
> +		tst_brkm(TBROK, cleanup, "Reached maximum number of open files for the system");
                           ^
			   Haven't we agreed that this should be TCONF?

No need to resend, I can update it before push.

-- 
Cyril Hrubis
chrubis@suse.cz
