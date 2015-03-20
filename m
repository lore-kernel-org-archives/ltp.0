Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1YYxZa-0004Nv-MF
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 14:06:50 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYxZY-0004iI-6q
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 14:06:50 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id
	t2KE36BG014894
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Mar 2015 15:06:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 1t7u29qba4-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Mar 2015 15:06:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 603E738
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Mar 2015 14:05:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8FB8257D5
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Mar 2015 14:06:39 +0000 (GMT)
Message-ID: <550C296E.3080109@st.com>
Date: Fri, 20 Mar 2015 15:06:38 +0100
From: Carmelo Amoroso <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>	<1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>	<756183AD4F83414184BA6A0635785E70A55C4BDC@LGEVEXMBAPSVC1.LGE.NET>
	<1985883687.604987.1426857226768.JavaMail.zimbra@redhat.com>
In-Reply-To: <1985883687.604987.1426857226768.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
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

Hello,

On 3/20/2015 2:13 PM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Satish Gedela" <satish.gedela@lge.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, 20 March, 2015 12:42:00 PM
>> Subject: RE: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
>>
>>
>>
>>> -----Original Message-----
>>> From: Jan Stancek [mailto:jstancek@redhat.com]
>>> Sent: Friday, March 20, 2015 1:41 PM
>>> To: Satish Gedela/LGSIA CSP-2(satish.gedela@lge.com)
>>> Cc: ltp-list@lists.sourceforge.net
>>> Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
>>>
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Satish Gedela" <satish.gedela@lge.com>
>>>> To: ltp-list@lists.sourceforge.net
>>>> Sent: Friday, 20 March, 2015 6:28:34 AM
>>>> Subject: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
>>>>
>>>> Dear all,
>>>>
>>>> I am newbie to open source, forgive me with text format I am trying to
>>>> run  LTP with kernel 3.16 on target board having cortex A9 processor ,
>>>> Facing issue with below test case:
>>>> Test script  name: "memcg_function_test.sh"
>>>> Test case description:  "Test mmap(locked) + alloc_mem > limit_in_bytes"
>>>>
>>>> Analysis:  memcg_function_test.sh   -----> test_proc_kill
>>>> 						                  ------->memcg_lib.sh
>>>>
>>> -------->memcg_process
>>>>      memcg_process
>>>>
>>>> ------>ltp/testcases/kernel/controllers/memcg/functional/memcg_process
>>>> .c
>>>>
>>>> mmap_lock1 () function is calling in memcg_process.c and it calls mmap
>>>> function with flags MAP_PRIVATE | MAP_ANYNOMOUS | MAP_LOCKED
>>>> {noformat} p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>>>>        MAP_PRIVATE | MAP_LOCKED, 0, 0); {noformat}
>>>>
>>>> but man page of mmap is mentioned as:
>>>> {noformat}
>>>> MAP_ANONYMOUS
>>>>          The  mapping  is  not  backed  by  any  file; its contents are
>>>>          initialized to zero.  The fd and offset arguments are
>>>>          ignored; however, some implementations require fd to be -1 if
>>>>          MAP_ANONYMOUS (or MAP_ANON) is specified, and portable
>>>>          applications should ensure this.  The use of MAP_ANONYMOUS in
>>>>          conjunction with MAP_SHARED is only supported on Linux
>>>>          since kernel 2.4.
>>>> {noformat}
>>>>
>>>> In my case, we are trying to lock the pages with flags  MAP_PRIVATE |
>>>> MAP_ANYNOMOUS |  MAP_LOCKED  and  it is failing.
>>>
>>> Hi,
>>>
>>> failing how? EINVAL or something else?
>>> Do you see mmap14 failing as well? If so, can you run it via strace?
>>>
>>> Regards,
>>> Jan
>>>
>> Hi Jan,
>> Failing  to kill process PID.
>
> It seems that MAP_LOCKED can now silently fail.
>
> https://lkml.org/lkml/2015/1/19/28
> http://marc.info/?l=linux-mm&m=142122902313315&w=2
>

I hit exactly the same issue on CA9 based platform when moved from 
kernel 3.10.53 to 3.10.65

> Those posts contain also kernel commit IDs that are likely responsible
> for same problem you see.
>

So, should the LTP be updated accordingly ?

> Regards,
> Jan
>

Thanks,
Carmelo

>> Not getting EINVAL
>> I did not test mmap14 but I replaced 5th argument with  '-1' instead of '0'
>> (Based on mmap14 test case)
>> still getting test case failure.
>>
>> Test procedure followed:
>>
>> Test case description : "kill the process if memory limit exceeds ,
>> Process memory locked through MAP_LOCKED  in test_ case_ 14 and using mlock()
>> in test_case_ 15"
>>
>> Running LTP on work station using
>> 	$make configure
>> 	$make
>> 	$make install
>> And copy ltp , kernel, sysinfo.sh, tools  into target directory " /opt "
>> and on target running below commnad
>>
>> #./runltp -f controllers  > log.txt
>>
>>  From log report, identified mmap-lock1 (MAP_LOCKED)  is failing and
>> mmap-lock2 (mlock2)  is passing
>> So from the memcg_process.c file
>> 	mmap_lock1() is using mmap () with MAP_PRIVATE | MAP_ANYNOMOUS | MAP_LOCKED
>> 	mmap_lock2 is using mmap () with MAP_PRIVATE | MAP_ANYNOMOUS
>> 	and mlock() function call.
>>
>>   In process of debugging, I replaced mmap_lock1 with mmap_lock2 , in test
>>   _case_ 14 and it is working successfully.
>> So I identified issue is in mmap() call and
>> replaced flag as "MAP_SHARED | MAP_LOCKED"  and  "MAP_PRIVATE  | MAP_LOCKED
>> "in mmap,
>> it is working successfully in both cases but not with MAP_ANYNOMOUS flag.
>>
>> Regards
>> Satish.G
>>
>>>> and with  MAP_SHARED | MAP_ANYNOMOUS |  MAP_LOCKED , it is failing
>>> but
>>>> with MAP_PRIVATE | MAP_LOCKED and with MAP_SHARED |
>>> MAP_LOCKED it is
>>>> working.
>>>>
>>>> Is there any changes made to kernel or test case has to update with
>>>> MAP_SHARED instead of MAP_PRIVATE flag.
>>>>
>>>> Thank you in advance.
>>>> Regards
>>>> Satish.G
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> ----------------------------------------------------------------------
>>>> -------- Dive into the World of Parallel Programming The Go Parallel
>>>> Website, sponsored by Intel and developed in partnership with Slashdot
>>>> Media, is your hub for all things parallel software development, from
>>>> weekly thought leadership blogs to news, videos, case studies,
>>>> tutorials and more. Take a look and join the conversation now.
>>>> http://goparallel.sourceforge.net/
>>>> _______________________________________________
>>>> Ltp-list mailing list
>>>> Ltp-list@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>>
>>
>
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
