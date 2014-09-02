Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1XOuE9-0007K0-4A
	for ltp-list@lists.sourceforge.net; Tue, 02 Sep 2014 19:58:53 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XOuE7-0001sF-8o
	for ltp-list@lists.sourceforge.net; Tue, 02 Sep 2014 19:58:53 +0000
Received: by mail-wi0-f178.google.com with SMTP id r20so8586908wiv.5
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Sep 2014 12:58:45 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 2 Sep 2014 14:58:44 -0500
Message-ID: <CAF7YWnxMVXpKKTbB3B4Sjqwp5K=u543PVbUBEy6jFGeq6YWkVw@mail.gmail.com>
From: Gary Robertson <gary.robertson@linaro.org>
Subject: [LTP] [RFC] Realtime tests - autoconf problems in OpenEmbedded
 cross-build environment
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6609707873396499849=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Mike Holmes <mike.holmes@linaro.org>

--===============6609707873396499849==
Content-Type: multipart/alternative; boundary=001a11c238c003fb1b05021a8caf

--001a11c238c003fb1b05021a8caf
Content-Type: text/plain; charset=UTF-8

LTP developers,

The autoconf scripts in 'ltp/testcases/realtime/m4/check.m4' evaluate
whether priority-inheriting mutexes and robust mutexes are supported on the
system for which the LTP realtime tests are being targeted.  Portions of
the LTP realtime test code required to test these features on the target
are then conditionally included or excluded at compile time based on
autoconf results.

To check these features, the autoconf scripts attempt to compile and then
execute initialization functions which rely on the features.  Is this done
because the mere presence of the appropriate headers and protocol value
definitions, etc. is insufficient proof that the features are supported?
That is, are there cases in which the headers may contain the associated
definitions but the installed runtime libraries lack the actual support
code for the features?:

The reason I ask is that in the OpenEmbedded cross-build environment, all
code is theoretically cross-compiled for the build target system.  When the
autoconf scripts subsequently attempt to execute the compiled code on the
cross-development host, the execution fails.  Even if the code were to be
compiled for the cross-development host and successfully executed, the
results would be misleading as they represent feature support on the
development host rather than on the test target system.

Without knowing the history of configuration issues in LTP I don't know
what conflicts may exist between the support for cross-build environments
and the reliable configuration of features in a wide variety of
native-build scenarios.

If autoconf in LTP must rely on the execution of target system code in
order to determine what features are supported on the target, then some
sort of override is needed in cross-build environments... so my question
is: what is the preferred method for handling this?

Possible solutions under consideration include:


   - adding command line options to be passed to the 'configure' script in
   order to force inclusion of support for the features in question without
   performing any tests, -or-
   - adding local patches to the bitbake recipe for LTP which would
   unconditionally patch either  the autoconf input files or the output of
   autoconf operations in order to force support for the features in
   question... and making no changes at the LTP level to address the problem.

If command line override options are the preferable solution, I notice
there are both '--with...' and '--enable...' options defined - but which
would be the more appropriate prefix for these new options?

OTOH, if the presence of the associated protocol name definitions, etc. in
the target system's header files is a sufficient indication of support,
could we just dispense with the execution of compiled target code and
configure support for the features based on the header contents alone?

I will be looking forward to your comments in order to determine the most
effective and/or least offensive means of addressing this problem.

Gary Robertson

--001a11c238c003fb1b05021a8caf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>LTP developers,<br><br></div>The =
autoconf scripts in &#39;ltp/testcases/realtime/m4/check.m4&#39; evaluate w=
hether priority-inheriting mutexes and robust mutexes are supported on the =
system for which the LTP realtime tests are being targeted.=C2=A0 Portions =
of the LTP realtime test code required to test these features on the target=
 are then conditionally included or excluded at compile time based on autoc=
onf results.<br>
<br></div>To check these features, the autoconf scripts attempt to compile =
and then execute initialization functions which rely on the features.=C2=A0=
 Is this done because the mere presence of the appropriate headers and prot=
ocol value definitions, etc. is insufficient proof that the features are su=
pported?=C2=A0 That is, are there cases in which the headers may contain th=
e associated definitions but the installed runtime libraries lack the actua=
l support code for the features?:<br>
<br></div>The reason I ask is that in the OpenEmbedded cross-build environm=
ent, all code is theoretically cross-compiled for the build target system.=
=C2=A0 When the autoconf scripts subsequently attempt to execute the compil=
ed code on the cross-development host, the execution fails.=C2=A0 Even if t=
he code were to be compiled for the cross-development host and successfully=
 executed, the results would be misleading as they represent feature suppor=
t on the development host rather than on the test target system.<br>
<br></div><div>Without knowing the history of configuration issues in LTP I=
 don&#39;t know what conflicts may exist between the support for cross-buil=
d environments and the reliable configuration of features in a wide variety=
 of native-build scenarios.<br>
</div><div><br></div>If autoconf in LTP must rely on the execution of targe=
t system code in order to determine what features are supported on the targ=
et, then some sort of override is needed in cross-build environments... so =
my question is: what is the preferred method for handling this?<br>
<br></div>Possible solutions under consideration include:<br><br><ul><li>ad=
ding command line options to be passed to the &#39;configure&#39; script in=
 order to force inclusion of support for the features in question without p=
erforming any tests, -or-</li>
<li>adding local patches to the bitbake recipe for LTP which would uncondit=
ionally patch either=C2=A0 the autoconf input files or the output of autoco=
nf operations in order to force support for the features in question... and=
 making no changes at the LTP level to address the problem.</li>
</ul><p>If command line override options are the preferable solution, I not=
ice there are both &#39;--with...&#39; and &#39;--enable...&#39; options de=
fined - but which would be the more appropriate prefix for these new option=
s?</p>
<p></p><p>OTOH, if the presence of the associated protocol name definitions=
, etc. in the target system&#39;s header files is a sufficient indication o=
f support, could we just dispense with the execution of compiled target cod=
e and configure support for the features based on the header contents alone=
?</p>
<p>I will be looking forward to your comments in order to determine the mos=
t effective and/or least offensive means of addressing this problem.</p><p>=
Gary Robertson</p><p><br></p></div>

--001a11c238c003fb1b05021a8caf--


--===============6609707873396499849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
--===============6609707873396499849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6609707873396499849==--

