Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1USJ0r-0003mY-1z
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 03:26:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USJ0p-0000Tt-Jo
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 03:26:25 +0000
Message-ID: <516E1673.6090902@cn.fujitsu.com>
Date: Wed, 17 Apr 2013 11:26:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1366122425.git.zliu@redhat.com>
In-Reply-To: <cover.1366122425.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v5 0/3] mm/thp: add two new case
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

On 04/16/2013 10:30 PM, Zhouping Liu wrote:
> The patchset is desinged to test THP functionality.
> 
> when one process allocate hugepage aligned anonymous pages,
> kernel thread 'khugepaged' controlled by sysfs knobs
> /sys/kernel/mm/transparent_hugepage/* will scan them, and make
> them as transparent hugepage if they are suited, you can find out
> how many transparent hugepages are there in one process from
> /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> stand for transparent hugepage.
> 
> v1 to v2:
> accepted Wanlong's suggestion, added some comment for '10s'
> added 'static' key word for single-file-only variant.
> 
> v2 to v3:
> added some comments for low memory system.
> 
> v3 to v4:
> Wanglong point out that the value of khugepaged/defrag is string type,
> not a numeric before applying the commit e27e6151b154 in v2.6.39-rc4,
> and I checked the code again, found the current cases thp0* don't be
> effected by khugepaged/defrag, so I removed the checking of
> khugepaged/defrag from khugepaged_scan_done().
> 
> v4 to v5:
>  1. made some cleaup
>  2. updated 10s to 5s for each checking in khugepaged_scan_done()
>  3. used SAFE_FILE_SCANF|PRINTF() instead of write_file()
> 
> v5 to v6:
> made a little cleanup.

Applied this V6, thank you.

You may use the wrong --subject-prefix

Wanlong Gao

> 
> Zhouping Liu (3):
>   mm/thp: new case thp04.c
>   lib/mem: introduce a new function set_global_mempolicy()
>   mm/thp: add new case thp05
> 
>  runtest/mm                         |   6 ++
>  testcases/kernel/mem/include/mem.h |  12 +++
>  testcases/kernel/mem/lib/mem.c     | 199 ++++++++++++++++++++++++++++++++++++-
>  testcases/kernel/mem/thp/thp04.c   | 142 ++++++++++++++++++++++++++
>  testcases/kernel/mem/thp/thp05.c   | 153 ++++++++++++++++++++++++++++
>  5 files changed, 511 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/mem/thp/thp04.c
>  create mode 100644 testcases/kernel/mem/thp/thp05.c
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
