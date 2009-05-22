Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M7OwW-00064a-GB
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 07:13:24 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7OwR-0001hZ-6h
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 07:13:24 +0000
Received: by ewy17 with SMTP id 17so1719053ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 May 2009 00:13:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242975161.8760.15.camel@subratamodak.linux.ibm.com>
References: <522C1DF17AF50042AD8AE87F7887BD3D0158B35583@exch.hq.tensilica.com>
	<1242975161.8760.15.camel@subratamodak.linux.ibm.com>
Date: Fri, 22 May 2009 12:43:16 +0530
Message-ID: <d51f89b0905220013v353268d4p3054995a3db0ee0a@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] [PATCH] Detect test results more accurately when
	generating HTML
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2140780384783799294=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============2140780384783799294==
Content-Type: multipart/alternative; boundary=0016364efa4095de4e046a7afe42

--0016364efa4095de4e046a7afe42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
The suggestion to - "Process test output lines that appear between
<<<test_end>>>
and the following <<<test_start>>>.  Assign to the preceding test where the
name matches, else to the following test." does not solve the problem
completely.

My observation is:

1. Lines between <<<test_end>>> and <<<test_start>>> belongs to the
following test case and not to the preceding one.
2. Also, at times I have observed the test output is spread in such a way
that few lines of the test output fall between <<<test_end>>> and
<<<test_start>>> and rest of lines appear between the <<<test_start>>> and
<<<test_output>>> of the corresponding testcase.

Regards,
rohit

On Fri, May 22, 2009 at 12:22 PM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

> On Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote:
> > Hi, my first patch to this list.  Actually not a patch,
> > but the files themselves, to avoid line-wrapping issues
> > and because the diff is twice the size of the new file.
> >
> > -Marc
>
> Thanks Marc.
>
> Rohit,
>
> Can you test this and see if these solves the problem that you were
> discussing for long ?
>
> Regards--
> Subrata
>
> >
> >
> > -----------
> > Detect test results more accurately when generating HTML
> >
> > Process test output lines that appear between <<<test_end>>>
> > and the following <<<test_start>>>.  Assign to the preceding
> > test where the name matches, else to the following test.
> >
> > If a single test has multiple types of results (e.g. both
> > FAIL and WARN), report only the most significant one, to
> > avoid mis-computing the total number of PASS tests or
> > total counts that don't add up to the number of tests.
> >
> > If a test's output has no explicit result (PASS, FAIL, etc),
> > look at the exit value to determine whether it passed.
> >
> > Setting the SHOW_UNRESOLVED environment variable to 1
> > classifies as UNRESOLVED any test with no explicit result
> > and a zero exit code.
> >
> > Setting the SUMMARY_OUTPUT environment variable to 1
> > causes only one line of output per test to be shown, for a
> > tighter page that allows quickly scanning the results.
> >
> > Show percentage of each result type in summary section.
> >
> > Simplify parsing a bit.
> >
> > Signed-off-by:  Marc Gauthier <marc@tensilica.com>
> >
> >
> ------------------------------------------------------------------------------
> > Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> > is a gathering of tech-side developers & brand creativity professionals.
> Meet
> > the minds behind Google Creative Lab, Visual Complexity, Processing, &
> > iPhoneDevCamp asthey present alongside digital heavyweights like
> Barbarian
> > Group, R/GA, & Big Spaceship. http://www.creativitycat.com
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--0016364efa4095de4e046a7afe42
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>The suggestion to - &quot;Process test output lines =
that appear between &lt;&lt;&lt;test_end&gt;&gt;&gt;</div><div>and the foll=
owing &lt;&lt;&lt;test_start&gt;&gt;&gt;. =A0Assign to the preceding=A0test=
 where the name matches, else to the following test.&quot; does not solve t=
he problem completely.=A0</div>
<div><br></div><div>My observation is:=A0</div><div><br></div><div>1. Lines=
 between &lt;&lt;&lt;test_end&gt;&gt;&gt; and &lt;&lt;&lt;test_start&gt;&gt=
