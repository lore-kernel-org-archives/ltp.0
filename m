Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1RFg3R-0004Ui-DD
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 05:48:05 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RFg3Q-0000Y5-BI
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 05:48:05 +0000
Received: by bkat8 with SMTP id t8so7066130bka.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 16 Oct 2011 22:47:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH67wT0uyaiV9uitsNkUKS+bdhSpHkR4BCrDcakAno8KieHcw@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CAGH67wTJVjjYHOqdcXqV8motaWeXWbin0RVDoB3iOSMh0ehyBA@mail.gmail.com>
	<CADfK0X6Rjn_+NPdO5XcZz7Ovk70RaLV4uHJ3abBTcKyRmfo9KA@mail.gmail.com>
	<CAGH67wQnRcOzEDya5VOKYC2faenALHh8ZqOQDUvyK4ZOYY2uNg@mail.gmail.com>
	<CAGH67wT0uyaiV9uitsNkUKS+bdhSpHkR4BCrDcakAno8KieHcw@mail.gmail.com>
Date: Mon, 17 Oct 2011 11:17:57 +0530
Message-ID: <CADfK0X5FnVK=qYKnUB3NznJSgu4HQyQqpkHnP_47qKzh+c3YHQ@mail.gmail.com>
From: "Josh!" <joshiplns@gmail.com>
Subject: Re: [LTP] ltp-pan: cannot execute binary file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8745384037023161869=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============8745384037023161869==
Content-Type: multipart/alternative; boundary=0015175cab4627cd7504af782618

--0015175cab4627cd7504af782618
Content-Type: text/plain; charset=ISO-8859-1

Thank you Garrett for inputs.

* Now I am able to Cross_Compile properly for arm architecture. i Did the
following steps.
____________________________________________
- Export the PATH
export PATH=/usr/local/arm-sony-linux-gnueabi/devel/bin/:$PATH
export CROSS_COMPILER=arm-linux-gnueabi-dev-

- Configured LTP
sudo ./configure --host=arm
prefix=/tftpboot/arm/beagleboard/ltp-full-20110915 CC=${CROSS_COMPILER}gcc

- After this Make and Make install
_________________________________________________



* Meanwhile I 'm Getting following error because of strip binary file.
________________________________
make[4]: Entering directory
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'

arm-linux-gnueabi-armv7a-dev-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
-Wall -g  -I../../../../include -I../../../../include  -c -o test_arch.o
test_arch.c

arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o
test_arch_debug

arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o
test_arch_stripped

strip test_arch_stripped

/usr/bin/strip: /usr/bin/strip: cannot execute binary file

make[4]: *** [test_arch_stripped] Error 126

make[4]: Leaving directory
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'

make[3]: *** [all] Error 2

make[3]: Leaving directory
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade'

make[2]: *** [all] Error 2

make[2]: Leaving directory
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands'

make[1]: *** [all] Error 2

make[1]: Leaving directory
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases'

make: *** [testcases-all] Error 2
________________________________

after this I replaced 'strip' binary file from host to cross_compiler
architecture 'strip' binary file. But still LTP is failing to compile .


Please give me hint to resolve this !


Joshi


On Thu, Oct 13, 2011 at 9:41 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Thu, Oct 13, 2011 at 9:07 AM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > On Thu, Oct 13, 2011 at 4:46 AM, Josh! <joshiplns@gmail.com> wrote:
> >> Hi..
> >>
> >> Yes i need modify Make-file to my Cross_Compiler platform.
> >
> >    You're doing it wrong then. Back when I built LTP on a more
> > regular linux with a group that I used to work with, I cross-compiled
>
> s/linux/basis/
>
> > for i386, mips, powerpc, and x86_64 on an x86_64 box.
> >    Please share how you're building instead of spinning in the thread
> > claiming that stuff is broken.
>
>     Please note that it's been several years since I've cross-compiled
> things (I've been working primarily with FreeBSD for the last year and
> a half) -- which doesn't mean that a bug or two hasn't snuck into
> LTP.. but I was pretty good at quashing issues like this at review
> time when I was more active in the project.
> -Garrett
>

