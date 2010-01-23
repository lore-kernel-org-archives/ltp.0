Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NYXgq-0001SC-04
	for ltp-list@lists.sourceforge.net; Sat, 23 Jan 2010 04:33:40 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYXgp-0002U6-6G
	for ltp-list@lists.sourceforge.net; Sat, 23 Jan 2010 04:33:39 +0000
Received: by pwj11 with SMTP id 11so1334422pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jan 2010 20:33:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b59be4f.6a44f10a.4f90.ffff8f8eSMTPIN_ADDED@mx.google.com>
References: <4b59be4f.6a44f10a.4f90.ffff8f8eSMTPIN_ADDED@mx.google.com>
Date: Fri, 22 Jan 2010 20:33:25 -0800
Message-ID: <364299f41001222033y617e0899y130605429656c850@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix a probable typo in mc_commo,
	causing attempts 	to run nonexistent binaries
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 22, 2010 at 4:27 AM, Jiri Palecek <jpalecek@web.de> wrote:
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0testcases/network/multicast/mc_commo/mc_commo | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/ne=
twork/multicast/mc_commo/mc_commo
> index 1dad35a..1ea7e59 100755
> --- a/testcases/network/multicast/mc_commo/mc_commo
> +++ b/testcases/network/multicast/mc_commo/mc_commo
> @@ -128,7 +128,7 @@ do_test ()
> =A0 =A0 =A0 do
> =A0 =A0 =A0 =A0 =A0echo "Running on $HOST mc_send $GROUP_ADDR $HOST $PORT=
 $TTL"
>
> - =A0 =A0 =A0 =A0 rsh -n -l root $HOST "$LTPROOT/testcases/bin$REMOTE_EXE=
C" $GROUP_ADDR \
> + =A0 =A0 =A0 =A0 rsh -n -l root $HOST "$LTPROOT/testcases/bin/$REMOTE_EX=
EC" $GROUP_ADDR \
> =A0 =A0 =A0 =A0 $HOST $PORT $TTL >/dev/null &
> =A0 =A0 =A0 =A0 =A0sleep 10
> =A0 =A0 =A0 =A0rsh -n -l root $HOST "ps -ewf | grep mc_send | grep -v gre=
p"

    Good eye as always Jiri. I'll commit this in a few hours when I
get back home..
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
