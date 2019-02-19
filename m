From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Feb 2019 21:34:03 +0800
Subject: [LTP] [PATCH v2] mprotect04: Support execute-only page access
	permissions
In-Reply-To: <20190212000008.57085-1-danielmentz@google.com>
References: <20190212000008.57085-1-danielmentz@google.com>
Message-ID: <CAEemH2d+jAXjtv=AnQ=GFP4gm7Hu_9Lc32x4v2gSkw1JFc2boQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Daniel,

On Tue, Feb 12, 2019 at 8:00 AM Daniel Mentz <danielmentz@google.com> wrote:

> Linux version 4.9 introduced support for execute-only page access
> permissions on
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
>
I believe your patch make sense, but I can't reproduce that problem on my
aarch64 platform with upstream kernel-v5.0-rc7. Is that execute-only page
permission needs a special config to enable? or can you point me which
commit made the change?

===== without your patch ====
# uname -rm
5.0.0-rc7 aarch64

# ./mprotect04
mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
mprotect04    2  TPASS  :  test PROT_EXEC for mprotect success

I confirmed the '&exec_func == 0x403460' has READ&EXEC permission in the
.text section. Or, did I missed anything?

00400000-00420000 r-xp 00000000 fd:00 101414360
/root/ltp/testcases/kernel/syscalls/mprotect/mprotect04
00420000-00430000 r--p 00010000 fd:00 101414360
/root/ltp/testcases/kernel/syscalls/mprotect/mprotect04
00430000-00440000 rw-p 00020000 fd:00 101414360
/root/ltp/testcases/kernel/syscalls/mprotect/mprotect04
2ff00000-2ff30000 rw-p 00000000 00:00 0
[heap]
ffff86b00000-ffff86b20000 --xp 00000000 00:00 0
ffff86b20000-ffff86c80000 r-xp 00000000 fd:00 1164
 /usr/lib64/libc-2.28.so
ffff86c80000-ffff86c90000 r--p 00150000 fd:00 1164
 /usr/lib64/libc-2.28.so
ffff86c90000-ffff86ca0000 rw-p 00160000 fd:00 1164
 /usr/lib64/libc-2.28.so
ffff86cb0000-ffff86cc0000 r--p 00000000 00:00 0
[vvar]
ffff86cc0000-ffff86cd0000 r-xp 00000000 00:00 0
[vdso]
ffff86cd0000-ffff86cf0000 r-xp 00000000 fd:00 1157
 /usr/lib64/ld-2.28.so
ffff86cf0000-ffff86d00000 r--p 00010000 fd:00 1157
 /usr/lib64/ld-2.28.so
ffff86d00000-ffff86d10000 rw-p 00020000 fd:00 1157
 /usr/lib64/ld-2.28.so
ffffed310000-ffffed340000 rw-p 00000000 00:00 0
[stack]

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190219/44ca0d04/attachment.html>
