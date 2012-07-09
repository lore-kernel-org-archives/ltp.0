Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1So3jf-00054r-Ts
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:30:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1So3je-0001uj-NR
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:30:03 +0000
Message-ID: <4FFA4210.607@cn.fujitsu.com>
Date: Mon, 09 Jul 2012 10:29:36 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <2e6144c3-13ca-4b3b-8b02-cd7cee9f25d0@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2e6144c3-13ca-4b3b-8b02-cd7cee9f25d0@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] hugetlb: add a new function
	get_available_hugepages
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/07/2012 11:30 PM, Zhouping Liu wrote:
> Hi,
> 
>> From: "Zhouping Liu" <zliu@redhat.com>
>> To: "LTP list" sourceforge.net>
>> Sent: Saturday, July 7, 2012 11:14:38 PM
>> Subject: [LTP] [PATCH] hugetlb: add a new function get_available_hugepages
>>
>> on some systems with small RAM, there aren't enough memory
>> to set as specific hugepages, such as 128 hugepages, it will
>> fail like this:
>>  [root@localhost hugemmap]# ./hugemmap01
>>  hugemmap01    0  TINFO  :  set nr_hugepages to 128
>>  hugemmap01    1  TBROK  :  nr_hugepages = 55, but expect 128
>>  hugemmap01    2  TBROK  :  Remaining cases broken
>>  hugemmap01    0  TINFO  :  set nr_hugepages to 54
>>
>> we can detect whether the system has the power to get the specific
>> hugepages through the following commands:
>>
>>  [root@localhost hugemmap]# echo 128 > /proc/sys/vm/nr_hugepages
>>  [root@localhost hugemmap]# cat /proc/sys/vm/nr_hugepages
>>  55
>>
>> as we know, on this system, there are 55 available hugepages, so we
>> can set 55 hugepages to continue the case, but to exit the case,
>> and this is desinged into get_available_hugepages() functions.
> 
> I have tested on some systems.
>  a. test on a low memory:
> [root@localhost hugemmap]# ./hugemmap01 
> hugemmap01    0  TINFO  :  set nr_hugepages to 128
> hugemmap01    0  TINFO  :  There're 56 available hugepages
> hugemmap01    0  TINFO  :  set nr_hugepages to 56
> hugemmap01    1  TPASS  :  call succeeded
> hugemmap01    0  TINFO  :  set nr_hugepages to 0
> 
>  b. try to set overcommit hugepages:
> [root@localhost hugemmap]# ./hugemmap01 -s 1000
> hugemmap01    0  TINFO  :  set nr_hugepages to 1000
> hugemmap01    0  TINFO  :  There're 363 available hugepages
> hugemmap01    0  TINFO  :  set nr_hugepages to 363
> hugemmap01    1  TPASS  :  call succeeded
> hugemmap01    0  TINFO  :  set nr_hugepages to 0


pushed, thank you.

Wanlong Gao

> 
> Thanks,
> Zhouping
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
