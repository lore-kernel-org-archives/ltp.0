Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZHrSU-0007uo-Cd
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 10:41:06 +0000
Received: from mail-qg0-f52.google.com ([209.85.192.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZHrSS-0003RW-H6
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 10:41:06 +0000
Received: by qgy5 with SMTP id 5so100383670qgy.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Jul 2015 03:40:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANKSX+HdUHTsLS2ON7ijqAoMnOvn1zmtFbVfemrVkfqGn-G1=Q@mail.gmail.com>
References: <CANKSX+HdUHTsLS2ON7ijqAoMnOvn1zmtFbVfemrVkfqGn-G1=Q@mail.gmail.com>
Date: Wed, 22 Jul 2015 16:10:56 +0530
Message-ID: <CANKSX+E7teM+x_D7VZ4u-pAuxqjR2wjRzSAKUueJQSAUXoHF7Q@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: [LTP] Cross-compiling issues
Reply-To: srikanth007m@gmail.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9137344155222266316=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============9137344155222266316==
Content-Type: multipart/alternative; boundary=001a11c13ccedffe08051b74670e

--001a11c13ccedffe08051b74670e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Able to figure out the issues with cross compiling for arm and now i am
successfully cross compiled  LTP. But few specific packages only which are
needed for me.

On Mon, Jul 20, 2015 at 7:06 PM, $rik@nth <srikanth007m@gmail.com> wrote:

> Hi,
>
> Though i am not expert in compiling LTP, but i am trying to cross compile
> current LTP for arm. Here is how i am configuring
>
> Go to root folder of ltp and execute
> ./configure AR=3Darm-linux-gnueabi-ar CC=3Darm-linux-gnueabi-gcc
> RANLIB=3Darm-linux-gnueabi-gcc-ranlib-4.7 STRIP=3Darm-linux-gnueabi-strip
> --host=3Darm-linux --target=3Darm-linux CFLAGS=3D"-static" LDFLAGS=3D"-st=
atic
> -pthread"
>
> Failing at
> configure: error: cannot run /bin/sh ./config.sub
> configure: error: ./configure failed for utils/ffsb-6.0-rc2
>
> But still i ignored these messages and tried building some specific tests=
.
> Ex: realtime tests
> Go to testcases/realtime/func/sched_football and run make. Here make
> failed due to `ld: cannot find -lrealtime`
>
> arm-linux-gnueabi-gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
> -static -Wold-style-definition -D_GNU_SOURCE
>  -I/local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/inc=
lude
> -I/local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/incl=
ude
> -I../../../../include -I../../../../include -static -pthread
>  -L/local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/lib
> -L../../../../lib  sched_football.c   -lrealtime -lpthread -lrt -lm -o
> sched_football
> In file included from sched_football.c:69:0:
> /local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/includ=
e/librttest.h:
> In function =C3=A2atomic_add=C3=A2:
> /local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/includ=
e/librttest.h:115:34:
> warning: unused parameter =C3=A2i=C3=A2 [-Wunused-parameter]
> /local/mnt/workspace/Srikanth/ltp-full-20140828/testcases/realtime/includ=
e/librttest.h:115:47:
> warning: unused parameter =C3=A2v=C3=A2 [-Wunused-parameter]
> sched_football.c: In function =C3=A2thread_defense=C3=A2:
> sched_football.c:111:28: warning: unused parameter =C3=A2arg=C3=A2
> [-Wunused-parameter]
> sched_football.c: In function =C3=A2thread_offense=C3=A2:
> sched_football.c:122:28: warning: unused parameter =C3=A2arg=C3=A2
> [-Wunused-parameter]
> /usr/lib/gcc-cross/arm-linux-gnueabi/4.7/../../../../arm-linux-gnueabi/bi=
n/ld:
> cannot find -lrealtime
> collect2: error: ld returned 1 exit status
> make: *** [sched_football] Error 1
>
>
> Pointers from anyone who tried cross compiling ltp for arm would really
> helpful.
>
> TIA.
>
> --
> Thanks & Regards,
> M.Srikanth Kumar.
>



--=20
Thanks & Regards,
M.Srikanth Kumar.

--001a11c13ccedffe08051b74670e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Able to figure out the issues with cross compiling for arm=
 and now i am successfully cross compiled =C2=A0LTP. But few specific packa=
ges only which are needed for me.</div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Mon, Jul 20, 2015 at 7:06 PM, $rik@nth <span dir=
=3D"ltr">&lt;<a href=3D"mailto:srikanth007m@gmail.com" target=3D"_blank">sr=
ikanth007m@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>Though i am not expert in c=
ompiling LTP, but i am trying to cross compile current LTP for arm. Here is=
 how i am configuring=C2=A0</div><div><br></div><div>Go to root folder of l=
tp and execute</div><div>./configure AR=3Darm-linux-gnueabi-ar CC=3Darm-lin=
ux-gnueabi-gcc RANLIB=3Darm-linux-gnueabi-gcc-ranlib-4.7 STRIP=3Darm-linux-=
gnueabi-strip --host=3Darm-linux --target=3Darm-linux CFLAGS=3D&quot;-stati=
c&quot; LDFLAGS=3D&quot;-static -pthread&quot;</div><div><br clear=3D"all">=
<div>Failing at=C2=A0</div><div><div>configure: error: cannot run /bin/sh .=
/config.sub</div><div>configure: error: ./configure failed for utils/ffsb-6=
.0-rc2</div></div><div><br></div><div>But still i ignored these messages an=
d tried building some specific tests. Ex: realtime tests</div><div>Go to=C2=
=A0testcases/realtime/func/sched_football and run make. Here make failed du=
e to `ld: cannot find -lrealtime`</div><div><br></div><div>arm-linux-gnueab=
i-gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W -static -Wold-styl=
e-definition -D_GNU_SOURCE =C2=A0-I/local/mnt/workspace/Srikanth/ltp-full-2=
0140828/testcases/realtime/include -I/local/mnt/workspace/Srikanth/ltp-full=
-20140828/testcases/realtime/include -I../../../../include -I../../../../in=
clude -static -pthread =C2=A0-L/local/mnt/workspace/Srikanth/ltp-full-20140=
828/testcases/realtime/lib -L../../../../lib =C2=A0sched_football.c =C2=A0 =
-lrealtime -lpthread -lrt -lm -o sched_football<br></div><div><div>In file =
included from sched_football.c:69:0:</div><div>/local/mnt/workspace/Srikant=
h/ltp-full-20140828/testcases/realtime/include/librttest.h: In function =C3=
=A2atomic_add=C3=A2:</div><div>/local/mnt/workspace/Srikanth/ltp-full-20140=
828/testcases/realtime/include/librttest.h:115:34: warning: unused paramete=
r =C3=A2i=C3=A2 [-Wunused-parameter]</div><div>/local/mnt/workspace/Srikant=
h/ltp-full-20140828/testcases/realtime/include/librttest.h:115:47: warning:=
 unused parameter =C3=A2v=C3=A2 [-Wunused-parameter]</div><div>sched_footba=
ll.c: In function =C3=A2thread_defense=C3=A2:</div><div>sched_football.c:11=
1:28: warning: unused parameter =C3=A2arg=C3=A2 [-Wunused-parameter]</div><=
div>sched_football.c: In function =C3=A2thread_offense=C3=A2:</div><div>sch=
ed_football.c:122:28: warning: unused parameter =C3=A2arg=C3=A2 [-Wunused-p=
arameter]</div><div>/usr/lib/gcc-cross/arm-linux-gnueabi/4.7/../../../../ar=
m-linux-gnueabi/bin/ld: cannot find -lrealtime</div><div>collect2: error: l=
d returned 1 exit status</div><div>make: *** [sched_football] Error 1</div>=
</div><div><br></div><div><br></div><div>Pointers from anyone who tried cro=
ss compiling ltp for arm would really helpful.=C2=A0</div><div><br></div><d=
iv>TIA.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div>=
-- <br><div>Thanks &amp; Regards,<br>M.Srikanth Kumar.</div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Thanks &amp; Regards,<br>M.Srikanth Kumar.</div>
</div>

--001a11c13ccedffe08051b74670e--


--===============9137344155222266316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
--===============9137344155222266316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9137344155222266316==--

