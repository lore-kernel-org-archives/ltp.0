From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Feb 2020 14:52:58 +0100
Subject: [LTP] [PATCH] syscalls: Check for time64 unsafe syscalls before
 using them
In-Reply-To: <c8a71ed3-be25-5eec-3419-adad3539c80f@cn.fujitsu.com>
References: <20200213062524.2027846-1-raj.khem@gmail.com>
 <c8a71ed3-be25-5eec-3419-adad3539c80f@cn.fujitsu.com>
Message-ID: <20200213135258.GA7062@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem, Xu,

> Can we use simple tst_syscall to fix this like commit 333a47be
> ("socketcall01: Use tst_syscall")?
+1
NOTE: legacy API (test.h, used by gettimeofday01.c) uses ltp_syscall().

Kind regards,
Petr
