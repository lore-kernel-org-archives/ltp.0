Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1Ruf7x-0001ec-K6
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:06:09 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ruf7u-00033A-BV
	for ltp-list@lists.sourceforge.net; Tue, 07 Feb 2012 07:06:09 +0000
Received: by wgbdr12 with SMTP id dr12so6622957wgb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Feb 2012 23:06:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F2CF2D9.4090004@cn.fujitsu.com>
References: <CADfK0X4BrdBUq=pQ8zjgsHPtbrXTz2w+xSvn+HP4UBtmMEfgZg@mail.gmail.com>
	<4F2CF2D9.4090004@cn.fujitsu.com>
From: "Josh!" <joshiplns@gmail.com>
Date: Tue, 7 Feb 2012 12:35:40 +0530
Message-ID: <CADfK0X7Qpj4xA3quEviwABThgY20TFc5fVdGzUhvx0h+Qd-CkQ@mail.gmail.com>
Subject: Re: [LTP] Please clarify
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5054880704215812681=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5054880704215812681==
Content-Type: multipart/alternative; boundary=f46d043c094e4fcb7f04b85a692e

--f46d043c094e4fcb7f04b85a692e
Content-Type: text/plain; charset=ISO-8859-1

Yes !! I Got it ..
Thank you Peng Haitao ..

Josh!

On Sat, Feb 4, 2012 at 2:26 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:

>
> Josh! said the following on 2012-2-2 18:48:
> > Hi folks,
> >
> > As I am testing 3.0 Kernel with 2012 January LTP version. I successfully
> tested the 3.0 Kernel. BUT from the result log TESTED result is 1279   and
> when I counted its 1274 . attached log with this mail.
> >
> > Result log :
> > {
> > -----------------------------------------------
> > Total Tests: 1279
> > Total Failures: 54
> > Kernel Version: 3.0.12_nl-kzm-a9-rt29-00003-g5c963e0
> > Machine Architecture: armv7l
> > Hostname: 10.2.222.5
> > -----------------------------------------------
> > }
> >
> > BUT
> >
> > {
> > [Joshi@myserver Desktop]$ cat 2012_LTP_Result | wc -l
> > 1274
> > }
> >
> > *So My query is about*:
> >       *1.**I am confusing about missing test cases - where is missing
> test cases?*
> >       *2*.*even though in log 1274 test cases, Why is showing as 1279 as
> TOTAL tested cases*.
>
> I know the four cases: aio01, aio02, Cap_bounds and Filecaps.
>
> aio01 and aio02 need header file /usr/include/libaio.h in libaio-devel.
> Cap_bounds need header file /usr/include/sys/capability.h in libcap-devel.
> Filecaps need command setcap, but ltp has a bug:(
>
> When the above condition is not satisfied, the cases will not build and
> install.
> When execute, the cases will return error, but not add in logfile.
>
> for example:
> initiation_status="pan(18488): execvp of 'filecapstest.sh' (tag Filecaps)
> failed.  errno:2  No such file or directory"
>
> >       *3*.*How it will segregate the the test cases from runtest
> directory?*
>
> If you run "/opt/ltp/runltp -f io", you will find aio01 and aio02 is not
> in the logfile.
>
> --
> Best Regards,
> Peng
>
> > *Please clarify these points*
> >
> > Thanks in advance
> > Joshi
> >
> >
> >
> ------------------------------------------------------------------------------
> > Keep Your Developer Skills Current with LearnDevNow!
> > The most comprehensive online learning library for Microsoft developers
> > is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> > Metro Style Apps, more. Free future releases when you subscribe now!
> > http://p.sf.net/sfu/learndevnow-d2d
> >
> >
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--f46d043c094e4fcb7f04b85a692e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(51,51,153)"></span><span style=3D=
"color:rgb(51,51,153)"></span><br>
Yes !! I Got it .. <br>Thank you Peng Haitao ..<br><br>Josh!<br><br><div cl=
ass=3D"gmail_quote">On Sat, Feb 4, 2012 at 2:26 PM, Peng Haitao <span dir=
=3D"ltr">&lt;<a href=3D"mailto:penght@cn.fujitsu.com">penght@cn.fujitsu.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Josh! said the following on 2012-2-2 18:48:<br>
<div class=3D"im">&gt; Hi folks,<br>
&gt;<br>
&gt; As I am testing 3.0 Kernel with 2012 January LTP version. I successful=
ly tested the 3.0 Kernel. BUT from the result log TESTED result is 1279 =A0=
 and when I counted its 1274 . attached log with this mail.<br>
&gt;<br>
&gt; Result log :<br>
&gt; {<br>
&gt; -----------------------------------------------<br>
&gt; Total Tests: 1279<br>
&gt; Total Failures: 54<br>
&gt; Kernel Version: 3.0.12_nl-kzm-a9-rt29-00003-g5c963e0<br>
&gt; Machine Architecture: armv7l<br>
&gt; Hostname: 10.2.222.5<br>
&gt; -----------------------------------------------<br>
&gt; }<br>
&gt;<br>
&gt; BUT<br>
&gt;<br>
&gt; {<br>
&gt; [Joshi@myserver Desktop]$ cat 2012_LTP_Result | wc -l<br>
&gt; 1274<br>
&gt; }<br>
&gt;<br>
</div>&gt; *So My query is about*:<br>
&gt; =A0 =A0 =A0 *1.**I am confusing about missing test cases - where is mi=
ssing test cases?*<br>
&gt; =A0 =A0 =A0 *2*.*even though in log 1274 test cases, Why is showing as=
 1279 as TOTAL tested cases*.<br>
<br>
I know the four cases: aio01, aio02, Cap_bounds and Filecaps.<br>
<br>
aio01 and aio02 need header file /usr/include/libaio.h in libaio-devel.<br>
Cap_bounds need header file /usr/include/sys/capability.h in libcap-devel.<=
br>
Filecaps need command setcap, but ltp has a bug:(<br>
<br>
When the above condition is not satisfied, the cases will not build and ins=
tall.<br>
When execute, the cases will return error, but not add in logfile.<br>
<br>
for example:<br>
initiation_status=3D&quot;pan(18488): execvp of &#39;filecapstest.sh&#39; (=
tag Filecaps) failed. =A0errno:2 =A0No such file or directory&quot;<br>
<br>
&gt; =A0 =A0 =A0 *3*.*How it will segregate the the test cases from runtest=
 directory?*<br>
<br>
If you run &quot;/opt/ltp/runltp -f io&quot;, you will find aio01 and aio02=
 is not in the logfile.<br>
<br>
--<br>
Best Regards,<br>
Peng<br>
<br>
&gt; *Please clarify these points*<br>
&gt;<br>
&gt; Thanks in advance<br>
&gt; Joshi<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Keep Your Developer Skills Current with LearnDevNow!<br>
&gt; The most comprehensive online learning library for Microsoft developer=
s<br>
&gt; is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC=
3,<br>
&gt; Metro Style Apps, more. Free future releases when you subscribe now!<b=
r>
&gt; <a href=3D"http://p.sf.net/sfu/learndevnow-d2d" target=3D"_blank">http=
://p.sf.net/sfu/learndevnow-d2d</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br>
</blockquote></div><br></div>

--f46d043c094e4fcb7f04b85a692e--


--===============5054880704215812681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============5054880704215812681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5054880704215812681==--

