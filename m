Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1USOzW-0003sG-NO
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:49:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USOzV-0007x5-GN
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:49:26 +0000
Message-ID: <516E7038.1000004@cn.fujitsu.com>
Date: Wed, 17 Apr 2013 17:49:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <516E68ED.3040507@gmail.com>
	<786685475.1661263.1366190535675.JavaMail.root@redhat.com>
In-Reply-To: <786685475.1661263.1366190535675.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH V3]  Fix short of nodemask array.
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
To: Lans Zhang <lans.zhang2008@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 04/17/2013 05:22 PM, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Lans Zhang" <lans.zhang2008@gmail.com>
>> To: "Jan Stancek" <jstancek@redhat.com>, "Zhouping Liu" <zliu@redhat.com>
>> Cc: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 17 April, 2013 11:18:37 AM
>> Subject: [PATCH V3] [LTP] Fix short of nodemask array.
>>
>> Changes since V2:
>> remove unused parameter in set_node()
>>
>> In kernel, if user specified more nodes, e.g, 512 nodes, than the
>> supported, e.g, 4 nodes, kernel will check if the non supported
>> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
>> are overrunning "nmask", whose length is shorter than MAXNODES,
>> and where the unsupported bits should be cleared to pass the check.
>>
>> Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> 
> Looks good to me, regards,
> Jan
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
