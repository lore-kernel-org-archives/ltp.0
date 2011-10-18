Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1RG6rS-000743-Qt
	for ltp-list@lists.sourceforge.net; Tue, 18 Oct 2011 10:25:30 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RG6rO-000745-IX
	for ltp-list@lists.sourceforge.net; Tue, 18 Oct 2011 10:25:30 +0000
Received: by bkat8 with SMTP id t8so817052bka.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Oct 2011 03:25:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <EBB832BF-763E-4623-ACCB-35B30EEC16EB@gmail.com>
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
	<CADfK0X5FnVK=qYKnUB3NznJSgu4HQyQqpkHnP_47qKzh+c3YHQ@mail.gmail.com>
	<EBB832BF-763E-4623-ACCB-35B30EEC16EB@gmail.com>
Date: Tue, 18 Oct 2011 15:55:19 +0530
Message-ID: <CADfK0X6icG=eLpE=8vRtobwYydjoNvd3Cxs76U+2doGRWGqVrQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7682798986955249828=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============7682798986955249828==
Content-Type: multipart/alternative; boundary=00151747c152f3248a04af902309

--00151747c152f3248a04af902309
Content-Type: text/plain; charset=ISO-8859-1

Hi Garrett ..,
Thank you for inputs,
I removed strip under /usr/bin/ and created symbolic link to the
cross_compiler strip command and exported the PATH.
-------
[Joshi@myserver ltp-full-20110915]$ ls -l /usr/bin/strip

lrwxrwxrwx 1 root root 82 Oct 18 14:34 /usr/bin/strip ->
/usr/local/arm-linux-gnueabi/cross/devel/bin/arm-linux-gnueabi-dev-strip
-------

Thanks to 'all' for your Kind support. Now I 'm able to build and execute
latest vesion ltp-full-20110915

Joshi


On Mon, Oct 17, 2011 at 11:44 AM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Oct 16, 2011, at 10:47 PM, Josh! wrote:
>
> Thank you Garrett for inputs.
>
> * Now I am able to Cross_Compile properly for arm architecture. i Did the
> following steps.
> ____________________________________________
> - Export the PATH
> export PATH=/usr/local/arm-sony-linux-gnueabi/devel/bin/:$PATH
> export CROSS_COMPILER=arm-linux-gnueabi-dev-
>
> - Configured LTP
> sudo ./configure --host=arm
> prefix=/tftpboot/arm/beagleboard/ltp-full-20110915 CC=${CROSS_COMPILER}gcc
>
> - After this Make and Make install
> _________________________________________________
>
>
>
> * Meanwhile I 'm Getting following error because of strip binary file.
> ________________________________
> make[4]: Entering directory
> `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'
>
> arm-linux-gnueabi-armv7a-dev-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
> -Wall -g  -I../../../../include -I../../../../include  -c -o test_arch.o
> test_arch.c
>
> arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o
> test_arch_debug
>
> arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o
> test_arch_stripped
>
> strip test_arch_stripped
>
> /usr/bin/strip: /usr/bin/strip: cannot execute binary file
>
> make[4]: *** [test_arch_stripped] Error 126
>
> make[4]: Leaving directory
> `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'
>
> make[3]: *** [all] Error 2
>
> make[3]: Leaving directory
> `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade'
>
> make[2]: *** [all] Error 2
>
> make[2]: Leaving directory
> `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands'
>
> make[1]: *** [all] Error 2
>
> make[1]: Leaving directory
> `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases'
>
> make: *** [testcases-all] Error 2
> ________________________________
>
> after this I replaced 'strip' binary file from host to cross_compiler
> architecture 'strip' binary file. But still LTP is failing to compile .
>
>
> See all variables from "Application specifying variables... " to "XXX: I'm
> lazy..." in include/mk/config.mk ... You may or may not have to define
> these when calling configure and cross-compiling LTP; FWIW the same
> guidelines should be used in any properly designed autotools enabled project
> (I know at least a handful that don't follow a sane variable convention like
> I tried to create because of the cross-compilation environment I used to
> work with).
> Cheers,
> -Garrett
>



--

--00151747c152f3248a04af902309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif">Hi Garrett ..,<br>Thank you for inputs,<br>I removed =
strip under /usr/bin/ and created symbolic link to the cross_compiler strip=
 command and exported the PATH.<br>
-------<br>[Joshi@myserver ltp-full-20110915]$ ls -l /usr/bin/strip<br><br>=
lrwxrwxrwx 1 root root 82 Oct 18 14:34 /usr/bin/strip -&gt; /usr/local/arm-=
linux-gnueabi/cross/devel/bin/arm-linux-gnueabi-dev-strip<br>-------<br>
<br>Thanks to &#39;all&#39; for your Kind support. Now I &#39;m able to bui=
ld and execute latest vesion ltp-full-20110915<br><br>Joshi<br>=A0<br></fon=
t></font></font><br><div class=3D"gmail_quote">On Mon, Oct 17, 2011 at 11:4=
4 AM, Garrett Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail=
.com">yanegomi@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div style=3D"wor=
d-wrap: break-word;"><div><div></div><div class=3D"h5"><div><div>On Oct 16,=
 2011, at 10:47 PM, Josh! wrote:</div>
<br><blockquote type=3D"cite"><div dir=3D"ltr"><font color=3D"#333399"><fon=
t size=3D"4"><font face=3D"trebuchet ms,sans-serif">Thank you Garrett for i=
nputs.<br><br>* Now I am able to Cross_Compile properly for arm architectur=
e. i Did the following steps. <br>
____________________________________________<br>
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
</font></font></font></div></blockquote><br></div></div></div><div><span st=
yle=3D"white-space: pre-wrap;">	</span>See all variables from &quot;Applica=
tion specifying variables... &quot; to &quot;XXX: I&#39;m lazy...&quot; in=
=A0include/mk/<a href=3D"http://config.mk" target=3D"_blank">config.mk</a> =
... You may or may not have to define these when calling configure and cros=
s-compiling LTP; FWIW the same guidelines should be used in any properly de=
signed autotools enabled project (I know at least a handful that don&#39;t =
follow a sane variable convention like I tried to create because of the cro=
ss-compilation environment I used to work with).</div>
<div>Cheers,</div><div>-Garrett</div></div></blockquote></div><br><br clear=
=3D"all"><br>-- <span style=3D"color: rgb(51, 51, 153);"></span><span style=
=3D"color: rgb(51, 51, 153);"></span><br>
</div>

--00151747c152f3248a04af902309--


--===============7682798986955249828==
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
--===============7682798986955249828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7682798986955249828==--

