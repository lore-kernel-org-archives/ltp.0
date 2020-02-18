From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Feb 2020 16:15:51 +0800
Subject: [LTP] [PATCH v3 2/3] Split off executable code from
 bpf/bpf_common.h
In-Reply-To: <20200217141622.26912-2-mdoucha@suse.cz>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
 <20200217141622.26912-2-mdoucha@suse.cz>
Message-ID: <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 17, 2020 at 10:16 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> Changes since v1: This patch was split off from the v1 BPF fix. Code
> cleanup
> to prevent future bugs and make the common code more readable.
>
> Changes since v2: None.
>
>  testcases/kernel/syscalls/bpf/Makefile     |  3 ++
>  testcases/kernel/syscalls/bpf/bpf_common.c | 45 ++++++++++++++++++++++
>  testcases/kernel/syscalls/bpf/bpf_common.h | 39 ++-----------------
>  3 files changed, 51 insertions(+), 36 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/bpf/bpf_common.c
>
> diff --git a/testcases/kernel/syscalls/bpf/Makefile
> b/testcases/kernel/syscalls/bpf/Makefile
> index 990c8c83c..2241bce9b 100644
> --- a/testcases/kernel/syscalls/bpf/Makefile
> +++ b/testcases/kernel/syscalls/bpf/Makefile
> @@ -5,6 +5,9 @@ top_srcdir              ?= ../../../..
>
>  include $(top_srcdir)/include/mk/testcases.mk
>
> +FILTER_OUT_MAKE_TARGETS        := bpf_common
>  CFLAGS                 += -D_GNU_SOURCE
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +$(MAKE_TARGETS): %: %.o bpf_common.o
>

May I ask why we need to reserve these *.o binary files in the compiling?

# ls
bpf_common.c  bpf_common.o  bpf_map01.c  bpf_prog01    bpf_prog01.o
 bpf_prog02.c  bpf_prog03    bpf_prog03.o
bpf_common.h  bpf_map01     bpf_map01.o  bpf_prog01.c  bpf_prog02
 bpf_prog02.o  bpf_prog03.c  Makefile


Otherwise, the patchset looks good.
    Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200218/f61366ed/attachment.htm>
