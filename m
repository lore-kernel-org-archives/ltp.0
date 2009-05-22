Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <marc@tensilica.com>) id 1M7Qp0-0000P7-S2
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:13:46 +0000
Received: from mailgw.tensilica.com ([65.205.227.134])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7Qow-0004w3-3Z
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:13:46 +0000
From: Marc Gauthier <marc@tensilica.com>
Date: Fri, 22 May 2009 02:13:27 -0700
Message-ID: <522C1DF17AF50042AD8AE87F7887BD3D0158B35726@exch.hq.tensilica.com>
In-Reply-To: <d51f89b0905220013v353268d4p3054995a3db0ee0a@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more accurately when
 generating HTML
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3811208643090222178=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: rohit verma <rohit.170309@gmail.com>, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============3811208643090222178==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_522C1DF17AF50042AD8AE87F7887BD3D0158B35726exchhqtensili_"

--_000_522C1DF17AF50042AD8AE87F7887BD3D0158B35726exchhqtensili_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Rohit,

I guess we've each observed output that the other has not  :-)

Per your (1):  I've seen a few cases where lines between test_end and test_=
start do belong to the preceding one, though they are indeed the exception,=
 not the rule.  Looking at the name to assign to previous seems to catch th=
e proper ones in all the cases I've seen (default test lists don't repeat t=
he same test twice in a row).

Per your (2):  Haven't seen that, interesting.  That's a bit harder to sort=
 out, but the script could at least catch the lines that report PASS/FAIL/B=
ROK etc.  And perhaps lines that don't look like a collection of var=3Dvalu=
e.  Hmmm.... maybe all it needs is another regexp test, see patch below (ag=
ainst the genhtml.pl file I posted, which btw was against its latest versio=
n, 1.3).

I haven't taken time to look at why things get out of order in the first pl=
ace, which seems like the correct thing to fix (well, I looked enough to no=
tice that fflush(stdout) was really there :-).  Though making the script ha=
ndle it doesn't hurt, and I've simply been trying to get an accurate look a=
t test results, this was the quickest way to do it.

-Marc

--- genhtml-v4.pl       2009-05-21 01:08:14.747493000 -0700
+++ genhtml.pl  2009-05-22 02:07:47.756226000 -0700
@@ -116,18 +116,18 @@
                }

                #  Read test result parameters and test output
