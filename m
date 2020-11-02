From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Nov 2020 13:00:14 +0100
Subject: [LTP] [PATCH v2] Convert dup01 to new API and clean up
In-Reply-To: <20201102082751.9807-1-radoslav.kolev@suse.com>
References: <20201102082751.9807-1-radoslav.kolev@suse.com>
Message-ID: <20201102120014.GB7653@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(dup(fd));
> +	
   ^
   Trailing whitespace
> +	if (TST_RET < -1) { 
                           ^
			   Here as well.

You can use checkpatch.pl from kernel sources to check for these (and a
few more common coding style violations) before submitting.

> +		tst_brk(TBROK, "Invalid dup() return value %ld", TST_RET);

I would argue that this is a TFAIL since TBROK means that test has
failed in preparation phase.


Other than these two minor issues the rest is good.

I can fix these two issues before applying if you agree, no need to send
a v3.

-- 
Cyril Hrubis
chrubis@suse.cz
