From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 14:51:52 +0200
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160413032907.GE17476@localhost.localdomain>
References: <20160412132256.GA7441@localhost.localdomain>
 <20160412155230.GB2917@rei.suse.cz>
 <20160413032907.GE17476@localhost.localdomain>
Message-ID: <20160413125152.GE10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -				tst_resm(TFAIL, "cannot open fork #%d", ikids);
> +				int i;
> +
> +				for (i = 1; i < ikids; i++)
> +					kill(pid[i], 9);
> +
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					 "cannot open fork #%d", ikids);

The problem is that the errno may get clobbered by the call to the
kill().

-- 
Cyril Hrubis
chrubis@suse.cz
