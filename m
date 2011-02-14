Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PouqG-0003p7-Es
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 09:35:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PouqE-00017P-Me
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 09:35:36 +0000
Message-ID: <4D58F766.6040208@cn.fujitsu.com>
Date: Mon, 14 Feb 2011 17:35:34 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D58C631.7040508@cn.fujitsu.com>
	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>
In-Reply-To: <AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] setfsuid04.c: the child process should exit 0
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

Garrett Cooper said the following on 2011-2-14 14:23:
>     How about this version instead? There were issues with the

The two "TEST_ERRNO" should be replaced with "errno" in this version, 
If not, the version will fail.

-- 
Best Regards,
Peng Haitao

> previous version of the file where calling tst_brkm from inside the
> child process would break test execution in interesting and
> non-deterministic ways.
>     As a bonus task you could convert things to SAFE_* macros as there
> are a number of spots that I didn't touch that are missing error
> checks.
> Thanks!
> -Garrett


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
