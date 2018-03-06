From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Mar 2018 11:41:57 +0100
Subject: [LTP] [PATCH] syscalls/connect01: bypass bionic connect()
 implementation
In-Reply-To: <20180306101102.GA16934@rei.lan>
References: <20180303000947.76487-1-ghackmann@google.com>
 <20180305214725.onvea2ng2565fqoy@dell5510>
 <20180306101102.GA16934@rei.lan>
Message-ID: <20180306104157.cjngiiqgmije4ynr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Maybe it's a good idea to call the raw syscall regardless of the libc
> implementation since we had cases where tests started to segfault on
> glibc upgrade or in special conditions where libc had to convert
> structure layouts between 32bit/64bit userspace/kernel.
Pushed change where the raw syscall is called regardless of the libc implementation.


Kind regards,
Petr
