Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1S8ZvS-0004DU-Al
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 16:22:46 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S8ZvO-0006Kq-0O
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 16:22:46 +0000
In-Reply-To: <1331914399.22861.38.camel@moss-pluto>
References: <OFEC1872A7.8CB8CA8C-ON652579C3.004D1716-652579C3.004DAE00@in.ibm.com>	
	<20120316141906.GB2897@peqn>
	<OFCE0DCA3A.339E9729-ON652579C3.00562D02-652579C3.0057D91F@in.ibm.com>
	<1331914399.22861.38.camel@moss-pluto>
MIME-Version: 1.0
Message-ID: <OF8DABE602.1AF53C92-ON652579C3.0059EC21-652579C3.0059F2F1@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Fri, 16 Mar 2012 21:52:28 +0530
Subject: Re: [LTP] Are you still maintaining Selinux testsuite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8693688866332432555=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@namei.org>

This is a multipart message in MIME format.
--===============8693688866332432555==
Content-Type: multipart/alternative;
	boundary="=_alternative 0059F2EF652579C3_="

This is a multipart message in MIME format.
--=_alternative 0059F2EF652579C3_=
Content-Type: text/plain; charset="US-ASCII"

Thanks a lot. It worked.

Regards
Poornima



Stephen Smalley <sds@tycho.nsa.gov> 
03/16/2012 09:43 PM

To
Poornima Nayak/India/IBM@IBMIN
cc
Serge Hallyn <serge.hallyn@canonical.com>, James Morris 
<jmorris@namei.org>, ltp-list <ltp-list@lists.sf.net>
Subject
Re: Are you still maintaining Selinux testsuite






On Fri, 2012-03-16 at 21:29 +0530, Poornima Nayak wrote:
> Thanks Serge for a quick reply. Can you share git url which I can
> clone, I am getting following error 
> git clone
> 
git://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=tree 

> Cloning into selinux-testsuite... 
> fatal: The remote end hung up unexpectedly 

git clone git://git.selinuxproject.org/~serge/selinux-testsuite

-- 
Stephen Smalley
National Security Agency



--=_alternative 0059F2EF652579C3_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks a lot. It worked.</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br><font size=2 face="sans-serif">Poornima</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Stephen Smalley &lt;sds@tycho.nsa.gov&gt;</b>
</font>
<p><font size=1 face="sans-serif">03/16/2012 09:43 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Poornima Nayak/India/IBM@IBMIN</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Serge Hallyn &lt;serge.hallyn@canonical.com&gt;,
James Morris &lt;jmorris@namei.org&gt;, ltp-list &lt;ltp-list@lists.sf.net&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: Are you still maintaining Selinux
testsuite</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Fri, 2012-03-16 at 21:29 +0530, Poornima Nayak
wrote:<br>
&gt; Thanks Serge for a quick reply. Can you share git url which I can<br>
&gt; clone, I am getting following error <br>
&gt; git clone<br>
&gt; git://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=tree
<br>
&gt; Cloning into selinux-testsuite... <br>
&gt; fatal: The remote end hung up unexpectedly <br>
<br>
git clone git://git.selinuxproject.org/~serge/selinux-testsuite<br>
<br>
-- <br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></tt>
<br>
--=_alternative 0059F2EF652579C3_=--



--===============8693688866332432555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============8693688866332432555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8693688866332432555==--


