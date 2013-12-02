Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VnMCf-0003m3-Qo
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 05:37:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VnMCe-0001yK-JA
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 05:37:53 +0000
Message-ID: <529C1C56.2010209@cn.fujitsu.com>
Date: Mon, 02 Dec 2013 13:36:22 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <2ad340abd08f682ea74269d96df3bcf6e4e10a67.1385721415.git.jstancek@redhat.com>
In-Reply-To: <2ad340abd08f682ea74269d96df3bcf6e4e10a67.1385721415.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] send*: use concrete flags for 'invalid flags set'
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

On 11/29/2013 06:39 PM, Jan Stancek wrote:
> Use a concrete set of flags instead of '-1', which is
> known to fail with EOPNOTSUPP.
> 
> Tested with:
>   2.6.18-128.37.1.el5
>   2.6.32-358.el6
>   3.10.0-54.el7
>   upstream 3.13.0-rc1+
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

FYI, applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
