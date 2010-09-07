Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dthite@mvista.com>) id 1OspR5-0001mj-Tp
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 04:05:31 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OspR1-0003nb-P8
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 04:05:31 +0000
Received: by mail-qw0-f47.google.com with SMTP id 26so4912418qwa.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Sep 2010 21:05:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinDeS1ODKGwEtwRed0H57e3vyzjqQB8nnv_Cn4G@mail.gmail.com>
References: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
	<AANLkTi=9PFi3k0eEyYO_SvwBsOK77CBECXkrWLy7rkhY@mail.gmail.com>
	<AANLkTinAQARYsEWv6jbezg=-J=xBZM3UXnWfOSz++Lto@mail.gmail.com>
	<AANLkTinDeS1ODKGwEtwRed0H57e3vyzjqQB8nnv_Cn4G@mail.gmail.com>
Date: Tue, 7 Sep 2010 09:35:27 +0530
Message-ID: <AANLkTimtsukr=vdq9TRL62LUdfdcy2k79cTvEJQ1xmi+@mail.gmail.com>
From: Deepti Thite <dthite@in.mvista.com>
Subject: Re: [LTP] [PATCH] ld01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1622623144414066333=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--===============1622623144414066333==
Content-Type: multipart/alternative; boundary=000feaf013add2c54c048fa38162

--000feaf013add2c54c048fa38162
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Garrett,

We execute ltp tests on different architectures like arm, mips, etc., hence
hardcoding the absolute path  will not work on all  architectures. So I cam=
e
up with the patch as a generic solution to it.

Regards
Deepti

On Tue, Sep 7, 2010 at 12:38 AM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Wed, Sep 1, 2010 at 2:49 AM, Deepti Thite <dthite@in.mvista.com> wrote=
:
> > Hi Garrett,
> >
> > The actual error messages which I got were:
> >
> > + diff -iw /tmp/ld-6569/errmsg.out /tmp/ld-6569/errmsg.exp
> > --- /tmp/ld-6569/errmsg.out     Fri Aug 27 15:42:16 2010
> >
> > +++ /tmp/ld-6569/errmsg.exp     Fri Aug 27 15:42:16 2010
> > @@ -1,3 +1,3 @@
> > -arm-none-linux-gnueabi-gcc: x.obj: No such file or directory
> > -arm-none-linux-gnueabi-gcc: y.obj: No such file or directory
> > -arm-none-linux-gnueabi-gcc: no input files
> >
> > +gcc: x.obj: No such file or directory
> > +gcc: y.obj: No such file or directory
> > +gcc: No input files
> > + [ 1 -eq 0 ]
> > + echo FAIL -  ld failed to give expected error msg
> > FAIL -  ld failed to give expected error msg
> >
> > We are getting this issue as the native gcc is actually a shell script
> which
> > calls
> > arm-none-linux-gnueabi-gcc with compiler flags.
> > So we are getting the actual output but as the two files dont match ld0=
1
> > fails.
> > The patch attached in previous mail will not compare two files but will
> grep
> > the expected output.
> >
> > Regards
> > Deepti Thite <dthite@mvista.com>
> >
> > On Tue, Aug 31, 2010 at 9:18 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> >>
> >> On Tue, Aug 31, 2010 at 2:47 AM, Deepti Thite <dthite@in.mvista.com>
> >> wrote:
> >> > ld01 test fails as native compilers don=92t match in the expected an=
d
> >> > output
> >> > file.
> >> >
> >> > The attached patch will grep expected results from the output file
> >> > generated
> >> > and will not create an expected results file.
> >>
> >> What is the actual error message that gets printed out by ld(1)?
> >> Thanks,
>
> Here's a solution that doesn't require any change:
>
> export CC=3D'absolute-path-to-gcc'
> export LD=3D'absolute-path-to-ld'
> runltp # ...
>
> this equals zero change in our code, and ensures that the absolute
> name for the compiler is correct.
>
> Thanks,
> -Garrett
>

