Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XRHt7-0001oE-Pa
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 09:39:01 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XRHt6-0003Uk-O8
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 09:39:01 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s899cs2b019091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 09:38:55 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s899crBt029296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 09:38:54 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s899cqNx003603
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 09:38:53 GMT
Message-ID: <540ECAAA.2090108@oracle.com>
Date: Tue, 09 Sep 2014 13:38:50 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1291208815.23057199.1408691123381.JavaMail.zimbra@redhat.com>	<53FAF335.7090506@oracle.com>
	<540D72E3.3040009@oracle.com>
In-Reply-To: <540D72E3.3040009@oracle.com>
Subject: Re: [LTP] [PATCH v4 3/3] fcntl16: Skip fcntl16 test block2 and
 block3 on NFS
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
To: ltp-list@lists.sourceforge.net



On 09/08/2014 01:12 PM, Stanislav Kholmanskikh wrote:
> Hi.
>
> Could anybody look at the series?
>
> If there are no objections, I'm going to push it tomorrow.

Pushed.

>
> Thanks.
>
> On 08/25/2014 12:26 PM, Stanislav Kholmanskikh wrote:
>>
>>
>> On 08/22/2014 11:05 AM, Xiong Zhou wrote:
>>>
>>> According to nfs(5), NLM supports advisory file locks only. So skip
>>> fcntl16 test block2 and block3 if NFS.
>>>
>>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>>> ---
>>
>> The entire series looks good for me.
>>
>> Just found removed spaces below, but there is no need to resend the
>> patch/series because it can be fixed at commit time. :)
>>
>> Thanks.
>>
>> Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>>
>>
>>>     testcases/kernel/syscalls/fcntl/fcntl16.c | 27 +++++++++++++++++++++------
>>>     1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
>>> index 44b6a80..67d3b17 100644
>>> --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
>>> +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
>>> @@ -51,6 +51,8 @@
>>>     #include <sys/types.h>
>>>     #include <sys/wait.h>
>>>
>>> +#include "tst_fs_type.h"
>>> +
>>>     #define SKIPVAL 0x0f00
>>>     //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
>>>     #define SKIP 0,0,0L,0L,0
>>> @@ -62,6 +64,7 @@
>>>     #define	NOBLOCK		2	/* immediate success */
>>>     #define	WILLBLOCK	3	/* blocks, succeeds, parent unlocks records */
>>>     #define	TIME_OUT	10
>>> +int NO_NFS = 1;			/* Test on NFS or not */
>>>
>>>     typedef struct {
>>>     	struct flock parent_a;
>>> @@ -412,6 +415,10 @@ void setup(void)
>>>
>>>     	tst_tmpdir();
>>>
>>> +	/* On NFS or not */
>>> +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
>>> +		NO_NFS = 0;
>>> +
>>>     	/* set up temp filename */
>>>     	sprintf(tmpname, "fcntl4.%d", parent);
>>>
>>> @@ -689,13 +696,17 @@ int main(int ac, char **av)
>>>     		 * locking
>>>     		 */
>>>     		tst_resm(TINFO, "Entering block 2");
>>> -		if (run_test(O_CREAT | O_RDWR | O_TRUNC, S_ISGID |
>>> +		if (NO_NFS && run_test(O_CREAT | O_RDWR | O_TRUNC, S_ISGID |
>>>     			     S_IRUSR | S_IWUSR, 0, 11)) {
>>>     			tst_resm(TINFO, "Test case 2: with mandatory record "
>>>     				 "locking FAILED");
>>>     		} else {
>>> -			tst_resm(TINFO, "Test case 2: with mandatory record "
>>> -				 "locking PASSED");
>>> +			if (NO_NFS)
>>> +				tst_resm(TINFO, "Test case 2: with mandatory"
>>> +					 "record locking PASSED");
>> We need a space here
>>
>>> +			else
>>> +				tst_resm(TCONF, "Test case 2: NFS does not"
>>> +					 " support mandatory locking");
>>>     		}
>>>     		tst_resm(TINFO, "Exiting block 2");
>>>
>>> @@ -705,13 +716,17 @@ int main(int ac, char **av)
>>>     		 * and no delay
>>>     		 */
>>>     		tst_resm(TINFO, "Entering block 3");
>>> -		if (run_test(O_CREAT | O_RDWR | O_TRUNC | O_NDELAY,
>>> +		if (NO_NFS && run_test(O_CREAT | O_RDWR | O_TRUNC | O_NDELAY,
>>>     			     S_ISGID | S_IRUSR | S_IWUSR, 0, 11)) {
>>>     			tst_resm(TINFO, "Test case 3: mandatory locking with "
>>>     				 "NODELAY FAILED");
>>>     		} else {
>>> -			tst_resm(TINFO, "Test case 3: mandatory locking with "
>>> -				 "NODELAY PASSED");
>>> +			if (NO_NFS)
>>> +				tst_resm(TINFO, "Test case 3: mandatory"
>>> +					 "locking with NODELAY PASSED");
>> and here
>>> +			else
>>> +				tst_resm(TCONF, "Test case 3: NFS does not"
>>> +					 " support mandatory locking");
>>>     		}
>>>     		tst_resm(TINFO, "Exiting block 3");
>>>     	}
>>>
>>
>> ------------------------------------------------------------------------------
>> Slashdot TV.
>> Video for Nerds.  Stuff that matters.
>> http://tv.slashdot.org/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>
> ------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
