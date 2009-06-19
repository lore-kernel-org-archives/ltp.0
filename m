Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MHa0O-0002eZ-AS
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 09:03:28 +0000
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHa0K-0001nY-CB
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 09:03:28 +0000
Message-ID: <4A3B542E.708@st.com>
Date: Fri, 19 Jun 2009 11:02:38 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>	
	<4A3A049B.2000002@st.com>
	<f5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com>
In-Reply-To: <f5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------010701070805080003070103"
Subject: Re: [LTP] [FIX HTML PATCH] ltp-genhtml
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

This is a multi-part message in MIME format.
--------------010701070805080003070103
Content-Type: multipart/alternative;
	boundary="------------090709020102090803050407"


--------------090709020102090803050407
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

thanks for your reply. Below some considerations:

naresh kamboju wrote:

>Hi Francesco,
>
> =20
>
>>In fact, in case the results of LTP session was related to cross-executio=
n, the >infiormation about KERNEL_VERSION and MACHINE_ARCHITECTURE have to =
>be referred to the target and not to the host. Do you agree ?
>>   =20
>>
>Yes.
>I agree with you.
>I have been using LTP for Target Board executions not on Host Machine.
>As per my understating KERNEL_VERSION and MACHINE_ARCHITECTURE are
>should come from env right?
>
Yes.


>But I could not print these variables in HTML file.
>

Why not ?
By means of (before to run genhtml.pl on the HOST):
export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"
export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"
you will be able to export on the final HTML file the info contained in=20
the above env variables.
The attached HTML log shows a typical summary (I report only subset of=20
info related to the env variables).

>Please refer the results published in LTP download page for 31-May-2009 re=
lease.
>http://sourceforge.net/project/platformdownload.php?group_id=3D3382
>
>
>LTP Results:
>
>ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-ppc64.tgz
>ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-x86_64.tgz
>ltp-full-20090531_results_kernel-2.6.18-128.el5PAE_architecture-i386.tgz
>ltp-full-20090531_results_kernel-2.6.23.13_architecture-ia64.tgz
>ltp-full-20090531_results_kernel-2.6.27.19-5-default_architecture-i386.tgz
>
>None of the above results got printed these two KERNEL_VERSION and
>MACHINE_ARCHITECTURE variables in HTML.
>

Probably because they haven't been defined the env variables.

>
>
> =20
>
>>With your fix, by using "uname -r" and "uname -m", to avoid to report wro=
ng >information, you have to run the "genhtml.pl" script over the target sy=
stem because if >you run the genhtml.pl on the host, you will get wrong inf=
ormation about the kernel >version and machine architecture.
>>   =20
>>
>No.
>As per my understanding to make generic script =93uname -r" and "uname
>-m" are best way of use. All the target Machines are wont have full
>=93env=94 support to extract KERNEL_VERSION and MACHINE_ARCHITECTURE info.
>Ofcourse my target Machine can not extract these variables.
>

No env variables have to be processed in the target. The env variables=20
will be used on the HOST execution of genthml.pl.

>
>"uname -r" and "uname -m" are from target not from Host I guess.
>Because runltp script will runs on target so obviously genhtml.pl will
>run when =96g option is  specified. =93 #sh runltp =96g
>ltp-full-results-file.html=94
> =20
>
>>Moreover, the assumption to run genhtml.pl over the target is not safe as=
 often the target >systems are embedded systems which do not support PERL.
>>   =20
>>
>
>Yes. That is true.
>When we run runltp with =96g option to create HTML file the person using
>this option should have knowledge that this script will use PERL
>script if there is no PERL no HTML file will generate right?
> =20
>

No, with the usage of env variables on the "genhtml.pl", you can have=20
HTML file even though PERL is not supported on your target. This is an=20
advantage!

Moreover, you can manage and process "off-line" LTP report without=20
having the risk to add in the report HOST information instead of TARGET=20
ones.

