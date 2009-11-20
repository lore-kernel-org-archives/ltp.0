Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1NBdGQ-0004wv-MH
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 23:51:42 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBdGG-0003eq-Py
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 23:51:40 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAKNgmui018235
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 18:42:48 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAKNpRYx106428
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 18:51:27 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAKJiGjg027329
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 14:44:16 -0500
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nAKJiGdZ027326
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 14:44:16 -0500
In-Reply-To: <364299f40911192054t4468c150v662836173a53876@mail.gmail.com>
References: <mailman.132487.1258104166.5845.ltp-list@lists.sourceforge.net>	
	<OF316379BD.F75980D7-ON85257674.000F56B9-85257674.0010FC8C@us.ibm.com>
	<364299f40911192054t4468c150v662836173a53876@mail.gmail.com>
Message-ID: <OFCCA51283.746183E6-ON85257674.006E1A38-85257674.00830D2D@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Fri, 20 Nov 2009 18:51:25 -0500
MIME-Version: 1.0
Subject: Re: [LTP] minimal ltp test set
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1202176584368186405=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Subrata Modak1 <subrata.modak@in.ibm.com>

--===============1202176584368186405==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFCE7DFFD9CA88f9e8a93df938690918c0ABBFCE7DFFD9CA8"
Content-Disposition: inline

--0__=0ABBFCE7DFFD9CA88f9e8a93df938690918c0ABBFCE7DFFD9CA8
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Garrett Cooper <yanegomi@gmail.com> wrote on 11/19/2009 11:54:02 PM:

> Mark,
>     An ideal solution to this problem is a two-tiered solution:
>     1. Feature based conditional compilation.
>     2. Tool based conditional compilation (some tests require certain=

> tools, such as perl, python, and various Unix utilities that aren't a=

> part of the minimal set of tools, e.g. useradd, userdel, etc).
>     The tool based condition compilation is somewhat simple at a 10k
> ft level (I have perl, python, ruby, etc -- add / remove these tests =
/
> features) -- the feature based conditional compilation issue is a bit=

> more difficult to deal with as it requires a more in-depth
> understanding of what code exists in the sourcebase, and what
> functional tests map to what functional blocks under test. This is
> ideal, but not trivial to perform.
>     My first goal is to deal with any fallout from the make
> infrastructure commit(s), dealing with the make 3.80 incompatibility
> and other unforeseen usecases like you have with building and
> executing out of the same source tree. Next, I want to clean up any
> and all C warnings so the tests are more robust (Mike, Cyril, and I
> have done a pretty good job but there's a ways to go...). Then I'll
> undertake completing the ballista cleanup, which will also involve
> adding the shims for perl and python across the entire sourcebase.
> We'll need to revisit the feature based enabling a little later.
>     How does that sound?
> Thanks,
> -Garrett

Sounds good to me.  Definitely getting the conditional compilation
straightened out is priority one.  Right now we end up having to remove=

testcases and modify makefiles just to get the test suite to build.

I guess I was thinking of the minimal test set for the cases when new
testcases were misbehaving rather than when they couldn't run because t=
hey
misjudged the environment.  But I agree the 2 scenarios probably overla=
p
95% of the time.


- Mark=

--0__=0ABBFCE7DFFD9CA88f9e8a93df938690918c0ABBFCE7DFFD9CA8
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Garrett Cooper &lt;yanegomi@gmail.com&gt; wrote on 11/19/2009 11=
:54:02 PM:<br>
<br>
&gt; Mark,<br>
&gt; &nbsp; &nbsp; An ideal solution to this problem is a two-tiered so=
lution:<br>
&gt; &nbsp; &nbsp; 1. Feature based conditional compilation.<br>
&gt; &nbsp; &nbsp; 2. Tool based conditional compilation (some tests re=
quire certain<br>
&gt; tools, such as perl, python, and various Unix utilities that aren'=
t a<br>
&gt; part of the minimal set of tools, e.g. useradd, userdel, etc).<br>=

&gt; &nbsp; &nbsp; The tool based condition compilation is somewhat sim=
ple at a 10k<br>
&gt; ft level (I have perl, python, ruby, etc -- add / remove these tes=
ts /<br>
&gt; features) -- the feature based conditional compilation issue is a =
bit<br>
&gt; more difficult to deal with as it requires a more in-depth<br>
&gt; understanding of what code exists in the sourcebase, and what<br>
&gt; functional tests map to what functional blocks under test. This is=
<br>
&gt; ideal, but not trivial to perform.<br>
&gt; &nbsp; &nbsp; My first goal is to deal with any fallout from the m=
ake<br>
&gt; infrastructure commit(s), dealing with the make 3.80 incompatibili=
ty<br>
&gt; and other unforeseen usecases like you have with building and<br>
&gt; executing out of the same source tree. Next, I want to clean up an=
y<br>
&gt; and all C warnings so the tests are more robust (Mike, Cyril, and =
I<br>
&gt; have done a pretty good job but there's a ways to go...). Then I'l=
l<br>
&gt; undertake completing the ballista cleanup, which will also involve=
<br>
&gt; adding the shims for perl and python across the entire sourcebase.=
<br>
&gt; We'll need to revisit the feature based enabling a little later.<b=
r>
&gt; &nbsp; &nbsp; How does that sound?<br>
&gt; Thanks,<br>
&gt; -Garrett</tt><br>
<br>
<tt>Sounds good to me. &nbsp;Definitely getting the conditional compila=
tion straightened out is priority one. &nbsp;Right now we end up having=
 to remove testcases and modify makefiles just to get the test suite to=
 build.<br>
</tt><br>
<tt>I guess I was thinking of the minimal test set for the cases when n=
ew testcases were misbehaving rather than when they couldn't run becaus=
e they misjudged the environment. &nbsp;But I agree the 2 scenarios pro=
bably overlap 95% of the time.</tt><br>
<br>
<br>
<tt>- Mark</tt></body></html>=

--0__=0ABBFCE7DFFD9CA88f9e8a93df938690918c0ABBFCE7DFFD9CA8--



--===============1202176584368186405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1202176584368186405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1202176584368186405==--


