From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 17:02:02 +0100
Subject: [LTP] [PATCH v5 3/5] llistxattr: improved code readability and
 stability
In-Reply-To: <1479212377-12830-4-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1479212377-12830-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1479212377-12830-4-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161205160201.GK22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	TEST(llistxattr(t->path, buf, t->size));
> -	if (TEST_RETURN != -1) {
> +	TEST(llistxattr(t->path, buf, sizeof(buf)));
> +	if (TEST_RETURN == 0) {
>  		tst_res(TFAIL, "llistxattr() succeeded unexpectedly");
> +		return;
> +	}

I've changed this check back to TEST_RETURN != -1 since the call must
return -1 on failure. The manual page says that it either returns -1 or
size of the copied data. Hence even if it returns -2 it's a bug in
libc/kernel.

And I've did the same change for the newly introduced listxattr() and
flistxattr() tests and pushed the rest of the patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
