Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSOJF-0001WZ-GG
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:47:37 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSOJ8-0002L2-8r
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:47:37 +0000
Received: by pzk8 with SMTP id 8so1339689pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 21:47:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A5E7649.9040705@cn.fujitsu.com>
References: <4A5E7649.9040705@cn.fujitsu.com>
Date: Sat, 18 Jul 2009 21:47:29 -0700
Message-ID: <364299f40907182147l4239c229m25eb180ea7c8ebf9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix the system call number of exit_group01
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 15, 2009 at 5:37 PM, Wei Yongjun<yjwei@cn.fujitsu.com> wrote:
> The system call number is depend on the system architecture, not always 2=
52. This patch fixed the problem.
>
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
>
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c =A0 =A0 =A0 200=
9-05-22 02:14:40.000000000 +0800
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c =A0 =A0 =A0 200=
9-07-15 09:26:23.000000000 +0800
> @@ -136,7 +136,7 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (TEST_RETURN =3D=3D =
0){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
INFO, "In the child process");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep(5);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscal=
l(252,4));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscal=
l(__NR_exit_group,4));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
INFO,"in the parent process");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(w =3D=
 wait(&status));

Hi Wei,
    The best way to do this (IMHO) may be to add the relevant syscall
number to the architecture specific .in file in
testcases/kernel/include. Do you have the syscall number for your
architecture?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
