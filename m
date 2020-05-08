From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 May 2020 10:20:14 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] lib/cloner.c: Use __clone instead of clone
 for s390
In-Reply-To: <8f28b9797be3408c0c1086d0a2bc9c052b55bfe2.1588942426.git.agordeev@linux.ibm.com>
References: <cover.1588942426.git.agordeev@linux.ibm.com>
 <8f28b9797be3408c0c1086d0a2bc9c052b55bfe2.1588942426.git.agordeev@linux.ibm.com>
Message-ID: <475724112.11805789.1588947614752.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The kernel sys_clone and s390 glibc entry __clone assume
> the flags parameter type as unsigned long. However, the
> glibc clone wrapper used by ltp_clone helper defines flags
> as signed int. That leads to gcc extending CLONE_IO flag of
> 0x80000000 value to 0xffffffff80000000.

Same problem exists on ppc64le. There's a patch proposed to fix this on
kernel side:
  https://lore.kernel.org/lkml/20200507103214.77218-1-christian.brauner@ubuntu.com/

Earlier discussion is here:
  https://sourceware.org/pipermail/libc-alpha/2020-May/113596.html

