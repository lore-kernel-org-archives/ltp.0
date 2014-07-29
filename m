Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1XCAlU-0004o3-HW
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 17:00:40 +0000
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XCAlR-0003EI-SG
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 17:00:39 +0000
Received: by mail-pd0-f177.google.com with SMTP id p10so11947182pdj.36
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Jul 2014 10:00:31 -0700 (PDT)
Message-ID: <53D7D37E.10208@casparzhang.com>
Date: Wed, 30 Jul 2014 01:01:50 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <49518ab05d50db10c44b8692334cfeab6ae57a48.1406639842.git.jstancek@redhat.com>
In-Reply-To: <49518ab05d50db10c44b8692334cfeab6ae57a48.1406639842.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] move cpuset01 to stress runtest
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net

On 07/29/2014 09:17 PM, Jan Stancek wrote:
> This reproducer takes significant time, it runs for 1 hour,
> which is ~1/3 of time spent by all mm testcases. Move it to
> stress runtest.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>   runtest/mm           |    2 --
>   runtest/stress.part1 |    4 +++-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/runtest/mm b/runtest/mm
> index 131bc3d..031d766 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -73,8 +73,6 @@ ksm06 ksm06
>   ksm06_1 ksm06 -n 10
>   ksm06_2 ksm06 -n 10000
>
> -cpuset01 cpuset01 -I 3600
> -
>   oom01 oom01
>   oom02 oom02
>   oom03 oom03
> diff --git a/runtest/stress.part1 b/runtest/stress.part1
> index 529716c..fc8363d 100644
> --- a/runtest/stress.part1
> +++ b/runtest/stress.part1
> @@ -23,7 +23,6 @@ mem02 mem02
>   # -s(seconds) settings, if default not desired
>   mmap-corruption01 mmap-corruption01 -h1 -m1 -s1
>
> -
>   page01 page01
>   page02 page02
>
> @@ -39,6 +38,9 @@ shmt07 shmt07
>   shmt08 shmt08
>   shmt09 shmt09
>   shmt10 shmt10
> +
> +cpuset01 cpuset01 -I 3600
> +
>   fsx-linux export TCbin=$LTPROOT/testcases/bin;fsxtest02 10000
>   #fsx-ext2 fsxtest $SCRATCHDEV ext2 10000
>   #fsx-ext3 fsxtest $SCRATCHDEV ext3 10000
>


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
