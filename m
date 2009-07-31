Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MWmuS-00071D-1N
	for Ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:52:12 +0000
Received: from wf-out-1314.google.com ([209.85.200.175])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWmuK-000619-19
	for Ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:52:12 +0000
Received: by wf-out-1314.google.com with SMTP id 26so549387wfd.4
	for <Ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 00:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1248978594.5788.69.camel@subratamodak.linux.ibm.com>
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
	<6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
	<578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
	<6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
	<13B0CDE8-B974-4CFA-A4B9-8AC4374B4694@kernel.crashing.org>
	<6213bc560907231331p188a7b32q7287e9fe777eaf18@mail.gmail.com>
	<6213bc560907290608i1ad6aea1gf327f523957f8a5c@mail.gmail.com>
	<1248978594.5788.69.camel@subratamodak.linux.ibm.com>
Date: Fri, 31 Jul 2009 13:21:57 +0530
Message-ID: <6213bc560907310051r3033a0bem2e31a4ff182e67b7@mail.gmail.com>
From: srikanth krishnakar <skrishnakar@gmail.com>
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5557053746572178139=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Ltp-list@lists.sourceforge.net

--===============5557053746572178139==
Content-Type: multipart/alternative; boundary=001636e9107ed5fc97046ffbb101

--001636e9107ed5fc97046ffbb101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Subrata,

This has been tested on PPC440 and PPC405 PowerPC targets below are the
results :

---------------------------------------------------

<<<test_start>>>
tag=remap_file_pages01 stime=1248547976
cmdline="remap_file_pages01"
contacts=""
analysis=exit
<<<test_output>>>
remap_file_pages01    1  TPASS  :  Non-Linear shm file OK
remap_file_pages01    2  TPASS  :  Non-Linear /tmp/ file OK
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=18 cstime=13
<<<test_end>>>


<<<test_start>>>
tag=remap_file_pages02 stime=1248547976
cmdline="remap_file_pages02"
contacts=""
analysis=exit
<<<test_output>>>
remap_file_pages02    1  TPASS  :  remap_file_pages(2) expected failure; Got
errno - EINVAL : start does not refer to a valid mapping created with the
MAP_SHARED flag
remap_file_pages02    2  TPASS  :  remap_file_pages(2) expected failure; Got
errno - EINVAL : start is invalid
remap_file_pages02    3  TPASS  :  remap_file_pages(2) expected failure; Got
errno - EINVAL : size is invalid
remap_file_pages02    4  TPASS  :  remap_file_pages(2) expected failure; Got
errno - EINVAL : prot is invalid
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>

-------------------------------------------------------


Or else other option to make these test cases pass on these target is to
modify the kernel config options :

Change of TASK_SIZE from 0x80000000 to 0xc0000000.  A workaround is to
set these config options to
revert back to the old TASK_SIZE:

CONFIG_ADVANCED_OPTIONS=y
CONFIG_TASK_SIZE_BOOL=y
CONFIG_TASK_SIZE=0x80000000


Thanks,
-Srikanth


On Thu, Jul 30, 2009 at 11:59 PM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

