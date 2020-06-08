From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 8 Jun 2020 19:01:07 +0800
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <20200608101032.GA9222@dell5510>
References: <1591083478-5342-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200608101032.GA9222@dell5510>
Message-ID: <9e9b223b-833b-0023-cfc7-7fbe22cb9b45@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


> Hi Xu,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Cyril concerned 3rd party use of lib/libltp.a, but nobody complained.
> Given Jan acked v1, I'd be also for merge.
> 
  We also should include android_libpthread and android_librt Makefile.

>> Use INTERNAL_LIB for ltp lib because installing these ltp static
>> library in any situation is meaningless.
> 
>> all static library as below:
>> ./libs/libltpuinput/libltpuinput.a
>> ./libs/libltpnewipc/libltpnewipc.a
>> ./libs/libltpnuma/libltpnuma.a
>> ./libs/libltpipc/libltpipc.a
>> ./libs/libltpipc/libltpmsgctl.a
>> ./utils/sctp/lib/libsctp.a
>> ./utils/sctp/testlib/libsctputil.a
>> ./lib/libltp.a
>> ./testcases/network/rpc/basic_tests/rpc01/lib/librpc01.a
>> ./testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.a
>> ./testcases/kernel/containers/libclone/libclone.a
>> ./testcases/kernel/mem/hugetlb/lib/libhugetlb.a
>> ./testcases/kernel/mem/lib/libmem.a
>> ./testcases/kernel/controllers/libcontrollers/libcontrollers.a
>> ./testcases/kernel/controllers/cpuset/cpuset_lib/libcpu_set.a
>> ./testcases/kernel/lib/libkerntest.a
> nit: I'd remove './' from commit message.
> 
> Kind regards,
> Petr
> 
>> Also include Android_libpthread and android_librt and remove useless
>> libdir variable.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>> v1->v2:
>> 1.remove ./testcases/commands/nm/datafiles/lib.a from commit message
>> 2.add two anroid Makefiles
>> 3.remove useless libdir
> FYI I'm still having in my mind trying dynamic library linking.
> But if I ever do it I'll just re-add this variable.
Yes, for now, this variable is meaningless unless using dynamic libraries.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


