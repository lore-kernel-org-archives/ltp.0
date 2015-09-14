Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Veerendra.Jonnalagadda@inedasystems.com>)
	id 1ZbO9v-0005hX-HM
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2015 07:26:39 +0000
Received: from mx2.invecas.com ([112.133.222.227] helo=mail.invecas.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZbO9r-0006ZH-QU
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2015 07:26:39 +0000
From: Veerendra Jonnalagadda <Veerendra.Jonnalagadda@inedasystems.com>
Date: Mon, 14 Sep 2015 07:17:45 +0000
Message-ID: <1442214807574.25113@inedasystems.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] How to enable USB test case while compiling
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6851311365973676072=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6851311365973676072==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_144221480757425113inedasystemscom_"

--_000_144221480757425113inedasystemscom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to compile LTP test suite by enabling USB in the kernel/device =
driver/Makefile.

I am getting error.


make[4]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/device-drivers/usb'
make[5]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/device-drivers/usb/tusb'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb/tusb'
make[5]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/device-drivers/usb/user_usb'
make -C "/home/veerendra/QA/ltp-full-20150420/testcases/kernel/include" -f =
"/home/veerendra/QA/ltp-full-20150420/testcases/kernel/include/Makefile" al=
l
make[6]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/include'
make[6]: Nothing to be done for `all'.
make[6]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/include'
/home/veerendra/Sourcery_CodeBench_Lite_for_MIPS_GNU_Linux/bin/mips-linux-g=
nu-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style=
-definition -D_FORTIFY_SOURCE=3D2 -I/home/veerendra/QA/ltp-full-20150420/te=
stcases/kernel/include -I../../../../../include -I../../../../../include   =
-L../../../../../lib  user_tusb.c   -lltp -o user_tusb
user_tusb.c: In function 'tusbopen':
user_tusb.c:66:5: warning: old-style function definition [-Wold-style-defin=
ition]
 int tusbopen()
     ^
user_tusb.c:89:4: warning: implicit declaration of function 'unlink' [-Wimp=
licit-function-declaration]
    rc =3D unlink(DEVICE_NAME);
    ^
user_tusb.c: In function 'tusbclose':
user_tusb.c:145:5: warning: old-style function definition [-Wold-style-defi=
nition]
 int tusbclose()
     ^
user_tusb.c:151:3: warning: implicit declaration of function 'close' [-Wimp=
licit-function-declaration]
   close(tusb_fd);
   ^
user_tusb.c: In function 'main':
user_tusb.c:158:5: warning: old-style function definition [-Wold-style-defi=
nition]
 int main()
     ^
user_tusb.c:208:2: warning: implicit declaration of function 'tst_exit' [-W=
implicit-function-declaration]
  tst_exit();
  ^
user_tusb.c:209:1: warning: control reaches end of non-void function [-Wret=
urn-type]
 }
 ^
user_tusb.c: In function 'tusbopen':
user_tusb.c:88:11: warning: 'st.st_mode' is used uninitialized in this func=
tion [-Wuninitialized]
   if (!(st.st_mode & S_IFDIR)) {
           ^
../../../../../lib/libltp.a(tst_res.o): In function `cat_file':
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:786: undefined reference=
 to `TCID'
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:786: undefined reference=
 to `TCID'
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:796: undefined reference=
 to `TCID'
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:796: undefined reference=
 to `TCID'
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:804: undefined reference=
 to `TCID'
../../../../../lib/libltp.a(tst_res.o):/home/veerendra/QA/ltp-full-20150420=
/lib/tst_res.c:804: more undefined references to `TCID' follow
collect2: error: ld returned 1 exit status
make[5]: *** [user_tusb] Error 1
make[5]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb/user_usb'
make[4]: *** [all] Error 2
make[4]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases'
make: *** [testcases-all] Error 2


Any suggestions


Regards

Veerendra

