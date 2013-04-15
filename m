Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URa6i-0003Mw-41
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:29:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URa6h-0006dW-96
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:29:28 +0000
Message-ID: <516B7420.5010002@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 11:29:36 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1365411883.git.zliu@redhat.com>
	<3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
	<516B52DB.2000004@cn.fujitsu.com> <516B7077.1000001@redhat.com>
In-Reply-To: <516B7077.1000001@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/3] mm/thp: new case thp04.c
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

On 04/15/2013 11:13 AM, Zhouping Liu wrote:
> depending on your system's memory info:
> 
> free reports:
>              total       used       free     shared    buffers     cached
> Mem:       8025000    7563668     461332          0     730920    4891316
> -/+ buffers/cache:    1941432    6083568
> Swap:      4194300      16212    4178088
> 
> your system has 8Gb RAM and there's 460Mb memory left when you start to test thp04 serial cases.
> I guess the cases failed because of the low memory.
> 
> can you re-test them on the system with enough memory? and provide the value of /proc/sys/vm/min_free_kbytes,
> I think 1Gb memory left is enough to test the new THP case.
> 
> also I'm very confused why the above case didn't get any THPs, maybe there's some performance issues...

Yes, that's passed after my reboot.

Thanks,
Wanlong Gao

> 
> Thanks,
> Zhouping


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
