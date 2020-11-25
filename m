From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 12:09:50 +0100
Subject: [LTP] [PATCH] Annotate tst_brk with noreturn
In-Reply-To: <20201125100910.25617-1-rpalethorpe@suse.com>
References: <20201125100910.25617-1-rpalethorpe@suse.com>
Message-ID: <20201125110950.GC2297@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Prevents compiler warnings when tst_brk is placed at the end of a
> non-void function's control flow. Indeed tst_brk never returns control
> to the caller.

It actually does, in a case of SAFE_MACROS() called from test cleanup().

Which is the reason we cannot annotate the function because if we do so
the compiler will not include the function epilog and tests would crash
in a case that something went wrong in a cleanup().

-- 
Cyril Hrubis
chrubis@suse.cz