--_000_144221480757425113inedasystemscom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} .ms-cui-menu {background-color:#ffffff;border:1px rgb(166, 166, 1=
66) solid;font-family:"Segoe UI","Segoe WP","Segoe UI WPC",Tahoma,Arial,san=
s-serif;font-size:10pt;color:rgb(51, 51, 51);} .ms-cui-menusection-title {d=
isplay:none;} .ms-cui-ctl {vertical-align:text-top;text-decoration:none;col=
or:rgb(51, 51, 51);} .ms-cui-ctl-on {background-color:rgb(205, 230, 247);op=
acity: 0.8;} .ms-cui-img-cont-float {display:inline-block;margin-top:2px} .=
ms-cui-smenu-inner {padding-top:0px;} .ms-owa-paste-option-icon {margin: 0p=
x 6px 0px 6px;vertical-align:middle!important;padding-bottom: 2px;display:i=
nline-block;} .ms-rtePasteFlyout-option:hover {background-color:rgb(205, 23=
0, 247) !important;opacity:1 !important;} .ms-rtePasteFlyout-option {paddin=
g:8px 4px 8px 4px;outline:none;} .ms-cui-menusection {float:left; width:85p=
x;height:24px;overflow:hidden}.wf {speak:none; font-weight:normal; font-var=
iant:normal; text-transform:none; -webkit-font-smoothing:antialiased; verti=
cal-align:middle; display:inline-block;}.wf-family-owa {font-family:'o365Ic=
ons'}@font-face {  font-family:'o365IconsIE8';  src:url('prem/15.0.995.29/r=
esources/styles/office365icons.ie8.eot?#iefix') format('embedded-opentype')=
,         url('prem/15.0.995.29/resources/styles/office365icons.ie8.woff') =
format('woff'),         url('prem/15.0.995.29/resources/styles/office365ico=
ns.ie8.ttf') format('truetype');  font-weight:normal;  font-style:normal;}@=
font-face {  font-family:'o365IconsMouse';  src:url('prem/15.0.995.29/resou=
rces/styles/office365icons.mouse.eot?#iefix') format('embedded-opentype'), =
        url('prem/15.0.995.29/resources/styles/office365icons.mouse.woff') =
format('woff'),         url('prem/15.0.995.29/resources/styles/office365ico=
ns.mouse.ttf') format('truetype');  font-weight:normal;  font-style:normal;=
}.wf-family-owa {font-family:'o365IconsMouse'}.ie8 .wf-family-owa {font-fam=
ily:'o365IconsIE8'}.ie8 .wf-owa-play-large:before {content:'\e254';}.notIE8=
 .wf-owa-play-large:before {content:'\e054';}.ie8 .wf-owa-play-large {color=
:#FFFFFF/*$WFWhiteColor*/;}.notIE8 .wf-owa-play-large {border-color:#FFFFFF=
/*$WFWhiteColor*/; width:1.4em; height:1.4em; border-width:.1em; border-sty=
le:solid; border-radius:.8em; text-align:center; box-sizing:border-box; -mo=
z-box-sizing:border-box; padding:0.1em; color:#FFFFFF/*$WFWhiteColor*/;}.ie=
8 .wf-size-play-large {width:40px; height:40px; font-size:30px}.notIE8 .wf-=
size-play-large {width:40px; height:40px; font-size:30px}.notIE8 .wf-owa-tr=
iangle-down-small:before {content:'\e052';}.ie8 .wf-owa-triangle-down-small=
:before { content:'\e052';}.ie8 .wf-owa-triangle-down-small {color:#666666/=
*$WFGreyColor*/;}.wf-size-x20 {font-size: 20px!important;}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p>I am trying to compile LTP test suite by enabling USB in the kernel/devi=
ce driver/Makefile.</p>
<p>I am getting error.</p>
<p><br>
</p>
<p>make[4]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testca=
ses/kernel/device-drivers/usb'<br>
make[5]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/device-drivers/usb/tusb'<br>
make[5]: Nothing to be done for `all'.<br>
make[5]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb/tusb'<br>
make[5]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/device-drivers/usb/user_usb'<br>
make -C &quot;/home/veerendra/QA/ltp-full-20150420/testcases/kernel/include=
&quot; -f &quot;/home/veerendra/QA/ltp-full-20150420/testcases/kernel/inclu=
de/Makefile&quot; all<br>
make[6]: Entering directory `/home/veerendra/QA/ltp-full-20150420/testcases=
/kernel/include'<br>
make[6]: Nothing to be done for `all'.<br>
make[6]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/include'<br>
/home/veerendra/Sourcery_CodeBench_Lite_for_MIPS_GNU_Linux/bin/mips-linux-g=
nu-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style=
-definition -D_FORTIFY_SOURCE=3D2 -I/home/veerendra/QA/ltp-full-20150420/te=
stcases/kernel/include -I../../../../../include
 -I../../../../../include&nbsp;&nbsp; -L../../../../../lib&nbsp; user_tusb.=
c&nbsp;&nbsp; -lltp -o user_tusb<br>
user_tusb.c: In function 'tusbopen':<br>
user_tusb.c:66:5: warning: old-style function definition [-Wold-style-defin=
ition]<br>
&nbsp;int tusbopen()<br>
&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
user_tusb.c:89:4: warning: implicit declaration of function 'unlink' [-Wimp=
licit-function-declaration]<br>
&nbsp;&nbsp;&nbsp; rc =3D unlink(DEVICE_NAME);<br>
&nbsp;&nbsp;&nbsp; ^<br>
user_tusb.c: In function 'tusbclose':<br>
user_tusb.c:145:5: warning: old-style function definition [-Wold-style-defi=
nition]<br>
&nbsp;int tusbclose()<br>
&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
user_tusb.c:151:3: warning: implicit declaration of function 'close' [-Wimp=
licit-function-declaration]<br>
&nbsp;&nbsp; close(tusb_fd);<br>
&nbsp;&nbsp; ^<br>
user_tusb.c: In function 'main':<br>
user_tusb.c:158:5: warning: old-style function definition [-Wold-style-defi=
nition]<br>
&nbsp;int main()<br>
&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
user_tusb.c:208:2: warning: implicit declaration of function 'tst_exit' [-W=
implicit-function-declaration]<br>
&nbsp; tst_exit();<br>
&nbsp; ^<br>
user_tusb.c:209:1: warning: control reaches end of non-void function [-Wret=
urn-type]<br>
&nbsp;}<br>
&nbsp;^<br>
user_tusb.c: In function 'tusbopen':<br>
user_tusb.c:88:11: warning: 'st.st_mode' is used uninitialized in this func=
tion [-Wuninitialized]<br>
&nbsp;&nbsp; if (!(st.st_mode &amp; S_IFDIR)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
../../../../../lib/libltp.a(tst_res.o): In function `cat_file':<br>
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:786: undefined reference=
 to `TCID'<br>
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:786: undefined reference=
 to `TCID'<br>
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:796: undefined reference=
 to `TCID'<br>
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:796: undefined reference=
 to `TCID'<br>
/home/veerendra/QA/ltp-full-20150420/lib/tst_res.c:804: undefined reference=
 to `TCID'<br>
../../../../../lib/libltp.a(tst_res.o):/home/veerendra/QA/ltp-full-20150420=
/lib/tst_res.c:804: more undefined references to `TCID' follow<br>
collect2: error: ld returned 1 exit status<br>
make[5]: *** [user_tusb] Error 1<br>
make[5]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb/user_usb'<br>
make[4]: *** [all] Error 2<br>
make[4]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers/usb'<br>
make[3]: *** [all] Error 2<br>
make[3]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel/device-drivers'<br>
make[2]: *** [all] Error 2<br>
make[2]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases/=
kernel'<br>
make[1]: *** [all] Error 2<br>
make[1]: Leaving directory `/home/veerendra/QA/ltp-full-20150420/testcases'=
<br>
make: *** [testcases-all] Error 2</p>
<p><br>
</p>
<p>Any suggestions<br>
</p>
<p><br>
</p>
<p>Regards</p>
<p>Veerendra<br>
</p>
</body>
</html>

--_000_144221480757425113inedasystemscom_--


--===============6851311365973676072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6851311365973676072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6851311365973676072==--

