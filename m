Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VGVIe-0006MU-FI
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 14:40:16 +0000
Received: from mail-lb0-f177.google.com ([209.85.217.177])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VGVId-0004t4-Je
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 14:40:16 +0000
Received: by mail-lb0-f177.google.com with SMTP id p5so3969525lbi.36
	for <ltp-list@lists.sourceforge.net>;
	Mon, 02 Sep 2013 07:40:08 -0700 (PDT)
Date: Mon, 2 Sep 2013 16:45:08 +0200
From: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20130902144508.GN18729@nexon.se>
References: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
Subject: Re: [LTP] [PATCHv2 0/2] Rework to printf and added required import
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
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

On 2013-08-29 15:55, Anders Roxell wrote:
> Hi,
> 
> Rewoked to printf and added required import
> 
> /Anders
> 
> Anders Roxell (2):
>   realtime parser: remove unused and depricated imports
>   runltp: rework echo -n to printf POSIX-compliant
> 
>  runltp                               | 15 +++++----------
>  testcases/realtime/scripts/parser.py |  2 +-
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> -- 
> 1.8.1.2
> 

Ping.

/Anders

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
