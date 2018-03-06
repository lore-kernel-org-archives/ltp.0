From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Mar 2018 11:11:02 +0100
Subject: [LTP] [PATCH] syscalls/connect01: bypass bionic connect()
 implementation
In-Reply-To: <20180305214725.onvea2ng2565fqoy@dell5510>
References: <20180303000947.76487-1-ghackmann@google.com>
 <20180305214725.onvea2ng2565fqoy@dell5510>
Message-ID: <20180306101102.GA16934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Maybe it's a good idea to call the raw syscall regardless of the libc
implementation since we had cases where tests started to segfault on
glibc upgrade or in special conditions where libc had to convert
structure layouts between 32bit/64bit userspace/kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
