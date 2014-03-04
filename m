Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WKiOh-0000rn-Bu
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:00:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKiOf-000069-Ry
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:00:11 +0000
Message-ID: <531565C1.6080103@cn.fujitsu.com>
Date: Tue, 04 Mar 2014 13:33:53 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1392372604.2085.10.camel@G08JYZSD130126>	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>	<1392889204.2053.7.camel@G08JYZSD130126>	<1392889813.2053.10.camel@G08JYZSD130126>	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>	<929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>	<1393832848.1991.19.camel@G08JYZSD130126>	<1393833079.1991.22.camel@G08JYZSD130126>	<1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
	<1393845775.1984.10.camel@G08JYZSD130126>
In-Reply-To: <1393845775.1984.10.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v5 1/3] safe_macros: Add SAFE_GETRLIMIT and
	SAFE_SETRLIMIT
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 03/03/2014 07:22 PM, Zeng Linggang wrote:
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  include/safe_macros.h | 10 ++++++++++
>  lib/safe_macros.c     | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)


Applied the series, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
