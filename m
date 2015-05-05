Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <narendrakumar.chepuri@gmail.com>) id 1Ypa7B-0004ll-U5
	for ltp-list@lists.sourceforge.net; Tue, 05 May 2015 10:30:13 +0000
Received: from mail-qg0-f42.google.com ([209.85.192.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ypa78-0002TM-0o
	for ltp-list@lists.sourceforge.net; Tue, 05 May 2015 10:30:13 +0000
MIME-Version: 1.0
In-Reply-To: <CAGMUi-D7ziRtBGaFcqy1i1CBbgLzqwiVY5Fq5W8a7=m=3yYLbw@mail.gmail.com>
References: <CAGMUi-D7ziRtBGaFcqy1i1CBbgLzqwiVY5Fq5W8a7=m=3yYLbw@mail.gmail.com>
Date: Tue, 5 May 2015 16:00:04 +0530
Message-ID: <CAGMUi-BhFdOmi0DNuXqOt__+WakP+bOiqHJbEHiarqtjMGF4Ww@mail.gmail.com>
From: Narendra Kumar <narendrakumar.chepuri@gmail.com>
Subject: Re: [LTP] LTP-DDT build error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2592024047870627216=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

--===============2592024047870627216==
Content-Type: multipart/related; boundary=001a11330b3866cf170515532999

--001a11330b3866cf170515532999
Content-Type: multipart/alternative; boundary=001a11330b3866cf120515532998

--001a11330b3866cf120515532998
Content-Type: text/plain; charset=UTF-8

Hi,

           May I know how to test the usb using testusb.c in of ltp my
devices are like /dev/bus/usb/001/001, I am tryng both ./testusb -a and
./testusb -D  /dev/bus/usb/001/001 first one is giving "no test devices
recognized" and second command is returning "./testusb:
/dev/bus/usb/001/001 may see only control tests\n /dev/bus/usb/001/001 test
0 --> 38 (Function not implemented)".

On Wed, Apr 15, 2015 at 2:39 PM, Narendra Kumar <
narendrakumar.chepuri@gmail.com> wrote:

> Hi I am getting build error: Build log is:
>
> make -C "testcases/ddt" \
> -f "/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/Makefile" all
> make[1]: Entering directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt'
> make[2]: Entering directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite'
> make[3]: Entering directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc'
> gcc -o test_rpmsg_rpc -I/uapi -I/include/uapi  tests_rpc_stress.c -g -O2
> -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -g
> -Wall -O1 -fomit-frame-pointer   -g  -L../../../../../lib  -lpthread
> tests_rpc_stress.c:57:29: fatal error: linux/rpmsg_rpc.h: No such file or
> directory
>  #include "linux/rpmsg_rpc.h"
>                              ^
> compilation terminated.
> /home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc/Makefile:31:
> recipe for target 'test_rpmsg_rpc' failed
> make[3]: *** [test_rpmsg_rpc] Error 1
> make[3]: Leaving directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc'
> ../../../include/mk/generic_trunk_target.inc:93: recipe for target 'all'
> failed
> make[2]: *** [all] Error 2
> make[2]: Leaving directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite'
> ../../include/mk/generic_trunk_target.inc:93: recipe for target 'all'
> failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> '/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt'
> Makefile:131: recipe for target 'testcases/ddt-all' failed
> make: *** [testcases/ddt-all] Error 2
>
>
>
>
>
> --
> [image: tree pine]Please consider the environment before printing this
> e-mail
>
> Thanks & Regards
> Narendra Kumar Chepuri
> (+917353049544)
>



-- 
[image: tree pine]Please consider the environment before printing this
e-mail

Thanks & Regards
Narendra Kumar Chepuri
(+917353049544)

--001a11330b3866cf120515532998
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0May I know how to test the usb using testusb.c in of ltp my devices a=
re like /dev/bus/usb/001/001, I am tryng both ./testusb -a and ./testusb -D=
 =C2=A0/dev/bus/usb/001/001 first one is giving &quot;no test devices recog=
nized&quot; and second command is returning &quot;./testusb: /dev/bus/usb/0=
01/001 may see only control tests\n /dev/bus/usb/001/001 test 0 --&gt; 38 (=
Function not implemented)&quot;.</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Wed, Apr 15, 2015 at 2:39 PM, Narendra Kumar <span =
dir=3D"ltr">&lt;<a href=3D"mailto:narendrakumar.chepuri@gmail.com" target=
=3D"_blank">narendrakumar.chepuri@gmail.com</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr">Hi I am getting build error: Buil=
d log is:<div><br></div><div>make -C &quot;testcases/ddt&quot; \<br></div><=
div><div><span style=3D"white-space:pre-wrap">	</span>-f &quot;/home/anvesh=
/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/Makefile&quot; all</div><div>m=
ake[1]: Entering directory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/=
testcases/ddt&#39;</div><div>make[2]: Entering directory &#39;/home/anvesh/=
Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite&#39;</div><div>m=
ake[3]: Entering directory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/=
testcases/ddt/ipc_test_suite/src/rpmsg_rpc&#39;</div><div>gcc -o test_rpmsg=
_rpc -I/uapi -I/include/uapi =C2=A0tests_rpc_stress.c -g -O2 -g -O2 -fno-st=
rict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -g -Wall -O1 -fo=
mit-frame-pointer =C2=A0 -g =C2=A0-L../../../../../lib =C2=A0-lpthread</div=
><div>tests_rpc_stress.c:57:29: fatal error: linux/rpmsg_rpc.h: No such fil=
e or directory</div><div>=C2=A0#include &quot;linux/rpmsg_rpc.h&quot;</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>compilation terminated.</div>=
<div>/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suit=
e/src/rpmsg_rpc/Makefile:31: recipe for target &#39;test_rpmsg_rpc&#39; fai=
led</div><div>make[3]: *** [test_rpmsg_rpc] Error 1</div><div>make[3]: Leav=
ing directory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt=
/ipc_test_suite/src/rpmsg_rpc&#39;</div><div>../../../include/mk/generic_tr=
unk_target.inc:93: recipe for target &#39;all&#39; failed</div><div>make[2]=
: *** [all] Error 2</div><div>make[2]: Leaving directory &#39;/home/anvesh/=
Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite&#39;</div><div>.=
./../include/mk/generic_trunk_target.inc:93: recipe for target &#39;all&#39=
; failed</div><div>make[1]: *** [all] Error 2</div><div>make[1]: Leaving di=
rectory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt&#39;<=
/div><div>Makefile:131: recipe for target &#39;testcases/ddt-all&#39; faile=
d</div><div>make: *** [testcases/ddt-all] Error 2</div><span class=3D"HOEnZ=
b"><font color=3D"#888888"><div><br></div><div><br></div><div><br></div><di=
v><br clear=3D"all"><div><br></div>-- <br><div><div dir=3D"ltr"><span style=
=3D"font-family:&#39;Times New Roman&#39;,serif;font-size:16px;color:rgb(31=
,73,125)"><img border=3D"0" width=3D"22" height=3D"36" src=3D"cid:image002.=
png@01CFA270.0DD937D0" alt=3D"tree pine"></span><span lang=3D"EN-GB" style=
=3D"font-family:&#39;Times New Roman&#39;,serif;font-size:16px;color:green"=
>Please consider the environment before printing this e-mail</span><br><div=
><span lang=3D"EN-GB" style=3D"font-family:&#39;Times New Roman&#39;,serif;=
font-size:16px;color:green"><br></span></div><div><span lang=3D"EN-GB" styl=
e=3D"font-size:16px"><font face=3D"trebuchet ms, sans-serif" color=3D"#0000=
ff">Thanks &amp; Regards</font></span></div><div><span lang=3D"EN-GB" style=
=3D"font-size:16px"><font face=3D"trebuchet ms, sans-serif" color=3D"#0000f=
f">Narendra Kumar Chepuri</font></span></div><div><span lang=3D"EN-GB" styl=
e=3D"font-size:16px"><font face=3D"trebuchet ms, sans-serif" color=3D"#0000=
ff">(+917353049544)</font></span></div></div></div>
</div></font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"font-family:&#39;Times=
 New Roman&#39;,serif;font-size:16px;color:rgb(31,73,125)"><img border=3D"0=
" width=3D"22" height=3D"36" src=3D"cid:image002.png@01CFA270.0DD937D0" alt=
=3D"tree pine"></span><span lang=3D"EN-GB" style=3D"font-family:&#39;Times =
New Roman&#39;,serif;font-size:16px;color:green">Please consider the enviro=
nment before printing this e-mail</span><br><div><span lang=3D"EN-GB" style=
=3D"font-family:&#39;Times New Roman&#39;,serif;font-size:16px;color:green"=
><br></span></div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font =
face=3D"trebuchet ms, sans-serif" color=3D"#0000ff">Thanks &amp; Regards</f=
ont></span></div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font f=
ace=3D"trebuchet ms, sans-serif" color=3D"#0000ff">Narendra Kumar Chepuri</=
font></span></div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font =
face=3D"trebuchet ms, sans-serif" color=3D"#0000ff">(+917353049544)</font><=
/span></div></div></div>
</div></div>

--001a11330b3866cf120515532998--

--001a11330b3866cf170515532999
Content-Type: image/png; name="image002.png"
Content-Disposition: inline; filename="image002.png"
Content-Transfer-Encoding: base64
Content-ID: <image002.png@01CFA270.0DD937D0>
X-Attachment-Id: a735e4d8b8d02cb9_0.0.2

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
YII=
--001a11330b3866cf170515532999--


--===============2592024047870627216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
--===============2592024047870627216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2592024047870627216==--

