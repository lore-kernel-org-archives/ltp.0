Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rfnhk-0000tg-GJ
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 07:13:40 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rfnhj-0001qg-MA
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 07:13:40 +0000
Received: by iakh37 with SMTP id h37so22297764iak.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 23:13:34 -0800 (PST)
Message-ID: <4EFABA8E.6050008@casparzhang.com>
Date: Wed, 28 Dec 2011 14:43:26 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1322044169-30851-3-git-send-email-gaowanlong@cn.fujitsu.com>
	<4EFAA778.5030704@casparzhang.com>
	<4EFAB5FB.1070907@cn.fujitsu.com>
In-Reply-To: <4EFAB5FB.1070907@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/5] hugemmap01.c : automatically mount hugetlbfs.
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
Cc: ltp-list@lists.sourceforge.net

On 12/28/2011 02:23 PM, Wanlong Gao wrote:
>>> >> +	tst_tmpdir();
>>> >> +	mount_point = get_tst_tmpdir();
>>> >> +	mount_hugetlbfs(mount_point);
>>> >> +	hugepage_alloc(1024);
> 
> sure, will change to a macro.

I don't think a macro can improve much. You patch reduces the testcase
scalability. A better way is passing hugepage size you want to set via
option:

./hugemmap01 -s 1024

The default value 1024 is not good enough, for x86 systems, it will
require at least 2GB free memory, for other systems, like powerpc, it
will require 16GB free memory. It would be better if you calculate how
much memory the system can be used for hugepages.

One more thing (on libmnt.c side), is there any action if hugepage_alloc
set 0, and is there any action if you want to set 1024 hpages, but only
allocated less amount than that?

Thanks,
Caspar

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
