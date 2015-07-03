Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZArIu-0000CI-F2
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:06:16 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZArIo-00023K-Lb
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 03:06:16 +0000
Message-ID: <5595FC03.10602@huawei.com>
Date: Fri, 3 Jul 2015 11:05:39 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1435724565-19631-1-git-send-email-sunyuan3@huawei.com>
	<1715707849.11822659.1435846199391.JavaMail.zimbra@redhat.com>
In-Reply-To: <1715707849.11822659.1435846199391.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V2] userns01: add capability verification
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

Hi Jan,
     Interesting. It works well in my environment.
What's your environment?

log:
root@p1:/tmp/ltp/testcases/kernel/containers/userns# ./userns01
user_namespace1    0  TINFO  :  USERNS test is running in a new user 
namespace.
user_namespace1    1  TPASS  :  uid and gid are right
root@p1:/tmp/ltp/testcases/kernel/containers/userns#
root@p1:/tmp/ltp/testcases/kernel/containers/userns# uname -a
Linux p1 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 
x86_64 x86_64 x86_64 GNU/Linux
root@p1:/tmp/ltp/testcases/kernel/containers/userns# cat /etc/issue
Ubuntu 14.04.1 LTS \n \l

root@p1:/tmp/ltp/testcases/kernel/containers/userns# file /bin/ls
/bin/ls: ELF 64-bit LSB  executable, x86-64, version 1 (SYSV), 
dynamically linked (uses shared libs), for GNU/Linux 2.6.24, 
BuildID[sha1]=64d095bc6589dd4bfbf1c6d62ae985385965461b, stripped

Thanks.
     Yuan

On 2015/7/2 22:09, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 1 July, 2015 6:22:45 AM
>> Subject: [PATCH V2] userns01: add capability verification
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
>> ---
>>   testcases/kernel/containers/userns/Makefile   |  2 +-
>>   testcases/kernel/containers/userns/userns01.c | 31
>>   +++++++++++++++++++++------
>>   2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/userns/Makefile
>> b/testcases/kernel/containers/userns/Makefile
>> index 9f67216..8370bff 100644
>> --- a/testcases/kernel/containers/userns/Makefile
>> +++ b/testcases/kernel/containers/userns/Makefile
>> @@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
>>   include $(top_srcdir)/include/mk/testcases.mk
>>   include $(abs_srcdir)/../Makefile.inc
>>   
>> -LDLIBS			:= -lclone -lltp
>> +LDLIBS			:= -lclone -lltp $(CAP_LIBS)
>>   
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/containers/userns/userns01.c
>> b/testcases/kernel/containers/userns/userns01.c
>> index 9cada5e..a9012ac 100644
>> --- a/testcases/kernel/containers/userns/userns01.c
>> +++ b/testcases/kernel/containers/userns/userns01.c
>> @@ -15,7 +15,9 @@
>>    * Verify that:
>>    *  If a user ID has no mapping inside the namespace, user ID and group
>>    * ID will be the value defined in the file
>>    /proc/sys/kernel/overflowuid(65534)
>> - * and /proc/sys/kernel/overflowgid(65534).
>> + * and /proc/sys/kernel/overflowgid(65534). A child process has a full set
>> + * of permitted and effective capabilities, even though the program was
>> + * run from an unprivileged account.
>>    */
>>   
>>   #define _GNU_SOURCE
>> @@ -29,6 +31,12 @@
>>   #include "test.h"
>>   #include "libclone.h"
>>   #include "userns_helper.h"
>> +#include "config.h"
>> +#if HAVE_SYS_CAPABILITY_H
>> +#include <linux/types.h>
>> +#include <sys/capability.h>
>> +#endif
>> +
>>   #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
>>   #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
>>   
>> @@ -43,21 +51,30 @@ static long overflowgid;
>>    */
>>   static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
>>   {
>> -	int exit_val;
>> +	int exit_val = 0;
>>   	int uid, gid;
>> +#ifdef HAVE_LIBCAP
>> +	cap_t caps, expectedcaps;
>> +#endif
>>   
>>   	uid = geteuid();
>>   	gid = getegid();
>>   
>>   	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
>> -	if (uid == overflowuid && gid == overflowgid) {
>> -		printf("Got expected uid and gid\n");
>> -		exit_val = 0;
>> -	} else {
>> +
>> +	if (uid != overflowuid || gid != overflowgid) {
>>   		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
>>   		exit_val = 1;
>>   	}
>>   
>> +#ifdef HAVE_LIBCAP
>> +	caps = cap_get_proc();
>> +	expectedcaps = cap_from_text("=ep");
>> +	if (cap_compare(caps, expectedcaps) != 0)
> Does this work for you? I'm getting failures.
> It seems that cap_from_text sets all bits in the set,
> not just those capabilities that are <= CAP_LAST_CAP
> and the comparison compares all bits.
>
> Regards,
> Jan
>
>> +		exit_val = 1;
>> +#else
>> +	printf("System doesn't support capabilities.\n");
>> +#endif
>>   	return exit_val;
>>   }
>>   
>> @@ -96,3 +113,5 @@ int main(int argc, char *argv[])
>>   	tst_exit();
>>   }
>>   
>> +
>> +
>> --
>> 1.9.1
>>
>>
> .
>


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
