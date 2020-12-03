From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2020 13:16:42 +0100
Subject: [LTP] [PATCH 1/2] lib: tst_test.c: Add TBROK counter.
In-Reply-To: <20201127163150.22903-2-chrubis@suse.cz>
References: <20201127163150.22903-1-chrubis@suse.cz>
 <20201127163150.22903-2-chrubis@suse.cz>
Message-ID: <20201203121642.GA5809@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This ensures that TBROK is never lost.
> 
> If test process forks a child and the child calls SAFE_MACRO() the
> failure will be lost unless the test process handles the exit value
> properly and propagates the TBROK.
> 
> It is also strange that TBROK is the only return value that is solely
> propagated by the exit value and not by the counters. This has been
> mistake to begin with.

Anybody to review this?

I consider it important and at the same time quite safe to apply since
I've tried to keep the changes minimal.

-- 
Cyril Hrubis
chrubis@suse.cz
