Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGX7Y-0003z9-PD
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 16:36:56 +0000
Date: Mon, 2 Sep 2013 18:37:06 +0200
From: chrubis@suse.cz
Message-ID: <20130902163706.GA30482@rei>
References: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
	<1377784548-1036-2-git-send-email-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377784548-1036-2-git-send-email-anders.roxell@linaro.org>
Subject: Re: [LTP] [PATCH 1/2] realtime parser: remove unused and depricated
 imports
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
To: Anders Roxell <anders.roxell@linaro.org>
Cc: ltp-list@lists.sourceforge.net, patches@linaro.org

Hi!
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/realtime/scripts/parser.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/realtime/scripts/parser.py b/testcases/realtime/scripts/parser.py
> index b90233c..6b2dc73 100644
> --- a/testcases/realtime/scripts/parser.py
> +++ b/testcases/realtime/scripts/parser.py
> @@ -26,7 +26,7 @@
>  ##                                                                            ##
>  ################################################################################
>  
> -import sys,os,string,re
> +import sys

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

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
