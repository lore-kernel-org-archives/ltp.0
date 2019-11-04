From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 4 Nov 2019 15:45:42 +0800
Subject: [LTP] question about the EPERM error of LTP bpf test
Message-ID: <008a677b-644d-615f-6c4f-0961af928700@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All

Now, I test bpf_prog02 and bpf_prog03 in my system(4.18.0-107.el8.x86_64).

#./bpf_prog03
tst_buffers.c:55: INFO: Test is using guarded buffers
tst_test.c:1137: INFO: Timeout per run is 0h 05m 00s
bpf_common.h:18: INFO: Raising RLIMIT_MEMLOCK to 262143
tst_capability.c:29: INFO: Dropping CAP_SYS_ADMIN(21)
bpf_common.h:37: CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM (1)
#

Jan Stancek has added rlimit_bump_memlock function to avoid EPERM errno,
but I still can meet this problem every time even though I have increased BPF_MEMLOCK_ADD limit.

How can I run the two cases normally? Also, this error log(requires CAP_SYS_ADMIN on this system: EPERM
) makes me confused in this situation(because case drops CAP_SYS_ADMIN, but log reports need CAP_SYS_ADMIN)
and I think we may change it into "require CAP_SYS_ADMIN or max locked memory limit is too low".

Or, can I keep CAP_SYS_ADMIN cap in bpf_prog02/[3]?


Thanks
Yang Xu
  



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191104/b9d1b09a/attachment.htm>
