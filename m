Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hakehuang@gmail.com>) id 1P5ePD-0005xu-IG
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 12:56:35 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5ePC-0000bw-Ju
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 12:56:35 +0000
Received: by ywl5 with SMTP id 5so1734616ywl.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 05:56:29 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Oct 2010 20:56:28 +0800
Message-ID: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: Re: [LTP] Patch to record kernel dump message to each testcases log
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3835913898554092723=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3835913898554092723==
Content-Type: multipart/alternative; boundary=000e0cd48b58532d2f04926b0168

--000e0cd48b58532d2f04926b0168
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I wnat LTP to record the kernel dump message during each test case, and I
make a patch for this. Any comments?


@@ -1238,6 +1242,7 @@ write_test_end(struct tag_pgrp *running, const char
*init_status,
                int term_id, struct tms *tms1, struct tms *tms2)
 {
     if (!strcmp(reporttype, "rts")) {
+       system("/bin/dmesg -c");
        printf("%s\ninitiation_status=\"%s\"\nduration=%ld
termination_type=%s "
                "termination_id=%d corefile=%s\ncutime=%d cstime=%d\n%s\n",
                        "<<<execution_status>>>", init_status,

Regards,

Hake

--000e0cd48b58532d2f04926b0168
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I wnat LTP to record the kernel dump message during each test ca=
se, and I make a patch for this. Any comments?<br><br><br>@@ -1238,6 +1242,=
7 @@ write_test_end(struct tag_pgrp *running, const char *init_status,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int term_id, struct tms *tms1=
, struct tms *tms2)<br>=A0{<br>=A0=A0=A0=A0 if (!strcmp(reporttype, &quot;r=
ts&quot;)) {<br>+=A0=A0=A0=A0=A0=A0 system(&quot;/bin/dmesg -c&quot;);<br>=
=A0=A0=A0=A0=A0=A0=A0 printf(&quot;%s\ninitiation_status=3D\&quot;%s\&quot;=
\nduration=3D%ld termination_type=3D%s &quot;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;termination_id=3D%d cor=
efile=3D%s\ncutime=3D%d cstime=3D%d\n%s\n&quot;,<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;&lt;&lt;&lt;executio=
n_status&gt;&gt;&gt;&quot;, init_status,<br><br>Regards,<br><br>Hake<br>

--000e0cd48b58532d2f04926b0168--


--===============3835913898554092723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============3835913898554092723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3835913898554092723==--

