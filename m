From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Jun 2021 15:54:29 +0200
Subject: [LTP] [PATCH 0/8] Fix uninitialized var errors
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <YNHrldS4vrr2BN/t@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In a lot of cases the compiler is simply confused and gives an error,
> but there is no undefined behaviour. This is often caused by tst_brk
> which is the source of much confusion. Most likely there should be two
> versions of tst_brk. One which never returns and is used by test
> authors and one which can return, but is usually only used in library
> functions which may be called from cleanup.

Having two tst_brk() wouldn't solve much since all SAFE_MACROS() still
needs to use the one that may return.

So as far as I can tell it's easier to initialize variables to 0 in the
few cases where compiler ends up confused.

Anyways whole patchset pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
