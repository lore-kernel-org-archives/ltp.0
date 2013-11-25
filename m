Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vl18N-0002Et-RW
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 18:43:47 +0000
Date: Mon, 25 Nov 2013 19:43:18 +0100
From: chrubis@suse.cz
Message-ID: <20131125184318.GD32540@rei.suse.cz>
References: <1385339610-862-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385339610-862-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V2] runltp: suppress the out message when creating
 loop device
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  runltp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/runltp b/runltp
> index 63c625f..c8a2e20 100755
> --- a/runltp
> +++ b/runltp
> @@ -956,7 +956,7 @@ main()
>  create_block()
>  {
>      #create a block device
> -    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480
> +    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480 >/dev/null 2>&1
>      if [ $? -ne 0 ]; then
>          echo "Failed to create loopback device image, please check disk space and re-run"
>          return 1

I remember not silencing the output because:

* I don't care much for tidy output from runltp script,
  it prints too much of output anyway.

* It's easier to tell what has happened when the command fails.

But I do not really care, if you need this for something feel free to
commit it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
