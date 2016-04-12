From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 12:05:36 +0200
Subject: [LTP] [PATCH] waitpid/waitpid02: check if fork failed
In-Reply-To: <20160412030310.GA10416@localhost.localdomain>
References: <20160412030310.GA10416@localhost.localdomain>
Message-ID: <20160412100536.GB24915@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		} else {
> +			if (pid < 0) {
> +				tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
> +			}

The check should be done right after the fork() and not in the else
branch. Also there shoudln't be the curly braces around the tst_brkm()
since it's just a signle line.

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
