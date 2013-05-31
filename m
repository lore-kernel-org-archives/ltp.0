Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UiKaL-0000EW-K1
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 08:21:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UiKaJ-0003XL-Uk
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 08:21:17 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4V8Fpmm000789
	for <ltp-list@lists.sourceforge.net>; Fri, 31 May 2013 16:16:31 +0800
Message-ID: <51A85BFC.4080205@cn.fujitsu.com>
Date: Fri, 31 May 2013 16:14:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <51A59AE7.60006@cn.fujitsu.com>
In-Reply-To: <51A59AE7.60006@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] su/su01_s1: fix mismatched double quotation marks
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/29/2013 02:06 PM, DAN LI wrote:
> Expect code
> * spawn su -c "/bin/su root -c \"echo \"\\\$TEST_LINE > $TEST_ENV_FILE\"\""
> will be translated to
> * spawn su -c /bin/su root -c "echo "\$TEST_LINE > /tmp/TEST_ENV_FILE_ROOT""
> which actually should be
> * spawn su -c /bin/su root -c "echo \$TEST_LINE > /tmp/TEST_ENV_FILE_ROOT"
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
