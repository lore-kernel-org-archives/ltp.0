From: $rik@nth  <srikanth007m@gmail.com>
Date: Wed, 20 Jan 2016 18:52:00 +0530
Subject: [LTP] get_mempolicy failing to compile
Message-ID: <CANKSX+ENW0PPUWmJ5EjOtCJX+4qGppBvw-uW4W6eEC3WRDiWrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

I am trying to compile latest snapshot from github [1] and getting below errors.

arm-linux-gnueabihf-gcc -static -g -O2 -fno-strict-aliasing -pipe
-Wall -W -Wold-style-definition
-I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/include
-I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils
 -I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/include
-I../../../../include -I../../../../include -static -pthread
-L/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/lib
-L../../../../lib  get_mempolicy01.c   -lltp  -lkerntest -lltp -o
get_mempolicy01
In file included from get_mempolicy01.c:63:0:
/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:
In function ?sigterm_handler?:
/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:111:33:
warning: unused parameter ?sig? [-Wunused-parameter]
 static void sigterm_handler(int sig)
                                 ^
get_mempolicy01.c: In function ?main?:
get_mempolicy01.c:197:14: warning: unused parameter ?argc? [-Wunused-parameter]
 int main(int argc, char **argv)
              ^
get_mempolicy01.c:197:27: warning: unused parameter ?argv? [-Wunused-parameter]
 int main(int argc, char **argv)
                           ^
/tmp/cciaYvm7.o: In function `setup_uid':
/home/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:64:
warning: Using 'getpwnam' in statically linked applications requires
at runtime the shared libraries from the glibc version used for
linking
/tmp/cciaYvm7.o: In function `main':
get_mempolicy01.c:(.text.startup+0x9c): undefined reference to
`numa_allocate_nodemask'
get_mempolicy01.c:(.text.startup+0xa2): undefined reference to
`numa_allocate_nodemask'
get_mempolicy01.c:(.text.startup+0xc2): undefined reference to
`numa_bitmask_setbit'
get_mempolicy01.c:(.text.startup+0x2ce): undefined reference to
`numa_bitmask_clearall'
get_mempolicy01.c:(.text.startup+0x2e8): undefined reference to
`numa_bitmask_equal'
/home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_max_node':
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
reference to `numa_max_possible_node'
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
reference to `numa_max_possible_node'
/home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_nodemask_allnodes':
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:71: undefined
reference to `nodemask_set'
/home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_allowed_nodes_arr':
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:191: undefined
reference to `nodemask_isset'
/home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `filter_nodemask_cpu':
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:126: undefined
reference to `nodemask_isset'
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:133: undefined
reference to `nodemask_clr'
/home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
In function `get_max_node':
/home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
reference to `numa_max_possible_node'
collect2: error: ld returned 1 exit status
make[4]: *** [get_mempolicy01] Error 1

Attached is my config log for reference.


[1] https://github.com/linux-test-project/ltp

-- 
Thanks & Regards,
M.Srikanth Kumar.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: application/octet-stream
Size: 335900 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160120/1aafdca6/attachment-0001.obj>
