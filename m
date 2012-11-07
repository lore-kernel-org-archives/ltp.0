Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TW4MN-0001KJ-3I
	for Ltp-list@lists.sourceforge.net; Wed, 07 Nov 2012 12:03:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TW4MI-00024R-UN
	for Ltp-list@lists.sourceforge.net; Wed, 07 Nov 2012 12:03:55 +0000
Message-ID: <509A4C9F.3070307@cn.fujitsu.com>
Date: Wed, 07 Nov 2012 19:57:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1352282601-7377-1-git-send-email-Barry.Song@csr.com>
In-Reply-To: <1352282601-7377-1-git-send-email-Barry.Song@csr.com>
Subject: Re: [LTP] [PATCH] thp01: make "true" applet foundable for busybox
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
To: Barry Song <Barry.Song@csr.com>
Cc: Ltp-list@lists.sourceforge.net, workgroup.linux@csr.com

On 11/07/2012 06:03 PM, Barry Song wrote:
> Many embedded systems use busybox. busybox only has one binary, so it depends
> on argv[0] as the applet name to execute right command. in thp01 case, it is
> "true" command.
> this fixes the issue thp01 case always reports "applet not found" for embedded
> systems and make the case pass on those systems using busybox.
> At the same time, this fix doesn't destory the validation of the test case.
> 
> Signed-off-by: Barry Song <Barry.Song@csr.com>

Applied, thank you very much Barry.

Wanlong Gao


------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