> =20
>
>>With the fix I've proposed and accepted, the LTP-user by means of the sim=
ple env >variables, can define the right information to be reported on the =
LTP results table about >kernel version and machine architecture.
>>   =20
>>
>I have attached my HTML output file after and before patch.
>Please share your commands for ltp executions and results HTML file
>and other files.
>Before and after your patch.
>
The steps I follow are simply:

1) runltp >> LTP.log (run on the TARGET platform);

2)  export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"
     export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"
     ...................... (run on the HOST platform)

3) genhtml.pl LTP.log LTP.html (run on the HOST platform);

In this way I avoid to make assumptions about TARGET requirements (PERL,=20
HTML, etc...).

The piece of attached LTP-log.html shows what I got.

I confirm my opinion to keep the current policy to generate HTML summary=20
info.

Best Regards,
FR



--------------090709020102090803050407
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv=3D"Content-Type"
 content=3D"text/html;charset=3Dwindows-1252">
  <title></title>
</head>
<body text=3D"#000000" bgcolor=3D"#ffffff">
Hi Naresh,<br>
<br>
thanks for your reply. Below some considerations:<br>
<br>
naresh kamboju wrote:<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">Hi Francesco,

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">In fact, in case the results of LTP session was related =
to cross-execution, the &gt;infiormation about KERNEL_VERSION and MACHINE_A=
RCHITECTURE have to &gt;be referred to the target and not to the host. Do y=
ou agree ?
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->Yes.
I agree with you.
I have been using LTP for Target Board executions not on Host Machine.
As per my understating KERNEL_VERSION and MACHINE_ARCHITECTURE are
should come from env right?</pre>
</blockquote>
Yes.<br>
<br>
<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">
But I could not print these variables in HTML file.</pre>
</blockquote>
<br>
Why not ?<br>
By means of (before to run genhtml.pl on the HOST):<br>
export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"<br>
export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"<br>
you will be able to export on the final HTML file the info contained in
the above env variables. <br>
The attached HTML log shows a typical summary (I report only subset of
info related to the env variables).<br>
<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">
Please refer the results published in LTP download page for 31-May-2009 rel=
ease.
<a class=3D"moz-txt-link-freetext" href=3D"http://sourceforge.net/project/p=
latformdownload.php?group_id=3D3382">http://sourceforge.net/project/platfor=
mdownload.php?group_id=3D3382</a>


LTP Results:

ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-ppc64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-x86_64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5PAE_architecture-i386.tgz
ltp-full-20090531_results_kernel-2.6.23.13_architecture-ia64.tgz
ltp-full-20090531_results_kernel-2.6.27.19-5-default_architecture-i386.tgz

None of the above results got printed these two KERNEL_VERSION and
MACHINE_ARCHITECTURE variables in HTML.</pre>
</blockquote>
<br>
Probably because they haven't been defined the env variables.<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">


  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">With your fix, by using "uname -r" and "uname -m", to av=
oid to report wrong &gt;information, you have to run the "genhtml.pl" scrip=
t over the target system because if &gt;you run the genhtml.pl on the host,=
 you will get wrong information about the kernel &gt;version and machine ar=
chitecture.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->No.
As per my understanding to make generic script =93uname -r" and "uname
-m" are best way of use. All the target Machines are wont have full
=93env=94 support to extract KERNEL_VERSION and MACHINE_ARCHITECTURE info.
Ofcourse my target Machine can not extract these variables.</pre>
</blockquote>
<br>
No env variables have to be processed in the target. The env variables
will be used on the HOST execution of genthml.pl.<br>
<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">

"uname -r" and "uname -m" are from target not from Host I guess.
Because runltp script will runs on target so obviously genhtml.pl will
run when =96g option is  specified. =93 #sh runltp =96g
ltp-full-results-file.html=94
  </pre>
</blockquote>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <blockquote type=3D"cite">
    <pre wrap=3D"">Moreover, the assumption to run genhtml.pl over the targ=
et is not safe as often the target &gt;systems are embedded systems which d=
o not support PERL.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Yes. That is true.
When we run runltp with =96g option to create HTML file the person using
this option should have knowledge that this script will use PERL
script if there is no PERL no HTML file will generate right?
  </pre>
