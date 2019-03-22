From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Mar 2019 08:04:45 -0400 (EDT)
Subject: [LTP] [PATCH v2 0/2] Implement syscall multiplexing
In-Reply-To: <20190321155112.13449-1-chrubis@suse.cz>
References: <20190321155112.13449-1-chrubis@suse.cz>
Message-ID: <450197962.11087564.1553256285704.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This is version 2 of the patchset, the main changes are documentation
> for the multiplex function and also fixes in the select multiplexing
> function.

Acked-by: Jan Stancek <jstancek@redhat.com>

This made me think, if we need something like tst_syscall_supported().
If in future we'll have multiplex function with couple #ifdefs,
we may hit TCONF (due to ENOSYS) before we iterate over all of them.

> 
> Cyril Hrubis (2):
>   tst_test: Add test multiplex function
>   syscalls/select04: Test four syscall variants
> 
>  doc/test-writing-guidelines.txt               | 80 +++++++++++++++++
>  include/tst_test.h                            | 14 +++
>  lib/tst_test.c                                | 11 ++-
>  testcases/kernel/syscalls/select/select04.c   |  5 +-
>  testcases/kernel/syscalls/select/select_mpx.h | 87 +++++++++++++++++++
>  5 files changed, 194 insertions(+), 3 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/select/select_mpx.h
> 
> --
> 2.19.2
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
