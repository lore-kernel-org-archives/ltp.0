Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NAjJ1-0002yx-Rf
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 12:06:39 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NAjIv-0000g8-FM
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 12:06:39 +0000
Received: by pwi12 with SMTP id 12so723940pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Nov 2009 04:06:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1258538660.7556.213.camel@rado-desktop>
References: <1258538660.7556.213.camel@rado-desktop>
Date: Wed, 18 Nov 2009 04:06:27 -0800
Message-ID: <364299f40911180406x563c7101wb99e6fac2d274c05@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Network stress tests patches
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Radoslav Kolev <radoslav.kolev@rnd.bg>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Nov 18, 2009 at 2:04 AM, Radoslav Kolev <radoslav.kolev@rnd.bg> wro=
te:
> Hello guys,
>
> I have run into some problems with the network stress tests. I submitted
> a bug through the sourceforge bug tracker, but after subscribing to the
> mailing list I can see that it's here where all the action is. If this
> is not the right place, then please tell me what is the preferred way to
> submit bug reports and patches.
>
> I am using ltp-full-20091031.
>
> A lot of the TCP tests involving packet loss fail with this error:
>
> ./tcp4-uni-basic01: line 394: netem_param: unbound variable
>
> The reason is that strict checking for undefined variables is enabled
> with "set -u", but the variable netem_param is not always defined before
> testing its contents.
>
> The fix I have applied is to initialize the netem_param variable with an
> empty string.
>
> Also if4-addr-change always fails with this error:
>
> TBROK =A0: =A0Failed to set an IPv4 address at the remote host
>
> I have found the reason to be a missing semicolon.
>
> Best regards,
> Radoslav Kolev
>
> --- ltp-full-20091031.orig/testcases/network/stress/tcp/uni-basic/tcp4-un=
i-basic01 =A0 =A0 =A02009-11-18 11:41:02.000000000 +0200
> +++ ltp-full-20091031/testcases/network/stress/tcp/uni-basic/tcp4-uni-bas=
ic01 =A0 2009-11-18 11:44:37.000000000 +0200
> @@ -379,6 +379,7 @@
> =A0 =A0 esac
>
> =A0 =A0 # Make the network delay
> + =A0 =A0netem_param=3D""
> =A0 =A0 if $DO_NET_DELAY ; then
> =A0 =A0 =A0 =A0netem_param=3D"delay ${NET_DELAY}ms ${NET_DELAY_DEFL}ms di=
stribution normal"
> =A0 =A0 =A0 =A0ret=3D`$LTP_RSH $RHOST 'PATH=3D/sbin:/usr/sbin:$PATH tc' q=
disc add dev $rhost_ifname root netem $netem_param' ; echo $?'`
>
>
> --- ltp-full-20091031.orig/testcases/network/stress/interface/if4-addr-ch=
ange =A0 2009-11-18 11:41:02.000000000 +0200
> +++ ltp-full-20091031/testcases/network/stress/interface/if4-addr-change =
=A0 =A0 =A0 =A02009-11-18 11:56:23.000000000 +0200
> @@ -70,7 +70,7 @@
> =A0LINK_NUM=3D0
>
> =A0# Network portion of the IPv4 address
> -IPV4_NETWORK=3D${IPV4_NETWORK-"10.0.0"}
> +IPV4_NETWORK=3D${IPV4_NETWORK:-"10.0.0"}
>
> =A0# Netmask of for the tested network
> =A0IPV4_NETMASK=3D"255.255.255.0"

Done. Please add a:

signed-off-by: John Smith <foo@bar.com>

tag before your patch when you submit it next time.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
