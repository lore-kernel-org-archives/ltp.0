Return-Path: <sitelist-bounces@lists.sourceforge.net>
Subject: Ltp-list post from narendrakumar.chepuri@gmail.com requires approval
From: ltp-list-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6601638435896925083=="
Message-ID: <mailman.117429.1429088962.21039.ltp-list@lists.sourceforge.net>
Date: Wed, 15 Apr 2015 09:09:22 +0000
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
Errors-To: sitelist-bounces@lists.sourceforge.net
To: ltp-list-owner@lists.sourceforge.net

--===============6601638435896925083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Ltp-list@lists.sourceforge.net
    From:    narendrakumar.chepuri@gmail.com
    Subject: LTP-DDT build error
    Reason:  Post by non-member to a members-only list

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/ltp-list
        
to approve or deny the request.

--===============6601638435896925083==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <narendrakumar.chepuri@gmail.com>) id 1YiJJx-0004bg-E4
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 09:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sourceforge.net; s=x; 
	h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version;
	bh=XJr7T0O2IFMcY2ZqHjzJN9BriCvQ+379n7BUsqK98EM=; 
	b=RJaiQNBlJTFqBBSSdZDw+Ze9GbOHa6KIwyyQQ8I60/A7xkOM51e30xEsiEOgagm1AL00quz7p8MegppLutgEq/kpJ8yxSPgSR/L7CAjFMcJ4yODbxgkNGV7k5gSK22+P/AXSb99Azajzdb0x6INQn/zaP6zc4r6aCyklpx3INgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x;
	h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version;
	bh=XJr7T0O2IFMcY2ZqHjzJN9BriCvQ+379n7BUsqK98EM=; 
	b=h+3LClgX6Ap6mzjhh2DM8RP1GtLTdZvOkt7mUwGnIGonxvRP96vJky8ub5ER7u16P6nlapIIVGYzfZ41luexCvKjREgS/r4J4xG8arVCR5kazkwFbRf0LKvZ95P023U3yXASOv9cyYtafGy7R1WA3T5VIHPv1jbOJ75fBSmlGT8=;
Received-SPF: pass (sog-mx-4.v43.ch3.sourceforge.com: domain of gmail.com
	designates 209.85.216.41 as permitted sender)
	client-ip=209.85.216.41;
	envelope-from=narendrakumar.chepuri@gmail.com;
	helo=mail-vn0-f41.google.com; 
