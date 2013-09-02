Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGX8Z-0000sv-48
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 16:37:59 +0000
Date: Mon, 2 Sep 2013 18:38:09 +0200
From: chrubis@suse.cz
Message-ID: <20130902163809.GB30482@rei>
References: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
	<1377784548-1036-3-git-send-email-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377784548-1036-3-git-send-email-anders.roxell@linaro.org>
Subject: Re: [LTP] [PATCH 2/2] runltp: rework echo -n to printf
 POSIX-compliant
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
>  runltp | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/runltp b/runltp
> index a419bf8..eb8e0c0 100755
> --- a/runltp
> +++ b/runltp
> @@ -537,18 +537,13 @@ main()
>          {
>              [ -z "$RHOST" ] && \
>              {
> -                echo \
> -                "INFO: Enter RHOST = 'name of the remote host machine'"
> -                echo -n "-> "
> +                printf "INFO: Enter RHOST = 'name of the remote host machine'\n-> "

Please do not add lines that are over 80 characters.

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
