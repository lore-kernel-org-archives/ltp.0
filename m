Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TqbED-00012I-W8
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 03:12:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TqbEC-0000v0-VS
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 03:12:21 +0000
Message-ID: <50E4F731.5050502@cn.fujitsu.com>
Date: Thu, 03 Jan 2013 11:12:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1356420393-4253-1-git-send-email-jshao@redhat.com>
	<1356511717-31058-3-git-send-email-jshao@redhat.com>
In-Reply-To: <1356511717-31058-3-git-send-email-jshao@redhat.com>
Subject: Re: [LTP] [PATCHv2 3/3] pidns16: child should not get parent pid in
 parent NS
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
To: Monson Shao <jshao@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/26/2012 04:48 PM, Monson Shao wrote:
> parent pid in parent NS is invisible to child, even when child got signalled
> from parent, the signaller process should be fake parent (PID 0).
> 
> Signed-off-by: Monson Shao <jshao@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
