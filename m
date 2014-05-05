Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WhCBE-0007Ns-HB
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 06:15:12 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WhCBD-0003WO-Gn
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 06:15:12 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s456F1q2026610
	for <ltp-list@lists.sourceforge.net>; Mon, 5 May 2014 14:15:01 +0800
Message-ID: <53672C1A.7080103@cn.fujitsu.com>
Date: Mon, 5 May 2014 14:13:46 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1398687969-16853-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1398687969-16853-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] kernel/mem/lib/mem.c: make tests continue to
 run even though KSM is not enabled
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/28/2014 08:26 PM, Xiaoguang Wang wrote:
> When kernel KSM configuration is not enabled, we make testcases continue to run
> instead of returning TCONF, e.g. oom01. And if KSM configuration is not enabled, in
> the original code, "tst_brkm(TCONF, NULL, ...)" will be called, in this case, we
> will forget to execute the restore operations defined in cleanup, which will forget
> to restore the /proc/sys/vm/overcommit_memory to 0, and this will impact other test
> cases in LTP, for example, fork14 in RHEL5 will succeed unexpectedly.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/lib/mem.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
