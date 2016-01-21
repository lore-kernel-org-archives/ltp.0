From: $rik@nth  <srikanth007m@gmail.com>
Date: Thu, 21 Jan 2016 15:48:17 +0530
Subject: [LTP] get_mempolicy failing to compile
In-Reply-To: <68157114.10446982.1453361771699.JavaMail.zimbra@redhat.com>
References: <CANKSX+ENW0PPUWmJ5EjOtCJX+4qGppBvw-uW4W6eEC3WRDiWrw@mail.gmail.com>
 <68157114.10446982.1453361771699.JavaMail.zimbra@redhat.com>
Message-ID: <CANKSX+EYKTb9gRY_5OSZjj0JhzenjzE=9F4rN08uCHM10Nbz+Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

libnuma-dev is already installed on my system. Any reason why still it
is failing to link with libraries?

On Thu, Jan 21, 2016 at 1:06 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
>
> ----- Original Message -----
>> From: "$rik@nth" <srikanth007m@gmail.com>
>> To: ltp@lists.linux.it
>> Sent: Wednesday, 20 January, 2016 2:22:00 PM
>> Subject: [LTP] get_mempolicy failing to compile
>>
>> Hi All,
>>
>> I am trying to compile latest snapshot from github [1] and getting below
>> errors.
>>
>> arm-linux-gnueabihf-gcc -static -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition
>> -I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/include
>> -I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils
>>  -I/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/include
>> -I../../../../include -I../../../../include -static -pthread
>> -L/home/hydlnxbld84/Srikanth/ltp/testcases/kernel/lib
>> -L../../../../lib  get_mempolicy01.c   -lltp  -lkerntest -lltp -o
>> get_mempolicy01
>> In file included from get_mempolicy01.c:63:0:
>> /home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:
>> In function ?sigterm_handler?:
>> /home/hydlnxbld84/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:111:33:
>> warning: unused parameter ?sig? [-Wunused-parameter]
>>  static void sigterm_handler(int sig)
>>                                  ^
>> get_mempolicy01.c: In function ?main?:
>> get_mempolicy01.c:197:14: warning: unused parameter ?argc?
>> [-Wunused-parameter]
>>  int main(int argc, char **argv)
>>               ^
>> get_mempolicy01.c:197:27: warning: unused parameter ?argv?
>> [-Wunused-parameter]
>>  int main(int argc, char **argv)
>>                            ^
>> /tmp/cciaYvm7.o: In function `setup_uid':
>> /home/Srikanth/ltp/testcases/kernel/syscalls/get_mempolicy/../utils/common_j_h.c:64:
>> warning: Using 'getpwnam' in statically linked applications requires
>> at runtime the shared libraries from the glibc version used for
>> linking
>> /tmp/cciaYvm7.o: In function `main':
>> get_mempolicy01.c:(.text.startup+0x9c): undefined reference to
>> `numa_allocate_nodemask'
>> get_mempolicy01.c:(.text.startup+0xa2): undefined reference to
>> `numa_allocate_nodemask'
>> get_mempolicy01.c:(.text.startup+0xc2): undefined reference to
>> `numa_bitmask_setbit'
>> get_mempolicy01.c:(.text.startup+0x2ce): undefined reference to
>> `numa_bitmask_clearall'
>> get_mempolicy01.c:(.text.startup+0x2e8): undefined reference to
>> `numa_bitmask_equal'
>> /home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
>> In function `get_max_node':
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
>> reference to `numa_max_possible_node'
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
>> reference to `numa_max_possible_node'
>> /home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
>> In function `get_nodemask_allnodes':
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:71: undefined
>> reference to `nodemask_set'
>> /home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
>> In function `get_allowed_nodes_arr':
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:191: undefined
>> reference to `nodemask_isset'
>> /home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
>> In function `filter_nodemask_cpu':
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:126: undefined
>> reference to `nodemask_isset'
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:133: undefined
>> reference to `nodemask_clr'
>> /home/Srikanth/ltp/testcases/kernel/lib/libkerntest.a(numa_helper.o):
>> In function `get_max_node':
>> /home/Srikanth/ltp/testcases/kernel/lib/numa_helper.c:53: undefined
>> reference to `numa_max_possible_node'
>> collect2: error: ld returned 1 exit status
>> make[4]: *** [get_mempolicy01] Error 1
>>
>> Attached is my config log for reference.
>
> According to your log you have numa headers, but don't heave numa library
> to link against.
>
> #define HAVE_NUMA_H 1
> #define HAVE_NUMAIF_H 1
>
> NUMA_CPPFLAGS=''
> NUMA_LIBS=''
>
> Both should come from numactl devel package. To unblock compilation
> you can edit include/config.h and set any numa related options to 0.
> Then make clean && make should work.
>
> Regards,
> Jan
>
>>
>>
>> [1] https://github.com/linux-test-project/ltp
>>
>> --
>> Thanks & Regards,
>> M.Srikanth Kumar.
>>
>>
>> --
>> Mailing list info: http://lists.linux.it/listinfo/ltp
>>



-- 
Thanks & Regards,
M.Srikanth Kumar.
