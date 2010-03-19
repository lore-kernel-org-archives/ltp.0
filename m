Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anthony.ton@ericsson.com>) id 1NsQpe-0004oT-6Q
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 01:16:58 +0000
Received: from imr1.ericy.com ([198.24.6.9])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NsQpd-0003bG-3n
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 01:16:58 +0000
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o2J1K0SM021418
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Mar 2010 20:20:00 -0500
From: Anthony Ton <anthony.ton@ericsson.com>
Date: Thu, 18 Mar 2010 21:16:50 -0400
Message-ID: <E0B6230F32558E43951AF1B0DEBF98102119D20EDD@EUSAACMS0714.eamcs.ericsson.se>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] tcore.exp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5628722434880266251=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5628722434880266251==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E0B6230F32558E43951AF1B0DEBF98102119D20EDDEUSAACMS0714e_"

--_000_E0B6230F32558E43951AF1B0DEBF98102119D20EDDEUSAACMS0714e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ltp team,

Hi LTP team,

It appears that the proc check_fpu in tcore.exp has an error when the expec=
t can't find the expected string "xmm$num ...".  In the timeout block, the =
code read

fail "fail to check the xmm value(timeout)"

In my humble opinion, it should be

send_user "fail to check the xmm value(timeout)"

The script crashes with error message:

(gdb) invalid command name "fail"
    while executing
"fail "fail to check the xmm value(timeout)""
    invoked from within
"expect -nobrace -re {xmm5[      ]+{f =3D .*}+[    ]+{f =3D .*}} {
                        set buf $expect_out(0,string)
                } timeout {
                    fail "fail to check the xmm value(..."
    invoked from within
"expect {
                -re "xmm$num\[\t \]+\{f \=3D .*\}+\[\t \]+\{f \=3D .*\}" {
                        set buf $expect_out(0,string)
                }
                timeout {
                    fail "fail to check t..."
    (procedure "check_fpu" line 7)
    invoked from within
"check_fpu 5"
    (file "/opt/anthony/ltp/testcases/bin//tcore.exp" line 137)

Please let me know how to fix this error.

Thanks,
Anthony




--_000_E0B6230F32558E43951AF1B0DEBF98102119D20EDDEUSAACMS0714e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hi Ltp team,</div>
<div>&nbsp;</div>
<div>Hi LTP team,</div>
<div>&nbsp;</div>
<div>It appears that the proc check_fpu in tcore.exp has an error when the =
expect can't find the expected string &quot;xmm$num &#8230;&quot;.&nbsp; In=
 the timeout block, the code read</div>
<div>&nbsp;</div>
<div><font color=3D"#FF0000">fail<font color=3D"#000000"> &quot;fail to che=
ck the xmm value(timeout)&quot;</font></font></div>
<div>&nbsp;</div>
<div>In my humble opinion, it should be</div>
<div>&nbsp;</div>
<div>send_user &quot;fail to check the xmm value(timeout)&quot;</div>
<div>&nbsp;</div>
<div>The script crashes with error message:</div>
<div>&nbsp;</div>
<div>(gdb) invalid command name &quot;fail&quot;</div>
<div>&nbsp;&nbsp;&nbsp; while executing</div>
<div>&quot;fail &quot;fail to check the xmm value(timeout)&quot;&quot;</div=
>
<div>&nbsp;&nbsp;&nbsp; invoked from within</div>
<div>&quot;expect -nobrace -re {xmm5[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&#43;{=
f =3D .*}&#43;[&nbsp;&nbsp;&nbsp; ]&#43;{f =3D .*}} {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set bu=
f $expect_out(0,string)</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; } timeout {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail &quot;fail to check the x=
mm value(...&quot;</div>
<div>&nbsp;&nbsp;&nbsp; invoked from within</div>
<div>&quot;expect { </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; -re &quot;xmm$num\[\t \]&#43;\{f \=3D .*\}&#43;\[\t \]=
&#43;\{f \=3D .*\}&quot; {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set bu=
f $expect_out(0,string)</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; timeout {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fail &quot;fail to check t...&=
quot;</div>
<div>&nbsp;&nbsp;&nbsp; (procedure &quot;check_fpu&quot; line 7)</div>
<div>&nbsp;&nbsp;&nbsp; invoked from within</div>
<div>&quot;check_fpu 5&quot;</div>
<div>&nbsp;&nbsp;&nbsp; (file &quot;/opt/anthony/ltp/testcases/bin//tcore.e=
xp&quot; line 137)</div>
<div>&nbsp;</div>
<div>Please let me know how to fix this error.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Anthony </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_E0B6230F32558E43951AF1B0DEBF98102119D20EDDEUSAACMS0714e_--


--===============5628722434880266251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5628722434880266251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5628722434880266251==--

