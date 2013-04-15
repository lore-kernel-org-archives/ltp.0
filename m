Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URfuO-0007Un-Bt
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 09:41:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URfuK-0001aE-Ni
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 09:41:08 +0000
Message-ID: <516BCB45.3080707@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 17:41:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1366005109.git.zliu@redhat.com>
	<516BB063.3060801@cn.fujitsu.com> <516BC7AC.2000003@redhat.com>
In-Reply-To: <516BC7AC.2000003@redhat.com>
Subject: Re: [LTP] [PATCH v3 0/3] mm/thp: add two new case
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/15/2013 05:26 PM, Zhouping Liu wrote:
> On 04/15/2013 03:46 PM, Wanlong Gao wrote:
>> Hi Zhouping:
>>> The patchset is desinged to test THP functionality.
>>>
>>> when one process allocate hugepage aligned anonymouse pages,
>>> kernel thread 'khugepaged' controlled by sysfs knobs
>>> /sys/kernel/mm/transparent_hugepage/* will scan them, and make
>>> them as transparent hugepage if they are suited, you can find out
>>> how many transparent hugepages are there in one process from
>>> /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
>>> stand for transparent hugepage.
>>>
>>> V1 to V2:
>>> accepted Wanlong's suggestion, added some comment for '10s'
>>> added 'static' key word for single-file-only variant.
>>>
>>> V2 to V3:
>>> added some comments for low memory system.
>> I just see that on the kernel before v2.6.39, the "defrag"
>> interface is "[yes] no" or "yes [no]"(eg. RHEL6). While it's changed
>> to boolean after commit e27e6151b154 in v2.6.39-rc4.
> 
> Good catch, I didn't find that.
> 
> I checked the code again, found that khugepaged/defrag is related to defragment,
> and any value of it can't effect the current thp0* cases, so I plan to remove it from
> khugepaged_scan_done() in v4.

Yeah, agree.

Thanks,
Wanlong Gao

> 
> For future cases, which will be related to khugepaged/defrag, we can set the value
> inside setup().
> 
> Thanks,
> Zhouping
> 
>>
>> So, you should deal with the multi-style interface of this "defrag",
>>
>> +        SAFE_FILE_SCANF(cleanup, PATH_KHPD "defrag", "%ld", &defrag);
>>
>> Thanks,
>> Wanlong Gao
>>
>>> Wanlong, I included you into 'Tested-by' thread, thanks for
>>> your reviewing and testing the patchset.
>>>
>>> Zhouping Liu (3):
>>>    mm/thp: new case thp04.c
>>>    lib/mem: introduce a new function set_global_mempolicy()
>>>    mm/thp: add new case thp05
>>>
>>>   runtest/mm                         |   6 ++
>>>   testcases/kernel/mem/include/mem.h |  12 +++
>>>   testcases/kernel/mem/lib/mem.c     | 203 ++++++++++++++++++++++++++++++++++++-
>>>   testcases/kernel/mem/thp/thp04.c   | 136 +++++++++++++++++++++++++
>>>   testcases/kernel/mem/thp/thp05.c   | 152 +++++++++++++++++++++++++++
>>>   5 files changed, 508 insertions(+), 1 deletion(-)
>>>   create mode 100644 testcases/kernel/mem/thp/thp04.c
>>>   create mode 100644 testcases/kernel/mem/thp/thp05.c
>>>
> 
> 


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
