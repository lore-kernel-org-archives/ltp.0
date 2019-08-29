From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 22:28:18 +0200
Subject: [LTP] [PATCH v2] syscall: rt_sigtimedwait01: Fix wrong sigset
 length for mips
In-Reply-To: <1567084186-417234-1-git-send-email-zhe.he@windriver.com>
References: <1567084186-417234-1-git-send-email-zhe.he@windriver.com>
Message-ID: <20190829202818.GA4408@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi He,

> From: He Zhe <zhe.he@windriver.com>

> rt_sigtimedwait01 fails as follow on MIPS arches
> rt_sigtimedwait01    1  TFAIL  :  .../sigwaitinfo01.c:58: test_empty_set
> (.../sigwaitinfo01.c: 148): Unexpected failure:
> TEST_ERRNO=EINVAL(22): Invalid argument

> As this case purposely bypasses glibc, it should align with the size of kernel
> definition of sigset_t which is different from other arches.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/uapi/asm/signal.h#n15

> This patch turns to use _NSIG which is always right for all arches.

> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: Use _NSIG/8 instead of fixed numbers

Thanks, merged.

Kind regards,
Petr
