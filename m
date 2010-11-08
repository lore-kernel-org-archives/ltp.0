Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PFPNV-0001Pb-FD
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 10:55:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFPNT-0007hu-Ly
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 10:55:09 +0000
Message-ID: <4CD7D71B.1000605@cn.fujitsu.com>
Date: Mon, 08 Nov 2010 18:55:23 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CCFD4C8.8060007@cn.fujitsu.com>
	<AANLkTi=ma-dX1YAJgc5sesDx67G75eOMGEUA3+uxOQsu@mail.gmail.com>
In-Reply-To: <AANLkTi=ma-dX1YAJgc5sesDx67G75eOMGEUA3+uxOQsu@mail.gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]pthread_mutex_getprioceiling should return
 EINVAl when mutex's protocol is PTHREAD_PRIO_NONE.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net



Garrett Cooper wrote:
> On Tue, Nov 2, 2010 at 2:07 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>> The default value of the mutex's protocol shall be PTHREAD_PRIO_NONE,
>> so pthread_mutex_getprioceiling should return EINVAL.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>
>> ---
>>  .../interfaces/pthread_mutex_getprioceiling/1-1.c  |   30 ++++++++++++++++++++
>>  1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
>> index d9251e6..65c8c6b 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
>> @@ -18,6 +18,7 @@
>>  #include <pthread.h>
>>  #include <stdio.h>
>>  #include <sched.h>
>> +#include <errno.h>
>>  #include "posixtest.h"
>>
>>  int main()
>> @@ -29,6 +30,7 @@ int main()
>>          return PTS_UNRESOLVED;
>>        #endif */
>>
>> +       pthread_mutexattr_t mattr;
>>        pthread_mutex_t mutex;

  ... snip ...


>> +
>> +       /* Get the prioceiling of the mutex. */
>>        if(pthread_mutex_getprioceiling(&mutex, &prioceiling) != 0)
>>        {
>>                printf("Test FAILED: Error obtaining the priority ceiling\n");
> 
>     A patch similar to this will be committed soon. The above patch
> has several correctness issues with perror (you have to capture the
> error and play it back via strerror), and the original test author
> accidentally mixed up one of the requirements between
> pthread_mutex_getprioceiling and pthread_mutexattr_getprioceiling as
> well by accident. This helped unroot a requirements issue on FreeBSD
> with PTHREAD_PRIO_INHERIT, and it might so similar on Linux.

  OK. I think it's better if you can send your patch at this thread. ^_^

>     Partial credit will be `awarded' for having keen eyes on this
> issue though :).

  Thanks very much. ^_^

> Thanks,
> -Garrett
> 
> 

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
