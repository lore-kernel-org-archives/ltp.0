Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Ugrm9-0001aS-NP
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 07:23:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ugrm3-0001Af-HB
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 07:23:25 +0000
Message-ID: <51A3099D.9060308@cn.fujitsu.com>
Date: Mon, 27 May 2013 15:22:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1369636182-4730-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1369636182-4730-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] Unmap the mapped address region
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

On 05/27/2013 02:29 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> It does not unmap the mapped address region,so we sometimes still get
> such
> warning when cleanup with nfs as TMPDIR although the file descriptor is
> closed:
> 0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb)
> failed:
> unlink(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb/.nfs000000000110cb3600000001)
> failed; errno=16: Device or resource busy
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
