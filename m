From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  6 Aug 2019 11:47:48 +0200
Subject: [LTP] [PATCH v3 0/4] eBPF tests using guarded buffers API
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190806094752.9794-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This is another version of my basic eBPF tests using Metan's guarded buffers
patch set. I have tried to use the new API for any pointer passed to a system
call.

Richard Palethorpe (4):
  BPF: Essential headers for map creation
  BPF: Sanity check creating and updating maps
  BPF: Essential headers for a basic program
  BPF: Sanity check creating a program

 include/lapi/bpf.h                         | 526 +++++++++++++++++++++
 include/lapi/socket.h                      |   4 +
 include/lapi/syscalls/aarch64.in           |   1 +
 include/lapi/syscalls/i386.in              |   1 +
 include/lapi/syscalls/s390.in              |   1 +
 include/lapi/syscalls/sparc.in             |   1 +
 include/lapi/syscalls/x86_64.in            |   1 +
 runtest/syscalls                           |   3 +
 testcases/kernel/syscalls/bpf/.gitignore   |   2 +
 testcases/kernel/syscalls/bpf/Makefile     |  10 +
 testcases/kernel/syscalls/bpf/bpf_map01.c  | 140 ++++++
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 161 +++++++
 12 files changed, 851 insertions(+)
 create mode 100644 include/lapi/bpf.h
 create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
 create mode 100644 testcases/kernel/syscalls/bpf/Makefile
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog01.c

-- 
2.22.0

