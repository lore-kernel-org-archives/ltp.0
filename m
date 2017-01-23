From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 17:07:50 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/mq_open: fix old tests + convert
 to use new API
In-Reply-To: <20170119153603.26881-1-pvorel@suse.cz>
References: <20170119153603.26881-1-pvorel@suse.cz>
Message-ID: <20170123160750.GH25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic changes, removed the now unused enum and fixed a
few over 80 character lines, thanks.

> ---
> Note about parsing results, there are too many cases (well there are quite a
> lot of tests). I used your version (added missing TPASS at the end). I have to
> say, I'd still prefer more complicated if stacement and less duplicity),
> something like this:
> 
> if (TEST_ERRNO != tc->err) {
> 	tst_res(TFAIL | TTERRNO, "%s unexpectedly expected errno: %d", tc->desc,
> 			TEST_ERRNO);
> 	goto CLEANUP;
> }
> 
> if ((tc->ret == 0 && TEST_RETURN < 0) ||
> 	(tc->ret < 0 && TEST_RETURN != tc->ret))
> 	tst_res(TFAIL | TTERRNO, "%s wrong return code: %ld", tc->desc,
> 			TEST_RETURN);
> else
> 	tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc, TEST_RETURN);

This one is not that bad, but I still prefer the more verbose one.

As far as code readability goes I think that the best solution is to
split the test into two, one for possitive cases and one (or a few more)
for negative ones...

-- 
Cyril Hrubis
chrubis@suse.cz
