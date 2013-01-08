Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TsSOP-0000ev-QQ
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:10:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsSOO-0004pT-Qi
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:10:33 +0000
Message-ID: <50EBB561.6010708@cn.fujitsu.com>
Date: Tue, 08 Jan 2013 13:57:53 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
	<ef3e82060d793bdd820b38b6ea669a70ef6bb494.1357277005.git.zliu@redhat.com>
In-Reply-To: <ef3e82060d793bdd820b38b6ea669a70ef6bb494.1357277005.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/2] mm/include: removed the global var 'memory'
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

On 01/04/2013 02:12 PM, Zhouping Liu wrote:
> we don't use the global var 'memory' any more,
> so removed it, and changed local var 'memory_new'
> as 'memory'.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

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
