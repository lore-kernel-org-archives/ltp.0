Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UwjhU-0008Ki-Td
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:00:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwjhR-0001t9-Qe
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:00:12 +0000
Message-ID: <51DCBFF1.4030902@cn.fujitsu.com>
Date: Wed, 10 Jul 2013 09:59:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1C23526A7C42DB45BBF55B662C7C530E25B424AA42@BUNGLE.Emea.Arm.com>
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E25B424AA42@BUNGLE.Emea.Arm.com>
Subject: Re: [LTP] [PATCH] flock03.c: fixes a typo when compiling with
	UCLINUX=1
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
To: Benoit Marcot <Benoit.Marcot@arm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 07/09/2013 08:37 PM, Benoit Marcot wrote:
> flock03.c: This patch fixes a typo when compiling with UCLINUX=1.
> 
>  
> 
> Corrects FILENAME to FILE_NAME, and removes some trailing white-spaces in
> 
> empty lines.
> 
>  
> 
> Signed-off-by: Benoit Marcot <benoit.marcot@arm.com>
> 

Thank you, fixed on site with your SOB.

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
