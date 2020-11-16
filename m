From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Nov 2020 08:08:57 +0100
Subject: [LTP] [PATCH] Define SYS_futex on 32bit arches using 64-bit
 time_t
In-Reply-To: <20201116003345.3261577-1-raj.khem@gmail.com>
References: <20201116003345.3261577-1-raj.khem@gmail.com>
Message-ID: <20201116070857.GB81864@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> Newer 32bit arches like RISCV32 and ARC are using 64bit time_t
> from get go unlike other 32bit architecture therefore aliasing __NR_futex to
> __NR_futex_time64 helps avoid the below errors

> tst_checkpoint.c:99:17: error: use of undeclared identifier 'SYS_futex'

Thanks for your fix.

I wonder if this could be defined just in include/lapi/futex.h and this:

https://github.com/pevik/ltp/commit/a20107ab47554798e0de0347dd4d7259f01675af

Kind regards,
Petr
