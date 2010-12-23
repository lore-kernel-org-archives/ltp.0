Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PVaxr-0002Fe-6Z
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 02:31:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PVaxp-00007T-Sv
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 02:31:35 +0000
Message-ID: <4D12B48A.9020500@cn.fujitsu.com>
Date: Thu, 23 Dec 2010 10:31:38 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CBEAF2A.1070101@cn.fujitsu.com>
	<20101221124935.GA944@hannu-debian.research.nokia.com>
In-Reply-To: <20101221124935.GA944@hannu-debian.research.nokia.com>
Subject: Re: [LTP] About LTP
 open_posix_testsuite/functional/threads/robust_test cases
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
To: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hannu Heikkinen wrote:
> On 20/10/10 10:58 +0200, ext Gui Jianfeng wrote:
>> Hi Garrett
>>
>> In open_posix_testsuite/functional/threads/robust_test category,
>> all test cases don't follow the POSIX standard. They call many 
>> functions that glibc doesn't even support. I wonder why not just
>> get rid of these test cases.
>>
>> -- 
>> Regards
>> Gui Jianfeng
> 
> Hi,
> 
> any progress/news about this?

Garrett,

Would you get rid of these cases?

Gui

> 
> br,
> Hannu
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
