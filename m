Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PpYWc-00040R-Sj
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 03:57:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpYWb-0007sw-6f
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 03:57:58 +0000
Message-ID: <4D5B4B51.2010301@cn.fujitsu.com>
Date: Wed, 16 Feb 2011 11:58:09 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D5A47E5.3060108@cn.fujitsu.com>
	<AANLkTikjFEnngX7__W7gK8UBTV8O50vf-My5unK_P=8p@mail.gmail.com>
In-Reply-To: <AANLkTikjFEnngX7__W7gK8UBTV8O50vf-My5unK_P=8p@mail.gmail.com>
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Garrett Cooper said the following on 2011-2-15 22:29:
> 
> How about this?

  The patch is OK, thanks.
but "break;" in block "default:" can be deleted:)

> Thanks,
> -Garrett

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
