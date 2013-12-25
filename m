Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VvcoK-0000HB-B1
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 00:58:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VvcoI-0001Jx-Uh
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 00:58:56 +0000
Message-ID: <52BA2DBA.6030204@cn.fujitsu.com>
Date: Wed, 25 Dec 2013 08:58:34 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <69b0ae6d4039f97ac8bc68975640f8a79ac69aa2.1386926927.git.jstancek@redhat.com>
In-Reply-To: <69b0ae6d4039f97ac8bc68975640f8a79ac69aa2.1386926927.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] get_robust_list01: use pid_max instead of
	UINT16_MAX
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

On 12/13/2013 05:29 PM, Jan Stancek wrote:
> UINT16_MAX can be a valid pid number on some systems.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../syscalls/get_robust_list/get_robust_list01.c   |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Pushed, thanks.

Wanlong Gao


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
