From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Aug 2016 10:02:52 -0400 (EDT)
Subject: [LTP] [PATCH] remap_file_pages: Remove since corresponding
 syscall	is depricated
In-Reply-To: <1471442189-29937-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471442189-29937-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <248280847.496370.1471442572726.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Yuriy Kolerov" <yuriy.kolerov@synopsys.com>
> To: ltp@lists.linux.it
> Cc: "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
> Sent: Wednesday, 17 August, 2016 3:56:29 PM
> Subject: [LTP] [PATCH] remap_file_pages: Remove since corresponding syscall	is depricated
> 
> 
> This system call is deprecated since Linux 3.16 and will
> eventually be replaced by a slower in-kernel emulation. See:

It already is replaced by emulation in latest upstream:
  commit c8d78c1823f46519473949d33f0d1d33fe21ea16
  Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
  Date:   Tue Feb 10 14:09:46 2015 -0800
    mm: replace remap_file_pages() syscall with emulation

But as long as interface is same, why not keep the test?
What about testing older kernels from various distros?

Regards,
Jan

> 
>     https://lwn.net/Articles/597632/
>     http://man7.org/linux/man-pages/man2/remap_file_pages.2.html
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> ---
>  runtest/syscalls                                   |   3 -
>  testcases/kernel/syscalls/Makefile                 |   2 +-
>  .../kernel/syscalls/remap_file_pages/Makefile      |  23 --
>  .../syscalls/remap_file_pages/remap_file_pages01.c | 278 -----------------
>  .../syscalls/remap_file_pages/remap_file_pages02.c | 334
>  ---------------------
>  5 files changed, 1 insertion(+), 639 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/remap_file_pages/Makefile
>  delete mode 100644
>  testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
>  delete mode 100644
>  testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
> 
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
