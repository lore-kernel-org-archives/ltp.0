Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SDCFJ-0007uj-4a
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 10:06:21 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SDCFD-0008R7-SA
	for ltp-list@lists.sourceforge.net; Thu, 29 Mar 2012 10:06:21 +0000
Received: by vcbfl13 with SMTP id fl13so2112620vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Mar 2012 03:06:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1333015103-23342-1-git-send-email-penght@cn.fujitsu.com>
References: <1333015103-23342-1-git-send-email-penght@cn.fujitsu.com>
Date: Thu, 29 Mar 2012 03:06:10 -0700
Message-ID: <CAGH67wR9ZGjypQbE_oWb1pM=U4=oetNFrberWD66sZj4o9Lm3g@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cron02: fix a bug of /etc/init.d/crond is
	nonexistent
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Mar 29, 2012 at 2:58 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> /etc/init.d/crond is nonexistent in fedora16, so should be replaced with
> systemctl.
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
> =A0testcases/commands/cron/cron02 | =A0 14 ++++++++++++++
> =A01 file changed, 14 insertions(+)
>
> diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cro=
n02
> index 0c05c95..213fe02 100755
> --- a/testcases/commands/cron/cron02
> +++ b/testcases/commands/cron/cron02
> @@ -52,12 +52,26 @@ do_setup(){
> =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 fi
>
> + =A0 =A0 =A0 # running under systemd?
> + =A0 =A0 =A0 if command -v systemctl >/dev/null 2>&1; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HAVE_SYSTEMCTL=3D1
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HAVE_SYSTEMCTL=3D0
> + =A0 =A0 =A0 fi
> +

HAVE_SYSTEMCTL=3Dtrue/false is easier to deal with. That way you can do...

if $HAVE_SYSTEMCTL
then
    # do something...
    :
fi

> =A0 =A0 =A0 =A0# restart cron daemon
> =A0 =A0 =A0 =A0# Red Hat uses crond, SuSE/Other uses cron.
> =A0 =A0 =A0 =A0if [ -x /etc/init.d/crond ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/etc/init.d/crond restart
> =A0 =A0 =A0 =A0elif [ -x /etc/init.d/cron ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/etc/init.d/cron restart
> + =A0 =A0 =A0 elif [ $HAVE_SYSTEMCTL =3D=3D 1 ]; then

bashism (=3D=3D).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for crond in "crond" "cron"; do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if systemctl is-enabled $cr=
ond.service >/dev/null 2>&1; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systemctl r=
estart $crond.service
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 done
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "Could not determine cron init.d scri=
pt."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit 1

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