> Has this Patch been tested on the concerned Power Box ? I would need
> some info before applying this.
>
> Regards--
> Subrata
>
> On Wed, 2009-07-29 at 18:38 +0530, srikanth krishnakar wrote:
> > Hi all,
> >
> >
> > I always found the remap_file_pages failing in PowerPC target
> > (ppc44x) , the patch to fix the test cases of remap_file_pages passes
> > the test cases on PowerPC targets ( ppc44x virtex target does not use
> > bootloader ), any better suggestions are welcome.
> >
> > -Srikanth
> >
> > On Fri, Jul 24, 2009 at 2:01 AM, srikanth krishnakar
> > <skrishnakar@gmail.com> wrote:
> >
> >
> >
> >         On Thu, Jul 23, 2009 at 6:33 AM, Kumar Gala
> >         <galak@kernel.crashing.org> wrote:
> >
> >                 On Jul 22, 2009, at 11:32 AM, srikanth krishnakar
> >                 wrote:
> >
> >
> >
> >                         On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala
> >                         <galak@kernel.crashing.org> wrote:
> >
> >                         On Jul 22, 2009, at 10:38 AM, srikanth
> >                         krishnakar wrote:
> >
> >
> >
> >                         On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala
> >                         <galak@kernel.crashing.org> wrote:
> >                         I'm not seeing any BUG* in traps.c @ line 904.
> >
> >
> >                         On Jul 21, 2009, at 4:33 AM, srikanth
> >                         krishnakar wrote:
> >
> >                         The LTP test case msgctl10.c fails on
> >                         linux-2.6.29.6 for PowerPC architecture
> >                         (ppc440)
> >
> >
> >                         msgctl10    1  B------------[ cut
> >                         here ]------------
> >                         kernel BUG at arch/powerpc/kernel/traps.c:904!
> >                         Oops: Exception in kernel mode, sig: 5 [#9]
> >
> >                         I'm not seeing any BUG* in traps.c @ line
> >                         904.  Do you have some other patches on top of
> >                         2.6.29.6?
> >
> >                         - k
> >
> >
> >                         I have LTTng patches on top of linux-2.6.29.6.
> >
> >                         Does it modify traps.c?  Can you see what the
> >                         code around line 904 looks like and post that.
> >
> >                         - k
> >                          896
> >                          897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT)
> >                         && defined(CONFIG_PPC_FPU)
> >                          898         if (reason & REASON_ILLEGAL) {
> >                          899                 if (excep_state < 1) {
> >                          900                         excep_state++;
> >                          901                         return;
> >                          902                 }
> >                          903                 /* should never get here
> >                         */
> >                          904                 BUG();
> >                          905         }
> >                          906 #endif
> >                          907
> >                          908         /* Try to emulate it if we
> >                         should. */
> >
> >
> >
> >                 Are you sure this is coming from the LTTng patches?
> >                  Which actual patch makes this change?
> >
> >                 - k
> >         Thanks kumar,
> >
> >
> >
> >         I've got the patch out which fixes the issues. But now.. seems
> >         there is some generic issue in PPC440 targets, I am observing
> >         that
> >         remap_file_pages01 and remap_file_pages02  test cases from LTP
> >         are failing since Linux-2.6.24 kernel to Linux-2.6.30. If you
> >         can give some pointers that would be greatly appreciated ! Or
> >         if you have results for this on any PPC44x would be helpful.
> >
> >
> >         Arch : PowerPC
> >
> >         Target : Xilinx PowerPC440 virtex5
> >
> >
> >
> >         I've tried to test the cause for this but found that kernel
> >         throws error message of "segmentation fault".
> >
> >
> >
> >         Thanks in Advance.
> >
> >
> >
> >         -Srikant
> >
> >
> >
> >
> >
> >
> >
> > --
> > "The Good You Do, The Best You GET"
> >
> > Regards
> > Srikanth Krishnakar
> > **********************
> >
> ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> 30-Day
> > trial. Simplify your report design, integration and deployment - and
> focus on
> > what you do best, core application coding. Discover what's new with
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--001636e9107ed5fc97046ffbb101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Subrata,<br><br>This has been tested on PPC440 and PPC405 PowerPC target=
s below are the results :<br><br>------------------------------------------=
---------<br><br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dremap_file_pag=
es01 stime=3D1248547976<br>
cmdline=3D&quot;remap_file_pages01&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>remap_file_pages01=A0=
=A0=A0 1=A0 TPASS=A0 :=A0 Non-Linear shm file OK<br>remap_file_pages01=A0=
=A0=A0 2=A0 TPASS=A0 :=A0 Non-Linear /tmp/ file OK<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=
=3Dno<br>cutime=3D18 cstime=3D13<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br><br=
><br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dremap_file_pages02 stime=3D1248547976<br>cmdline=3D&quot;remap_file_p=
ages02&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;t=
est_output&gt;&gt;&gt;<br>remap_file_pages02=A0=A0=A0 1=A0 TPASS=A0 :=A0 re=
map_file_pages(2) expected failure; Got errno - EINVAL : start does not ref=
er to a valid mapping created with the MAP_SHARED flag<br>
remap_file_pages02=A0=A0=A0 2=A0 TPASS=A0 :=A0 remap_file_pages(2) expected=
 failure; Got errno - EINVAL : start is invalid<br>remap_file_pages02=A0=A0=
=A0 3=A0 TPASS=A0 :=A0 remap_file_pages(2) expected failure; Got errno - EI=
NVAL : size is invalid<br>
remap_file_pages02=A0=A0=A0 4=A0 TPASS=A0 :=A0 remap_file_pages(2) expected=
 failure; Got errno - EINVAL : prot is invalid<br>&lt;&lt;&lt;execution_sta=
tus&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&quot;<br>duration=3D0 termi=
nation_type=3Dexited termination_id=3D0 corefile=3Dno<br>
cutime=3D0 cstime=3D1<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br><br>----------=
---------------------------------------------<br><br><br>Or else other opti=
on to make these test cases pass on these target is to modify the kernel co=
nfig options :<br>
<br><pre id=3D"comment_text_0">Change of TASK_SIZE from 0x80000000 to 0xc00=
00000.  A workaround is to set these config options to<br>revert back to th=
e old TASK_SIZE:<br><br>CONFIG_ADVANCED_OPTIONS=3Dy<br>CONFIG_TASK_SIZE_BOO=
L=3Dy<br>
CONFIG_TASK_SIZE=3D0x80000000<br></pre><br>Thanks,<br>-Srikanth<br><br><br>=
<div class=3D"gmail_quote">On Thu, Jul 30, 2009 at 11:59 PM, Subrata Modak =
<span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com">subrata=
@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Has this Patch be=
en tested on the concerned Power Box ? I would need<br>
some info before applying this.<br>
<br>
Regards--<br>
Subrata<br>
<div><div></div><div class=3D"h5"><br>
On Wed, 2009-07-29 at 18:38 +0530, srikanth krishnakar wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt;<br>
&gt; I always found the remap_file_pages failing in PowerPC target<br>
&gt; (ppc44x) , the patch to fix the test cases of remap_file_pages passes<=
br>
&gt; the test cases on PowerPC targets ( ppc44x virtex target does not use<=
br>
&gt; bootloader ), any better suggestions are welcome.<br>
&gt;<br>
&gt; -Srikanth<br>
&gt;<br>
&gt; On Fri, Jul 24, 2009 at 2:01 AM, srikanth krishnakar<br>
&gt; &lt;<a href=3D"mailto:skrishnakar@gmail.com">skrishnakar@gmail.com</a>=
&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Thu, Jul 23, 2009 at 6:33 AM, Kumar Gala<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:galak@kernel.crashing.org">galak=
@kernel.crashing.org</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Jul 22, 2009, at 11:32 AM, srikanth=
 krishnakar<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Wed, Jul 22, 2009 a=
