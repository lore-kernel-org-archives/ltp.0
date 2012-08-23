Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T4OJL-0002K5-Sa
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 03:42:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4OJK-0000NH-BU
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 03:42:23 +0000
Message-ID: <5035A62C.8060601@cn.fujitsu.com>
Date: Thu, 23 Aug 2012 11:40:28 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
	<5035A4CF.6000200@casparzhang.com>
In-Reply-To: <5035A4CF.6000200@casparzhang.com>
Subject: Re: [LTP] [PATCH] proc01: add option to limit max read bytes
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
To: Caspar Zhang <caspar@casparzhang.com>, Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/23/2012 11:34 AM, Caspar Zhang wrote:
> On 07/31/2012 04:33 PM, Jan Stancek wrote:
>>
>> Add option -m to set upper limit of read megabytes from
>> single proc file. When this limit is reached testcase
>> will continue with next file.
>>
>> Reason for this new option is to allow running this testcase
>> as sanity test, that doesn't need go through full content of
>> files such as "pagemap" (which can take hours).
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

Pushed, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
