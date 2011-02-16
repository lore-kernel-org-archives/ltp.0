Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Ppbmj-0000rL-IC
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 07:26:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Ppbmi-0008KD-0b
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 07:26:49 +0000
Message-ID: <4D5B7C44.6080005@cn.fujitsu.com>
Date: Wed, 16 Feb 2011 15:27:00 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D58C631.7040508@cn.fujitsu.com>	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>	<4D58F766.6040208@cn.fujitsu.com>	<AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>	<4D5B7144.9000801@cn.fujitsu.com>
	<AANLkTim23RXT05JSZHwY0Bhnki4qz2T3vNen35gKFn1=@mail.gmail.com>
In-Reply-To: <AANLkTim23RXT05JSZHwY0Bhnki4qz2T3vNen35gKFn1=@mail.gmail.com>
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

Garrett Cooper said the following on 2011-2-16 14:45:
>> Sorry, the child process need exit when success in do_master_child().
>> I rewrite a new patch base on your version, please review.
> 
>     This is what the code currently looks like. I assume the same
> needs to be done for the other set*suid syscall testcases?

setresuid and setreuid also need to be fixed at least.
Thanks.

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
