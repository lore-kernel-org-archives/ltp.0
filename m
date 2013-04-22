Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rameshyr@linux.vnet.ibm.com>) id 1UUCaI-0003sL-AP
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 08:58:50 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UUCaF-0003oi-V8
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 08:58:50 +0000
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <rameshyr@linux.vnet.ibm.com>;
	Mon, 22 Apr 2013 18:49:15 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 444122BB0085
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Apr 2013 18:51:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r3M8UorK51904552
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Apr 2013 18:30:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r3M8iUHR014672
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Apr 2013 18:44:31 +1000
Message-ID: <5174F86B.20601@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 14:14:27 +0530
From: Ramesh <rameshyr@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <515EA506.8060305@linux.vnet.ibm.com>
	<51621625.6000507@cn.fujitsu.com>
	<5163BCCC.90909@linux.vnet.ibm.com>
	<516CABFB.3030602@cn.fujitsu.com>
In-Reply-To: <516CABFB.3030602@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runltp: syscalls/mount0* and inotify03 tests are
 getting skipped from runltp's execution
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
To: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net

On 04/16/2013 07:10 AM, Wanlong Gao wrote:
> On 04/09/2013 03:01 PM, Ramesh wrote:
>> Hi,
>>
>> I have corrected few indentation flaws and I think this patch should be fine to commit.
>> Please let me know if you are still facing any issues in extracting this patch for commit.
>>
>>
>> Signed-off-by: Ramesh YR<rameshyr@linux.vnet.ibm.com>
> Applied with the long-line-echo fixed, thank you.
>
>
> Wanlong Gao
>
Thanks Wanlong !

I think History part in runltp script needs to be updated to reflect the 
changes.


Regards,
Ramesh


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