</blockquote>
<br>
No, with the usage of env variables on the "genhtml.pl", you can have
HTML file even though PERL is not supported on your target. This is an
advantage!<br>
<br>
Moreover, you can manage and process "off-line" LTP report without
having the risk to add in the report HOST information instead of TARGET
ones.<br>
<br>
<blockquote type=3D"cite"
 cite=3D"midf5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com">
  <pre wrap=3D"">
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">With the fix I've proposed and accepted, the LTP-user by=
 means of the simple env &gt;variables, can define the right information to=
 be reported on the LTP results table about &gt;kernel version and machine =
architecture.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->I have attached my HTML output file after and befor=
e patch.
Please share your commands for ltp executions and results HTML file
and other files.
Before and after your patch.</pre>
</blockquote>
The steps I follow are simply:<br>
<br>
1) runltp &gt;&gt; LTP.log (run on the TARGET platform);<br>
<br>
2)=A0 export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"<br>
=A0=A0=A0=A0 export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"<br>
=A0 =A0=A0 ...................... (run on the HOST platform)<br>
<br>
3) genhtml.pl LTP.log LTP.html (run on the HOST platform);<br>
<br>
In this way I avoid to make assumptions about TARGET requirements
(PERL, HTML, etc...).<br>
<br>
The piece of attached LTP-log.html shows what I got.<br>
<br>
I confirm my opinion to keep the current policy to generate HTML
summary info.<br>
<br>
Best Regards,<br>
FR<br>
<br>
<br>
</body>
</html>

--------------090709020102090803050407--

--------------010701070805080003070103
Content-Type: text/html;
 name="LTP-log.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="LTP-log.html"

<h2 id="_2">Summary Report</h2>

<div>

<table border="1" cellspacing="3"><tbody>
<tr>
<td bgcolor="#66ff66"> <strong>Test Summary</strong></p></td><td bgcolor="#66ff66"><strong>Pan reported all Test Pass</strong></p></td></tr>
<tr><td><strong>LTP Version</strong> </td><td><strong> ltp-full-20090430     </strong></td></tr>
<tr><td><strong>Start Time</strong>  </td><td><strong> Fri May 22, 2009 - 2.44 pm </strong></td></tr>
<tr><td><strong>End Time</strong>    </td><td><strong> Fri May 22, 2009 - 2.44 pm   </strong></td></tr>
<tr><td><strong>Log Result</strong>  </td><td><a href="http://www.stlinux.com/drupal/">      <strong>http://www.stlinux.com/drupal/</strong></a></td></tr>
<tr><td><strong>Output/Failed Result</strong></td><td><a href="http://www.stlinux.com/drupal/"> <strong>http://www.stlinux.com/drupal/</strong></a></td></tr>
<tr><td><strong>Total Tests</strong></td><td><strong>                        </strong></td></tr>
<tr><td><strong>Total Test TPASS:</strong></td><td><strong>  </strong></td></tr>
<tr><td><strong>Total Test TFAIL:</strong></td><td><strong>  </strong></td></tr>
<tr><td><strong>Total Test TBROK</strong></td><td><strong>  </strong></td></tr>
<tr><td><strong>Total Test TWARN</strong></td><td><strong>  </strong></td></tr>
<tr><td><strong>Total Test TRETR</strong></td><td><strong>  </strong></td></tr>
<tr><td><strong>Total Test TCONF</strong></td><td><strong> 7 </strong></td></tr>
<tr><td><strong>Kernel Version</strong></td><td><strong> linux-sh4-2.6.23_stm23_120  </strong></td></tr>
<tr><td><strong>Machine Architecture</strong></td><td><strong> SuperH(SH) - STBi7100c3 reference board -mb442- </strong></td></tr>
<tr><td><strong>Hostname</strong>  </td> <td><strong>STSLX02
  </strong></td></tr>
<br>
<li><a href="#_1">Click Here for Detailed Report</a></li>
<br>
</tbody></table></div></body></html>

--------------010701070805080003070103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--------------010701070805080003070103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010701070805080003070103--


