Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URiOW-0000XF-Q1
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 12:20:24 +0000
Date: Mon, 15 Apr 2013 14:21:12 +0200
From: chrubis@suse.cz
Message-ID: <20130415122112.GB1091@rei>
References: <cover.1365402799.git.zliu@redhat.com>
	<6b9bfe6944adbbb2963d6e18cad373a309956f90.1365402799.git.zliu@redhat.com>
	<51627C9C.9060200@cn.fujitsu.com> <51628513.4000702@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51628513.4000702@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] mm/thp: new case thp04.c
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

Hi!
> here 10s is similar with one inside wait_ksmd_done() (see lib/mem.c)
> 
> 10s is an interval for khugepaged to finish scan process's transparent
> hugepages, and at the beginning, 
> khugepaged/[scan_sleep_millisecs|alloc_sleep_millisecs]
> are all be set 0, so 'khugepaged' always run 100% during the testing, 
> depending on
> this, I choose an optional value 10s to khugepaged, and I think the 
> interval is enough
> to recognise whether khugepaged finished scanning process's anonymous 
> hugepage or not.

Hardcoded constants tend to break from time to time. Is there any
interface that could give you information about the state of the scan?

-- 
Cyril Hrubis
chrubis@suse.cz

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
