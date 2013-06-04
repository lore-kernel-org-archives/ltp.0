Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Ujnrn-0001qN-LK
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 09:49:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ujnrm-0001qu-6N
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 09:49:23 +0000
Message-ID: <51ADB77E.7070105@cn.fujitsu.com>
Date: Tue, 04 Jun 2013 17:46:38 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51A5C347.4020202@cn.fujitsu.com>
	<1098836685.51729.1369819107988.JavaMail.root@redhat.com>
	<51A5D7A9.3070801@cn.fujitsu.com>
	<577470418.347391.1369824283490.JavaMail.root@redhat.com>
	<51A84F5A.9060708@cn.fujitsu.com>
	<1492205844.3281606.1370292459997.JavaMail.root@redhat.com>
	<51AD9784.3080605@casparzhang.com>
In-Reply-To: <51AD9784.3080605@casparzhang.com>
Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach
 SHM_NORESERVE to shmflg
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/04/2013 03:30 PM, Caspar Zhang wrote:
> On 06/04/2013 04:47 AM, Jan Stancek wrote:
>>>>>>> > >>>>
>>>>>>> > >>>>3. Add SHM_NORESERVE to shmflg to test
>>>>>> > >>>
>>>>>> > >>>Can you add some description why you are adding this flag?
>>>>> > >>
>>>>> > >>Actually, we are trying to complete test cases and expand
>>>>> > >>the test scope of LTP.
>>>>> > >>
>>>>> > >>So, it is just for completeness of this case.
>>>> > >
>>>> > >My concern here is:
>>>> > >So if we add this flag, we cover SHM_NORESERVE path.
>>>> > >Do we have a testcase which still covers current non-SHM_NORESERVE path?
>>> >
>>> >Hi Jan,
>>> >
>>> >Sorry for the late reply.:)
>>> >
>>> >In my opinion, SHM_NORESERVE is an independent feature of others and should
>>> >have
>>> >no effect on them, so we do not need a non-SHM_NORESERVE path.
>>> >They are like two branches of a river, one branch can do nothing on the other
>>> >one,
>>> >but if either of them goes wrong, the river will get feedback.
>> Presence of that flag has some effect, absence has different one.
>> To follow up on river metaphore, Are crocodiles in this river?
>>
>> Anyway, we cover that path in other testcases, so unless
>> someone else objects, I'm OK with adding that flag.
>>
> 
> Crocodile spotted:
> 
> in fact in this patch, SHM_NORESERVE doesn't get fully tested. from the man page:
> 
>     SHM_NORESERVE (since Linux 2.6.15)
>         [snip]When swap space is not reserved one might get SIGSEGV upon a write if no physical memory is available. [snip]
> 
> We could design such a new testcase if we really want to cover the SHM_NORESERVE branch of river (and the RESERVE branch
> as well) by set the flag and fill the memory, check the result to see if a SIGSEGV is triggered.
> 
> Thoughts?

Do you have any idea about how or what i can use to fill memory and keep away from the OOM-kill,
when trigger this SIGSEGV? :)

Regards,
DAN LI

> 
> Caspar
> 



------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
