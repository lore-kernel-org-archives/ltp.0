From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Feb 2019 18:50:53 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/cma: test case should return
 TCONF if syscall doesn't exist
In-Reply-To: <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
 <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <CAEemH2fvR1WQBEmwPM_rpy4z3xN6Ueeqk9Ri8BHrFoPQgaAJqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jason,

A new failure was occured after applying this new patch.

From our observation, the latest process_vm_readv03.c failed with
process_vm_readv() Invalid argument error on rhel7.3 platfrom. We suspect
that this problem maybe caused by glibc or compiler, because if compile the
test program with -O0 it get pass, but with the ltp
default optimization -O2 it get fail.  Also, if we revert this new patch,
the test PASS whatever with -O2 and -O0, that's very strange.

--------------------------------
# gcc -g -O2 -g -O2   -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../include
-I../../../../include -I../../../../include/old/   -L../../../../lib
process_vm_readv03.c   -lltp -o process_vm_readv03_O2

# ./process_vm_readv03_O2
process_vm_readv03    0  TINFO  :  child 0: 10 iovecs allocated and
initialized.
process_vm_readv03    0  TINFO  :  child 1: 10 remote iovecs received.
process_vm_readv03    0  TINFO  :  child 1: 4 local iovecs initialized.
process_vm_readv03    1  TBROK  :  process_vm_readv03.c:220:
process_vm_readv: errno=EINVAL(22): Invalid argument
process_vm_readv03    2  TBROK  :  process_vm_readv03.c:220: Remaining
cases broken
process_vm_readv03    1  TFAIL  :  process_vm_readv03.c:103: child 1
returns 512

# strace -f ./process_vm_readv03_O2
...
[pid 14676] process_vm_readv(14675, 0x7ffe40232ea0, 4, 0x7640c0, 10,
140728898420736) = -1 EINVAL (Invalid argument)
[pid 14676] write(1, "process_vm_readv03    1  \33[1;31m"...,
125process_vm_readv03    1  TBROK  :  process_vm_readv03.c:220:
process_vm_readv: errno=EINVAL(22): Invalid argument
) = 125
...

--------------------------------------------
# gcc -g -O0 -g -O0   -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../include
-I../../../../include -I../../../../include/old/   -L../../../../lib
process_vm_readv03.c   -lltp -o process_vm_readv03_O0

# ./process_vm_readv03_O0
process_vm_readv03    0  TINFO  :  child 0: 10 iovecs allocated and
initialized.
process_vm_readv03    0  TINFO  :  child 1: 10 remote iovecs received.
process_vm_readv03    0  TINFO  :  child 1: 4 local iovecs initialized.
process_vm_readv03    1  TPASS  :  child 1: all bytes are correctly
received.

# strace -f ./process_vm_readv03_O0
...
[pid 14703] process_vm_readv(14702,
[{"\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"...,
43269},
{"\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
!\"#$"..., 18907},
{"\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377"...,
3203}, {"cdefghijklmnopqrstuvwxyz{|}~\177\200\201\202"..., 34621}], 4,
[{0x9570c0, 24638}, {0x95d110, 35640}, {0x965c50, 19802}, {0x96a9c0, 490},
{0x96abc0, 8624}, {0x96cd80, 3571}, {0x96db80, 2114}, {0x96e3d0, 2374},
{0x96ed20, 1139}, {0x96f1a0, 1608}], 10, 0) = 100000
[pid 14703] write(1, "process_vm_readv03    1  \33[1;32m"...,
89process_vm_readv03    1  TPASS  :  child 1: all bytes are correctly
received.
) = 89
...

# uname  -r
3.10.0-514.55.4.el7.x86_64

# rpm -q glibc
glibc-2.17-157.el7_3.5.x86_64

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190215/02b113eb/attachment-0001.html>
