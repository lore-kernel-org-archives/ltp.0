Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1USJQ6-0004r2-Mk
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 03:52:30 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USJQ4-0002ZD-Ke
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 03:52:30 +0000
Date: Tue, 16 Apr 2013 23:52:14 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <580855074.1538065.1366170734748.JavaMail.root@redhat.com>
In-Reply-To: <516E1673.6090902@cn.fujitsu.com>
References: <cover.1366122425.git.zliu@redhat.com>
	<516E1673.6090902@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v5 0/3] mm/thp: add two new case
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



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, April 17, 2013 11:26:43 AM
> Subject: Re: [LTP] [PATCH v5 0/3] mm/thp: add two new case
> 
> On 04/16/2013 10:30 PM, Zhouping Liu wrote:
> > The patchset is desinged to test THP functionality.
> > 
> > when one process allocate hugepage aligned anonymous pages,
> > kernel thread 'khugepaged' controlled by sysfs knobs
> > /sys/kernel/mm/transparent_hugepage/* will scan them, and make
> > them as transparent hugepage if they are suited, you can find out
> > how many transparent hugepages are there in one process from
> > /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> > stand for transparent hugepage.
> > 
> > v1 to v2:
> > accepted Wanlong's suggestion, added some comment for '10s'
> > added 'static' key word for single-file-only variant.
> > 
> > v2 to v3:
> > added some comments for low memory system.
> > 
> > v3 to v4:
> > Wanglong point out that the value of khugepaged/defrag is string type,
> > not a numeric before applying the commit e27e6151b154 in v2.6.39-rc4,
> > and I checked the code again, found the current cases thp0* don't be
> > effected by khugepaged/defrag, so I removed the checking of
> > khugepaged/defrag from khugepaged_scan_done().
> > 
> > v4 to v5:
> >  1. made some cleaup
> >  2. updated 10s to 5s for each checking in khugepaged_scan_done()
> >  3. used SAFE_FILE_SCANF|PRINTF() instead of write_file()
> > 
> > v5 to v6:
> > made a little cleanup.
> 
> Applied this V6, thank you.
> 
> You may use the wrong --subject-prefix

yeah, thanks for your friendly correcting, I used the history command :(

-- 
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
