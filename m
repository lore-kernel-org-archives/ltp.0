Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OwSqw-000407-Cs
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 04:47:14 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwSqv-0007rm-KI
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 04:47:14 +0000
Received: by yxg6 with SMTP id 6so849570yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 21:47:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C92EBBE.8090108@jp.fujitsu.com>
References: <4C92EBBE.8090108@jp.fujitsu.com>
Date: Thu, 16 Sep 2010 21:47:07 -0700
Message-ID: <AANLkTin9tmLMZQyvBh898Z7pYAAn_BzVZEYkGZjCJNv-@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Fix warning at cpuset_syscall_test.c
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
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

2010/9/16 ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>:
> Hi,
>
> I found the following warning at cpuset_syscall_test.c.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> make[5]: Entering directory `/root/ltp/ltp-old/testcases/kernel/controlle=
rs/cpuset/cpuset_syscall_test'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I/root/ltp/ltp-old=
/testcases/kernel/include -I../../../../../include -I../../../../../include
> -L/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_te=
st/../cpuset_lib
> -L/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_te=
st/../../libcontrollers -L../../../../../lib =A0cpuset_syscall_test.c =A0 -=
lltp -lcpu_set
> -lcontrollers -lltp -o cpuset_syscall_test
> cpuset_syscall_test.c: In function 'main':
> cpuset_syscall_test.c:254: warning: control reaches end of non-void funct=
ion
> make[5]: Leaving directory `/root/ltp/ltp-old/testcases/kernel/controller=
s/cpuset/cpuset_syscall_test'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This warning appears because it doesn't have "return <num>" in main().
> The attached patch will fix it.
>
> Signed-off-by: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpus=
et_syscall_test.c
> b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_=
test.c
> index 961d0f9..0d4fe87 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_sysc=
all_test.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_sysc=
all_test.c
> @@ -251,5 +251,6 @@ int main(int argc, char *argv[])
> =A0#else
> =A0int main (void) {
> =A0 =A0 =A0 =A0printf("System doesn't have required mempolicy support\n");
> + =A0 =A0 =A0 return -1;
> =A0}
> =A0#endif

1. Negative return values from main are bad.
2. 0 would be better, otherwise it's going to cause more churn on the
list because people without the support are going to start asking the
question: "why is this testcase failing"?

I'll implement return 0 instead.

Thanks for the heads up!
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
