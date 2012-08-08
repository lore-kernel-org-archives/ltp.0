Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SyyjC-0001Kr-0P
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 05:22:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Syyj9-0001MY-IW
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 05:22:41 +0000
Message-ID: <5021F749.4070205@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 13:21:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343924528-1811-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1343924528-1811-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH 1/1] capability: fix sys/capability.h compile error
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net, OEL-QA_WW@oracle.com

On 08/03/2012 12:22 AM, Simon Xu wrote:
> Capability testcases fail to compile with sys/capability.h of libcap-devel in
> RHEL5-like distros:
> 
> In file included from /usr/include/sys/capability.h:34, from cap_bounds_r.c:30:
> /usr/include/linux/capability.h:70:
>          error: expected specifier-qualifier-list before '__le32'
> 
> This is due to sys/capability.h preventing the correct _LINUX_TYPES_H_ from
> being included.  The problem can be bypassed by including linux/types.h in
> capability testcases.
> 
> Signed-off-by: Simon Xu <xu.simon@oracle.com>

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
