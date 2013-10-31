Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vbo4q-0005B8-95
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:58:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vbo4o-0006cL-O4
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:58:04 +0000
Message-ID: <52721B84.8050105@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 16:57:40 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383208907-9881-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1383208907-9881-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] fcntl/fcntl16: close fd before unlink
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On 10/31/2013 04:41 PM, Stanislav Kholmanskikh wrote:
> This testcase fails on NFS but doesn't remove its
> working directory on exit (NFS silly rename):
> 
> TWARN  :  tst_rmdir: rmobj(/mnt/fcn1GHJ8g) failed: unlink(/mnt/fcn1GHJ8g/.nfs0000000000000c4200000001) failed; errno=16: Device or resource busy
> 
> Fixed.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/fcntl/fcntl16.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
