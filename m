Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UUYTJ-0008DI-I3
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:21:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUYTG-0005Zl-IM
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:21:05 +0000
Message-ID: <51764477.1080004@cn.fujitsu.com>
Date: Tue, 23 Apr 2013 16:21:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <ac28b41ad3d99415f2bc72b14708ad2c24350099.1366700755.git.zliu@redhat.com>
In-Reply-To: <ac28b41ad3d99415f2bc72b14708ad2c24350099.1366700755.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2] lib/mem: removed read_file() and write_file()
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

On 04/23/2013 03:12 PM, Zhouping Liu wrote:
> SAFE_FILE_SCANF() and SAFE_FILE_PRINTF() can completely displace
> read_file() and write_file(), so removed them.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> 
> v1 - v2:
> made some cleanup, and fixed a little error.

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
