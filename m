From: Xiao Yang <ice_yangxiao@163.com>
Date: Wed, 19 Feb 2020 21:07:57 +0800
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
 <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
Message-ID: <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/19/20 8:20 PM, Li Wang wrote:
> Hi Xiao,
>
>     Why don't you avoid libftest.o as well if you want to build test
>     by new rule?
>
>
> That should be generated?because it is the local library. In LTP 
> Makefile, the sequencing is to build the library first then 
> compile&link?to?the testcase. We can avoid dumping the testname.o 
> since it only exists in the last phase.

Hi Li,

Thanks for your detailed explanation.

I think you try to change the building rule, as below:

Previous rule: generate all object files and then link them at the last 
phase.

---------------------------------------------

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
-Wold-style-definition -D_FORTIFY_SOURCE=2 
-I/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-I../../../../include -I../../../../include -I../../../../include/old/? 
-c -o swapoff01.o swapoff01.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
-Wold-style-definition -D_FORTIFY_SOURCE=2 
-I/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-I../../../../include -I../../../../include -I../../../../include/old/? 
-c -o ../swapon/libswapon.o ../swapon/libswapon.c
gcc?? -L/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-L../../../../lib? swapoff01.o ../swapon/libswapon.o?? -lltp -o swapoff01

---------------------------------------------

Current rule: just generate some common object files(e.g. library) and 
then mix building and link at the last phase.

---------------------------------------------

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
-Wold-style-definition -D_FORTIFY_SOURCE=2 
-I/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-I../../../../include -I../../../../include -I../../../../include/old/? 
-c -o ../swapon/libswapon.o ../swapon/libswapon.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
-Wold-style-definition -D_FORTIFY_SOURCE=2 
-I/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-I../../../../include -I../../../../include -I../../../../include/old/ 
-L/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-L../../../../lib? swapoff01.c ../swapon/libswapon.o?? -lltp -o swapoff01

---------------------------------------------

Why don't you remove all object files and mix building and link at the 
last phase?

---------------------------------------------

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
-Wold-style-definition -D_FORTIFY_SOURCE=2 
-I/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-I../../../../include -I../../../../include -I../../../../include/old/ 
-L/root/ltp/testcases/kernel/syscalls/swapoff/../swapon/ 
-L../../../../lib? swapoff01.c ../swapon/libswapon.c?? -lltp -o swapoff01

---------------------------------------------

>
> And, I don't want to change too much for LTP build rule(I think it 
> works correctly), especially in the case directory some of the local 
> libraries are reused.? e.g The swapoff test needs linking to 
> ../swapon/libswapon.o, that requires?libswapon.o?is in the correct path.

You can build and link libswapon.c directly, as below:

---------------------------------

# grep MAKE_TARGETS Makefile
$(MAKE_TARGETS): %: ../swapon/libswapon.c

---------------------------------

Sorry, I am not sure if your improvement is the best way.

Thanks,

Xiao Yang

>
> Or, did I misunderstand your words? if yes, please correct me.
>
> -- 
> Regards,
> Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200219/6a4c8f15/attachment-0001.htm>