-               while ($line !~ /$end_tag/) {
+               while (1) {
+                       get_line(\$line) or last TEST;
+                       last if $line =3D~ /$end_tag/;
                        ($read_output =3D 1, next) if $line =3D~ /$output_t=
ag/;
                        ($read_output =3D 0, next) if $line =3D~ /$executio=
n_tag/;
-                       if ($read_output) {
+                       if ($read_output or $line !~ /^(\s*\w+=3D(".*"|\S*)=
)+\s*$/) {
                            push @output_lines, $line;
                        } else {
                            while ($line =3D~ s/^\s*(\w+)=3D(".*"|\S*)//) {
                                $values{$1} =3D $2;
                            }
                        }
-               } continue {
-                       get_line(\$line) or last TEST;
                }

                #  Treat lines that follow <<<end_test>>> as output lines





________________________________
From: rohit verma [mailto:rohit.170309@gmail.com]
Sent: Friday, May 22, 2009 00:13
To: subrata@linux.vnet.ibm.com
Cc: Marc Gauthier; LTP List
Subject: Re: [LTP] [PATCH] Detect test results more accurately when generat=
ing HTML

Hi,

The suggestion to - "Process test output lines that appear between <<<test_=
end>>>
and the following <<<test_start>>>.  Assign to the preceding test where the=
 name matches, else to the following test." does not solve the problem comp=
letely.

My observation is:

1. Lines between <<<test_end>>> and <<<test_start>>> belongs to the followi=
ng test case and not to the preceding one.
2. Also, at times I have observed the test output is spread in such a way t=
hat few lines of the test output fall between <<<test_end>>> and <<<test_st=
art>>> and rest of lines appear between the <<<test_start>>> and <<<test_ou=
tput>>> of the corresponding testcase.

Regards,
rohit

On Fri, May 22, 2009 at 12:22 PM, Subrata Modak <subrata@linux.vnet.ibm.com=
<mailto:subrata@linux.vnet.ibm.com>> wrote:
On Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote:
> Hi, my first patch to this list.  Actually not a patch,
> but the files themselves, to avoid line-wrapping issues
> and because the diff is twice the size of the new file.
>
> -Marc

Thanks Marc.

Rohit,

Can you test this and see if these solves the problem that you were
discussing for long ?

Regards--
Subrata

>
>
> -----------
> Detect test results more accurately when generating HTML
>
> Process test output lines that appear between <<<test_end>>>
> and the following <<<test_start>>>.  Assign to the preceding
> test where the name matches, else to the following test.
>
> If a single test has multiple types of results (e.g. both
> FAIL and WARN), report only the most significant one, to
> avoid mis-computing the total number of PASS tests or
> total counts that don't add up to the number of tests.
>
> If a test's output has no explicit result (PASS, FAIL, etc),
> look at the exit value to determine whether it passed.
>
> Setting the SHOW_UNRESOLVED environment variable to 1
> classifies as UNRESOLVED any test with no explicit result
> and a zero exit code.
>
> Setting the SUMMARY_OUTPUT environment variable to 1
> causes only one line of output per test to be shown, for a
> tighter page that allows quickly scanning the results.
>
> Show percentage of each result type in summary section.
>
> Simplify parsing a bit.
>
> Signed-off-by:  Marc Gauthier <marc@tensilica.com<mailto:marc@tensilica.c=
om>>
>
> -------------------------------------------------------------------------=
-----
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. =
Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, &
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbaria=
n
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com
> _______________________________________________ Ltp-list mailing list Ltp=
-list@lists.sourceforge.net<mailto:Ltp-list@lists.sourceforge.net> https://=
lists.sourceforge.net/lists/listinfo/ltp-list



--_000_522C1DF17AF50042AD8AE87F7887BD3D0158B35726exchhqtensili_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D750184608-22052009><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>Hi Rohit,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D750184608-22052009><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D750184608-22052009><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>I guess we've each observed output that the other =
has=20
not&nbsp; :-)</FONT></SPAN></DIV><SPAN class=3D750184608-22052009>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2></F=
ONT><FONT=20
face=3DArial color=3D#0000ff size=3D2></FONT><FONT face=3DArial color=3D#00=
00ff=20
size=3D2></FONT><FONT face=3DArial color=3D#0000ff size=3D2></FONT><BR><FON=
T=20
face=3DArial><FONT color=3D#0000ff><FONT size=3D2>Per your (1):&nbsp; I've =
seen a few=20
cases where lines between test_end and test_start do belong to the precedin=
g=20
one, though they are indeed the exception, not the rule.<SPAN=20
class=3D750184608-22052009>&nbsp; Looking at the name to assign to previous=
 seems=20
to catch the proper ones in all the cases I've seen (default test lists don=
't=20
repeat the same test twice in a row).</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>Per your (2):&nbsp; Haven't seen that,=20
interesting.&nbsp; That's a bit harder to sort out, but the script could at=
=20
least catch the lines that report PASS/FAIL/BROK etc.&nbsp; And perhaps lin=
es=20
that don't look like a collection of var=3Dvalue.&nbsp; Hmmm.... maybe all =
it=20
needs is another regexp test, see patch below (against the genhtml.pl file =
I=20
posted, which btw was against its latest version,=20
1.3).</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>I haven't taken time to look at why things get o=
ut of=20
order in the first place, which seems like the correct thing to fix (well, =
I=20
looked enough to notice that fflush(stdout) was really there :-).&nbsp; Tho=
ugh=20
making the script handle it doesn't hurt, and I've simply been trying to ge=
t an=20
accurate look at test results, this was the quickest way to do=20
it.</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>-Marc</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>--- genhtml-v4.pl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
2009-05-21 01:08:14.747493000 -0700<BR>+++ genhtml.pl&nbsp; 2009-05-22=20
02:07:47.756226000 -0700<BR>@@ -116,18 +116,18=20
@@<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
}</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#&nbsp; Read test result parameters and test=20
output<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
while ($line !~ /$end_tag/)=20
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
while (1)=20
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
get_line(\$line) or last=20
TEST;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
last if $line =3D~=20
/$end_tag/;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
($read_output =3D 1, next) if $line =3D~=20
/$output_tag/;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
($read_output =3D 0, next) if $line =3D~=20
/$execution_tag/;<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
if ($read_output)=20
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
if ($read_output or $line !~ /^(\s*\w+=3D(".*"|\S*))+\s*$/)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
push @output_lines,=20
$line;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
} else=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
while ($line =3D~ s/^\s*(\w+)=3D(".*"|\S*)//)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
$values{$1} =3D=20
$2;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
} continue=20
{<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
get_line(\$line) or last=20
TEST;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
}</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#&nbsp; Treat lines that follow &lt;&lt;&lt;end_test&gt;&gt;&gt; as output=
=20
lines<BR></SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009>&nbsp;</DIV></SPAN></FONT></FONT></FONT>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial><FONT color=3D#0000ff><FONT =
size=3D2><SPAN=20
class=3D750184608-22052009></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT><FONT face=3DArial color=3D#0000ff size=3D2></FONT><FONT fa=
ce=3DArial=20
color=3D#0000ff size=3D2></FONT><FONT face=3DArial color=3D#0000ff size=3D2=
></FONT><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> rohit verma=20
  [mailto:rohit.170309@gmail.com] <BR><B>Sent:</B> Friday, May 22, 2009=20
  00:13<BR><B>To:</B> subrata@linux.vnet.ibm.com<BR><B>Cc:</B> Marc Gauthie=
