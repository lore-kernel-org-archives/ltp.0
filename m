Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UUCgC-0002QE-2l
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 09:04:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUCgA-0004ST-Nn
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 09:04:56 +0000
Message-ID: <5174FD40.5040703@cn.fujitsu.com>
Date: Mon, 22 Apr 2013 17:05:04 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <515EA506.8060305@linux.vnet.ibm.com>
	<51621625.6000507@cn.fujitsu.com>
	<5163BCCC.90909@linux.vnet.ibm.com>
	<516CABFB.3030602@cn.fujitsu.com>
	<5174F86B.20601@linux.vnet.ibm.com>
In-Reply-To: <5174F86B.20601@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] runltp: syscalls/mount0* and inotify03 tests are
 getting skipped from runltp's execution
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
To: Ramesh <rameshyr@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 04/22/2013 04:44 PM, Ramesh wrote:
> On 04/16/2013 07:10 AM, Wanlong Gao wrote:
>> On 04/09/2013 03:01 PM, Ramesh wrote:
>>> Hi,
>>>
>>> I have corrected few indentation flaws and I think this patch should be fine to commit.
>>> Please let me know if you are still facing any issues in extracting this patch for commit.
>>>
>>>
>>> Signed-off-by: Ramesh YR<rameshyr@linux.vnet.ibm.com>
>> Applied with the long-line-echo fixed, thank you.
>>
>>
>> Wanlong Gao
>>
> Thanks Wanlong !
> 
> I think History part in runltp script needs to be updated to reflect the changes.

Patches are welcome! ;)

Thanks,
Wanlong Gao

> 
> 
> Regards,
> Ramesh
> 
> 


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
