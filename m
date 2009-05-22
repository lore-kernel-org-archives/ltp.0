Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M7R0w-0006R5-Ok
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:26:06 +0000
Received: from ey-out-1920.google.com ([74.125.78.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7R0q-0007mx-JB
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:26:06 +0000
Received: by ey-out-1920.google.com with SMTP id 13so345369eye.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 May 2009 02:25:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D0158B35726@exch.hq.tensilica.com>
References: <d51f89b0905220013v353268d4p3054995a3db0ee0a@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35726@exch.hq.tensilica.com>
Date: Fri, 22 May 2009 14:55:59 +0530
Message-ID: <d51f89b0905220225u4cc3d98dsc9b402b1bd11a772@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8435737461727330266=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Marc Gauthier <marc@tensilica.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============8435737461727330266==
Content-Type: multipart/alternative; boundary=0016364c7edd33cfa7046a7cd9bc

--0016364c7edd33cfa7046a7cd9bc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

There is no problem with the genhtml.pl script. The real problem is in the
pan driver (ltp/pan/pan.c). This seems to be a problem of race condition
after going through the code.

My suggestion was to use the buffered mode as default. This can be done with
the -O option followed by a directory name where the buffered data can be
stored. But, there is a problem - the -O option has no effect unless the -x
option with an argument greater than 1 is used.

In your test runs you can add the options " -O <dirname> -x 2" and find out
if the problem with logging still persists.

Regards,
rohit




On Fri, May 22, 2009 at 2:43 PM, Marc Gauthier <marc@tensilica.com> wrote:

>  Hi Rohit,
>
> I guess we've each observed output that the other has not  :-)
>
> Per your (1):  I've seen a few cases where lines between test_end and
> test_start do belong to the preceding one, though they are indeed the
> exception, not the rule.  Looking at the name to assign to previous seems
> to catch the proper ones in all the cases I've seen (default test lists
> don't repeat the same test twice in a row).
>
> Per your (2):  Haven't seen that, interesting.  That's a bit harder to sort
> out, but the script could at least catch the lines that report
> PASS/FAIL/BROK etc.  And perhaps lines that don't look like a collection of
> var=value.  Hmmm.... maybe all it needs is another regexp test, see patch
> below (against the genhtml.pl file I posted, which btw was against its
> latest version, 1.3).
>
> I haven't taken time to look at why things get out of order in the first
> place, which seems like the correct thing to fix (well, I looked enough to
> notice that fflush(stdout) was really there :-).  Though making the script
> handle it doesn't hurt, and I've simply been trying to get an accurate look
> at test results, this was the quickest way to do it.
>
> -Marc
>
> --- genhtml-v4.pl       2009-05-21 01:08:14.747493000 -0700
> +++ genhtml.pl  2009-05-22 02:07:47.756226000 -0700
> @@ -116,18 +116,18 @@
>                 }
>
>                 #  Read test result parameters and test output
> -               while ($line !~ /$end_tag/) {
> +               while (1) {
> +                       get_line(\$line) or last TEST;
> +                       last if $line =~ /$end_tag/;
>                         ($read_output = 1, next) if $line =~ /$output_tag/;
>                         ($read_output = 0, next) if $line =~
> /$execution_tag/;
> -                       if ($read_output) {
> +                       if ($read_output or $line !~
> /^(\s*\w+=(".*"|\S*))+\s*$/) {
>                             push @output_lines, $line;
>                         } else {
>                             while ($line =~ s/^\s*(\w+)=(".*"|\S*)//) {
>                                 $values{$1} = $2;
>                             }
>                         }
> -               } continue {
> -                       get_line(\$line) or last TEST;
>                 }
>
>                 #  Treat lines that follow <<<end_test>>> as output lines
>
>
>
>
>
>  ------------------------------
> *From:* rohit verma [mailto:rohit.170309@gmail.com]
> *Sent:* Friday, May 22, 2009 00:13
> *To:* subrata@linux.vnet.ibm.com
> *Cc:* Marc Gauthier; LTP List
> *Subject:* Re: [LTP] [PATCH] Detect test results more accurately when
> generating HTML
>
> Hi,
> The suggestion to - "Process test output lines that appear between
> <<<test_end>>>
> and the following <<<test_start>>>.  Assign to the preceding test where the
> name matches, else to the following test." does not solve the problem
> completely.
>
> My observation is:
>
> 1. Lines between <<<test_end>>> and <<<test_start>>> belongs to the
> following test case and not to the preceding one.
> 2. Also, at times I have observed the test output is spread in such a way
> that few lines of the test output fall between <<<test_end>>> and
> <<<test_start>>> and rest of lines appear between the <<<test_start>>> and
> <<<test_output>>> of the corresponding testcase.
>
> Regards,
> rohit
>
> On Fri, May 22, 2009 at 12:22 PM, Subrata Modak <
> subrata@linux.vnet.ibm.com> wrote:
>
>> On Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote:
>> > Hi, my first patch to this list.  Actually not a patch,
>> > but the files themselves, to avoid line-wrapping issues
>> > and because the diff is twice the size of the new file.
>> >
>> > -Marc
>>
>> Thanks Marc.
>>
>> Rohit,
>>
>> Can you test this and see if these solves the problem that you were
>> discussing for long ?
>>
>> Regards--
>> Subrata
>>
>> >
>> >
>> > -----------
>> > Detect test results more accurately when generating HTML
>> >
>> > Process test output lines that appear between <<<test_end>>>
>> > and the following <<<test_start>>>.  Assign to the preceding
>> > test where the name matches, else to the following test.
>> >
>> > If a single test has multiple types of results (e.g. both
>> > FAIL and WARN), report only the most significant one, to
>> > avoid mis-computing the total number of PASS tests or
>> > total counts that don't add up to the number of tests.
>> >
>> > If a test's output has no explicit result (PASS, FAIL, etc),
>> > look at the exit value to determine whether it passed.
>> >
>> > Setting the SHOW_UNRESOLVED environment variable to 1
>> > classifies as UNRESOLVED any test with no explicit result
>> > and a zero exit code.
>> >
>> > Setting the SUMMARY_OUTPUT environment variable to 1
>> > causes only one line of output per test to be shown, for a
>> > tighter page that allows quickly scanning the results.
>> >
>> > Show percentage of each result type in summary section.
>> >
>> > Simplify parsing a bit.
>> >
>> > Signed-off-by:  Marc Gauthier <marc@tensilica.com>
>> >
>> >
>> ------------------------------------------------------------------------------
>> > Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
>> > is a gathering of tech-side developers & brand creativity professionals.
>> Meet
>> > the minds behind Google Creative Lab, Visual Complexity, Processing, &
>> > iPhoneDevCamp asthey present alongside digital heavyweights like
>> Barbarian
>> > Group, R/GA, & Big Spaceship. http://www.creativitycat.com
>> > _______________________________________________ Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>

--0016364c7edd33cfa7046a7cd9bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div>There is no problem with the genhtml.pl s=
cript. The real problem is in the pan driver (ltp/pan/pan.c). This seems to=
 be a problem of race condition after going through the code.</div><div>
<br></div><div>My suggestion was to use the buffered mode as default. This =
can be done with the -O option followed by a directory name where the buffe=
red data can be stored. But, there is a problem - the -O option has no effe=
ct unless the -x option with an argument greater than 1 is used.=A0</div>
<div><br></div><div>In your test runs you can add the options &quot; -O &lt=
;dirname&gt; -x 2&quot; and find out if the problem with logging still pers=
ists.</div><div><br></div><div>Regards,</div><div>rohit</div><div><br></div=
>
<div><br></div><br><br><div class=3D"gmail_quote">On Fri, May 22, 2009 at 2=
:43 PM, Marc Gauthier <span dir=3D"ltr">&lt;<a href=3D"mailto:marc@tensilic=
a.com">marc@tensilica.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex;">




<div>
<div dir=3D"ltr" align=3D"left"><span><font face=3D"Arial" color=3D"#0000ff=
" size=3D"2">Hi Rohit,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font face=3D"Arial" color=3D"#0000ff=
" size=3D"2"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font face=3D"Arial" color=3D"#0000ff=
" size=3D"2">I guess we&#39;ve each observed output that the other has=20
not=A0 :-)</font></span></div><span>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial" color=3D"#0000ff" size=
=3D"2"></font><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></font><fon=
t face=3D"Arial" color=3D"#0000ff" size=3D"2"></font><font face=3D"Arial" c=
olor=3D"#0000ff" size=3D"2"></font><br>
<font face=3D"Arial"><font color=3D"#0000ff"><font size=3D"2">Per your (1):=
=A0 I&#39;ve seen a few=20
cases where lines between test_end and test_start do belong to the precedin=
g=20
one, though they are indeed the exception, not the rule.<span>=A0 Looking a=
t the name to assign to previous seems=20
to catch the proper ones in all the cases I&#39;ve seen (default test lists=
 don&#39;t=20
repeat the same test twice in a row).</span></font></font></font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>Per your (2):=A0 Haven&#39;t seen that,=20
interesting.=A0 That&#39;s a bit harder to sort out, but the script could a=
t=20
least catch the lines that report PASS/FAIL/BROK etc.=A0 And perhaps lines=
=20
that don&#39;t look like a collection of var=3Dvalue.=A0 Hmmm.... maybe all=
 it=20
needs is another regexp test, see patch below (against the genhtml.pl file =
I=20
posted, which btw was against its latest version,=20
1.3).</span></font></font></font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>I haven&#39;t taken time to look at why things get=
 out of=20
order in the first place, which seems like the correct thing to fix (well, =
I=20
looked enough to notice that fflush(stdout) was really there :-).=A0 Though=
=20
making the script handle it doesn&#39;t hurt, and I&#39;ve simply been tryi=
ng to get an=20
accurate look at test results, this was the quickest way to do=20
it.</span></font></font></font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>-Marc</span></font></font></font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>--- genhtml-v4.pl=A0=A0=A0=A0=A0=A0=20
2009-05-21 01:08:14.747493000 -0700<br>+++ genhtml.pl=A0 2009-05-22=20
02:07:47.756226000 -0700<br>@@ -116,18 +116,18=20
@@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
}</span></font></font></font></div>
<div><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
#=A0 Read test result parameters and test=20
output<br>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
while ($line !~ /$end_tag/)=20
{<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
while (1)=20
{<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
get_line(\$line) or last=20
TEST;<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
last if $line =3D~=20
/$end_tag/;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=20
($read_output =3D 1, next) if $line =3D~=20
/$output_tag/;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=20
($read_output =3D 0, next) if $line =3D~=20
/$execution_tag/;<br>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
if ($read_output)=20
{<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
if ($read_output or $line !~ /^(\s*\w+=3D(&quot;.*&quot;|\S*))+\s*$/)=20
{<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=20
push @output_lines,=20
$line;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=20
} else=20
{<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=20
while ($line =3D~ s/^\s*(\w+)=3D(&quot;.*&quot;|\S*)//)=20
{<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=20
$values{$1} =3D=20
$2;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
}<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=20
}<br>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
} continue=20
{<br>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
get_line(\$line) or last=20
TEST;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
}</span></font></font></font></div>
<div><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
#=A0 Treat lines that follow &lt;&lt;&lt;end_test&gt;&gt;&gt; as output=20
lines<br></span></font></font></font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span>=A0</span></font></font></font></div></span>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><font color=3D"#0000ff=
"><font size=3D"2"><span></span></font></font></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial" color=3D"#0000ff" size=
=3D"2"></font>=A0</div><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></=
font><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></font><font face=3D=
"Arial" color=3D"#0000ff" size=3D"2"></font><font face=3D"Arial" color=3D"#=
0000ff" size=3D"2"></font><br>

<blockquote dir=3D"ltr" style=3D"padding-left:5px;margin-left:5px;border-le=
ft:#0000ff 2px solid;margin-right:0px">
  <div lang=3D"en-us" dir=3D"ltr" align=3D"left">
  <hr>
  <font face=3D"Tahoma" size=3D"2"><b>From:</b> rohit verma=20
  [mailto:<a href=3D"mailto:rohit.170309@gmail.com" target=3D"_blank">rohit=
.170309@gmail.com</a>] <br><b>Sent:</b> Friday, May 22, 2009=20
  00:13<br><b>To:</b> <a href=3D"mailto:subrata@linux.vnet.ibm.com" target=
=3D"_blank">subrata@linux.vnet.ibm.com</a><br><b>Cc:</b> Marc Gauthier;=20
  LTP List<br><b>Subject:</b> Re: [LTP] [PATCH] Detect test results more=20
  accurately when generating HTML<br></font><br></div><div><div></div><div =
class=3D"h5">
  <div></div>Hi,
  <div><font face=3D"Arial" color=3D"#0000ff" size=3D"2"></font><br></div>
  <div>The suggestion to - &quot;Process test output lines that appear betw=
een=20
  &lt;&lt;&lt;test_end&gt;&gt;&gt;</div>
  <div>and the following &lt;&lt;&lt;test_start&gt;&gt;&gt;. =A0Assign to t=
he=20
  preceding=A0test where the name matches, else to the following test.&quot=
; does=20
  not solve the problem completely.=A0</div>
  <div><br></div>
  <div>My observation is:=A0</div>
  <div><br></div>
  <div>1. Lines between &lt;&lt;&lt;test_end&gt;&gt;&gt; and=20
  &lt;&lt;&lt;test_start&gt;&gt;&gt; belongs to the following test case and=
 not=20
  to the preceding one.</div>
  <div>2. Also, at times I have observed the test output is spread in such =
a way=20
  that few lines of the test output fall between=20
  &lt;&lt;&lt;test_end&gt;&gt;&gt; and &lt;&lt;&lt;test_start&gt;&gt;&gt; a=
nd=20
  rest of lines appear between the &lt;&lt;&lt;test_start&gt;&gt;&gt; and=
=20
  &lt;&lt;&lt;test_output&gt;&gt;&gt; of the corresponding testcase.</div>
  <div><br></div>
  <div>Regards,</div>
  <div>rohit<br><br>
  <div class=3D"gmail_quote">On Fri, May 22, 2009 at 12:22 PM, Subrata Moda=
k <span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com" targe=
t=3D"_blank">subrata@linux.vnet.ibm.com</a>&gt;</span>=20
  wrote:<br>
  <blockquote class=3D"gmail_quote" style=3D"padding-left:1ex;margin:0px 0p=
x 0px 0.8ex;border-left:#ccc 1px solid">On=20
    Thu, 2009-05-21 at 01:13 -0700, Marc Gauthier wrote:<br>&gt; Hi, my fir=
st=20
    patch to this list. =A0Actually not a patch,<br>&gt; but the files=20
    themselves, to avoid line-wrapping issues<br>&gt; and because the diff =
is=20
    twice the size of the new file.<br>&gt;<br>&gt; -Marc<br><br>Thanks=20
    Marc.<br><br>Rohit,<br><br>Can you test this and see if these solves th=
e=20
    problem that you were<br>discussing for long=20
    ?<br><br>Regards--<br>Subrata<br><br>&gt;<br>&gt;<br>&gt;=20
    -----------<br>&gt; Detect test results more accurately when generating=
=20
    HTML<br>&gt;<br>&gt; Process test output lines that appear between=20
    &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&gt; and the following=20
    &lt;&lt;&lt;test_start&gt;&gt;&gt;. =A0Assign to the preceding<br>&gt;=
=20
    test where the name matches, else to the following test.<br>&gt;<br>&gt=
; If=20
    a single test has multiple types of results (e.g. both<br>&gt; FAIL and=
=20
    WARN), report only the most significant one, to<br>&gt; avoid mis-compu=
ting=20
    the total number of PASS tests or<br>&gt; total counts that don&#39;t a=
dd up to=20
    the number of tests.<br>&gt;<br>&gt; If a test&#39;s output has no expl=
icit=20
    result (PASS, FAIL, etc),<br>&gt; look at the exit value to determine=
=20
    whether it passed.<br>&gt;<br>&gt; Setting the SHOW_UNRESOLVED environm=
ent=20
    variable to 1<br>&gt; classifies as UNRESOLVED any test with no explici=
t=20
    result<br>&gt; and a zero exit code.<br>&gt;<br>&gt; Setting the=20
    SUMMARY_OUTPUT environment variable to 1<br>&gt; causes only one line o=
f=20
    output per test to be shown, for a<br>&gt; tighter page that allows qui=
ckly=20
    scanning the results.<br>&gt;<br>&gt; Show percentage of each result ty=
pe in=20
    summary section.<br>&gt;<br>&gt; Simplify parsing a bit.<br>&gt;<br>&gt=
;=20
    Signed-off-by: =A0Marc Gauthier &lt;<a href=3D"mailto:marc@tensilica.co=
m" target=3D"_blank">marc@tensilica.com</a>&gt;<br>&gt;<br>&gt;=20
    -----------------------------------------------------------------------=
-------<br>&gt;=20
    Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT<br=
>&gt;=20
    is a gathering of tech-side developers &amp; brand creativity professio=
nals.=20
    Meet<br>&gt; the minds behind Google Creative Lab, Visual Complexity,=
=20
    Processing, &amp;<br>&gt; iPhoneDevCamp asthey present alongside digita=
l=20
    heavyweights like Barbarian<br>&gt; Group, R/GA, &amp; Big Spaceship. <=
a href=3D"http://www.creativitycat.com" target=3D"_blank">http://www.creati=
vitycat.com</a><br>&gt;=20
    _______________________________________________ Ltp-list mailing list <=
a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-list=
@lists.sourceforge.net</a>=20
    <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targe=
t=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br><=
br></blockquote></div><br></div></div></div></blockquote></div>
</blockquote></div><br>

--0016364c7edd33cfa7046a7cd9bc--


--===============8435737461727330266==
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
--===============8435737461727330266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8435737461727330266==--

