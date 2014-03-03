Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <monstr@monstr.eu>) id 1WKV4a-0004Jo-N4
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 15:46:32 +0000
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WKV4Z-0005RE-Cb
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 15:46:32 +0000
Received: by mail-qa0-f52.google.com with SMTP id m5so3666233qaj.11
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Mar 2014 07:46:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+G9fYv9+Fhyz=nVZQZXxLU0YMTJadfr1XVVVb9P=inEfUaDuA@mail.gmail.com>
References: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
	<52FDE52A.4070002@linux.vnet.ibm.com>
	<CA+G9fYv9+Fhyz=nVZQZXxLU0YMTJadfr1XVVVb9P=inEfUaDuA@mail.gmail.com>
Date: Mon, 3 Mar 2014 16:21:11 +0100
Message-ID: <CAHTX3dLrfW_Hbqx_-vEfcHGCh7c4n=Hs1OATfvjJ9UEaxJTCaQ@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Subject: Re: [LTP] How to get the Linux kernel coverage data on ARM arch
 when I run LTP test?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2202517847648756186=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, fhrbata@redhat.com, Arnd Bergmann <arnd.bergmann@linaro.org>, Mark Brown <mark.brown@linaro.org>, Milosz Wasilewski <milosz.wasilewski@linaro.org>

--===============2202517847648756186==
Content-Type: multipart/alternative; boundary=001a113a80d674aa3904f3b5562f

--001a113a80d674aa3904f3b5562f
Content-Type: text/plain; charset=ISO-8859-1

HI,


2014-02-18 15:30 GMT+01:00 Naresh Kamboju <naresh.kamboju@linaro.org>:

> On 14 February 2014 15:13, Peter Oberparleiter
> <oberpar@linux.vnet.ibm.com> wrote:
> > On 14.02.2014 10:02, Naresh Kamboju wrote:
> >> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov
> kernel/gcov/base.c -o
> >>  /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
> >> File 'kernel/gcov/base.c'
> >> Lines executed:43.18% of 44
> >> Creating 'base.c.gcov'
> >>
> >> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#
> >>
> >> The above experiment gives coverage of a single file base.c when i run
> >> gcov manually.
> >> Is there any way to get Linux kernel coverage of all files after
> >> running LTP test cases ?
> >
> > 1. Reset coverage data: lcov -z
> > 2. Run LTP (or any other test case)
> > 3. Capture coverage data: lcov -c -o coverage.info
> > 4. Generate HTML output: genhtml coverage.info -o out
> > 5. View HTML output: <browser> out/index.html
>
> It is working !!!
> LTP executed on linux-linaro build on vexpress-tc2 target.
> Please find results obtained
> http://people.linaro.org/~naresh.kamboju/linux-linaro-coverage-by-ltp/
>
> The plan is to run all linaro test suite and to get coverage date.


Have you already run it? Are these test cases available?

Thanks,
Michal

--001a113a80d674aa3904f3b5562f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">HI,<br><div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">2014-02-18 15:30 GMT+01:00 Naresh Kamboju <span dir=3D"ltr=
">&lt;<a href=3D"mailto:naresh.kamboju@linaro.org" target=3D"_blank">naresh=
.kamboju@linaro.org</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 14 February 2014 15:13, Peter Oberparleit=
er<br>
<div class=3D"">&lt;<a href=3D"mailto:oberpar@linux.vnet.ibm.com">oberpar@l=
inux.vnet.ibm.com</a>&gt; wrote:<br>
&gt; On 14.02.2014 10:02, Naresh Kamboju wrote:<br>
&gt;&gt; root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/=
gcov/base.c -o<br>
&gt;&gt; =A0/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gco=
v/<br>
&gt;&gt; File &#39;kernel/gcov/base.c&#39;<br>
&gt;&gt; Lines executed:43.18% of 44<br>
&gt;&gt; Creating &#39;base.c.gcov&#39;<br>
&gt;&gt;<br>
&gt;&gt; root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#<br>
&gt;&gt;<br>
&gt;&gt; The above experiment gives coverage of a single file base.c when i=
 run<br>
&gt;&gt; gcov manually.<br>
&gt;&gt; Is there any way to get Linux kernel coverage of all files after<b=
r>
&gt;&gt; running LTP test cases ?<br>
&gt;<br>
&gt; 1. Reset coverage data: lcov -z<br>
&gt; 2. Run LTP (or any other test case)<br>
&gt; 3. Capture coverage data: lcov -c -o <a href=3D"http://coverage.info" =
target=3D"_blank">coverage.info</a><br>
&gt; 4. Generate HTML output: genhtml <a href=3D"http://coverage.info" targ=
et=3D"_blank">coverage.info</a> -o out<br>
&gt; 5. View HTML output: &lt;browser&gt; out/index.html<br>
<br>
</div>It is working !!!<br>
LTP executed on linux-linaro build on vexpress-tc2 target.<br>
Please find results obtained<br>
<a href=3D"http://people.linaro.org/~naresh.kamboju/linux-linaro-coverage-b=
y-ltp/" target=3D"_blank">http://people.linaro.org/~naresh.kamboju/linux-li=
naro-coverage-by-ltp/</a><br>
<br>
The plan is to run all linaro test suite and to get coverage date.</blockqu=
ote><div><br></div><div>Have you already run it? Are these test cases avail=
able? <br></div><div><br></div><div>Thanks,<br>Michal<br></div><div><br>
</div></div></div></div></div>

--001a113a80d674aa3904f3b5562f--


--===============2202517847648756186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
--===============2202517847648756186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2202517847648756186==--

