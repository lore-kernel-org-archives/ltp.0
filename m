Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RFgTZ-00058z-55
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 06:15:05 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RFgTY-0004nA-8r
	for ltp-list@lists.sourceforge.net; Mon, 17 Oct 2011 06:15:05 +0000
Received: by iafi7 with SMTP id i7so7371163iaf.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 16 Oct 2011 23:14:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <CADfK0X5FnVK=qYKnUB3NznJSgu4HQyQqpkHnP_47qKzh+c3YHQ@mail.gmail.com>
Date: Sun, 16 Oct 2011 23:14:55 -0700
Message-Id: <EBB832BF-763E-4623-ACCB-35B30EEC16EB@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1855593367372601761=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Josh! <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--===============1855593367372601761==
Content-Type: multipart/alternative; boundary=Apple-Mail-1--925004040


--Apple-Mail-1--925004040
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 16, 2011, at 10:47 PM, Josh! wrote:

> Thank you Garrett for inputs.
>=20
> * Now I am able to Cross_Compile properly for arm architecture. i Did =
the following steps.=20
> ____________________________________________
> - Export the PATH
> export PATH=3D/usr/local/arm-sony-linux-gnueabi/devel/bin/:$PATH
> export CROSS_COMPILER=3Darm-linux-gnueabi-dev-
>=20
> - Configured LTP
> sudo ./configure --host=3Darm =
prefix=3D/tftpboot/arm/beagleboard/ltp-full-20110915 =
CC=3D${CROSS_COMPILER}gcc
>=20
> - After this Make and Make install
> _________________________________________________
>=20
>=20
>=20
> * Meanwhile I 'm Getting following error because of strip binary file.
> ________________________________
> make[4]: Entering directory =
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdum=
p'
>=20
> arm-linux-gnueabi-armv7a-dev-gcc -g -O2 -g -O2 -fno-strict-aliasing =
-pipe -Wall -g  -I../../../../include -I../../../../include  -c -o =
test_arch.o test_arch.c
>=20
> arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o =
test_arch_debug
>=20
> arm-linux-gnueabi-armv7a-dev-gcc   -L../../../../lib  test_arch.o   -o =
test_arch_stripped
>=20
> strip test_arch_stripped
>=20
> /usr/bin/strip: /usr/bin/strip: cannot execute binary file
>=20
> make[4]: *** [test_arch_stripped] Error 126
>=20
> make[4]: Leaving directory =
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdum=
p'
>=20
> make[3]: *** [all] Error 2
>=20
> make[3]: Leaving directory =
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade'
>=20
> make[2]: *** [all] Error 2
>=20
> make[2]: Leaving directory =
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands'
>=20
> make[1]: *** [all] Error 2
>=20
> make[1]: Leaving directory =
`/tftpboot/arm/beagleboard/ltp-full-20110915/testcases'
>=20
> make: *** [testcases-all] Error 2
> ________________________________
>=20
> after this I replaced 'strip' binary file from host to cross_compiler =
architecture 'strip' binary file. But still LTP is failing to compile .

	See all variables from "Application specifying variables... " to =
"XXX: I'm lazy..." in include/mk/config.mk ... You may or may not have =
to define these when calling configure and cross-compiling LTP; FWIW the =
same guidelines should be used in any properly designed autotools =
enabled project (I know at least a handful that don't follow a sane =
variable convention like I tried to create because of the =
cross-compilation environment I used to work with).
Cheers,
-Garrett=

--Apple-Mail-1--925004040
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div><div>On Oct 16, 2011, at 10:47 PM, Josh! wrote:</div><br class="Apple-interchange-newline"><blockquote type="cite"><div dir="ltr"><font color="#333399"><font size="4"><font face="trebuchet ms,sans-serif">Thank you Garrett for inputs.<br><br>* Now I am able to Cross_Compile properly for arm architecture. i Did the following steps. <br>____________________________________________<br>
- Export the PATH<br>export PATH=/usr/local/arm-sony-linux-gnueabi/devel/bin/:$PATH<br>export CROSS_COMPILER=arm-linux-gnueabi-dev-<br><br>- Configured LTP<br>sudo ./configure --host=arm prefix=/tftpboot/arm/beagleboard/ltp-full-20110915 CC=${CROSS_COMPILER}gcc<br>
<br>- After this Make and Make install<br>_________________________________________________<br><br><br><br>* Meanwhile I 'm Getting following error because of strip binary file.<br>________________________________<br>
make[4]: Entering directory `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'<br><br>arm-linux-gnueabi-armv7a-dev-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -g&nbsp; -I../../../../include -I../../../../include&nbsp; -c -o test_arch.o test_arch.c<br>
<br>arm-linux-gnueabi-armv7a-dev-gcc&nbsp;&nbsp; -L../../../../lib&nbsp; test_arch.o&nbsp;&nbsp; -o test_arch_debug<br><br>arm-linux-gnueabi-armv7a-dev-gcc&nbsp;&nbsp; -L../../../../lib&nbsp; test_arch.o&nbsp;&nbsp; -o test_arch_stripped<br><br>strip test_arch_stripped<br>
<br>/usr/bin/strip: /usr/bin/strip: cannot execute binary file<br><br>make[4]: *** [test_arch_stripped] Error 126<br><br>make[4]: Leaving directory `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade/objdump'<br>
<br>make[3]: *** [all] Error 2<br><br>make[3]: Leaving directory `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands/ade'<br><br>make[2]: *** [all] Error 2<br><br>make[2]: Leaving directory `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases/commands'<br>
<br>make[1]: *** [all] Error 2<br><br>make[1]: Leaving directory `/tftpboot/arm/beagleboard/ltp-full-20110915/testcases'<br><br>make: *** [testcases-all] Error 2<br>________________________________<br><br>after this I replaced 'strip' binary file from host to cross_compiler architecture 'strip' binary file. But still LTP is failing to compile .<br></font></font></font></div></blockquote><br></div><div><span class="Apple-tab-span" style="white-space:pre">	</span>See all variables from "Application specifying variables... " to "XXX: I'm lazy..." in&nbsp;include/mk/config.mk ... You may or may not have to define these when calling configure and cross-compiling LTP; FWIW the same guidelines should be used in any properly designed autotools enabled project (I know at least a handful that don't follow a sane variable convention like I tried to create because of the cross-compilation environment I used to work with).</div><div>Cheers,</div><div>-Garrett</div></body></html>
--Apple-Mail-1--925004040--


--===============1855593367372601761==
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
--===============1855593367372601761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1855593367372601761==--

