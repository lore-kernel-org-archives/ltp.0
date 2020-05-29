From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 May 2020 06:08:25 -0400 (EDT)
Subject: [LTP] [PATCH] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <1590730943-23463-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1590730943-23463-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1709395031.14049839.1590746905611.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Use INTERNAL_LIB for ltp lib because installing these ltp static
> library in any situation is meaningless.
> 
> all static library as below:
> ./libs/libltpuinput/libltpuinput.a
> ./libs/libltpnewipc/libltpnewipc.a
> ./libs/libltpnuma/libltpnuma.a
> ./libs/libltpipc/libltpipc.a
> ./libs/libltpipc/libltpmsgctl.a
> ./utils/sctp/lib/libsctp.a
> ./utils/sctp/testlib/libsctputil.a
> ./lib/libltp.a
> ./testcases/network/rpc/basic_tests/rpc01/lib/librpc01.a
> ./testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.a
> ./testcases/kernel/containers/libclone/libclone.a
> ./testcases/kernel/mem/hugetlb/lib/libhugetlb.a
> ./testcases/kernel/mem/lib/libmem.a
> ./testcases/kernel/controllers/libcontrollers/libcontrollers.a
> ./testcases/kernel/controllers/cpuset/cpuset_lib/libcpu_set.a
> ./testcases/kernel/lib/libkerntest.a
> ./testcases/commands/nm/datafiles/lib.a

With the one above omitted from commit message:

Acked-by: Jan Stancek <jstancek@redhat.com>