r;=20
  LTP List<BR><B>Subject:</B> Re: [LTP] [PATCH] Detect test results more=20
  accurately when generating HTML<BR></FONT><BR></DIV>
  <DIV></DIV>Hi,
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT><BR></DIV>
  <DIV>The suggestion to - "Process test output lines that appear between=20
  &lt;&lt;&lt;test_end&gt;&gt;&gt;</DIV>
  <DIV>and the following &lt;&lt;&lt;test_start&gt;&gt;&gt;. &nbsp;Assign t=
o the=20
  preceding&nbsp;test where the name matches, else to the following test." =
does=20
  not solve the problem completely.&nbsp;</DIV>
  <DIV><BR></DIV>
  <DIV>My observation is:&nbsp;</DIV>
  <DIV><BR></DIV>
  <DIV>1. Lines between &lt;&lt;&lt;test_end&gt;&gt;&gt; and=20
  &lt;&lt;&lt;test_start&gt;&gt;&gt; belongs to the following test case and=
 not=20
  to the preceding one.</DIV>
  <DIV>2. Also, at times I have observed the test output is spread in such =
a way=20
  that few lines of the test output fall between=20
  &lt;&lt;&lt;test_end&gt;&gt;&gt; and &lt;&lt;&lt;test_start&gt;&gt;&gt; a=
nd=20
  rest of lines appear between the &lt;&lt;&lt;test_start&gt;&gt;&gt; and=20
  &lt;&lt;&lt;test_output&gt;&gt;&gt; of the corresponding testcase.</DIV>
  <DIV><BR></DIV>
  <DIV>Regards,</DIV>
  <DIV>rohit<BR><BR>
  <DIV class=3Dgmail_quote>On Fri, May 22, 2009 at 12:22 PM, Subrata Modak =
<SPAN=20
  dir=3Dltr>&lt;<A=20
  href=3D"mailto:subrata@linux.vnet.ibm.com">subrata@linux.vnet.ibm.com</A>=