;&gt; belongs to the following test case and not to the preceding one.</div=
>
<div>2. Also, at times I have observed the test output is spread in such a =
way that few lines of the test output fall between &lt;&lt;&lt;test_end&gt;=
&gt;&gt; and &lt;&lt;&lt;test_start&gt;&gt;&gt; and rest of lines appear be=
tween the &lt;&lt;&lt;test_start&gt;&gt;&gt; and &lt;&lt;&lt;test_output&gt=
;&gt;&gt; of the corresponding testcase.</div>
<div><br></div><div>Regards,</div><div>rohit<br><br><div class=3D"gmail_quo=
te">On Fri, May 22, 2009 at 12:22 PM, Subrata Modak <span dir=3D"ltr">&lt;<=
a href=3D"mailto:subrata@linux.vnet.ibm.com">subrata@linux.vnet.ibm.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">On Thu, 2009-05-21 at 01:13 -0700, Marc Gau=
thier wrote:<br>
&gt; Hi, my first patch to this list. =A0Actually not a patch,<br>
&gt; but the files themselves, to avoid line-wrapping issues<br>
&gt; and because the diff is twice the size of the new file.<br>
&gt;<br>
&gt; -Marc<br>
<br>
Thanks Marc.<br>
<br>
Rohit,<br>
<br>
Can you test this and see if these solves the problem that you were<br>
discussing for long ?<br>
<br>
Regards--<br>
Subrata<br>
<br>
&gt;<br>
&gt;<br>
&gt; -----------<br>
&gt; Detect test results more accurately when generating HTML<br>
&gt;<br>
&gt; Process test output lines that appear between &lt;&lt;&lt;test_end&gt;=
&gt;&gt;<br>
&gt; and the following &lt;&lt;&lt;test_start&gt;&gt;&gt;. =A0Assign to the=
 preceding<br>
&gt; test where the name matches, else to the following test.<br>
&gt;<br>
&gt; If a single test has multiple types of results (e.g. both<br>
&gt; FAIL and WARN), report only the most significant one, to<br>
&gt; avoid mis-computing the total number of PASS tests or<br>
&gt; total counts that don&#39;t add up to the number of tests.<br>
&gt;<br>
&gt; If a test&#39;s output has no explicit result (PASS, FAIL, etc),<br>
&gt; look at the exit value to determine whether it passed.<br>
&gt;<br>
&gt; Setting the SHOW_UNRESOLVED environment variable to 1<br>
&gt; classifies as UNRESOLVED any test with no explicit result<br>
&gt; and a zero exit code.<br>
&gt;<br>
&gt; Setting the SUMMARY_OUTPUT environment variable to 1<br>
&gt; causes only one line of output per test to be shown, for a<br>
&gt; tighter page that allows quickly scanning the results.<br>
&gt;<br>
&gt; Show percentage of each result type in summary section.<br>
&gt;<br>
&gt; Simplify parsing a bit.<br>
&gt;<br>
&gt; Signed-off-by: =A0Marc Gauthier &lt;<a href=3D"mailto:marc@tensilica.c=
om">marc@tensilica.com</a>&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT<b=
r>
&gt; is a gathering of tech-side developers &amp; brand creativity professi=
onals. Meet<br>
&gt; the minds behind Google Creative Lab, Visual Complexity, Processing, &=
amp;<br>
&gt; iPhoneDevCamp asthey present alongside digital heavyweights like Barba=
rian<br>
&gt; Group, R/GA, &amp; Big Spaceship. <a href=3D"http://www.creativitycat.=
com" target=3D"_blank">http://www.creativitycat.com</a><br>
&gt; _______________________________________________ Ltp-list mailing list =
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a> <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a=
><br>

<br>
</blockquote></div><br></div>

--0016364efa4095de4e046a7afe42--


--===============2140780384783799294==
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
--===============2140780384783799294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2140780384783799294==--

