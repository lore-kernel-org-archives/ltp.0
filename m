Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1URaTm-0004Jw-3v
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:53:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URaTi-0001tH-Fi
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:53:18 +0000
Message-ID: <516B7911.7040403@redhat.com>
Date: Mon, 15 Apr 2013 11:50:41 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1365411883.git.zliu@redhat.com>
	<3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
	<516B52DB.2000004@cn.fujitsu.com> <516B7077.1000001@redhat.com>
	<516B7420.5010002@cn.fujitsu.com>
In-Reply-To: <516B7420.5010002@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/3] mm/thp: new case thp04.c
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/15/2013 11:29 AM, Wanlong Gao wrote:
> On 04/15/2013 11:13 AM, Zhouping Liu wrote:
>> depending on your system's memory info:
>>
>> free reports:
>>               total       used       free     shared    buffers     cached
>> Mem:       8025000    7563668     461332          0     730920    4891316
>> -/+ buffers/cache:    1941432    6083568
>> Swap:      4194300      16212    4178088
>>
>> your system has 8Gb RAM and there's 460Mb memory left when you start to test thp04 serial cases.
>> I guess the cases failed because of the low memory.
>>
>> can you re-test them on the system with enough memory? and provide the value of /proc/sys/vm/min_free_kbytes,
>> I think 1Gb memory left is enough to test the new THP case.
>>
>> also I'm very confused why the above case didn't get any THPs, maybe there's some performance issues...
> Yes, that's passed after my reboot.

Thanks again for your tests :)

the case needs most memory is 'thp0[4|5]_3 -n 1 -N 300', which require 
300 huge pages(600Mb memory) at least,
also there's some memory limitation, such as 
/proc/sys/vm/min_free_kbytes, so I think 1Gb free memory is enough
to test the serial cases, it's better to give some kind comments when 
memory is low, what I can think of is to print out
the MemFree when starting to test:

e.g:
memfree= read_meminfo("MemFree:");
tst_resm(TINFO, "The system has %ld memory left before starting", memfree);
if (memfree < 1G)
     tst_resm(TINFO, "The system has low memory, which will cause the 
case fail");

I'll send v3 to include it.

Thanks,
Zhouping

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