--0015175cab4627cd7504af782618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif">Thank you Garrett for inputs.<br><br>* Now I am able =
to Cross_Compile properly for arm architecture. i Did the following steps. =
<br>____________________________________________<br>
- Export the PATH<br>export PATH=3D/usr/local/arm-sony-linux-gnueabi/devel/=
bin/:$PATH<br>export CROSS_COMPILER=3Darm-linux-gnueabi-dev-<br><br>- Confi=
gured LTP<br>sudo ./configure --host=3Darm prefix=3D/tftpboot/arm/beagleboa=
rd/ltp-full-20110915 CC=3D${CROSS_COMPILER}gcc<br>
<br>- After this Make and Make install<br>_________________________________=
________________<br><br><br><br>* Meanwhile I &#39;m Getting following erro=
r because of strip binary file.<br>________________________________<br>
make[4]: Entering directory `/tftpboot/arm/beagleboard/ltp-full-20110915/te=
stcases/commands/ade/objdump&#39;<br><br>arm-linux-gnueabi-armv7a-dev-gcc -=
g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -g=A0 -I../../../../include -=
I../../../../include=A0 -c -o test_arch.o test_arch.c<br>
<br>arm-linux-gnueabi-armv7a-dev-gcc=A0=A0 -L../../../../lib=A0 test_arch.o=
=A0=A0 -o test_arch_debug<br><br>arm-linux-gnueabi-armv7a-dev-gcc=A0=A0 -L.=
./../../../lib=A0 test_arch.o=A0=A0 -o test_arch_stripped<br><br>strip test=
_arch_stripped<br>
<br>/usr/bin/strip: /usr/bin/strip: cannot execute binary file<br><br>make[=
4]: *** [test_arch_stripped] Error 126<br><br>make[4]: Leaving directory `/=
tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump&#=
39;<br>
<br>make[3]: *** [all] Error 2<br><br>make[3]: Leaving directory `/tftpboot=
/arm/beagleboard/ltp-full-20110915/testcases/commands/ade&#39;<br><br>make[=
2]: *** [all] Error 2<br><br>make[2]: Leaving directory `/tftpboot/arm/beag=
leboard/ltp-full-20110915/testcases/commands&#39;<br>
<br>make[1]: *** [all] Error 2<br><br>make[1]: Leaving directory `/tftpboot=
/arm/beagleboard/ltp-full-20110915/testcases&#39;<br><br>make: *** [testcas=
es-all] Error 2<br>________________________________<br><br>after this I rep=
laced &#39;strip&#39; binary file from host to cross_compiler architecture =
&#39;strip&#39; binary file. But still LTP is failing to compile .<br>
<br><br>Please give me hint to resolve this !<br><br><br>Joshi</font></font=
></font><span></span><br><font color=3D"#333399"><font size=3D"4"><font fac=
e=3D"trebuchet ms,sans-serif"><br></font></font></font><br><div class=3D"gm=
ail_quote">
On Thu, Oct 13, 2011 at 9:41 PM, Garrett Cooper <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Thu, Oct 13, 2011 at 9:07 AM, Garrett Cooper &lt;<a hr=
ef=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt; wrote:<br>
&gt; On Thu, Oct 13, 2011 at 4:46 AM, Josh! &lt;<a href=3D"mailto:joshiplns=
@gmail.com">joshiplns@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hi..<br>
&gt;&gt;<br>
&gt;&gt; Yes i need modify Make-file to my Cross_Compiler platform.<br>
&gt;<br>
&gt; =A0 =A0You&#39;re doing it wrong then. Back when I built LTP on a more=
<br>
&gt; regular linux with a group that I used to work with, I cross-compiled<=
br>
<br>
</div>s/linux/basis/<br>
<div class=3D"im"><br>
&gt; for i386, mips, powerpc, and x86_64 on an x86_64 box.<br>
&gt; =A0 =A0Please share how you&#39;re building instead of spinning in the=
 thread<br>
&gt; claiming that stuff is broken.<br>
<br>
</div> =A0 =A0Please note that it&#39;s been several years since I&#39;ve c=
ross-compiled<br>
things (I&#39;ve been working primarily with FreeBSD for the last year and<=
br>
a half) -- which doesn&#39;t mean that a bug or two hasn&#39;t snuck into<b=
r>
LTP.. but I was pretty good at quashing issues like this at review<br>
time when I was more active in the project.<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br><br clear=3D"all"><br><span style=3D"color: r=
gb(51, 51, 153);"></span><span style=3D"color: rgb(51, 51, 153);"></span><b=
r>
</div>

--0015175cab4627cd7504af782618--


--===============8745384037023161869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
--===============8745384037023161869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8745384037023161869==--

