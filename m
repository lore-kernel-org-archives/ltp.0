From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2020 13:30:41 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <0c6f7b59-c1ec-5ff9-d261-7b4772ed9b1a@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <0c6f7b59-c1ec-5ff9-d261-7b4772ed9b1a@suse.cz>
Message-ID: <20201203123041.GB5809@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'd recommend adding TEST_*_IMPL() variant with extra arguments that'll
> allow special handling of ENOSYS, ENOTSUP and possibly also a
> zero-terminated array of allowed errnos. TEST_FD() etc. would then call
> the respective IMPL macro with default arguments:
> 
> #define TEST_FD_IMPL(SCALL, NOSYS_RES, NOTSUP_RES, ERRNO_LIST, ...) \
>     ...
> 
> #define TEST_FD(SCALL, ...) \
>     TEST_FD_IMPL((SCALL), TFAIL, TFAIL, NULL, ##__VA_ARGS__)

I do plan adding something like this later on once I run out of the
simple cases to convert, then I would like to review what is left there
and how to make best interface for the rest of the testcases.

So for now I would like to proceed with the patchset as it is in order
not to make it overly complicated.

-- 
Cyril Hrubis
chrubis@suse.cz
