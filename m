From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 06 Sep 2019 15:43:16 +0200
Subject: [LTP] [PATCH v5 0/4] Basic eBPF tests
In-Reply-To: <20190903111535.27565-1-chrubis@suse.cz>
References: <20190903111535.27565-1-chrubis@suse.cz>
Message-ID: <87imq5levf.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> v5:
>
> Fixed problems pointed out by Jan.

I am happy with these changes and have rebased bpf_prog02 on this
patchset.

>
> Richard Palethorpe (4):
>   BPF: Essential headers for map creation
>   BPF: Sanity check creating and updating maps
>   BPF: Essential headers for a basic program
>   BPF: Sanity check creating a program
>
>  include/lapi/bpf.h                         | 526 +++++++++++++++++++++
>  include/lapi/socket.h                      |   4 +
>  include/lapi/syscalls/aarch64.in           |   1 +
>  include/lapi/syscalls/i386.in              |   1 +
>  include/lapi/syscalls/s390.in              |   1 +
>  include/lapi/syscalls/sparc.in             |   1 +
>  include/lapi/syscalls/x86_64.in            |   1 +
>  runtest/syscalls                           |   3 +
>  testcases/kernel/syscalls/bpf/.gitignore   |   2 +
>  testcases/kernel/syscalls/bpf/Makefile     |  10 +
>  testcases/kernel/syscalls/bpf/bpf_map01.c  | 163 +++++++
>  testcases/kernel/syscalls/bpf/bpf_prog01.c | 166 +++++++
>  12 files changed, 879 insertions(+)
>  create mode 100644 include/lapi/bpf.h
>  create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
>  create mode 100644 testcases/kernel/syscalls/bpf/Makefile
>  create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c
>  create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog01.c
>
> --
> 2.21.0


--
Thank you,
Richard.
