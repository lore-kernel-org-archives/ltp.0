Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Syyjl-0000Vx-Hg
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 05:23:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Syyjj-0007ZY-23
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 05:23:17 +0000
Message-ID: <5021F76F.7050608@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 13:21:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343922131-1520-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1343922131-1520-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH 1/1] runltp: avoid using --tmpdir with mktemp
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
Cc: ltp-list@lists.sourceforge.net

On 08/02/2012 11:42 PM, Simon Xu wrote:
> '--tmpdir' is not supported by older mktemp, and runltp encounters error:
> 
> mktemp: invalid option -- -
> Usage: mktemp [-V] | [-dqtu] [-p prefix] [template]
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
