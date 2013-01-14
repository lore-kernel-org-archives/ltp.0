Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TuZ71-0006zm-PP
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:45:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TuZ6y-0001U1-0W
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:45:19 +0000
Message-ID: <50F36336.6010102@cn.fujitsu.com>
Date: Mon, 14 Jan 2013 09:45:26 +0800
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

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