t 9:14 PM, Kumar Gala<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:=
galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Jul 22, 2009, at 10=
:38 AM, srikanth<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 krishnakar wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Wed, Jul 22, 2009 a=
t 8:52 PM, Kumar Gala<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:=
galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I&#39;m not seeing any=
 BUG* in traps.c @ line 904.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Jul 21, 2009, at 4:=
33 AM, srikanth<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 krishnakar wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The LTP test case msgc=
tl10.c fails on<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux-2.6.29.6 for Pow=
erPC architecture<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ppc440)<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgctl10 =A0 =A01 =A0B=
------------[ cut<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 here ]------------<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kernel BUG at arch/pow=
erpc/kernel/traps.c:904!<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Oops: Exception in ker=
nel mode, sig: 5 [#9]<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I&#39;m not seeing any=
 BUG* in traps.c @ line<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 904. =A0Do you have so=
me other patches on top of<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2.6.29.6?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - k<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I have LTTng patches o=
n top of linux-2.6.29.6.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Does it modify traps.c=
? =A0Can you see what the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code around line 904 l=
ooks like and post that.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - k<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0896<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0897 #if defined(CON=
FIG_XILINX_VIRTEX_5_FXT)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;&amp; defined(CON=
FIG_PPC_FPU)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0898 =A0 =A0 =A0 =A0=
 if (reason &amp; REASON_ILLEGAL) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0899 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 if (excep_state &lt; 1) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0900 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 excep_state++;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0901 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0902 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0903 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* should never get here<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0904 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 BUG();<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0905 =A0 =A0 =A0 =A0=
 }<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0906 #endif<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0907<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0908 =A0 =A0 =A0 =A0=
 /* Try to emulate it if we<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 should. */<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Are you sure this is coming from the L=
TTng patches?<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Which actual patch makes this chang=
e?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - k<br>
&gt; =A0 =A0 =A0 =A0 Thanks kumar,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I&#39;ve got the patch out which fixes the issues. But=
 now.. seems<br>
&gt; =A0 =A0 =A0 =A0 there is some generic issue in PPC440 targets, I am ob=
serving<br>
&gt; =A0 =A0 =A0 =A0 that<br>
&gt; =A0 =A0 =A0 =A0 remap_file_pages01 and remap_file_pages02 =A0test case=
s from LTP<br>
&gt; =A0 =A0 =A0 =A0 are failing since Linux-2.6.24 kernel to Linux-2.6.30.=
 If you<br>
&gt; =A0 =A0 =A0 =A0 can give some pointers that would be greatly appreciat=
ed ! Or<br>
&gt; =A0 =A0 =A0 =A0 if you have results for this on any PPC44x would be he=
lpful.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Arch : PowerPC<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Target : Xilinx PowerPC440 virtex5<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I&#39;ve tried to test the cause for this but found th=
at kernel<br>
&gt; =A0 =A0 =A0 =A0 throws error message of &quot;segmentation fault&quot;=
.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Thanks in Advance.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 -Srikant<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; &quot;The Good You Do, The Best You GET&quot;<br>
&gt;<br>
&gt; Regards<br>
&gt; Srikanth Krishnakar<br>
&gt; **********************<br>
</div></div>&gt; ----------------------------------------------------------=
--------------------<br>
&gt; Let Crystal Reports handle the reporting - Free Crystal Reports 2008 3=
0-Day<br>
&gt; trial. Simplify your report design, integration and deployment - and f=
ocus on<br>
&gt; what you do best, core application coding. Discover what&#39;s new wit=
h<br>
&gt; Crystal Reports now. =A0<a href=3D"http://p.sf.net/sfu/bobj-july" targ=
et=3D"_blank">http://p.sf.net/sfu/bobj-july</a><br>
&gt; _______________________________________________ Ltp-list mailing list =
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a> <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a=
><br>

<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good You Do, =
The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>***********=
***********<br>

--001636e9107ed5fc97046ffbb101--


--===============5557053746572178139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5557053746572178139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5557053746572178139==--

