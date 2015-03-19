Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YYZkp-0005KA-AC
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 12:40:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYZkn-0000gq-Rw
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 12:40:51 +0000
Message-ID: <550AC3C8.6070707@redhat.com>
Date: Thu, 19 Mar 2015 13:40:40 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>	<1426742198-17967-2-git-send-email-bamvor.zhangjian@huawei.com>
	<1627971631.32976127.1426764822909.JavaMail.zimbra@redhat.com>
In-Reply-To: <1627971631.32976127.1426764822909.JavaMail.zimbra@redhat.com>
Content-Type: multipart/mixed; boundary="------------010707070301080207070606"
Subject: Re: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct
	kernel_sigaction
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: ltp-list@lists.sourceforge.net, bintian wang <bintian.wang@huawei.com>, yangyingliang@huawei.com, apinski@cavium.com, dingtianhong@huawei.com

This is a multi-part message in MIME format.
--------------010707070301080207070606
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 03/19/2015 12:33 PM, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
>> To: ltp-list@lists.sourceforge.net
>> Cc: "bintian wang" <bintian.wang@huawei.com>, yangyingliang@huawei.com, apinski@cavium.com, dingtianhong@huawei.com
>> Sent: Thursday, 19 March, 2015 6:16:36 AM
>> Subject: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct kernel_sigaction
>>
>> From: Yang Yingliang <yangyingliang@huawei.com>
>>
>> In ILP32, the sigaction struct is the same as AARCH64.
>> To allow for this to work, we use a long long fields and
>> then add extra casts when converting between the user
>> exposed struct and the kernel exposed struct.
>> The modify is came from a patch of glibc,
>> the commit is 9266f4b060f6("Add kernel_sigaction.h for AARCH64 ILP32").
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  include/lapi/rt_sigaction.h | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
>> index 46f6a50..2b1365a 100644
>> --- a/include/lapi/rt_sigaction.h
>> +++ b/include/lapi/rt_sigaction.h
>> @@ -34,9 +34,9 @@
>>  #define INVAL_SA_PTR ((void *)-1)
>>  
>>  struct kernel_sigaction {
>> -	__sighandler_t k_sa_handler;
>> -	unsigned long sa_flags;
>> -	void (*sa_restorer) (void);
>> +	unsigned long long k_sa_handler;
>> +	unsigned long long sa_flags;
>> +	unsigned long long sa_restorer;
> 
> Isn't this going to break i386? (long is 4, long long is 8).

Hi,

Attached is a testcase I put together to check how it behaves.
It's expected that signal handler will run on alternate stack and
testcase will print "frame_addr is within my_stack: 1"

# uname -m
i686

LTP HEAD:
# ./rt_sigaction04
my_stack: 0x0804d260 frame_addr: 0x0844cd08
frame_addr is within my_stack: 1

LTP HEAD + patch that changes kernel_sigaction to long long
# ./rt_sigaction04
my_stack: 0x0804d260 frame_addr: 0xbfda5068
frame_addr is within my_stack: 0

Regards,
Jan


--------------010707070301080207070606
Content-Type: text/x-csrc;
 name="rt_sigaction04.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rt_sigaction04.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <inttypes.h>
#include <errno.h>
#include <sys/syscall.h>
#include <string.h>

#include "test.h"
#include "linux_syscall_numbers.h"
#include "lapi/rt_sigaction.h"

char *TCID = "rt_sigaction01";
int TST_TOTAL = 1;

static char my_stack[4*1024*1024];

static void handler(int sig)
{
	(void) sig;
	uintptr_t frame_addr = (uintptr_t) __builtin_frame_address(0);
	uintptr_t stack_addr = (uintptr_t) &my_stack;
	uintptr_t stack_last = stack_addr + sizeof(my_stack);
	printf("my_stack: 0x%08"PRIxPTR " frame_addr: 0x%08"PRIxPTR "\n",
		stack_addr, frame_addr);
	printf("frame_addr is within my_stack: %d\n",
		(frame_addr > stack_addr && frame_addr < stack_last));
}

static int set_handler(int sig, int sig_to_mask, int mask_flags)
{
	struct sigaction sa, oldaction;

	(void) sig_to_mask;

	sa.sa_handler = (void *)handler;
	sa.sa_flags = mask_flags;
	sigemptyset(&sa.sa_mask);
	sigaddset(&sa.sa_mask, sig);

	ltp_rt_sigaction(sig, &sa, &oldaction, SIGSETSIZE);
	return 0;
}


int main(int ac, char **av)
{
	const char *msg;

	msg = parse_opts(ac, av, NULL, NULL);
	if (msg != NULL)
		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

	stack_t stack = {
		.ss_sp = (void *)my_stack,
		.ss_flags = 0,
		.ss_size = sizeof(my_stack)
	};

	sigaltstack(&stack, NULL);
	set_handler(SIGRTMIN, 0, SA_ONSTACK);
	kill(getpid(), SIGRTMIN);

	tst_exit();
}

--------------010707070301080207070606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--------------010707070301080207070606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010707070301080207070606--

