Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7GHS-0008I3-QK
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:58 +0000
Received: from mail-iw0-f196.google.com ([209.85.223.196])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7GHS-0007iE-2s
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:58 +0000
Received: by mail-iw0-f196.google.com with SMTP id 34so11414028iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Apr 2010 16:02:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100428210936.GA20642@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
	<20100428210936.GA20642@us.ibm.com>
Date: Wed, 28 Apr 2010 16:02:57 -0700
Message-ID: <h2q364299f41004281602p6a6a5565rdbc6210b2650ee7e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] pidns30: strip leading / from name passed to
	mq_open
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Apr 28, 2010 at 2:09 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> ---
> =A0testcases/kernel/containers/pidns/pidns30.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kern=
el/containers/pidns/pidns30.c
> index ea8c54c..5975b53 100644
> --- a/testcases/kernel/containers/pidns/pidns30.c
> +++ b/testcases/kernel/containers/pidns/pidns30.c
> @@ -59,7 +59,7 @@
> =A0char *TCID =3D "pidns30";
> =A0int TST_TOTAL =3D 1;
>
> -char *mqname =3D "/mq1";
> +char *mqname =3D "mq1";
> =A0int result =3D TFAIL;
>
> =A0int errno;

Acked-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
