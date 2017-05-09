From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 May 2017 11:08:10 +0200
Subject: [LTP] [PATCH] Fix getcwd03 testcase by zeroing target buffer
 for readlink()
In-Reply-To: <20170506070042.GA30720@ls3530.fritz.box>
References: <20170504182346.GA4959@ls3530.fritz.box>
 <20170505093412.GB16729@rei.suse.de>
 <20170506070042.GA30720@ls3530.fritz.box>
Message-ID: <20170509090810.GA4150@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > According to the man(2) page of readlink(), a null byte is not appended to the
> > > target buffer. So applications need to make sure that the target buffer is
> > > zero-initialized, otherwise random bytes at the end of the returned string may
> > > exist. 
> > 
> > Good catch.
> > 
> > > This patch zero-initializes the on-stack char array "link" and thus fixes the
> > > testcase failure of getcwd03 on the hppa/parisc architecture (and maybe others).
> > 
> > Can we use the return value form the readlink instead?
> > 
> > 	r = SAFE_READLINK(.., buf, sizeof(buf)-1);
> > 	buf[r] = '\0';
> 
> Yes, that's possible.
> But we have in total three testcase which exhibit the same problem:
> 
> testcases/kernel/syscalls/openat/openat03.c:    SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
> testcases/kernel/syscalls/getcwd/getcwd03.c:    SAFE_READLINK(dir_link, link, sizeof(link));
> testcases/kernel/syscalls/open/open14.c:        SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
> 
> All of those use a temporary un-initialized buffer on the stack, so all
> would need this fix. On the hppa architecture I found those testcases
> failing randomly.

Ok.

> > The SAFE_READLINK() does catch the case where readlink() returns -1 and
> > passing size decreased by one should handle the corner case where the
> > path is truncated and return value is the size of the buffer we passed
> > to the readlink() call.
> 
> This still doesn't zero-terminate the buffer (which is on stack).
> 
> Instead I'd propose the patch below. It always zero-terminates the
> buffer and as such we would handle newly added testcases in future which
> will probably miss this readlink behaviour too.

Fixing the problem in SAFE_READLIN() is a good idea, comments below.

> ----------------
> 
> [PATCH] SAFE_READLINK() should return zero-terminated target buffer
> 
> According to the man(2) page of readlink(), a null byte is not appended
> to the target buffer. So applications need to make sure that the target
> buffer is zero-initialized, otherwise random bytes at the end of the
> returned string may exist.
> 
> Currently all users of SAFE_READLINK() get it wrong. This include the
> openat03, getcwd03 and open14 testcases which pass a temporary,
> un-initialized on-stack buffer to readlink().
> 
> This patch fixes SAFE_READLINK to always return a zero-terminated string
> and thus fixes the the failure of getcwd03 on the hppa/parisc
> architecture (and probably others).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index bffc5a17a..1267b0098 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -408,9 +408,17 @@ ssize_t safe_readlink(const char *file, const int lineno,
>  	rval = readlink(path, buf, bufsize);
>  
>  	if (rval == -1) {
> +		buf[0] = 0; /* clear buffer on error */

Clearing the buffer here is not really needed since the tst_brkm() will
abort the test anyway.

>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "%s:%d: readlink(%s,%p,%zu) failed",
>  			 file, lineno, path, buf, bufsize);
> +	} else {
> +		/* readlink does not append a null byte to the buffer.
> +		 * Add it now. */
> +		if ((size_t) rval < bufsize)
> +			buf[rval] = 0;
> +		else
> +			buf[bufsize-1] = 0;

This looks good.

>  	}
>  
>  	return rval;

-- 
Cyril Hrubis
chrubis@suse.cz
