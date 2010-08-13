Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OjnWk-0000Px-2J
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:14:02 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjnWi-0002sl-FQ
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:14:02 +0000
Received: by mail-fx0-f47.google.com with SMTP id 6so1727353fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Aug 2010 23:14:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C63ADC4.3030100@windriver.com>
References: <4C63ADC4.3030100@windriver.com>
Date: Thu, 12 Aug 2010 23:13:59 -0700
Message-ID: <AANLkTiku9JvJ9YkmEz7NVp_FaL2at=_AcCCOzv4UAOE2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch]rt_sigprocmask01 issue
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
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Aug 12, 2010 at 1:16 AM, lina.zhao <lina.zhao@windriver.com> wrote:
> Hi,
>
> In rt_sigprocmask01.c:
>
> TEST(syscall(__NR_rt_sigpending, &oset,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIGSETSIZE));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TFAIL|TTERRNO, cleanup,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rt_sigpending call failed");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sigismember(&oset, TEST_SIG));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TFAIL|TTERRNO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"sigismember call failed");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0/* call rt_sigprocmask() to unblock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 * signal#TEST_SIG */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sigprocmask,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIG_UNBLOCK, &set, &oset, 8));
>
> on most of the arch,the SIGSETSIZE is 8, but it is 16 for mips, so in
> sigprocmask,
> the last parameter should be SIGSETSIZE too, not 8.

Committed. Please provide a signed-off-by line next time.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
