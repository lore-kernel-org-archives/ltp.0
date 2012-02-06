Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RuG3v-0002vD-Nh
	for ltp-list@lists.sourceforge.net; Mon, 06 Feb 2012 04:20:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RuG3u-0001I2-D7
	for ltp-list@lists.sourceforge.net; Mon, 06 Feb 2012 04:20:19 +0000
Message-ID: <4F2F54C3.1090208@cn.fujitsu.com>
Date: Mon, 06 Feb 2012 12:19:15 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328498186-14768-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F2F5392.5010502@casparzhang.com>
In-Reply-To: <4F2F5392.5010502@casparzhang.com>
Subject: Re: [LTP] [PATCH v5 0/4] hugemmap: code cleanups
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

On 02/06/2012 12:14 PM, Caspar Zhang wrote:

> On 02/06/2012 11:16 AM, Wanlong Gao wrote:
>>
>> Hi Caspar, Cyril:
>> This is the v5 of the hugemmmap cleanups.
>>
>> Thanks
>> -Wanlong Gao
>>
>> Wanlong Gao (4):
>>   hugemmap01: code cleanups
>>   hugemmap02: code cleanups
>>   hugemmap03: code cleanups
>>   hugemmap04: code cleanups
>>
>>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  177 +++++++-----------
>>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  190 ++++++++-----------
>>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |  133 +++++--------
>>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  199 ++++++++------------
>>  4 files changed, 276 insertions(+), 423 deletions(-)
>>
> 
> Hi, all patches committed.


Glad to hear that, thank you.

-Wanlong Gao

> 
> Thanks,
> Caspar
> 



------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
