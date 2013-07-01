Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UtaOV-0001lD-1A
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 09:27:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UtaOT-0004Ke-Ig
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 09:27:34 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r619RP6R012037
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Jul 2013 17:27:25 +0800
Message-ID: <51D14AF5.4000704@cn.fujitsu.com>
Date: Mon, 01 Jul 2013 17:25:09 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cron_tests.sh: fix a bug of syslog daemon is
	disabled
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 06/28/2013 11:10 AM, Peng Haitao wrote:
> The case will check the /var/log/messages to see if there is a record of
> any crontab activity, so make sure syslog daemon is enabld.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
