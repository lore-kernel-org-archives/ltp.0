From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Mar 2020 14:42:15 +0100
Subject: [LTP] [PATCH] syscalls/clone3: New tests
In-Reply-To: <20200313041947.2ua6abqerhdo6wfv@vireshk-i7>
References: <08f6f9f8af7b8f999136cc2a30744a8d678d2b5f.1584000268.git.viresh.kumar@linaro.org>
 <20200312134300.GB3803@rei.lan>
 <20200313041947.2ua6abqerhdo6wfv@vireshk-i7>
Message-ID: <20200313134215.GA7318@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I tried this but here is the problem ..
> 
> - pidfd: Kernel doesn't check this pointer and we get EFAULT.
> - child_tid: Kernel checks for valid pointer and doesn't use the
>   variable if NULL, so test passes unexpectedly.

We do have tst_get_bad_addr() that produces PROT_NONE mapped page that
should get you EFAULT in both cases here.

> - parent_tid: Kernel doesn't verify the pointer, but doesn't return
>   the error code properly and so test passes unexpectedly.

Huh? That sounds like a bug. Or does it skip only NULL silently? In that
case tst_get_bad_addr() should fix this case as well.

-- 
Cyril Hrubis
chrubis@suse.cz
