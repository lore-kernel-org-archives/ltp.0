From: $rik@nth  <srikanth007m@gmail.com>
Date: Wed, 23 Mar 2016 11:45:23 +0000
Subject: [LTP]  ld failed to link numa while compiling migrate_pages01
Message-ID: <CANKSX+GSJ2c+1wyrEELkYvWDhYrxCthwJujAV=M-NwqsA+0wrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril/LTP Devs,

Today i pulled few fixes from master branch [1] on top of last LTP
release. While compiling i am getting below exception at
migrate_pages01. Can you help in look into the issue once?

make[4]: Entering directory
'/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages'
gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -static
-I/home/linaro/ltp-master/testcases/kernel/include
-I/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/../utils/
-DNUMA_VERSION1_COMPATIBILITY
-I/home/linaro/ltp-master/testcases/kernel/include
-I../../../../include -I../../../../include  -c -o migrate_pages01.o
migrate_pages01.c
gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -static
-I/home/linaro/ltp-master/testcases/kernel/include
-I/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/../utils/
-DNUMA_VERSION1_COMPATIBILITY
-I/home/linaro/ltp-master/testcases/kernel/include
-I../../../../include -I../../../../include  -c -o
migrate_pages_common.o migrate_pages_common.c
make -C "/home/linaro/Srikanth/ltp-master/testcases/kernel/include" -f
"/home/linaro/ltp-master/testcases/kernel/include/Makefile" all
make[5]: Entering directory '/home/linaro/ltp-master/testcases/kernel/include'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory '/home/linaro/ltp-master/testcases/kernel/include'
gcc -static -pthread  -L/home/linaro/ltp-master/testcases/kernel/lib
-L../../../../lib  migrate_pages01.o migrate_pages_common.o   -lltp
-lnuma -lkerntest -lltp -o migrate_pages01
migrate_pages01.o: In function `test_invalid_perm':
/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c:183:
warning: Using 'getpwnam' in statically linked applications requires
at runtime the shared libraries from the glibc version used for
linking
/home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_max_node':
/home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
undefined reference to `numa_max_possible_node'
/home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_allowed_nodes_arr':
/home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:177:
undefined reference to `numa_available'
/home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_max_node':
/home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
undefined reference to `numa_max_possible_node'
/home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_allowed_nodes_arr':
/home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:177:
undefined reference to `numa_available'
/home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_max_node':
/home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
undefined reference to `numa_max_possible_node'
collect2: error: ld returned 1 exit status
<builtin>: recipe for target 'migrate_pages01' failed
make[4]: *** [migrate_pages01] Error 1


[1] https://github.com/linux-test-project/ltp.git

-- 
Thanks & Regards,
M.Srikanth Kumar.
