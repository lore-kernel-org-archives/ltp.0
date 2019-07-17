From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Jul 2019 04:36:02 -0400 (EDT)
Subject: [LTP] [PATCH] getrlimit03: adjust a bit of code to compatiable
 with mips32
In-Reply-To: <1563267862-42483-2-git-send-email-hongzhi.song@windriver.com>
References: <1563267862-42483-1-git-send-email-hongzhi.song@windriver.com>
 <1563267862-42483-2-git-send-email-hongzhi.song@windriver.com>
Message-ID: <1984233025.591567.1563352562020.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Error info:
> getrlimit03.c:104: FAIL: __NR_prlimit64(0) had rlim_cur =
> ffffffffffffffff but __NR_getrlimit(0) had rlim_cur = 7fffffff
> 
> According to kernel code: [arch/mips/include/uapi/asm/resource.h]
> RLIM_INFINITY is set to 0x7fffffffUL instead of ULONG_MAX on mips32.
> 
>  /*
>  * SuS says limits have to be unsigned.
>  * Which makes a ton more sense anyway,
>  * but we keep the old value on MIPS32,
>  * for compatibility:
>  */
>  #ifndef __mips64
>  # define RLIM_INFINITY      0x7fffffffUL
>  #endif
> 
> Adding conditional statement about mips to fix this.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>

Pushed.

Thanks,
Jan
