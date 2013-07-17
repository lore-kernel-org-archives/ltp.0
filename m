Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UzG4K-00009l-3g
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 00:58:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UzG4I-0006Yv-0c
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 00:58:12 +0000
Message-ID: <51E5EC13.5030400@cn.fujitsu.com>
Date: Wed, 17 Jul 2013 08:57:55 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <65bd50b9cbce20c71adb8a412ef1f95a527db102.1373973465.git.jstancek@redhat.com>
In-Reply-To: <65bd50b9cbce20c71adb8a412ef1f95a527db102.1373973465.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] kernel/firmware: always build userspace bits
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 07/16/2013 07:20 PM, Jan Stancek wrote:
> Because this testcase is listed in runtest files, we should
> always build userspace bits, so that ltp has something to run.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
