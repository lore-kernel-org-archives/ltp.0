From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Wed, 17 Aug 2016 16:56:29 +0300
Subject: [LTP] [PATCH] remap_file_pages: Remove since corresponding syscall
	is depricated
Message-ID: <1471442189-29937-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This system call is deprecated since Linux 3.16 and will
eventually be replaced by a slower in-kernel emulation. See:

    https://lwn.net/Articles/597632/
    http://man7.org/linux/man-pages/man2/remap_file_pages.2.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 runtest/syscalls                                   |   3 -
 testcases/kernel/syscalls/Makefile                 |   2 +-
 .../kernel/syscalls/remap_file_pages/Makefile      |  23 --
 .../syscalls/remap_file_pages/remap_file_pages01.c | 278 -----------------
 .../syscalls/remap_file_pages/remap_file_pages02.c | 334 ---------------------
 5 files changed, 1 insertion(+), 639 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/remap_file_pages/Makefile
 delete mode 100644 testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
 delete mode 100644 testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-remap_file_pages-Remove-since-corresponding-syscall-.patch
Type: text/x-patch
Size: 19404 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160817/907198ac/attachment-0001.bin>
