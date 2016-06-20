From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Jun 2016 14:17:59 +0200
Subject: [LTP] new ltp lib doesn't print actual error
In-Reply-To: <57618B7B.9070402@oracle.com>
References: <57618B7B.9070402@oracle.com>
Message-ID: <20160620121758.GB22157@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When running a test with the new LTP lib, noticed that if some error 
> occurs in a library (tst_tmpdir.c), it'll print the same message:
> 
> TMPDIR=/usr ./creat01
> tst_tmpdir.c:155: BROK: Non-NULL cleanup in newlib!
> 
> but should be:
> TMPDIR=/usr ./creat01
> tst_tmpdir.c:155: BROK: tst_tmpdir: mkdtemp(/usr/creF5DhMS) failed: EACCES
> 
> 
> May be we should remove the strict check in tst_res.c? Otherwise we 
> don't see the actual error.

Passing a cleanup callback from newlib testcase is always a mistake
because it's never executed. I would prefer keeping the check in the
library.

It does not matter in case of tmpdir_cleanup() since that function only
prints a warning message. What about removing the tmpdir_cleanup()
cleanup instead? It does not seem to be useful to me anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
