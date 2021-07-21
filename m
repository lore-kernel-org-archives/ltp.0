From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Jul 2021 16:15:49 +0200
Subject: [LTP] [PATCH v2] stime: Only o32 system calls require 32-bit
 programs on mips
In-Reply-To: <20210720083708.13281-1-zhanglianjie@uniontech.com>
References: <20210720083708.13281-1-zhanglianjie@uniontech.com>
Message-ID: <YPgsFalGpQdaDF3x@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi zhanglianjie,

> The stime() system call is only o32, not n32 and n64. If you do not
> specify that the current program is compiled to 32-bit when compiling
> the program on mips, the stime() system call will fail when the
> program is running.

Thanks, merged!

Kind regards,
Petr
