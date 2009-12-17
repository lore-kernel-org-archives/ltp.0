Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLBXX-0000Dx-4J
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 08:16:51 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLBXQ-000781-34
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 08:16:50 +0000
Received: by pwj11 with SMTP id 11so1275626pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Dec 2009 00:16:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B28C695.5040705@cn.fujitsu.com>
References: <4B28C695.5040705@cn.fujitsu.com>
Date: Thu, 17 Dec 2009 00:16:38 -0800
Message-ID: <364299f40912170016g363cfffct225311cd352bb380@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/3] ade: fix the bug of ld/ldd/nm
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 16, 2009 at 3:37 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
> According to case ld, ldd and nm's Makefile,
> s/*.o/*.obj/
>
> This patch fixed these
>
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>
> ---
> =A0testcases/commands/ade/ld/ld01 =A0 | =A0 62 +++++++++++++++++++-------=
------------
> =A0testcases/commands/ade/ldd/ldd01 | =A0 24 +++++++-------
> =A0testcases/commands/ade/nm/nm01 =A0 | =A0 =A07 ++--
> =A03 files changed, 47 insertions(+), 46 deletions(-)
>
> diff --git a/testcases/commands/ade/ld/ld01 b/testcases/commands/ade/ld/l=
d01
> index 0e6ad36..ef9ca8b 100755
> --- a/testcases/commands/ade/ld/ld01
> +++ b/testcases/commands/ade/ld/ld01
> @@ -49,13 +49,13 @@ mkdir $TCtmp
> =A0#
> =A0#CODE
> =A0 =A0 =A0 =A0echo "Assertion 1 .................."
> - =A0 =A0 =A0 /usr/bin/ld x.o y.o 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 /usr/bin/ld x.obj y.obj 2> $TCtmp/errmsg.obj
> =A0#cat <<EOF > $TCtmp/errmsg.exp
> -#/usr/bin/ld: cannot open x.o: No such file or directory
> +#/usr/bin/ld: cannot open x.obj: No such file or directory
> =A0#EOF
>
> -#diff -iw =A0$TCtmp/errmsg.out $TCtmp/errmsg.exp
> -cat $TCtmp/errmsg.out |grep "/usr/bin/ld:" | grep [xy].o | grep -q "No s=
uch file or directory"
> +#diff -iw =A0$TCtmp/errmsg.obj $TCtmp/errmsg.exp
> +cat $TCtmp/errmsg.obj |grep "/usr/bin/ld:" | grep [xy].obj | grep -q "No=
 such file or directory"
> =A0if [ $? -eq 0 ]
> =A0then
> =A0 =A0 =A0 =A0echo =A0"-)"
> @@ -72,14 +72,14 @@ fi
> =A0#
> =A0#CODE
> =A0 =A0 =A0 =A0echo "Assertion 2 .................."
> - =A0 =A0 =A0 /usr/bin/cc x.o =A0y.o 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 /usr/bin/cc x.obj =A0y.obj 2> $TCtmp/errmsg.obj
> =A0cat <<EOF > $TCtmp/errmsg.exp
> -cc: x.o: No such file or directory
> -cc: y.o: No such file or directory
> +cc: x.obj: No such file or directory
> +cc: y.obj: No such file or directory
> =A0cc: No input files
> =A0EOF
>
> -diff -iw =A0$TCtmp/errmsg.out $TCtmp/errmsg.exp
> +diff -iw =A0$TCtmp/errmsg.obj $TCtmp/errmsg.exp
> =A0if [ $? -eq 0 ]
> =A0then
> =A0 =A0 =A0 =A0echo =A0"-)"
> @@ -96,13 +96,13 @@ fi
> =A0#
> =A0#CODE
> =A0 =A0 =A0 =A0echo "Assertion 3 .................."
> - =A0 =A0 =A0 /usr/bin/ld bad/x.o 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 /usr/bin/ld bad/x.obj 2> $TCtmp/errmsg.obj
> =A0#cat <<EOF > $TCtmp/errmsg.exp
> -#/usr/bin/ld: cannot open bad/x.o: No such file or directory
> +#/usr/bin/ld: cannot open bad/x.obj: No such file or directory
> =A0#EOF
> -cat $TCtmp/errmsg.out | grep "/usr/bin/ld:" | grep "bad/[xy].o:" | grep =
-q "No such file or directory"
> +cat $TCtmp/errmsg.obj | grep "/usr/bin/ld:" | grep "bad/[xy].obj:" | gre=
p -q "No such file or directory"
>
> -#diff -iw =A0$TCtmp/errmsg.out $TCtmp/errmsg.exp
> +#diff -iw =A0$TCtmp/errmsg.obj $TCtmp/errmsg.exp
> =A0if [ $? -eq 0 ]
> =A0then
> =A0 =A0 =A0 =A0echo =A0"-)"
> @@ -119,13 +119,13 @@ fi
> =A0#
> =A0#CODE
> =A0 =A0 =A0 =A0echo "Assertion 4 .................."
> - =A0 =A0 =A0 /usr/bin/cc bad/x.o 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 /usr/bin/cc bad/x.obj 2> $TCtmp/errmsg.obj
> =A0cat <<EOF > $TCtmp/errmsg.exp
> -cc: bad/x.o: No such file or directory
> +cc: bad/x.obj: No such file or directory
> =A0cc: No input files
> =A0EOF
>
> -diff -iw =A0$TCtmp/errmsg.out $TCtmp/errmsg.exp
> +diff -iw =A0$TCtmp/errmsg.obj $TCtmp/errmsg.exp
> =A0if [ $? -eq 0 ]
> =A0then
> =A0 =A0 =A0 =A0echo =A0"-)"
> @@ -140,11 +140,11 @@ fi
> =A0##
> =A0echo "Assertion 5 .................."
> =A0# Check for ppc64 architecture
> - file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
> + file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
> =A0if [ $? -eq 0 ]; then
> - =A0 =A0 =A0 ld -m elf64ppc -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/te=
st.lib
> + =A0 =A0 =A0 ld -m elf64ppc -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtm=
p/test.lib
> =A0else
> - =A0 =A0 =A0 ld -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/test.lib
> + =A0 =A0 =A0 ld -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/test.lib
> =A0fi
> =A0file $TCtmp/test.lib | grep -q shared
> =A0if [ $? -eq 0 ]
> @@ -164,21 +164,21 @@ fi
> =A0echo "Assertion 6 .................."
>
> =A0# Check for ppc64 architecture
> - file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
> + file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
> =A0if [ $? -eq 0 ]; then
> - =A0 =A0 =A0 ld -m elf64ppc -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o=
 $TCtmp/lola 2>$TCtmp/errmsg.out
> - =A0 =A0 =A0 ld -m elf64ppc -Bstatic =A0-L. $TCdat/ldmain.o $TCdat/rd1.o=
 $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 ld -m elf64ppc -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.ob=
j -o $TCtmp/lola 2>$TCtmp/errmsg.obj
> + =A0 =A0 =A0 ld -m elf64ppc -Bstatic =A0-L. $TCdat/ldmain.obj $TCdat/rd1=
.obj $TCtmp/lola -o $TCtmp/a.obj 2> $TCtmp/errmsg.obj
> =A0else
> - =A0 =A0 =A0 ld -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola=
 2>$TCtmp/errmsg.out
> - =A0 =A0 =A0 ld -Bstatic =A0-L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola=
 -o $TCtmp/a.out 2> $TCtmp/errmsg.out
> + =A0 =A0 =A0 ld -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/=
lola 2>$TCtmp/errmsg.obj
> + =A0 =A0 =A0 ld -Bstatic =A0-L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/=
lola -o $TCtmp/a.obj 2> $TCtmp/errmsg.obj
> =A0fi
> -#nm $TCtmp/a.out | grep -q DYNAMIC
> +#nm $TCtmp/a.obj | grep -q DYNAMIC
> =A0rc_code=3D$?
>
> - =A0 =A0 =A0 version_num=3D`ld --version | grep version | \
> + =A0 =A0 =A0 version_num=3D`ld --version | grep version | grep ld |\
> =A0 =A0 =A0 =A0 awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
> -
> - =A0 =A0 =A0 version_num_level2=3D`ld --version | grep version |\
> +
> + =A0 =A0 =A0 version_num_level2=3D`ld --version | grep version | grep ld=
 |\
> =A0 =A0 =A0 =A0 awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
>
> =A0if [ "$version_num" -le "2" =A0-a "$version_num_level2" -le "15" ]; th=
en
> @@ -214,15 +214,15 @@ if [ "$version_num" -le "2" =A0-a "$version_num_lev=
el2" -le "15" ]; then
>
>
> =A0echo "Assertion 7 .................."
> -ld -Bdynamic -shared $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o -o $TCtmp/=
lola -L/usr/lib/
> -ld -Bstatic -r =A0$TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o $TCtmp/lola -=
L/usr/lib/ 2> $TCtmp/errmsg.out
> +ld -Bdynamic -shared $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj -o $=
TCtmp/lola -L/usr/lib/
> +ld -Bstatic -r =A0$TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj $TCtmp/=
lola -L/usr/lib/ 2> $TCtmp/errmsg.obj
> =A0cat <<EOF > $TCtmp/errmsg.exp
> =A0$TCtmp/lola: could not read symbols: Invalid operation
> =A0EOF
>
> -grep -q =A0"could not read symbols: Invalid operation" $TCtmp/errmsg.out
> +grep -q =A0"could not read symbols: Invalid operation" $TCtmp/errmsg.obj
> =A0rc_grep=3D$?
> -grep -q "ld: attempted static link of dynamic object" $TCtmp/errmsg.out
> +grep -q "ld: attempted static link of dynamic object" $TCtmp/errmsg.obj
> =A0if [ $rc_grep -eq 0 =A0-o $? -eq 0 ]; then
> =A0 =A0 =A0 =A0echo "-)"
> =A0else
> diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ld=
d/ldd01
> index ba7dc41..cdce0a0 100755
> --- a/testcases/commands/ade/ldd/ldd01
> +++ b/testcases/commands/ade/ldd/ldd01
> @@ -47,19 +47,19 @@ mkdir $TCtmp
> =A0# Check for ppc64 architecture
> =A0file lddfile1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
> =A0if [ $? -eq 0 ]; then
> - =A0cc -m64 -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.o
> - =A0cc -m64 -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.o
> - =A0cc -m64 -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.o
> - =A0cc -m64 -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.o
> - =A0cc -m64 -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.o
> - =A0cc -m64 -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.o
> + =A0cc -m64 -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.obj
> + =A0cc -m64 -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.obj
> + =A0cc -m64 -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.obj
> + =A0cc -m64 -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.obj
> + =A0cc -m64 -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.obj
> + =A0cc -m64 -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.obj
> =A0else
> - =A0cc -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.o
> - =A0cc -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.o
> - =A0cc -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.o
> - =A0cc -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.o
> - =A0cc -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.o
> - =A0cc -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.o
> + =A0cc -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.obj
> + =A0cc -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.obj
> + =A0cc -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.obj
> + =A0cc -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.obj
> + =A0cc -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.obj
> + =A0cc -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.obj
> =A0fi
> =A0}
>
> diff --git a/testcases/commands/ade/nm/nm01 b/testcases/commands/ade/nm/n=
m01
> index dccc922..1ba3b35 100755
> --- a/testcases/commands/ade/nm/nm01
> +++ b/testcases/commands/ade/nm/nm01
> @@ -58,7 +58,8 @@ while [ $LOOP -gt 0 ]
> =A0do
> =A0echo "-------System test for nm command------"
> =A0cd $TCdat
> -ar -cr $TCtmp/lib.a nmfile1.o nmfile1.o nmfile2.o nmfile3.o
> +#ar -cr $TCtmp/lib.a nmfile1.o nmfile1.o nmfile2.o nmfile3.o
> +ar -cr $TCtmp/lib.a nmfile1.obj nmfile1.obj nmfile2.obj nmfile3.obj
>
> =A0# -A =A0Displays either the full path name or library name of an object
> =A0# on each line.
> @@ -69,10 +70,10 @@ RC2=3D0
>
> =A0mkdir -p $TCtmp/a/b/c/d
>
> -nm -f posix -A $TCtmp/lib.a | grep "$TCtmp/lib.a\[nmfile2.o\]\:" 2>&1 1>=
/dev/null
> +nm -f posix -A $TCtmp/lib.a | grep "$TCtmp/lib.a\[nmfile2.obj\]\:" 2>&1 =
1>/dev/null
> =A0RC1=3D$?
> =A0cp $TCtmp/lib.a $TCtmp/a/b/c/d/
> -nm -f posix -A $TCtmp/a/b/c/d/lib.a | grep "$TCtmp/a/b/c/d/lib.a\[nmfile=
2.o\]\:" =A02>&1 1>/dev/null
> +nm -f posix -A $TCtmp/a/b/c/d/lib.a | grep "$TCtmp/a/b/c/d/lib.a\[nmfile=
2.obj\]\:" =A02>&1 1>/dev/null
> =A0RC2=3D$?

    Fixed, and also enabled parameterization for CC, LD, LDD, and NM.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
