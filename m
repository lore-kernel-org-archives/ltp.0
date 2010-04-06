Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liangrenxiu@gmail.com>) id 1Nyy0w-0003Cf-PQ
	for ltp-list@lists.sourceforge.net; Tue, 06 Apr 2010 01:55:38 +0000
Received: from mail-pz0-f182.google.com ([209.85.222.182])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nyy0v-0000ZO-Uj
	for ltp-list@lists.sourceforge.net; Tue, 06 Apr 2010 01:55:38 +0000
Received: by pzk12 with SMTP id 12so1262779pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Apr 2010 18:55:32 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 6 Apr 2010 09:55:32 +0800
Message-ID: <g2kd955a1171004051855zca3d16a1p27a4c7adcd3dd91b@mail.gmail.com>
From: renxiu liang <liangrenxiu@gmail.com>
Subject: [LTP] mtest06: mmap1 -x 0.05 : how to handle SIGSEGV with
	"SEGV_ACCERR" si_code value
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1154363311195431842=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1154363311195431842==
Content-Type: multipart/alternative; boundary=001636b2ac6da133ba048387bdd6

--001636b2ac6da133ba048387bdd6
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Recently, we found the default test case mtest06 failed; the test case
wanted to handle sigal "SIGSEGV", but it only handles when si_code is
"SEGV_MAPERR";
the si_code for SIGSEGV signal has two values: SEGV_MAPERR and SEGV_ACCERR;

 static void
 sig_handler(int signal,     /* signal number, set to handle SIGALRM
*/
             siginfo_t *info,
             struct ucontext *ut)/* contains pointer to sigcontext
structure   */
 {
     switch (signal)
     {
         case SIGALRM:
              tst_resm(TPASS, "Test ended, success");
              _exit(0);

         case SIGSEGV:
              if (info->si_code == SEGV_MAPERR &&
                       info->si_addr == map_address)
              {
                   tst_resm(TINFO,
                     "page fault occurred at %p",
                     map_address);
                   longjmp(jmpbuf, 1);

}---------------------------------------------------------------------------------------->>>>>>>
it doesn't handle when si_code is "SEGV_ACCERR", the test exits with -1;
this isn't right; there should be some code to process the SEGV_ACCERR type
sigsegv.
         default:
             fprintf(stderr, "caught unexpected signal - %d --- exiting\n",
                      signal);
             _exit(-1);
     }
 }

Please improve the test case for handling sigsegv signal or give advices on
how to improve it;

thanks,
best regards,
renxiu liang

--001636b2ac6da133ba048387bdd6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>Recently, we found the default test case mtest06 failed; the=
 test case wanted to handle sigal &quot;SIGSEGV&quot;, but it only handles =
when si_code is &quot;SEGV_MAPERR&quot;; <br>the si_code for SIGSEGV signal=
 has two values: SEGV_MAPERR and SEGV_ACCERR; <br>
<br>=A0static void<br>=A0sig_handler(int signal,=A0=A0=A0=A0 /* signal numb=
er, set to handle SIGALRM=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 siginfo_t *info,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struc=
t ucontext *ut)/* contains pointer to sigcontext structure=A0=A0 */<br>=A0{=
<br>
=A0=A0=A0=A0 switch (signal)<br>=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0 =
case SIGALRM:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(TPASS, &q=
uot;Test ended, success&quot;);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
_exit(0);<br>=A0<br>=A0=A0=A0=A0=A0=A0=A0=A0 case SIGSEGV:<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (info-&gt;si_code =3D=3D SEGV_MAPERR &amp;&a=
mp;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info-&gt=
;si_addr =3D=3D map_address) <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(TINFO,<b=
r>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;page f=
ault occurred at %p&quot;,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 map_address);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 longjmp(jmpbuf, 1);<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }----------------------------------=
------------------------------------------------------&gt;&gt;&gt;&gt;&gt;&=
gt;&gt; it doesn&#39;t handle when si_code is &quot;SEGV_ACCERR&quot;, the =
test exits with -1; this isn&#39;t right; there should be some code to proc=
ess the SEGV_ACCERR type sigsegv.<br>
=A0=A0=A0=A0=A0=A0=A0=A0 default:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f=
printf(stderr, &quot;caught unexpected signal - %d --- exiting\n&quot;,<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 signal);<br=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _exit(-1);=A0 <br>=A0=A0=A0=A0 }<br>=
=A0}<br><br>Please improve the test case for handling sigsegv signal or giv=
e advices on how to improve it;<br>
<br>thanks,<br>best regards,<br>renxiu liang<br><br>

--001636b2ac6da133ba048387bdd6--


--===============1154363311195431842==
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
--===============1154363311195431842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1154363311195431842==--

