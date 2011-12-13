Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RaLYD-0002zY-O6
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 06:09:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RaLYB-0007fq-AE
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 06:09:17 +0000
Message-ID: <4EE6EBC1.3000305@cn.fujitsu.com>
Date: Tue, 13 Dec 2011 14:08:01 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1323419326-13172-1-git-send-email-kai.kang@windriver.com>
	<1323419326-13172-3-git-send-email-kai.kang@windriver.com>
	<4EE1D27A.6000600@cn.fujitsu.com>
	<CAGH67wQKH_iXJ59eDikG89_DzgGAU5n-_Sd9hoFt8devOFOmKg@mail.gmail.com>
In-Reply-To: <CAGH67wQKH_iXJ59eDikG89_DzgGAU5n-_Sd9hoFt8devOFOmKg@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2] pthread_rwlock_unlock/4-2: remove local var
 'rc'
Reply-To: gaowanlong@cn.fujitsu.com
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

On 12/13/2011 01:56 PM, Garrett Cooper wrote:

> On Fri, Dec 9, 2011 at 1:18 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 12/09/2011 04:28 PM, Kang Kai wrote:
>>
>>> Local var 'rc' in function main hides the global one. In child thread
>>> it sets global var 'rc' with funtion return value. But in function main,
>>> test var 'rc' always succeeds because it tests local var 'rc'.
>>>
>>
>>
>> Good catch.
>>
>> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>>
>>> Signed-off-by: Kang Kai <kai.kang@windriver.com>
>>> ---
>>>  .../interfaces/pthread_rwlock_unlock/4-2.c         |    3 +--
>>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
>>> index 3023886..4928f85 100644
>>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
>>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
>>> @@ -54,7 +54,6 @@ static void* fn_unlk(void *arg)
>>>  int main()
>>>  {
>>>       int cnt = 0;
>>> -     int rc = 0;
>>>
>>>       pthread_t un_thread;
>>>
>>> @@ -125,4 +124,4 @@ int main()
>>>
>>>       printf("Test PASSED: Note*: Returned 0 instead of EPERM, but standard specified _may_ fail.\n");
>>>       return PTS_PASS;
>>> -}
>>> \ No newline at end of file
>>> +}
> 
> Will be committed soon (kind of interesting why -Wshadow didn't
> identify this issue...).


Yeah, odd, I didn't see warning by -Wshadow, either.

> -Garrett
> 



------------------------------------------------------------------------------
Systems Optimization Self Assessment
Improve efficiency and utilization of IT resources. Drive out cost and 
improve service delivery. Take 5 minutes to use this Systems Optimization 
Self Assessment. http://www.accelacomm.com/jaw/sdnl/114/51450054/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
