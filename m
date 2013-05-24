Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Uflzx-0007iR-Ki
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 07:01:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uflzv-00044r-Py
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 07:01:09 +0000
Message-ID: <519F0FF6.1000403@cn.fujitsu.com>
Date: Fri, 24 May 2013 15:00:06 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1369364619-24704-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1369364619-24704-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] dup07:Close the file before unlink it.
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

On 05/24/2013 11:03 AM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> When unlink() a file in nfs environment,it will rename the file to a
> .nfs<xxxxx> file if any process still has that file open.And this file
> could not be deleted until it is closed.So we always get the following
> warning which makes testcase "dup07" failed:
> 0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H)
> failed:
> unlink(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H/.nfs000000000110cb3800000066)
> failed; errno=16: Device or resource busy
> 
> Close the created/dup file before unlink() it to fix this issue.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
