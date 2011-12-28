Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Rfmwj-0004KG-7G
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 06:25:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rfmwh-0004Ix-Jo
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 06:25:05 +0000
Message-ID: <4EFAB5FB.1070907@cn.fujitsu.com>
Date: Wed, 28 Dec 2011 14:23:55 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1322044169-30851-3-git-send-email-gaowanlong@cn.fujitsu.com>
	<4EFAA778.5030704@casparzhang.com>
In-Reply-To: <4EFAA778.5030704@casparzhang.com>
Subject: Re: [LTP] [PATCH 2/5] hugemmap01.c : automatically mount hugetlbfs.
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi Casper:

> 
> Hi, I think it's better to keep this option, since not all users would
> like the default mount place.


-H option is not needed, users can set TDIRECTORY env to change the dir if
he don't like the default one, also, remove the -H option can be consistent with
others.


>> +	tst_tmpdir();
>> +	mount_point = get_tst_tmpdir();
>> +	mount_hugetlbfs(mount_point);
>> +	hugepage_alloc(1024);


sure, will change to a macro.


Thanks a lot
-Wanlong Gao

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
