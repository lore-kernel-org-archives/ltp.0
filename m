Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1ObR4o-0006yJ-LV
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 04:38:38 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObR4l-0004D2-Oh
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 04:38:38 +0000
Received: by iwn34 with SMTP id 34so8942085iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Jul 2010 21:38:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1012448207.707951279683624684.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1072286102.707931279683604082.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1012448207.707951279683624684.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 20 Jul 2010 21:38:25 -0700
Message-ID: <AANLkTin3aHZdgxQgSCdbc-hPy7rG8SwjTAS9oRzhZpJA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix mail test
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Tue, Jul 20, 2010 at 8:40 PM, Caspar Zhang <czhang@redhat.com> wrote:
> Hi all,
> =A0 In latest RHEL6, the mail format sometimes becomes "...Mail
> =A0 Delivery System..." instead of "...Mail Delivery Subsys...".
> =A0 This patch fixes this problem. Plus, corrected misspelling.
>
> =A0 Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/m=
ail/mail_tests.sh
> index 53a5d90..2aaf764 100755
> --- a/testcases/commands/mail/mail_tests.sh
> +++ b/testcases/commands/mail/mail_tests.sh
> @@ -160,7 +160,7 @@ if [ $? -ne 0 ]; then
> =A0 =A0 =A0 =A0 =A0 =A0"Test #2: mail command failed. Reason:"
> =A0 =A0 =A0 =A0: $(( TFAILCNT +=3D 1 ))
> =A0else
> - =A0 =A0 =A0 # check if Mailer-Deamon reported any delivery failure.
> + =A0 =A0 =A0 # check if Mailer-Daemon reported any delivery failure.
> =A0 =A0 =A0 =A0# but wait for the mail to arrive first, sleep 5.
> =A0 =A0 =A0 =A0sleep 5
> =A0 =A0 =A0 =A0echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
> @@ -169,7 +169,7 @@ else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print =
match($3, "Mailer-Daemon")}' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$LTPTMP/tst_mail.res)
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print m=
atch($3 $4 $5, "MailDeliverySubsys")}' \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print m=
atch($3 $4 $5, "MailDelivery(Subsys|System)")}' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$LTPTMP/tst_mail.res)
> =A0 =A0 =A0 =A0fi
>
> @@ -208,10 +208,10 @@ else
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 =
-ne 0 -a $RC3 -ne 0 ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: M=
ailer-Deamon reported delivery failure"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: M=
ailer-Daemon reported delivery failure"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_=
mail.res \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: Mailer-Deamon fai=
led to report delivery failure. Reason:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: Mailer-Daemon fai=
led to report delivery failure. Reason:"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: $(( TFAILCNT +=3D 1 ))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
>
> @@ -222,7 +222,7 @@ fi
>
> =A0# Test #3
> =A0# Test that mail non_existent_user@localhost will result in delivery f=
ailure.
> -# Mailer-Deamon will report this failure.
> +# Mailer-Daemon will report this failure.
>
> =A0export TCID=3Dmail_tests::mail03
> =A0export TST_COUNT=3D3
> @@ -241,7 +241,7 @@ if [ $? -ne 0 ]; then
> =A0 =A0 =A0 =A0 =A0 =A0"Test #3: mail command failed. Reason: "
> =A0 =A0 =A0 =A0: $(( TFAILCNT +=3D 1 ))
> =A0else
> - =A0 =A0 =A0 # check if Mailer-Deamon reported any delivery failure.
> + =A0 =A0 =A0 # check if Mailer-Daemon reported any delivery failure.
> =A0 =A0 =A0 =A0# but wait for the mail to arrive first, sleep 5.
> =A0 =A0 =A0 =A0sleep 5
> =A0 =A0 =A0 =A0echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
> @@ -250,7 +250,7 @@ else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print =
match($3, "Mailer-Daemon")}' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$LTPTMP/tst_mail.res)
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print m=
atch($3 $4 $5, "MailDeliverySubsys")}' \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print m=
atch($3 $4 $5, "MailDelivery(Subsys|System)")}' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$LTPTMP/tst_mail.res)
> =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0##########################################################=
########

How about MailDeliverySub? It's a simpler version of the same string,
so it's more resilient to change. Besides, the point isn't to check
for the name being that, it's to verify that the the delivery failed
:)..

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
