From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 16:52:08 +0100
Subject: [LTP] [PATCH V2 10/32] replace __BEGIN_DECLS and __END_DECLS
In-Reply-To: <1452302060-103643-10-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-10-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202155208.GG19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> They are not portable across libc implementations
> therefore replace them with expanded macros

There is not C++ source including these headers, just remove these
instead.

> Include <asm-generic/types.h> to get __s32 definitions
> its not a generally available typedef

Please use int32_t from stdint.h instead.
(And this should ideally be separate patch)

-- 
Cyril Hrubis
chrubis@suse.cz
