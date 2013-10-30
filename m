Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VbLTY-0000cl-6D
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 02:25:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbLTW-0008Cp-MM
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 02:25:40 +0000
Message-ID: <52706E0A.1030805@cn.fujitsu.com>
Date: Wed, 30 Oct 2013 10:25:14 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383033332-932-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1383033332-932-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] setpgid03: use SIGUSR1 instead of sleep
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

On 10/29/2013 03:55 PM, Stanislav Kholmanskikh wrote:
> I came accross the following rare issue:
> 
> setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
> setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1
> 
> I suppose It may happen if the test host is under stress.
> To prevent this It would be better to use SIGUSR1 for parent-child
> synchronisations.
> 
> Also fixed error passing from children and performed a minor cleanup.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>


And it's better to split the cleanup part to another patch to make
your patch clear.

Thanks,
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
