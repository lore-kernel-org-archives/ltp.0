From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 May 2018 15:16:31 +0200
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving
 EXTPROC|ICANON terminal mode
In-Reply-To: <20180513000101.13027-1-ebiggers3@gmail.com>
References: <20180513000101.13027-1-ebiggers3@gmail.com>
Message-ID: <20180518131631.GA32299@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
> +	SAFE_IOCTL(pts, FIONREAD, &nbytes);

I've added two SAFE_CLOSE() here so that the test works with the -i 1000
as well and pushed, thanks.

> +	tst_res(TPASS, "Got to the end without hanging");
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
