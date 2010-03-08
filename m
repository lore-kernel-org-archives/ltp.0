Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NofDD-0005Ya-Hi
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 15:49:43 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NofDB-0004Lw-Bc
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 15:49:43 +0000
Received: by iwn33 with SMTP id 33so5202361iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Mar 2010 07:49:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <007e01cabe99$8669b9f0$933d2dd0$@co.jp>
References: <007e01cabe99$8669b9f0$933d2dd0$@co.jp>
Date: Mon, 8 Mar 2010 07:49:35 -0800
Message-ID: <364299f41003080749i3315b5ek268985acf785fa57@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] mail_tests.sh : a small mistake
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
To: Yuki Yao <y_yao@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Mar 8, 2010 at 12:29 AM, Yuki Yao <y_yao@ryobi.co.jp> wrote:
> Hi,
>
> I found a small mistake about "mail" test.
>
> When mail reception error occurred in "Test #3", this test displays
> "Test #2" not "Test #3".
>
> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>
>
> Index: ./testcases/commands/mail/mail_tests.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> --- ./testcases/commands/mail/mail_tests.sh.orig =A0 =A0 =A0 =A02010-03-08
> 16:00:56.000000000 +0900
> +++ ./testcases/commands/mail/mail_tests.sh =A0 =A0 2010-03-08
> 16:01:34.000000000 +0900
> @@ -257,7 +257,7 @@
> =A0 =A0 if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
> =A0 =A0 then
> =A0 =A0 =A0 =A0 $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
> - =A0 =A0 =A0 =A0"Test #2: No new mail for root. Reason:"
> + =A0 =A0 =A0 =A0"Test #3: No new mail for root. Reason:"
> =A0 =A0 =A0 =A0 TFAILCNT=3D$(( $TFAILCNT+1 ))
> =A0 =A0 else
> =A0 =A0 =A0 =A0 if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -=
ne 0 ]

This was already fixed on git head.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
