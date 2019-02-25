From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Feb 2019 02:39:00 -0500 (EST)
Subject: [LTP] [PATCH v2] mprotect04: Support execute-only page access
 permissions
In-Reply-To: <20190212000008.57085-1-danielmentz@google.com>
References: <20190212000008.57085-1-danielmentz@google.com>
Message-ID: <725517488.2635953.1551080340197.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Linux version 4.9 introduced support for execute-only page access permissions
> on
> arm64. As a result, user space processes, by default, cannot read from
> their own .text sections. This change adds an extra call to mprotect()
> to explicitly change access protections to allow relevant parts of the
> .text section to be read.
> 
> Without this change, mprotect04 generates false TBROK results. We
> previously saw this test output:
> 
> mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
> mprotect04    0  TINFO  :  exec_func: 0x5ac82d3588, page_to_copy:
> 0x5ac82d3000
> mprotect04    2  TBROK  :
> ltp/testcases/kernel/syscalls/mprotect/mprotect04.c:236: page_to_copy not
> present
> mprotect04    3  TBROK  :
> ltp/testcases/kernel/syscalls/mprotect/mprotect04.c:236: Remaining cases
> broken
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>

Pushed with minor tweaks so it applies to my v3.

Thanks,
Jan
