Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TxU9M-00005H-KJ
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 03:03:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TxU9K-0007H3-Je
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 03:03:48 +0000
Message-ID: <50FE018A.2090002@cn.fujitsu.com>
Date: Tue, 22 Jan 2013 11:03:38 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <92867bc530123caf2e89e05551d79db89cb94e0b.1358819770.git.zliu@redhat.com>
In-Reply-To: <92867bc530123caf2e89e05551d79db89cb94e0b.1358819770.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2]] syscalls/sendmsg01: using 'ip' command to
 replace 'ifconfig'
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/22/2013 10:00 AM, Zhouping Liu wrote:
> 'ip' tools is more general than 'ifconfig', and there are some
> distros don't support to install 'ifconfig' tools under default,
> which will cause such below error:
> 
>    sh: ifconfig: command not found
>    sendmsg01    1  TBROK  :  ifconfig failed to bring up loop back device
>    sendmsg01    2  TBROK  :  Remaining cases broken
> 
> the patch displaced 'ifconfig' using 'ip', and also the case need root
> permission and to check capture unexpected signal.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
