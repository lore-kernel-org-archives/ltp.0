Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WkrvA-0002Vn-F4
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 09:25:48 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wkrv8-0005vc-FN
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 09:25:48 +0000
Message-ID: <53748770.8090806@cn.fujitsu.com>
Date: Thu, 15 May 2014 17:22:56 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1400059055-22877-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<948116490.5076233.1400060143816.JavaMail.zimbra@redhat.com>
In-Reply-To: <948116490.5076233.1400060143816.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH RFC] change MAKE_TARGETS's dependency to normal
 prerequisites and order-only prerequisites
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 05/14/2014 05:35 PM, Jan Stancek wrote:
>
>
> ----- Original Message -----
>> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 14 May, 2014 11:17:35 AM
>> Subject: [LTP] [PATCH RFC] change MAKE_TARGETS's dependency to normal	prerequisites and order-only prerequisites
>>
>> See the below issue:
>>   When we made modifications to source files in lib/, for example
>>   lib/tst_mkfs.c, then
>>   back to testcases/kernel/syscalls/access and execute 'make'. This will not
>>   make the
>>   access[0-5] to be re-linked with the newly generated libltp.a, we need to
>>   touch
>>   access[0-5].c or remove access[0-5] files first, then make. This will make
>>   no sense.
>>   Users may expect just a make command to ensure a new access[0-5] generated
>>   with the
>>   new libltp.a.
>>
>> This is because in 'include/mk/generic_leaf_target.inc', MAKE_TARGETS's
>> dependency is
>> order-only prerequisites, not normal prerequisites, so we change lib's
>> dependency type
>> to normal prerequisites, not order-only prerequisites.
>>
>> The original MAKE_DEPS is replaced by MAKE_NORMAL_DEPS or
>> MAKE_ORDER_ONLY_DEPS.
>>
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>  include/mk/generic_leaf_target.inc                      | 2 +-
>>  include/mk/generic_trunk_target.inc                     | 2 +-
>>  include/mk/testcases.mk                                 | 3 ++-
>>  testcases/kernel/Makefile                               | 2 +-
>>  testcases/kernel/containers/Makefile                    | 2 +-
>>  testcases/kernel/containers/Makefile.inc                | 2 +-
>>  testcases/kernel/controllers/Makefile                   | 2 +-
>>  testcases/kernel/controllers/Makefile.inc               | 2 +-
>>  testcases/kernel/controllers/cpuset/Makefile            | 2 +-
>>  testcases/kernel/controllers/cpuset/Makefile.inc        | 2 +-
>>  testcases/kernel/include/lib.mk                         | 2 +-
>>  testcases/kernel/mem/hugetlb/Makefile                   | 2 +-
>>  testcases/kernel/mem/hugetlb/Makefile.inc               | 2 +-
>>  testcases/kernel/mem/include/libmem.mk                  | 2 +-
>>  testcases/kernel/power_management/Makefile              | 2 +-
>>  testcases/kernel/syscalls/ipc/Makefile                  | 2 +-
>>  testcases/kernel/syscalls/ipc/Makefile.inc              | 2 +-
>>  testcases/kernel/syscalls/ipc/msgctl/Makefile           | 2 +-
>>  testcases/kernel/syscalls/kill/Makefile                 | 2 +-
>>  testcases/kernel/syscalls/mremap/Makefile               | 2 +-
>>  testcases/network/rpc/basic_tests/rpc01/Makefile        | 2 +-
>>  testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc | 2 +-
>>  testcases/network/tcp_cmds/Makefile.inc                 | 4 ++--
>>  23 files changed, 25 insertions(+), 24 deletions(-)
>>
> <snip>
>> diff --git a/testcases/kernel/include/lib.mk
>> b/testcases/kernel/include/lib.mk
>> index c193ca3..c0b9189 100644
>> --- a/testcases/kernel/include/lib.mk
>> +++ b/testcases/kernel/include/lib.mk
>> @@ -32,7 +32,7 @@ $(LIBKERNTEST_DIR):
>>  $(LIBKERNTEST): $(LIBKERNTEST_DIR)
>>  	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
>>  
>> -MAKE_DEPS		+= $(LIBKERNTEST)
>> +MAKE_ORDER_ONLY_DEPS	+= $(LIBKERNTEST)
> Hi,
>
> Why is libkerntest.a order only dependency here?
> If we go this way, shouldn't we do it for all libraries?

Agree, thanks.
I will send a new version later :-)

Regards,
Xiaoguang Wang
>
> Regards,
> Jan
> .
>


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
