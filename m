Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PDh28-0007MW-5t
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 17:22:00 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDh27-0007Wm-1J
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 17:22:00 +0000
Received: by wwb31 with SMTP id 31so869640wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Nov 2010 10:21:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CD1952A.2000604@linux.vnet.ibm.com>
References: <4CD1952A.2000604@linux.vnet.ibm.com>
Date: Wed, 3 Nov 2010 10:21:52 -0700
Message-ID: <AANLkTimc93rVnn6XY=yB3HN_SectB-jORgSG__2_2AY5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Fwd: Query regarding termination_id=4 in LTP.]
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1274232594904025217=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--===============1274232594904025217==
Content-Type: multipart/alternative; boundary=0016364c7576fc250c0494294675

--0016364c7576fc250c0494294675
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Nov 3, 2010 at 10:00 AM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

>  FYI...!!
>
> -------- Original Message --------  Subject: Query regarding
> termination_id=4 in LTP.  Date: Wed, 3 Nov 2010 12:08:56 +0530  From:
> naren.mehra@gmail.com  To: manojo@austin.ibm.com  CC:
> subrata@linux.vnet.ibm.com
>
> Hi,
>
> I am not sure whom to ask this question so putting it here.
> I am trying to run LTP on my arm based board and in some of the tests like
> shm_test01 and mtest05
> I am getting termination_id=4.
>
> So, I am stuck as theres no other information as to why these 2 tests failed.
> Could you help me out and tell me what does "termination_id=4" suggests ??
>
> Log Snippet:
> 1) shm_test01 :
> <<<test_start>>>
> tag=stime=3934
> cmdline="shm_test -l 10 -t 2"
> contacts=""
> analysis=exit
> <<<test_output>>>
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=signaled termination_id=4 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
>
> 2) mtest05
> <<<test_start>>>
> tag=mtest05 stime=3930
> cmdline="  mmstress"
> contacts=""
> analysis=exit
> <<<test_output>>>
> mmstress    0  TINFO  :  run mmstress -h for all options
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=signaled termination_id=4 corefile=no
> cutime=0 cstime=0
> <<<test_end>>
>
>
    No idea (could have exited with signal = 4, which is SIGILL, but I'm
looking at the BSD signals manpage). This could suggest a number of issues
with how the tests are being executed on the board. strace'ing the tests and
providing the board details would be a helpful start -- otherwise we can't
help the end-user.
Thanks,
-Garrett

--0016364c7576fc250c0494294675
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Nov 3, 2010 at 10:00 AM, Subrata Modak <=
span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com">subrata@=
linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204,=
 204); padding-left: 1ex;">




<div bgcolor=3D"#ffffff" text=3D"#000000">
FYI...!!<br>
<br>
-------- Original Message --------
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
  <tbody>
    <tr>
      <th align=3D"right" nowrap valign=3D"baseline">Subject: </th>
      <td>Query regarding termination_id=3D4 in LTP.</td>
    </tr>
    <tr>
      <th align=3D"right" nowrap valign=3D"baseline">Date: </th>
      <td>Wed, 3 Nov 2010 12:08:56 +0530</td>
    </tr>
    <tr>
      <th align=3D"right" nowrap valign=3D"baseline">From: </th>
      <td><a href=3D"mailto:naren.mehra@gmail.com" target=3D"_blank">naren.=
mehra@gmail.com</a></td>
    </tr>
    <tr>
      <th align=3D"right" nowrap valign=3D"baseline">To: </th>
      <td><a href=3D"mailto:manojo@austin.ibm.com" target=3D"_blank">manojo=
@austin.ibm.com</a></td>
    </tr>
    <tr>
      <th align=3D"right" nowrap valign=3D"baseline">CC: </th>
      <td><a href=3D"mailto:subrata@linux.vnet.ibm.com" target=3D"_blank">s=
ubrata@linux.vnet.ibm.com</a></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<pre>Hi,

I am not sure whom to ask this question so putting it here.
I am trying to run LTP on my arm based board and in some of the tests like
shm_test01 and mtest05
I am getting termination_id=3D4.

So, I am stuck as theres no other information as to why these 2 tests faile=
d.
Could you help me out and tell me what does &quot;termination_id=3D4&quot; =
suggests ??

Log Snippet:
1) shm_test01 :
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=3Dstime=3D3934
cmdline=3D&quot;shm_test -l 10 -t 2&quot;
contacts=3D&quot;&quot;
analysis=3Dexit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status=3D&quot;ok&quot;
duration=3D1 termination_type=3Dsignaled termination_id=3D4 corefile=3Dno
cutime=3D0 cstime=3D0
&lt;&lt;&lt;test_end&gt;&gt;&gt;

2) mtest05
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=3Dmtest05 stime=3D3930
cmdline=3D&quot;  mmstress&quot;
contacts=3D&quot;&quot;
analysis=3Dexit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
mmstress    0  TINFO  :  run mmstress -h for all options
&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status=3D&quot;ok&quot;
duration=3D0 termination_type=3Dsignaled termination_id=3D4 corefile=3Dno
cutime=3D0 cstime=3D0
&lt;&lt;&lt;test_end&gt;&gt;<br></pre></div></blockquote><div><br>=A0=A0=A0=
 No idea (could have exited with signal =3D 4, which is SIGILL, but I&#39;m=
 looking at the BSD signals manpage). This could suggest a number of issues=
 with how the tests are being executed on the board. strace&#39;ing the tes=
ts and providing the board details would be a helpful start -- otherwise we=
 can&#39;t help the end-user.<br>
Thanks,<br>-Garrett<br></div></div>

--0016364c7576fc250c0494294675--


--===============1274232594904025217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve Improved Network Security with IP and DNS Reputation.
Defend against bad network traffic, including botnets, malware, 
phishing sites, and compromised hosts - saving your company time, 
money, and embarrassment.   Learn More! 
http://p.sf.net/sfu/hpdev2dev-nov
--===============1274232594904025217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1274232594904025217==--