Received: from mail-vn0-f41.google.com ([209.85.216.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YiJJw-0007uk-G5
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 09:09:21 +0000
Received: by vnbf129 with SMTP id f129so12592092vnb.9
	for <ltp-list@lists.sf.net>; Wed, 15 Apr 2015 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113; 
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=XJr7T0O2IFMcY2ZqHjzJN9BriCvQ+379n7BUsqK98EM=;
	b=g5bdEx6/tQ+2tDgo/aX3Q0Pd1TvR7oMy0ROEnOKNJ/5RglCWSddk/iBGYlWu46GQTu
	R+jQ2sKxIwst1DgS1DF4RzlFz+zy92iYdZzXOVNFhj32rzdNVSuRdkRyLjaXrOiZ3Bfl
	P2UlmsMZoknPex2O32NzOBVYbm7Tc4t+hDIgvOYIcKfoVb87s9NkUEFGOgYLFNARjbRh
	vSm3if2DvVcbdRw/3zODrapuTloK4+3031NmodHOP2n/1bBcfVgX4YTvPyAJ6EWdUXSf
	wmAg5HeWFRwhVxHFQSDu8eAB5yMTy5s6As70iUhx46wsabGUo4YIltRpd/XnfRNt2mC2
	DTQQ==
MIME-Version: 1.0
X-Received: by 10.140.82.144 with SMTP id h16mr20710894qgd.29.1429088954928;
	Wed, 15 Apr 2015 02:09:14 -0700 (PDT)
Received: by 10.229.29.2 with HTTP; Wed, 15 Apr 2015 02:09:14 -0700 (PDT)
Date: Wed, 15 Apr 2015 14:39:14 +0530
Message-ID: <CAGMUi-D7ziRtBGaFcqy1i1CBbgLzqwiVY5Fq5W8a7=m=3yYLbw@mail.gmail.com>
Subject: LTP-DDT build error
From: Narendra Kumar <narendrakumar.chepuri@gmail.com>
To: ltp-list@lists.sf.net
Content-Type: multipart/related; boundary=001a11c118088331b20513bfb382
X-Spam-Score: -0.6 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-1.5 SPF_CHECK_PASS SPF reports sender host as permitted sender for
	sender-domain
	0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	(narendrakumar.chepuri[at]gmail.com)
	-0.0 SPF_PASS               SPF: sender matches SPF record
	0.0 HTML_IMAGE_ONLY_32 BODY: HTML: images with 2800-3200 bytes of words
	1.0 HTML_MESSAGE           BODY: HTML included in message
	-0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	author's domain
	0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
	not necessarily valid
	-0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Headers-End: 1YiJJw-0007uk-G5

--001a11c118088331b20513bfb382
Content-Type: multipart/alternative; boundary=001a11c118088331ae0513bfb381

--001a11c118088331ae0513bfb381
Content-Type: text/plain; charset=UTF-8

Hi I am getting build error: Build log is:

make -C "testcases/ddt" \
-f "/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/Makefile" all
make[1]: Entering directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt'
make[2]: Entering directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite'
make[3]: Entering directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc'
gcc -o test_rpmsg_rpc -I/uapi -I/include/uapi  tests_rpc_stress.c -g -O2 -g
-O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -g
-Wall -O1 -fomit-frame-pointer   -g  -L../../../../../lib  -lpthread
tests_rpc_stress.c:57:29: fatal error: linux/rpmsg_rpc.h: No such file or
directory
 #include "linux/rpmsg_rpc.h"
                             ^
compilation terminated.
/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc/Makefile:31:
recipe for target 'test_rpmsg_rpc' failed
make[3]: *** [test_rpmsg_rpc] Error 1
make[3]: Leaving directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc'
../../../include/mk/generic_trunk_target.inc:93: recipe for target 'all'
failed
make[2]: *** [all] Error 2
make[2]: Leaving directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite'
../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory
'/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt'
Makefile:131: recipe for target 'testcases/ddt-all' failed
make: *** [testcases/ddt-all] Error 2





-- 
[image: tree pine]Please consider the environment before printing this
e-mail

Thanks & Regards
Narendra Kumar Chepuri
(+917353049544)

--001a11c118088331ae0513bfb381
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi I am getting build error: Build log is:<div><br></div><=
div>make -C &quot;testcases/ddt&quot; \<br></div><div><div><span class=3D""=
 style=3D"white-space:pre">	</span>-f &quot;/home/anvesh/Desktop/work/ltp_t=
est/ltp-ddt/testcases/ddt/Makefile&quot; all</div><div>make[1]: Entering di=
rectory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt&#39;<=
/div><div>make[2]: Entering directory &#39;/home/anvesh/Desktop/work/ltp_te=
st/ltp-ddt/testcases/ddt/ipc_test_suite&#39;</div><div>make[3]: Entering di=
rectory &#39;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_t=
est_suite/src/rpmsg_rpc&#39;</div><div>gcc -o test_rpmsg_rpc -I/uapi -I/inc=
lude/uapi =C2=A0tests_rpc_stress.c -g -O2 -g -O2 -fno-strict-aliasing -pipe=
 -Wall -W -g -O2 -Wold-style-definition -g -Wall -O1 -fomit-frame-pointer =
=C2=A0 -g =C2=A0-L../../../../../lib =C2=A0-lpthread</div><div>tests_rpc_st=
ress.c:57:29: fatal error: linux/rpmsg_rpc.h: No such file or directory</di=
v><div>=C2=A0#include &quot;linux/rpmsg_rpc.h&quot;</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^</div><div>compilation terminated.</div><div>/home/anvesh=
/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/src/rpmsg_rpc/M=
akefile:31: recipe for target &#39;test_rpmsg_rpc&#39; failed</div><div>mak=
e[3]: *** [test_rpmsg_rpc] Error 1</div><div>make[3]: Leaving directory &#3=
9;/home/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt/ipc_test_suite/s=
rc/rpmsg_rpc&#39;</div><div>../../../include/mk/generic_trunk_target.inc:93=
: recipe for target &#39;all&#39; failed</div><div>make[2]: *** [all] Error=
 2</div><div>make[2]: Leaving directory &#39;/home/anvesh/Desktop/work/ltp_=
test/ltp-ddt/testcases/ddt/ipc_test_suite&#39;</div><div>../../include/mk/g=
eneric_trunk_target.inc:93: recipe for target &#39;all&#39; failed</div><di=
v>make[1]: *** [all] Error 2</div><div>make[1]: Leaving directory &#39;/hom=
e/anvesh/Desktop/work/ltp_test/ltp-ddt/testcases/ddt&#39;</div><div>Makefil=
e:131: recipe for target &#39;testcases/ddt-all&#39; failed</div><div>make:=
 *** [testcases/ddt-all] Error 2</div><div><br></div><div><br></div><div><b=
r></div><div><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_si=
gnature"><div dir=3D"ltr"><span style=3D"font-family:&#39;Times New Roman&#=
39;,serif;font-size:16px;color:rgb(31,73,125)"><img border=3D"0" width=3D"2=
2" height=3D"36" src=3D"cid:image002.png@01CFA270.0DD937D0" alt=3D"tree pin=
e"></span><span lang=3D"EN-GB" style=3D"font-family:&#39;Times New Roman&#3=
9;,serif;font-size:16px;color:green">Please consider the environment before=
 printing this e-mail</span><br><div><span lang=3D"EN-GB" style=3D"font-fam=
ily:&#39;Times New Roman&#39;,serif;font-size:16px;color:green"><br></span>=
</div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font face=3D"treb=
uchet ms, sans-serif" color=3D"#0000ff">Thanks &amp; Regards</font></span><=
/div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font face=3D"trebu=
chet ms, sans-serif" color=3D"#0000ff">Narendra Kumar Chepuri</font></span>=
</div><div><span lang=3D"EN-GB" style=3D"font-size:16px"><font face=3D"treb=
uchet ms, sans-serif" color=3D"#0000ff">(+917353049544)</font></span></div>=
</div></div>
</div></div></div>

--001a11c118088331ae0513bfb381--

--001a11c118088331b20513bfb382
Content-Type: image/png; name="image002.png"
Content-Disposition: inline; filename="image002.png"
Content-Transfer-Encoding: base64
Content-ID: <image002.png@01CFA270.0DD937D0>
X-Attachment-Id: a735e4d8b8d02cb9_0.0.2

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
YII=
--001a11c118088331b20513bfb382--


--===============6601638435896925083==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm af2b29eba067e3c6b880f42f187b8b45c4705d89
Sender: ltp-list-request@lists.sourceforge.net
From: ltp-list-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============6601638435896925083==--

