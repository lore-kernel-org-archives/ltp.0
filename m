From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Oct 2018 15:30:59 +0200
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
Message-ID: <20181008133059.GB30978@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP syscall test case futex_wake04 hangs forever on i386 kernel
> running on x86_64 server machine.
> 
> Test PASS on qemu_i386 and other devices.
> Test HANGs on i386 (i386 kernel booting on x86_64 machine).
> 
> output,
> incrementing stop
> futex_wake04    0  TINFO  :  Hugepagesize 4194304

Looks like we are trying to fault 4GB hugepage, that may be quite slow,
but then, the test is a kernel reproducer as well.

Can you connect to the process with gdb and check if we happened to
timeout before or after the two threads that are are supposed to trigger
kernel bug are started?

-- 
Cyril Hrubis
chrubis@suse.cz
