Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <AANLkTimUmvdHqx4YEYE29BcfJjoEMpW2QeHYa-KwCdSF@mail.gmail.com>
References: <AANLkTimUmvdHqx4YEYE29BcfJjoEMpW2QeHYa-KwCdSF@mail.gmail.com>
Date: Fri, 13 Aug 2010 09:50:10 +0530
Message-ID: <AANLkTimEQwoXeM9-surDyRPwTKW5x5_zMOPcJMU-k-0X@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] Fwd: dio testcase failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4845208014079414490=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Ltp-list-request@lists.sourceforge.net

--===============4845208014079414490==
Content-Type: multipart/alternative; boundary=001485f1dcf66a0858048dacccda

--001485f1dcf66a0858048dacccda
Content-Type: text/plain; charset=ISO-8859-1

---------- Forwarded message ----------
From: ARJIT SHARMA <joyarjit@gmail.com>
Date: Aug 11, 2010 12:29 PM
Subject: dio testcase failure
To: ltp-list@lists.sourceforge.net

dio" testcase results in failure of many tests ie. 25 out of 28.
The cause of error is "tst_rmdir()" like....

"Tst_rmdir():failed:errno=16: device or resource busy."

all the tests are failing due to the same reason.


How can I overcome this error.?
i m not able to correct it.    :(
-- 
Arjit........


-- 
Arjit........

--001485f1dcf66a0858048dacccda
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br><br>---------- Forwarded message ----------<br><span class=3D"gmai=
l_quote">From: <b class=3D"gmail_sendername">ARJIT SHARMA</b> &lt;<a href=
=3D"mailto:joyarjit@gmail.com">joyarjit@gmail.com</a>&gt;<br>Date: Aug 11, =
2010 12:29 PM<br>
Subject: dio testcase failure<br>To: <a href=3D"mailto:ltp-list@lists.sourc=
eforge.net">ltp-list@lists.sourceforge.net</a><br><br></span>dio&quot; test=
case results in failure of many tests ie. 25 out of 28.<br>The cause of err=
or is &quot;tst_rmdir()&quot; like....</div>

<div><br>&quot;Tst_rmdir():failed:errno=3D16: device or resource busy.&quot=
;</div>
<div>=A0</div>
<div>all the tests are failing due to the same reason.</div>
<div>=A0</div>
<div><br>How can I overcome this error.?<br clear=3D"all">i m not able to c=
orrect it.=A0=A0=A0 :(<br>-- <br><span class=3D"sg">Arjit........<br></span=
><br clear=3D"all"><br>-- <br>Arjit........ </div>

--001485f1dcf66a0858048dacccda--


--===============4845208014079414490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--===============4845208014079414490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4845208014079414490==--

