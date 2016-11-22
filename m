From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 09:02:27 +0100
Subject: [LTP] [PATCH 1/2] lib: move create_sig_proc() into newlib
In-Reply-To: <20161122070953.za3jy6ww75dq2lj6@dell5510>
References: <20161116161833.16910-1-pvorel@suse.cz>
 <20161121145701.GF25334@rei.lan>
 <20161122070953.za3jy6ww75dq2lj6@dell5510>
Message-ID: <20161122080227.GC5620@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Shouldn't be including tst_safe_macros.h here enough?
> Well, create_sig_proc() uses SAFE_FORK macro (defined in tst_test.h), which uses (via
> safe_fork() function) tst_test structure (also defined in tst_test.h). That's probably the
> reason, why SAFE_FORK isn't in tst_safe_macros.h among with other SAFE_* macros.
> So I'd keep it as it is.

Ah, right, the SAFE_FORK() is special since we have do make sure stdio
is flushed before we call fork, etc.

-- 
Cyril Hrubis
chrubis@suse.cz
