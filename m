Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <iranna.ankad@in.ibm.com>) id 1PGSpw-0006hP-78
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:48:52 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGSpu-0003yp-4e
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:48:52 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id oAB8IvHa004998
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 13:48:57 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB8mfVm1110142
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 14:18:41 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAB8mf32009555
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 19:48:41 +1100
In-Reply-To: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-ID: <OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@in.ibm.com>
From: Iranna D Ankad <iranna.ankad@in.ibm.com>
Date: Thu, 11 Nov 2010 14:17:52 +0530
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3373098944048284966=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com, yanegomi@gmail.com, shubgoya@in.ibm.com
Cc: LTP list <ltp-list@lists.sourceforge.net>, takahash <takahash@us.ibm.com>

This is a multipart message in MIME format.
--===============3373098944048284966==
Content-Type: multipart/alternative;
	boundary="=_alternative 003066F0652577D8_="

This is a multipart message in MIME format.
--=_alternative 003066F0652577D8_=
Content-Type: text/plain; charset="US-ASCII"

Oh yes, IBM (especially SystemX team) still uses pounder for distro 
validation. The thing is we use couple of other customized pounder scripts 
in addition to the ones present in the LTP's "pounder21" directory, so 
that dependent config files are downloaded & logs are saved from/to our 
repo server. Having said that, we still require LTP's "pounder21" tree. So 
please DO NOT remove it.

However, I agree that current pounder of LTP has some compatibility 
issues, thereby making it difficult to run independently on a stand alone 
system. This needs to be addressed and is in TODO list of our new pounder 
maintainer "Shubham Goyal (shubgoya@in.ibm.com)". 

@Shubham, any comments?

Thanks!
-Iranna D Ankad
----------------------------------------------------------------------------------------------------
Linux-Technology Center, IBM India Software Labs
Manyata Embassy Park, BENGALURU - 560045,
Ph: +91-080-28055007   Extn: 55007
----------------------------------------------------------------------------------------------------
"If you don't have patience to test the software, the software will test 
your patience !!"



Subrata Modak <subrata@linux.vnet.ibm.com> 
11/11/10 12:27 PM
Please respond to
subrata@linux.vnet.ibm.com


To
Garrett Cooper <yanegomi@gmail.com>, Iranna D Ankad/India/IBM@IBMIN
cc
Murlin Wenzel <mwenzel@novell.com>, LTP list 
<ltp-list@lists.sourceforge.net>, takahash <takahash@us.ibm.com>
Subject
Re: [LTP] [RFC] Remove testcases/pounder21






On Wed, 2010-11-10 at 16:54 -0800, Garrett Cooper wrote:
> On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com> 
wrote:
> >>>> On 11/10/2010 at 01:28 PM, in message
> > <AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>, 
Garrett Cooper
> > <yanegomi@gmail.com> wrote:
> >> On Mon, Nov 8, 2010 at 1:57 PM, Garrett Cooper <yanegomi@gmail.com> 
wrote:
> >>>    Hasn't compiled for a while, and looks pretty broken. If no one
> >>> objects to me removing it in 3 days I'll get rid of it.
> >>
> >> (retroactively as of yesterday)
> >> Going twice...
> >
> > I thought this was still being used by IBM in particular.  I know for 
a fact it has multiple issues with file versions, missing/changed updates 
etc.  Are you talking about removing the whole pounder tree?
> 
> Answering my own question:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html
> , I asked this earlier on this year and someone replied saying "don't
> remove it". If it's not removed and serves a particular purpose, maybe
> it should be moved to a different section of the tree to avoid
> confusion in the future (in particular if it's a framework and not
> actually a test / test suite).

IBM still uses Pounder heavily for testing Distros. So, we can move it
to some other portion of the tree but still should be inside LTP.

Regards--
Subrata

> Thanks!
> -Garrett
> 
> 
------------------------------------------------------------------------------
> Centralized Desktop Delivery: Dell and VMware Reference Architecture
> Simplifying enterprise desktop deployment and management using
> Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
> client virtualization framework. Read more!
> http://p.sf.net/sfu/dell-eql-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



