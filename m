Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1S8a2k-0002Rp-Ku
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 16:30:18 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S8a2e-0001Q0-Ts
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 16:30:18 +0000
In-Reply-To: <20120316141906.GB2897@peqn>
References: <OFEC1872A7.8CB8CA8C-ON652579C3.004D1716-652579C3.004DAE00@in.ibm.com>
	<20120316141906.GB2897@peqn>
MIME-Version: 1.0
Message-ID: <OFCE0DCA3A.339E9729-ON652579C3.00562D02-652579C3.0057D91F@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Fri, 16 Mar 2012 21:29:32 +0530
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
Content-Type: multipart/mixed; boundary="===============7057087913336177968=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>

This is a multipart message in MIME format.
--===============7057087913336177968==
Content-Type: multipart/alternative;
	boundary="=_alternative 0057D91D652579C3_="

This is a multipart message in MIME format.
--=_alternative 0057D91D652579C3_=
Content-Type: text/plain; charset="US-ASCII"

Thanks Serge for a quick reply. Can you share git url which I can clone, I 
am getting following error
git clone 
git://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=tree
Cloning into selinux-testsuite...
fatal: The remote end hung up unexpectedly

Regards
Poornima




Serge Hallyn <serge.hallyn@canonical.com> 
03/16/2012 07:49 PM

To
Poornima Nayak/India/IBM@IBMIN
cc
Stephen Smalley <sds@tycho.nsa.gov>, ltp-list <ltp-list@lists.sf.net>, 
James Morris <jmorris@namei.org>
Subject
Re: Are you still maintaining Selinux testsuite






Quoting Poornima Nayak (Poornima.Nayak@in.ibm.com):
> Hi Serge
> 
> I was looking out for selinux test suite after the call was taken to 
move 
> it out of LTP. Latest discussion is this 
> http://permalink.gmane.org/gmane.linux.ltp/15301. Any progress beyond 
this 
> ?

Hi Poornima,

yes, I'm sorry it's taken this long, but I finally got a copy up at:

http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary


Thanks James for the account, and Stephen for the copy of the git tree.

Now I should get back to getting this to pass on Ubuntu - unfortunately
the changes I"d been staging for that were the victim of a hard drive
crash.

-serge



--=_alternative 0057D91D652579C3_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks Serge for a quick reply. Can you
share git url which I can clone, I am getting following error</font>
<br><font size=2 face="sans-serif">git clone git://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=tree</font>
<br><font size=2 face="sans-serif">Cloning into selinux-testsuite...</font>
<br><font size=2 face="sans-serif">fatal: The remote end hung up unexpectedly</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br><font size=2 face="sans-serif">Poornima</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Serge Hallyn &lt;serge.hallyn@canonical.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">03/16/2012 07:49 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Poornima Nayak/India/IBM@IBMIN</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Stephen Smalley &lt;sds@tycho.nsa.gov&gt;,
ltp-list &lt;ltp-list@lists.sf.net&gt;, James Morris &lt;jmorris@namei.org&gt;</font>
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
<br><tt><font size=2>Quoting Poornima Nayak (Poornima.Nayak@in.ibm.com):<br>
&gt; Hi Serge<br>
&gt; <br>
&gt; I was looking out for selinux test suite after the call was taken
to move <br>
&gt; it out of LTP. Latest discussion is this <br>
&gt; </font></tt><a href=http://permalink.gmane.org/gmane.linux.ltp/15301><tt><font size=2>http://permalink.gmane.org/gmane.linux.ltp/15301</font></tt></a><tt><font size=2>.
Any progress beyond this <br>
&gt; ?<br>
<br>
Hi Poornima,<br>
<br>
yes, I'm sorry it's taken this long, but I finally got a copy up at:<br>
<br>
</font></tt><a href="http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary"><tt><font size=2>http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary</font></tt></a><tt><font size=2><br>
<br>
Thanks James for the account, and Stephen for the copy of the git tree.<br>
<br>
Now I should get back to getting this to pass on Ubuntu - unfortunately<br>
the changes I&quot;d been staging for that were the victim of a hard drive<br>
crash.<br>
<br>
-serge<br>
<br>
</font></tt>
<br>
--=_alternative 0057D91D652579C3_=--



--===============7057087913336177968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============7057087913336177968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7057087913336177968==--


