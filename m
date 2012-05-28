Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SYpgS-0004ne-HV
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 02:27:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SYpgQ-0005wV-Sq
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 02:27:48 +0000
Message-ID: <4FC2E263.6080701@cn.fujitsu.com>
Date: Mon, 28 May 2012 10:26:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
	<4FC1D8C5.4050804@cn.fujitsu.com>
	<CAGH67wQw2j6AMgKxs0JwynQYT7JB0mjVkiB+hztWUSnLRneS9w@mail.gmail.com>
	<4FC1E248.6040008@cn.fujitsu.com>
	<CAGH67wT3etJ-v7sA4ygKpXZNeX=0quNQkXmCp_PC9No2wxu4kA@mail.gmail.com>
	<4FC1EE9E.8020503@cn.fujitsu.com>
	<CAGH67wSgF4U+FZ-S_LSmyYd4TOk7MMYT=+_S=H7aEWjiFzvovQ@mail.gmail.com>
In-Reply-To: <CAGH67wSgF4U+FZ-S_LSmyYd4TOk7MMYT=+_S=H7aEWjiFzvovQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix the fork/11-1 conformance testcase
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/28/2012 02:19 AM, Garrett Cooper wrote:

> On Sun, May 27, 2012 at 2:06 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 05/27/2012 04:23 PM, Garrett Cooper wrote:
>>
>>> On Sun, May 27, 2012 at 1:14 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>>>> On 05/27/2012 04:00 PM, Garrett Cooper wrote:
>>>>
>>>>> On Sun, May 27, 2012 at 12:33 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>>>>>> On 05/26/2012 10:15 PM, Garrett Cooper wrote:
>>>>>>
>>>>>>> The testcase tests to see whether or not locks are successfully
>>>>>>> inherited across forking processes, as the requirements for fork state
>>>>>>> that they should not be. The problem is that the test tests the negative
>>>>>>> case for ftrylockfile (!= 0) instead of the positive case, which creates
>>>>>>
>>>>>> The ftrylockfile() function returns zero for success (the lock was obtained),
>>>>>> and nonzero for failure.
>>>>>> So I think the origin is right.
>>>>>
>>>>>     My description might be wrong, but the fix is right. ftrylockfile
>>>>> should fail in the testcase (not succeed) because the file lock isn't
>>>>> owned by the forked process. It succeeds simply because the delay is
>>>>
>>>>
>>>> But on my system ftrylockfile() always return 0, and the test PASSED.
>>>> and with your patch, it fails.
>>>
>>> Then that's a Linux/POSIX bug then. From fork(2) on OpenGroup [1]:
>>>
>>> "File locks set by the parent process are not inherited by the child process."
>>>
>>> And from flockfile(2) on OpenGroup [2]:
>>>
>>> "   The flockfile() function is used by a thread to acquire ownership
>>> of a ( FILE *) object.
>>>
>>>     The ftrylockfile() function is used by a thread to acquire
>>> ownership of a ( FILE *) object if the object is available;
>>> ftrylockfile() is a non-blocking version of flockfile().
>>>
>>> ...
>>>
>>>     None for flockfile() and funlockfile(). The function
>>> ftrylockfile() returns zero for success and non-zero to indicate that
>>> the lock cannot be acquired."
>>
>>>
>>
>>> The goal/algorithm as stated at the top of the testcase was...
>>>
>>> "* The steps are:
>>> * -> lock stdout
>>> * -> fork
>>> * -> child creates a thread
>>> * -> child thread trylock stdout
>>> * -> join the child
>>>
>>> * The test fails if the child thread cannot lock the file
>>> * -- this would mean the child process got stdout file lock ownership."
>>
>>
>> Yes, if trylock can't get the lock, it should return nonzero, I think
>> the concept is right.
>> But you mean if trylock() can't get the lock, it should return zero?
> 
> No.
> 
> Looking into the implementation of ftrylockfile further, it looks like
> the locking is not advisory locking in the traditional sense, but
> instead thread-based locking -- this matches the description in the
> FreeBSD and OpenGroup manpage.
> 
> The problem that I see is multi-fold:
> 1. The testcase's original test for success was right as the testcase
> is using fork, not forkall.
> 2. There's a bug in FreeBSD that I need to investigate and fix.
> 
> I think that the testcase should test another stream than stdout
> though (say, open up /dev/null via fopen?). It would at least allow
> the test to return immediately instead of blocking indefinitely.
> 
> Do you object to the other changes?


I think I have no more objection.

Thanks,
Wanlong Gao 

> 
> Thanks!
> -Garrett
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