--000feaf013add2c54c048fa38162
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Garrett,<br><br>We execute ltp tests on different architectures like arm=
, mips, etc., hence hardcoding the absolute path=A0 will not work on all=A0=
 architectures. So I came up with the patch as a generic solution to it.<br=
>
<br>Regards <br>Deepti<br><br><div class=3D"gmail_quote">On Tue, Sep 7, 201=
0 at 12:38 AM, Garrett Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yaneg=
omi@gmail.com">yanegomi@gmail.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Wed, Sep 1, 2010 at 2:49 AM, Deepti Th=
ite &lt;<a href=3D"mailto:dthite@in.mvista.com">dthite@in.mvista.com</a>&gt=
; wrote:<br>
&gt; Hi Garrett,<br>
&gt;<br>
&gt; The actual error messages which I got were:<br>
&gt;<br>
&gt; + diff -iw /tmp/ld-6569/errmsg.out /tmp/ld-6569/errmsg.exp<br>
&gt; --- /tmp/ld-6569/errmsg.out =A0 =A0 Fri Aug 27 15:42:16 2010<br>
&gt;<br>
&gt; +++ /tmp/ld-6569/errmsg.exp =A0 =A0 Fri Aug 27 15:42:16 2010<br>
&gt; @@ -1,3 +1,3 @@<br>
&gt; -arm-none-linux-gnueabi-gcc: x.obj: No such file or directory<br>
&gt; -arm-none-linux-gnueabi-gcc: y.obj: No such file or directory<br>
&gt; -arm-none-linux-gnueabi-gcc: no input files<br>
&gt;<br>
&gt; +gcc: x.obj: No such file or directory<br>
&gt; +gcc: y.obj: No such file or directory<br>
&gt; +gcc: No input files<br>
&gt; + [ 1 -eq 0 ]<br>
&gt; + echo FAIL - =A0ld failed to give expected error msg<br>
&gt; FAIL - =A0ld failed to give expected error msg<br>
&gt;<br>
&gt; We are getting this issue as the native gcc is actually a shell script=
 which<br>
&gt; calls<br>
&gt; arm-none-linux-gnueabi-gcc with compiler flags.<br>
&gt; So we are getting the actual output but as the two files dont match ld=
01<br>
&gt; fails.<br>
&gt; The patch attached in previous mail will not compare two files but wil=
l grep<br>
&gt; the expected output.<br>
&gt;<br>
&gt; Regards<br>
&gt; Deepti Thite &lt;<a href=3D"mailto:dthite@mvista.com">dthite@mvista.co=
m</a>&gt;<br>
&gt;<br>
&gt; On Tue, Aug 31, 2010 at 9:18 PM, Garrett Cooper &lt;<a href=3D"mailto:=
yanegomi@gmail.com">yanegomi@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Aug 31, 2010 at 2:47 AM, Deepti Thite &lt;<a href=3D"mailt=
o:dthite@in.mvista.com">dthite@in.mvista.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt; ld01 test fails as native compilers don=92t match in the expe=
cted and<br>
&gt;&gt; &gt; output<br>
&gt;&gt; &gt; file.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The attached patch will grep expected results from the output=
 file<br>
&gt;&gt; &gt; generated<br>
&gt;&gt; &gt; and will not create an expected results file.<br>
&gt;&gt;<br>
&gt;&gt; What is the actual error message that gets printed out by ld(1)?<b=
r>
&gt;&gt; Thanks,<br>
<br>
</div></div>Here&#39;s a solution that doesn&#39;t require any change:<br>
<br>
export CC=3D&#39;absolute-path-to-gcc&#39;<br>
export LD=3D&#39;absolute-path-to-ld&#39;<br>
runltp # ...<br>
<br>
this equals zero change in our code, and ensures that the absolute<br>
name for the compiler is correct.<br>
<br>
Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br>

--000feaf013add2c54c048fa38162--


--===============1622623144414066333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--===============1622623144414066333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1622623144414066333==--

