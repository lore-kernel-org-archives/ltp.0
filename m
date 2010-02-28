Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nlg7z-0007Bq-EI
	for ltp-list@lists.sourceforge.net; Sun, 28 Feb 2010 10:11:59 +0000
Received: from mail-px0-f203.google.com ([209.85.216.203])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nlg7x-0006Sl-UF
	for ltp-list@lists.sourceforge.net; Sun, 28 Feb 2010 10:11:58 +0000
Received: by pxi41 with SMTP id 41so514273pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Sun, 28 Feb 2010 02:11:28 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 28 Feb 2010 02:11:21 -0800
Message-ID: <364299f41002280211i5ab0e74dr4d9693ed40f2b4b5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] RFC : refactor LTP execution model
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4748578905264789321=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

--===============4748578905264789321==
Content-Type: multipart/alternative; boundary=000e0cd1aa68b4efed0480a65a76

--000e0cd1aa68b4efed0480a65a76
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

   Currently LTP's execution scripts are split into 5 discrete blocks:

   1. execltp - python wrapper which invokes runltp and processes output to
expedite execution and reporting (provides summary and context for test
PASSes, and all non-PASSes).
   2. runalltests.sh - a semi-dynamic user-customizable execution wrapper
that executes runltp after performing needed setup for each section;
performs needed teardown after each section. Uses a number of scripts inside
testscripts/*.
   3. runltp - the primary end-user execution wrapper on top of ltp-pan.
   4. runltplite.sh - an abbreviated form of runltp (minus the email / html
output driver,
   5. testscripts/* - a number of ad hoc ltp-pan callers.

   If you take a look at the caller hierarchy, it's something similar to the
following:

| execltp |                     | runalltests.sh |
     |                                  |
| runltp  |  | runltplite.sh |  | testscripts/*  |
      \             |                  /
                | pan |

   Now, analyzing the layers in more detail:

   1. runltplite.sh contains the guts of runltp, but isn't maintained as
readily as runltp, thus needed bug fixes or feature enhancements aren't
making it into runltplite.sh as quickly, if at all, and as such there's some
unnecessary code divergence.
   2.  testscripts/* contains a lot of setup and teardown logic that could
be sorted out and properly handled inline before and after the test is
executed, unlike what's available currently.
   3. It would be nice if the commands and blocks of code were modularized,
s.t. outside groups could pre-process and/or post-process the tests to

   My proposal is as follows:

   1. A discrete set of reporting functions should be created (error, info,
warning, etc). This messages should adhere to the following basic paradigm:
       error - always displayed.
       info - only displayed when quiet isn't used.
       warning - only displayed when quiet isn't used.
       That way folks could
   2. runltp be split into discrete functional blocks, as follows:
       i.   Parse core options. Parse any additional options for
functionality like email, HTML output, etc.
       ii.  Prepare the tests based on the runtests files and options passed
in (run valgrind on the tests, etc).
       iii. Basic setup.
       iv.  Execute the tests.
       v.   Basic teardown.
       vi.  Output methods for email, HTML, etc.
   2. The testscripts/* setup and teardown logic be moved to a separate
script, which looks like the following:

<testname>_setup()
{
# Do setup here.
}

<testname>_test()
{
# Execute runtest file via pan.
}

<testname>_teardown()
{
# Do teardown here.
}

    So when runltp is executed, it does something like the following:
    1. source testscript [if it exists].
    2. Change the test ``execution plan'' so that they setup and teardown
inexplicably executed in the following manner (following Java's unit-test
and python unittest):

    Setup the test; if successful, continue on with the test(s) and teardown
at the end.

    The purpose for making this into a script as opposed to any other sort
of metadata, is that anyone executing the tests standalone will only need to
source the script to set everything up, then execute the test itself.
    The only thing that might be a problem is that runtest files are mashed
together if multiple runtest scenario files are specified. This shouldn't be
an issue though if everything is strung together properly via the calls
above (setup, test, teardown).
    Thoughts?
Thanks,
-Garrett

--000e0cd1aa68b4efed0480a65a76
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br> <br>=A0=A0 Currently LTP&#39;s execution scripts are split into=
 5 discrete blocks:<br><br> =A0 =A01. execltp - python wrapper which invoke=
s runltp and processes output to expedite execution and reporting (provides=
 summary and context for test PASSes, and all non-PASSes).<br>

 =A0 =A02. runalltests.sh - a semi-dynamic user-customizable execution wrap=
per that executes runltp after performing needed setup for each section; pe=
rforms needed teardown after each section. Uses a number of scripts inside =
testscripts/*.<br>

 =A0 =A03. runltp - the primary end-user execution wrapper on top of ltp-pa=
n.<br> =A0 =A04. runltplite.sh - an abbreviated form of runltp (minus the e=
mail / html output driver, <br> =A0 =A05. testscripts/* - a number of ad ho=
c ltp-pan callers.<br>

<br> =A0=A0 If you take a look at the caller hierarchy, it&#39;s something =
similar to the following:<br><br><span style=3D"font-family: courier new,mo=
nospace;">| execltp | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | runalltests=
.sh |</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 | =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|</span><br style=3D=
"font-family: courier new,monospace;"><span style=3D"font-family: courier n=
ew,monospace;">| runltp =A0| =A0| runltplite.sh | =A0| testscripts/* =A0|</=
span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;"> =A0 =A0 =A0\ =A0 =A0 =
=A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/</span><br style=3D"f=
ont-family: courier new,monospace;"><span style=3D"font-family: courier new=
,monospace;"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | pan |</span><br>

<br>=A0=A0 Now, analyzing the layers in more detail:<br><br>=A0=A0 1. runlt=
plite.sh contains the guts of runltp, but isn&#39;t maintained as readily a=
s runltp, thus needed bug fixes or feature enhancements aren&#39;t making i=
t into runltplite.sh as quickly, if at all, and as such there&#39;s some un=
necessary code divergence.<br>

 =A0=A0 2.=A0 testscripts/* contains a lot of setup and teardown logic that=
 could be sorted out and properly handled inline before and after the test =
is executed, unlike what&#39;s available currently.<br>=A0=A0 3. It would b=
e nice if the commands and blocks of code were modularized, s.t. outside gr=
oups could pre-process and/or post-process the tests to <br>
<br>=A0=A0 My proposal is as follows:<br>
<br>=A0=A0 1. A discrete set of reporting functions should be created (erro=
r, info, warning, etc). This messages should adhere to the following basic =
paradigm:<br>=A0=A0=A0=A0=A0=A0 error - always displayed.<br>=A0=A0=A0=A0=
=A0=A0 info - only displayed when quiet isn&#39;t used.<br>

=A0=A0=A0=A0=A0=A0 warning - only displayed when quiet isn&#39;t used.<br>=
=A0=A0=A0=A0=A0=A0 That way folks could<br>=A0=A0 2. runltp be split into d=
iscrete functional blocks, as follows:<br>=A0=A0=A0=A0=A0=A0 i.=A0=A0 Parse=
 core options. Parse any additional options for functionality like email, H=
TML output, etc.<br>
=A0=A0=A0=A0=A0=A0 ii.=A0 Prepare the tests based on the runtests files and=
 options passed in (run valgrind on the tests, etc).<br>=A0=A0=A0=A0=A0=A0 =
iii. Basic setup.<br>=A0=A0=A0=A0=A0=A0 iv.=A0 Execute the tests.<br>=A0=A0=
=A0=A0=A0=A0 v. =A0 Basic teardown.<br>
=A0=A0=A0=A0=A0=A0 vi.=A0 Output methods for email, HTML, etc.<br>=A0=A0 2.=
 The testscripts/* setup and teardown logic be moved to a separate script, =
which looks like the following:<br><br>&lt;testname&gt;_setup()<br>{<br># D=
o setup here.<br>
}<br><br>&lt;testname&gt;_test()<br>{<br># Execute runtest file via pan.<br=
>}<br><br>&lt;testname&gt;_teardown()<br>

{<br>
# Do teardown here.<br>
}<br><br>=A0=A0=A0 So when runltp is executed, it does something like the f=
ollowing:<br>=A0=A0=A0 1. source testscript [if it exists].<br>=A0=A0=A0 2.=
 Change the test ``execution plan&#39;&#39; so that they setup and teardown=
 inexplicably executed in the following manner (following Java&#39;s unit-t=
est and python unittest):<br>
<br>=A0 =A0 Setup the test; if successful, continue on with the test(s) and=
 teardown at the end.<br><br>=A0=A0=A0 The purpose for making this into a s=
cript as opposed to any other sort of metadata, is that anyone executing th=
e tests standalone will only need to source the script to set everything up=
, then execute the test itself.<br>
=A0=A0=A0 The only thing that might be a problem is that runtest files are =
mashed together if multiple runtest scenario files are specified. This shou=
ldn&#39;t be an issue though if everything is strung together properly via =
the calls above (setup, test, teardown).<br>
=A0=A0=A0 Thoughts?<br>Thanks,<br>-Garrett<br>

--000e0cd1aa68b4efed0480a65a76--


--===============4748578905264789321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============4748578905264789321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4748578905264789321==--

