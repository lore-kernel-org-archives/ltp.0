From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 15:24:22 +0200
Subject: [LTP] [PATCH] lib/tst_tmpdir: tst_get_tmpdir() add error handing
In-Reply-To: <b208d879-0d31-ff16-4ef0-d363e9a65c51@jv-coder.de>
References: <20210806032131.25721-1-zhanglianjie@uniontech.com>
 <b208d879-0d31-ff16-4ef0-d363e9a65c51@jv-coder.de>
Message-ID: <YREshhDwOKlFpbbi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -	return strdup(TESTDIR);
> > +	ret = strdup(TESTDIR);
> Is a failing strdup here really a thing? The only reason strdup should 
> be able to fail is with ENOMEM.
> The only way tst_brkm will work, if strdup fails here is, if TESTDIR is 
> an extremely huge string (the NULL case is already handled above).

It's unlikely, but it may happen if:

* Someone runs memeater on the baground along with LTP
* And kernel is set not to overcommit

And in a case of the test lirary I would rather see it written so that
we check everything, even the unlikely errors.

-- 
Cyril Hrubis
chrubis@suse.cz