--=_alternative 003066F0652577D8_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Oh yes, IBM (especially SystemX team)
still uses pounder for distro validation. The thing is we use couple of
other customized pounder scripts in addition to the ones present in the
LTP's &quot;pounder21&quot; directory, so that dependent config files are
downloaded &amp; logs are saved from/to our repo server. Having said that,
we still require LTP's &quot;pounder21&quot; tree. So please DO NOT remove
it.</font>
<br>
<br><font size=2 face="sans-serif">However, I agree that current pounder
of LTP has some compatibility issues, thereby making it difficult to run
independently on a stand alone system. This needs to be addressed and is
in TODO list of our new pounder maintainer &quot;Shubham Goyal (shubgoya@in.ibm.com)&quot;.
</font>
<br>
<br><font size=2 face="sans-serif">@Shubham, any comments?</font>
<br>
<br><font size=2 face="sans-serif">Thanks!</font>
<br><font size=2 face="sans-serif">-Iranna D Ankad<br>
----------------------------------------------------------------------------------------------------<br>
Linux-Technology Center, IBM India Software Labs<br>
Manyata Embassy Park, BENGALURU - 560045,<br>
Ph: +91-080-28055007 &nbsp; Extn: 55007<br>
----------------------------------------------------------------------------------------------------<br>
&quot;If you don't have patience to test the software, the software will
test your patience !!&quot;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Subrata Modak &lt;subrata@linux.vnet.ibm.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">11/11/10 12:27 PM</font>
<table border>
<tr valign=top>
<td bgcolor=white>
<div align=center><font size=1 face="sans-serif">Please respond to<br>
subrata@linux.vnet.ibm.com</font></div></table>
<br>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Garrett Cooper &lt;yanegomi@gmail.com&gt;,
Iranna D Ankad/India/IBM@IBMIN</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Murlin Wenzel &lt;mwenzel@novell.com&gt;,
LTP list &lt;ltp-list@lists.sourceforge.net&gt;, takahash &lt;takahash@us.ibm.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [LTP] [RFC] Remove testcases/pounder21</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Wed, 2010-11-10 at 16:54 -0800, Garrett Cooper
wrote:<br>
&gt; On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel &lt;mwenzel@novell.com&gt;
wrote:<br>
&gt; &gt;&gt;&gt;&gt; On 11/10/2010 at 01:28 PM, in message<br>
&gt; &gt; &lt;AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com&gt;,
Garrett Cooper<br>
&gt; &gt; &lt;yanegomi@gmail.com&gt; wrote:<br>
&gt; &gt;&gt; On Mon, Nov 8, 2010 at 1:57 PM, Garrett Cooper &lt;yanegomi@gmail.com&gt;
wrote:<br>
&gt; &gt;&gt;&gt; &nbsp; &nbsp;Hasn't compiled for a while, and looks pretty
broken. If no one<br>
&gt; &gt;&gt;&gt; objects to me removing it in 3 days I'll get rid of it.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; (retroactively as of yesterday)<br>
&gt; &gt;&gt; Going twice...<br>
&gt; &gt;<br>
&gt; &gt; I thought this was still being used by IBM in particular. &nbsp;I
know for a fact it has multiple issues with file versions, missing/changed
updates etc. &nbsp;Are you talking about removing the whole pounder tree?<br>
&gt; <br>
&gt; Answering my own question:<br>
&gt; http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html<br>
&gt; , I asked this earlier on this year and someone replied saying &quot;don't<br>
&gt; remove it&quot;. If it's not removed and serves a particular purpose,
maybe<br>
&gt; it should be moved to a different section of the tree to avoid<br>
&gt; confusion in the future (in particular if it's a framework and not<br>
&gt; actually a test / test suite).<br>
<br>
IBM still uses Pounder heavily for testing Distros. So, we can move it<br>
to some other portion of the tree but still should be inside LTP.<br>
<br>
Regards--<br>
Subrata<br>
<br>
&gt; Thanks!<br>
&gt; -Garrett<br>
&gt; <br>
&gt; ------------------------------------------------------------------------------<br>
&gt; Centralized Desktop Delivery: Dell and VMware Reference Architecture<br>
&gt; Simplifying enterprise desktop deployment and management using<br>
&gt; Dell EqualLogic storage and VMware View: A highly scalable, end-to-end<br>
&gt; client virtualization framework. Read more!<br>
&gt; http://p.sf.net/sfu/dell-eql-dev2dev<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; Ltp-list@lists.sourceforge.net<br>
&gt; https://lists.sourceforge.net/lists/listinfo/ltp-list<br>
<br>
</font></tt>
<br>
--=_alternative 003066F0652577D8_=--


--===============3373098944048284966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
--===============3373098944048284966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3373098944048284966==--

