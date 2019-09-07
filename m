From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 7 Sep 2019 06:19:02 -0400 (EDT)
Subject: [LTP] [PATCH v5 0/4] Basic eBPF tests
In-Reply-To: <20190903111535.27565-1-chrubis@suse.cz>
References: <20190903111535.27565-1-chrubis@suse.cz>
Message-ID: <1108769731.10519822.1567851542307.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> v5:
> 
> Fixed problems pointed out by Jan.

ack

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
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
