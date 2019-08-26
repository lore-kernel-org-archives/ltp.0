From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Aug 2019 13:10:20 +0200
Subject: [LTP] [PATCH v4 0/4] Basic eBPF tests
Message-ID: <20190826111024.19053-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've ended up playing with the patchset and fixed a few loose ends on
the map test and as I had the code at hand I decided to send v4 instead
of pointing out the mistakes in a review.

There were numerous small changes for the map test:

* Make sure the key buffer is sized exactly for the content

* Initialized the array/hash element value in test setup

* Made the code flow a bit more obvious, it was hard to tell which
  part was run for n == 0 and which for n == 1

Also it looks that for me the test that loads the eBPF program ends up
with EPERM randomly at about 10th iteration both as unpriviledged and
priviledged user, which is really strange.

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
 testcases/kernel/syscalls/bpf/bpf_map01.c  | 158 +++++++
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 162 +++++++
 12 files changed, 870 insertions(+)
 create mode 100644 include/lapi/bpf.h
 create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
 create mode 100644 testcases/kernel/syscalls/bpf/Makefile
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog01.c

-- 
2.21.0

