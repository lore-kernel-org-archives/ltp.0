Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7GHJ-0008HO-GI
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:49 +0000
Received: from mail-iw0-f196.google.com ([209.85.223.196])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7GHI-0007iE-Pj
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:49 +0000
Received: by iwn34 with SMTP id 34so11414028iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Apr 2010 16:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100428210947.GB20642@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
	<20100428210947.GB20642@us.ibm.com>
Date: Wed, 28 Apr 2010 16:02:43 -0700
Message-ID: <x2u364299f41004281602u398e8300y82caeb4b083d5b50@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] mqns2: fix some error checking and reporting
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
> =A0testcases/kernel/containers/mqns/mqns_02.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kerne=
l/containers/mqns/mqns_02.c
> index 8f783ba..07ab042 100644
> --- a/testcases/kernel/containers/mqns/mqns_02.c
> +++ b/testcases/kernel/containers/mqns/mqns_02.c
> @@ -76,7 +76,7 @@ int check_mqueue(void *vtest)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read(p1=
[0], buf, 5))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read(p1=
[0], buf, 5) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0tst_resm(TBROK | TERRNO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0"read(p1[0], ..) failed");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> @@ -142,7 +142,7 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (read(p2[0], buf, 7) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "read(p1[0], ..) failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "read(p2[0], ..) failed");
> =A0 =A0 =A0 =A0} else if (!strcmp(buf, "mqfail")) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "child process could not c=
reate mqueue\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0umount(DEV_MQUEUE);
> @@ -160,8 +160,8 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "Parent pr=
ocess found mqueue\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_close(mqd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write(p1[1], "cont", 5)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "read(p1[0]=
, ..) failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write(p1[1], "cont", 5) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "write(p1[1=
], ..) failed");

Acked-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