&gt;</SPAN>=20
  wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc =
1px solid">On=20
    Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote:<BR>&gt; Hi, my fir=
st=20
    patch to this list. &nbsp;Actually not a patch,<BR>&gt; but the files=20
    themselves, to avoid line-wrapping issues<BR>&gt; and because the diff =
is=20
    twice the size of the new file.<BR>&gt;<BR>&gt; -Marc<BR><BR>Thanks=20
    Marc.<BR><BR>Rohit,<BR><BR>Can you test this and see if these solves th=
e=20
    problem that you were<BR>discussing for long=20
    ?<BR><BR>Regards--<BR>Subrata<BR><BR>&gt;<BR>&gt;<BR>&gt;=20
    -----------<BR>&gt; Detect test results more accurately when generating=
=20
    HTML<BR>&gt;<BR>&gt; Process test output lines that appear between=20
    &lt;&lt;&lt;test_end&gt;&gt;&gt;<BR>&gt; and the following=20
    &lt;&lt;&lt;test_start&gt;&gt;&gt;. &nbsp;Assign to the preceding<BR>&g=
t;=20
    test where the name matches, else to the following test.<BR>&gt;<BR>&gt=
; If=20
    a single test has multiple types of results (e.g. both<BR>&gt; FAIL and=
=20
    WARN), report only the most significant one, to<BR>&gt; avoid mis-compu=
ting=20
    the total number of PASS tests or<BR>&gt; total counts that don't add u=
p to=20
    the number of tests.<BR>&gt;<BR>&gt; If a test's output has no explicit=
=20
    result (PASS, FAIL, etc),<BR>&gt; look at the exit value to determine=20
    whether it passed.<BR>&gt;<BR>&gt; Setting the SHOW_UNRESOLVED environm=
ent=20
    variable to 1<BR>&gt; classifies as UNRESOLVED any test with no explici=
t=20
    result<BR>&gt; and a zero exit code.<BR>&gt;<BR>&gt; Setting the=20
    SUMMARY_OUTPUT environment variable to 1<BR>&gt; causes only one line o=
f=20
    output per test to be shown, for a<BR>&gt; tighter page that allows qui=
ckly=20
    scanning the results.<BR>&gt;<BR>&gt; Show percentage of each result ty=
pe in=20
    summary section.<BR>&gt;<BR>&gt; Simplify parsing a bit.<BR>&gt;<BR>&gt=
;=20
    Signed-off-by: &nbsp;Marc Gauthier &lt;<A=20
    href=3D"mailto:marc@tensilica.com">marc@tensilica.com</A>&gt;<BR>&gt;<B=
R>&gt;=20
    -----------------------------------------------------------------------=
-------<BR>&gt;=20
    Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT<BR=
>&gt;=20
    is a gathering of tech-side developers &amp; brand creativity professio=
nals.=20
    Meet<BR>&gt; the minds behind Google Creative Lab, Visual Complexity,=20
    Processing, &amp;<BR>&gt; iPhoneDevCamp asthey present alongside digita=
l=20
    heavyweights like Barbarian<BR>&gt; Group, R/GA, &amp; Big Spaceship. <=
A=20
    href=3D"http://www.creativitycat.com"=20
    target=3D_blank>http://www.creativitycat.com</A><BR>&gt;=20
    _______________________________________________ Ltp-list mailing list <=
A=20
    href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourcefor=
ge.net</A>=20
    <A href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list"=20
    target=3D_blank>https://lists.sourceforge.net/lists/listinfo/ltp-list</=
A><BR><BR></BLOCKQUOTE></DIV><BR></DIV></BLOCKQUOTE></BODY></HTML>

--_000_522C1DF17AF50042AD8AE87F7887BD3D0158B35726exchhqtensili_--


--===============3811208643090222178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
--===============3811208643090222178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3811208643090222178==--

