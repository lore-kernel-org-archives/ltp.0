Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M7SXk-00072a-Nh
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 11:04:04 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7SXe-0004PG-6R
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 11:04:04 +0000
Received: by ewy17 with SMTP id 17so1802137ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 May 2009 04:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090521.153754.179938255.caiqian@cclom.cn>
References: <d51f89b0904070228q4d4333c7vdd2dfc1e1f7ca8a@mail.gmail.com>
	<23553926.post@talk.nabble.com>
	<20090521.153754.179938255.caiqian@cclom.cn>
Date: Fri, 22 May 2009 16:33:56 +0530
Message-ID: <d51f89b0905220403m29abd736scf6251b0ae3e4397@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] HTML report generation issue.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0773254144507860884=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

--===============0773254144507860884==
Content-Type: multipart/alternative; boundary=00504502d4d3804544046a7e37ff

--00504502d4d3804544046a7e37ff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

In response to your query - "if there is any side-effect for single pan
instance by using -O
as default."

As per my understanding the pan driver creates files in the directory
specified with the -O option for every testcase that is being executed. If
the disk space is a constraint then using buffered mode might be an
overhead. But, the space is only required when the LTP is running. After the
execution of the tests all the files that are created during the buffering
mode is deleted from the folder.

I feel, using the default buffered mode will not create an
overhead/side-effect.

Regards,
rohit




On Thu, May 21, 2009 at 1:07 PM, CAI Qian <caiqian@cclom.cn> wrote:

> From: rohitv <rohit.170309@gmail.com>
> Subject: Re: [LTP] HTML report generation issue.
> Date: Thu, 14 May 2009 23:04:13 -0700 (PDT)
>
> >
> > Hi,
> >
> > Regarding the output coming out of place, can we use the output buffered
> > mode as the default? Output buffered mode can be set with the -O option.
> > But, this works only when no. of instances of LTP is more than 1
> (specified
> > by -x option). Currently, for few of the testcases the output generated
> does
> > not appear between <<<test_output>>> and <<<execution_status>>>, it can
> be
> > seen anywhere before <<<test_output>>> when corresponding .output file is
> > checked. This might be because of race condition in the pan driver.  I
> think
> > by using the buffered output mode this problem can be fixed.
> >
>
> Are you saying that when we use pan without -x option, it will not use
> buffered mode even if specifying -O option? What I am interested to know
> is that if there is any side-effect for single pan instance by using -O
> as default.
>
> CAI Qian
>
> > Regards.
> > --
> > View this message in context:
> http://www.nabble.com/HTML-report-generation-issue.-tp22925527p23553926.html
> > Sent from the ltp-list mailing list archive at Nabble.com.
> >
> >
> >
> ------------------------------------------------------------------------------
> > Crystal Reports - New Free Runtime and 30 Day Trial
> > Check out the new simplified licensing option that enables
> > unlimited royalty-free distribution of the report engine
> > for externally facing server and web deployment.
> > http://p.sf.net/sfu/businessobjects
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>

--00504502d4d3804544046a7e37ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div><span class=3D"Apple-style-span" style=3D=
"border-collapse: collapse; ">In response to your query - &quot;if there is=
 any side-effect for single pan instance by using -O<br>as default.&quot;</=
span><br>
</div><div><br></div><div>As per my understanding the pan driver creates fi=
les in the directory specified with the -O option for every testcase that i=
s being executed. If the disk space is a constraint then using buffered mod=
e might be an overhead. But, the space is only required when the LTP is run=
ning. After the execution of the tests all the files that are created durin=
g the buffering mode is deleted from the folder.</div>
<div><br></div><div>I feel, using the default buffered mode will not create=
 an overhead/side-effect.</div><div><br></div><div>Regards,</div><div>rohit=
</div><div><br></div><div><br></div><br><br><div class=3D"gmail_quote">On T=
hu, May 21, 2009 at 1:07 PM, CAI Qian <span dir=3D"ltr">&lt;<a href=3D"mail=
to:caiqian@cclom.cn">caiqian@cclom.cn</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">From: rohitv &lt;<a href=3D"mailto:rohit.17=
0309@gmail.com">rohit.170309@gmail.com</a>&gt;<br>
Subject: Re: [LTP] HTML report generation issue.<br>
Date: Thu, 14 May 2009 23:04:13 -0700 (PDT)<br>
<br>
&gt;<br>
&gt; Hi,<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; Regarding the output coming out of place, can we use the output buffer=
ed<br>
&gt; mode as the default? Output buffered mode can be set with the -O optio=
n.<br>
&gt; But, this works only when no. of instances of LTP is more than 1 (spec=
ified<br>
&gt; by -x option). Currently, for few of the testcases the output generate=
d does<br>
&gt; not appear between &lt;&lt;&lt;test_output&gt;&gt;&gt; and &lt;&lt;&lt=
;execution_status&gt;&gt;&gt;, it can be<br>
&gt; seen anywhere before &lt;&lt;&lt;test_output&gt;&gt;&gt; when correspo=
nding .output file is<br>
&gt; checked. This might be because of race condition in the pan driver. =
=A0I think<br>
&gt; by using the buffered output mode this problem can be fixed.<br>
&gt;<br>
<br>
</div></div>Are you saying that when we use pan without -x option, it will =
not use<br>
buffered mode even if specifying -O option? What I am interested to know<br=
>
is that if there is any side-effect for single pan instance by using -O<br>
as default.<br>
<br>
CAI Qian<br>
<br>
&gt; Regards.<br>
&gt; --<br>
&gt; View this message in context: <a href=3D"http://www.nabble.com/HTML-re=
port-generation-issue.-tp22925527p23553926.html" target=3D"_blank">http://w=
ww.nabble.com/HTML-report-generation-issue.-tp22925527p23553926.html</a><br=
>

&gt; Sent from the ltp-list mailing list archive at Nabble.com.<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Crystal Reports - New Free Runtime and 30 Day Trial<br>
&gt; Check out the new simplified licensing option that enables<br>
&gt; unlimited royalty-free distribution of the report engine<br>
&gt; for externally facing server and web deployment.<br>
&gt; <a href=3D"http://p.sf.net/sfu/businessobjects" target=3D"_blank">http=
://p.sf.net/sfu/businessobjects</a><br>
<div><div></div><div class=3D"h5">&gt; ____________________________________=
___________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</div></div></blockquote></div><br>

--00504502d4d3804544046a7e37ff--


--===============0773254144507860884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
--===============0773254144507860884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0773254144507860884==--

