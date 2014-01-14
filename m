Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ashagow@gmail.com>) id 1W33Ph-0005WH-7I
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 12:48:13 +0000
Received: from mail-we0-f178.google.com ([74.125.82.178])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W33PZ-0005MK-3y
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 12:48:13 +0000
Received: by mail-we0-f178.google.com with SMTP id t60so333895wes.9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jan 2014 04:47:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADqC_HrK3E-yrpMFkKAgEg=Eyt9GO0TafKcmD9eG4ZL2zhBVCA@mail.gmail.com>
References: <CADqC_Hq=ivTffZYogdg9doXU1zdGJZM34OhM0deuHJ7RNrO-Gg@mail.gmail.com>
	<CADqC_HrK3E-yrpMFkKAgEg=Eyt9GO0TafKcmD9eG4ZL2zhBVCA@mail.gmail.com>
Date: Tue, 14 Jan 2014 18:17:58 +0530
Message-ID: <CADqC_HqOtR3MuPBOsKkvX186+mf_s-Egfuju7dfByasJgwnTOw@mail.gmail.com>
From: Asha Gowda <ashagow@gmail.com>
Subject: Re: [LTP] Issue with commands
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8897692193479295829=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8897692193479295829==
Content-Type: multipart/alternative; boundary=047d7b86df6620a9f704efed9a1c

--047d7b86df6620a9f704efed9a1c
Content-Type: text/plain; charset=ISO-8859-1

HI,

Actually I am getting the same response for all the commands listed before
"sh: $'mail_tests.sh\r': command not found"

What could be the issue?

Thanks,
Asha


On Tue, Jan 14, 2014 at 6:16 PM, Asha Gowda <ashagow@gmail.com> wrote:

> HI,
>
> Actually I am getting the same response for all the commands listed before
> "sh: $'mail_tests.sh\r': command not found"
>
> What could be the issue?
>
> Thanks,
> Asha
>
>
> On Tue, Jan 14, 2014 at 6:09 PM, Asha Gowda <ashagow@gmail.com> wrote:
>
>> Hi,
>>
>> I am trting to run SEPtember LTP release and found that commands are not
>> working for me : Here are the logs : Can you please let mek now the issues:
>>
>>
>> Running tests.......
>> <<<test_start>>>
>> tag=ar stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; ar01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'ar01\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=ld stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; ld01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'ld01\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=ldd stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; ldd01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'ldd01\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=nm stime=4106
>>  "mdline="export TCdat=$LTPROOT/testcases/bin; nm01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'nm01\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=objdump stime=4106
>> "mdline="export TCsrc=$LTPROOT/testcases/bin; objdump01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'objdump01\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=file stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; file_test.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'file_test.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=tar stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; tar_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'tar_tests.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=cron stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; cron_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'cron_tests.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=logrotate stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'logrotate_tests.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=mail stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; mail_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'mail_tests.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=cpio stime=4106
>> "mdline="export TCdat=$LTPROOT/testcases/bin; cpio_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> sh: $'cpio_tests.sh\r': command not found
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=unzip01 stime=4106
>> "mdline="unzip_tests.sh $LTPROOT/testcases/data/tst_unzip_file.zip
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> ': No such file or directorySEP/ltp/testcases/data/tst_unzip_file.zip
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=1 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=gzip01 stime=4106
>> "mdline="gzip_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag gzip01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=cp_tests01 stime=4106
>> "mdline="cp_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag cp_tests01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=ln_tests01 stime=4106
>> "mdline="ln_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag ln_tests01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=mkdir_tests01 stime=4106
>> "mdline="mkdir_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag mkdir_tests01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=mv_tests01 stime=4106
>> "mdline="mv_tests.sh
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag mv_tests01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=size01 stime=4106
>> "mdline="size01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag size01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=sssd01 stime=4106
>> "mdline="sssd01
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag sssd01) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=sssd02 stime=4106
>> "mdline="sssd02
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag sssd02) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=sssd03 stime=4106
>> "mdline="sssd03
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> <<<execution_status>>>
>> ' (tag sssd03) failed.  errno:2  No such file or directory"
>> duration=0 termination_type=exited termination_id=2 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> incrementing stop
>> INFO: ltp-pan reported some tests FAIL
>> LTP Version: 20130904
>>
>> Thanks,
>> Asha
>>
>
>

--047d7b86df6620a9f704efed9a1c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" style=3D"font-family:arial,sans-serif;fon=
t-size:13px">HI,<div><br></div><div>Actually I am getting the same response=
 for all the commands listed before &quot;sh: $&#39;mail_tests.sh\r&#39;: c=
ommand not found&quot;</div>
<div><br></div><div>What could be the issue?</div><div><br></div><div>Thank=
s,</div><div>Asha</div></div><div class=3D"" style=3D"font-family:arial,san=
s-serif;font-size:13px"><div id=3D":16z" class=3D"" tabindex=3D"0"><img cla=
ss=3D"" src=3D"https://mail.google.com/mail/u/0/images/cleardot.gif" style=
=3D""></div>
</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Tue, Jan 14, 2014 at 6:16 PM, Asha Gowda <span dir=3D"ltr">&lt;<a href=3D=
"mailto:ashagow@gmail.com" target=3D"_blank">ashagow@gmail.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">HI,<div><br></div><div>Actu=
ally I am getting the same response for all the commands listed before &quo=
t;sh: $&#39;mail_tests.sh\r&#39;: command not found&quot;</div>
<div><br></div><div>What could be the issue?</div>
<div><br></div><div>Thanks,</div><div>Asha</div></div><div class=3D"HOEnZb"=
><div class=3D"h5"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_q=
uote">On Tue, Jan 14, 2014 at 6:09 PM, Asha Gowda <span dir=3D"ltr">&lt;<a =
href=3D"mailto:ashagow@gmail.com" target=3D"_blank">ashagow@gmail.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I am=
 trting to run SEPtember LTP release and found that commands are not workin=
g for me : Here are the logs : Can you please let mek now the issues:</div>

<div><br></div><div><br></div>
<div><div>Running tests.......</div><div>&lt;&lt;&lt;test_start&gt;&gt;&gt;=
</div><div>tag=3Dar stime=3D4106</div><div>&quot;mdline=3D&quot;export TCda=
t=3D$LTPROOT/testcases/bin; ar01</div><div>contacts=3D&quot;&quot;</div><di=
v>analysis=3Dexit</div>


<div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>sh: $&#39;ar01\r&#39;: c=
ommand not found</div><div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><d=
iv>initiation_status=3D&quot;ok&quot;</div><div>duration=3D0 termination_ty=
pe=3Dexited termination_id=3D127 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dld stime=3D4106</di=
v><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; ld01</di=
v><div>

contacts=3D&quot;&quot;</div>
<div>analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><di=
v>sh: $&#39;ld01\r&#39;: command not found</div><div>&lt;&lt;&lt;execution_=
status&gt;&gt;&gt;</div><div>initiation_status=3D&quot;ok&quot;</div><div>

duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=3Dno</=
div>
<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dldd stime=3D4106</d=
iv><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; ldd01</=
div><div>


contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&lt;tes=
t_output&gt;&gt;&gt;</div><div>sh: $&#39;ldd01\r&#39;: command not found</d=
iv><div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>initiation_statu=
s=3D&quot;ok&quot;</div>


<div>duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=
=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt=
;&gt;</div><div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dnm stime=
=3D4106</div>

<div>
&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; nm01</div><div>=
contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&lt;tes=
t_output&gt;&gt;&gt;</div><div>sh: $&#39;nm01\r&#39;: command not found</di=
v><div>


&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>initiation_status=3D&quo=
t;ok&quot;</div><div>duration=3D0 termination_type=3Dexited termination_id=
=3D127 corefile=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;=
test_end&gt;&gt;&gt;</div>


<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dobjdump stime=3D410=
6</div><div>&quot;mdline=3D&quot;export TCsrc=3D$LTPROOT/testcases/bin; obj=
dump01</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><di=
v>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>


<div>sh: $&#39;objdump01\r&#39;: command not found</div><div>&lt;&lt;&lt;ex=
ecution_status&gt;&gt;&gt;</div><div>initiation_status=3D&quot;ok&quot;</di=
v><div>duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=
=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dfile stime=3D4106</=
div><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; file_t=
est.sh</div>


<div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&l=
t;test_output&gt;&gt;&gt;</div><div>sh: $&#39;file_test.sh\r&#39;: command =
not found</div><div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>init=
iation_status=3D&quot;ok&quot;</div>


<div>duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=
=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt=
;&gt;</div><div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dtar stim=
e=3D4106</div>


<div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; tar_tests.=
sh</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&l=
t;&lt;&lt;test_output&gt;&gt;&gt;</div><div>sh: $&#39;tar_tests.sh\r&#39;: =
command not found</div>


<div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>initiation_status=
=3D&quot;ok&quot;</div><div>duration=3D0 termination_type=3Dexited terminat=
ion_id=3D127 corefile=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&l=
t;&lt;test_end&gt;&gt;&gt;</div>


<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dcron stime=3D4106</=
div><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; cron_t=
ests.sh</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><d=
iv>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>


<div>sh: $&#39;cron_tests.sh\r&#39;: command not found</div><div>&lt;&lt;&l=
t;execution_status&gt;&gt;&gt;</div><div>initiation_status=3D&quot;ok&quot;=
</div><div>duration=3D0 termination_type=3Dexited termination_id=3D127 core=
file=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dlogrotate stime=3D4=
106</div><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; l=
ogrotate_tests.sh</div>


<div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&l=
t;test_output&gt;&gt;&gt;</div><div>sh: $&#39;logrotate_tests.sh\r&#39;: co=
mmand not found</div><div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><di=
v>


initiation_status=3D&quot;ok&quot;</div><div>duration=3D0 termination_type=
=3Dexited termination_id=3D127 corefile=3Dno</div><div>cutime=3D0 cstime=3D=
0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div><div>&lt;&lt;&lt;test_sta=
rt&gt;&gt;&gt;</div>


<div>tag=3Dmail stime=3D4106</div><div>&quot;mdline=3D&quot;export TCdat=3D=
$LTPROOT/testcases/bin; mail_tests.sh</div><div>contacts=3D&quot;&quot;</di=
v><div>analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><=
div>sh: $&#39;mail_tests.sh\r&#39;: command not found</div>


<div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>initiation_status=
=3D&quot;ok&quot;</div><div>duration=3D0 termination_type=3Dexited terminat=
ion_id=3D127 corefile=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&l=
t;&lt;test_end&gt;&gt;&gt;</div>


<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dcpio stime=3D4106</=
div><div>&quot;mdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; cpio_t=
ests.sh</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><d=
iv>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>


<div>sh: $&#39;cpio_tests.sh\r&#39;: command not found</div><div>&lt;&lt;&l=
t;execution_status&gt;&gt;&gt;</div><div>initiation_status=3D&quot;ok&quot;=
</div><div>duration=3D0 termination_type=3Dexited termination_id=3D127 core=
file=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dunzip01 stime=3D410=
6</div><div>&quot;mdline=3D&quot;unzip_tests.sh $LTPROOT/testcases/data/tst=
_unzip_file.zip</div>


<div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&l=
t;test_output&gt;&gt;&gt;</div><div>&#39;: No such file or directorySEP/ltp=
/testcases/data/tst_unzip_file.zip</div><div>&lt;&lt;&lt;execution_status&g=
t;&gt;&gt;</div>


<div>initiation_status=3D&quot;ok&quot;</div><div>duration=3D0 termination_=
type=3Dexited termination_id=3D1 corefile=3Dno</div><div>cutime=3D0 cstime=
=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div><div>&lt;&lt;&lt;test_=
start&gt;&gt;&gt;</div>


<div>tag=3Dgzip01 stime=3D4106</div><div>&quot;mdline=3D&quot;gzip_tests.sh=
</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&lt;=
&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt;&lt;&lt;execution_status&gt;&=
gt;&gt;</div>


<div>&#39; (tag gzip01) failed. =A0errno:2 =A0No such file or directory&quo=
t;</div><div>duration=3D0 termination_type=3Dexited termination_id=3D2 core=
file=3Dno</div><div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt=
;&gt;&gt;</div>


<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dcp_tests01 stime=3D=
4106</div><div>&quot;mdline=3D&quot;cp_tests.sh</div><div>contacts=3D&quot;=
&quot;</div><div>analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&=
gt;</div>


<div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag cp_tests=
01) failed. =A0errno:2 =A0No such file or directory&quot;</div><div>duratio=
n=3D0 termination_type=3Dexited termination_id=3D2 corefile=3Dno</div><div>=
cutime=3D0 cstime=3D0</div>


<div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div><div>&lt;&lt;&lt;test_start&gt;&=
gt;&gt;</div><div>tag=3Dln_tests01 stime=3D4106</div><div>&quot;mdline=3D&q=
uot;ln_tests.sh</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit=
</div>


<div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt;&lt;&lt;execution_st=
atus&gt;&gt;&gt;</div><div>&#39; (tag ln_tests01) failed. =A0errno:2 =A0No =
such file or directory&quot;</div><div>duration=3D0 termination_type=3Dexit=
ed termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dmkdir_tests01 stime=
=3D4106</div><div>&quot;mdline=3D&quot;mkdir_tests.sh</div><div>contacts=3D=
&quot;&quot;</div>


<div>analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><di=
v>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag mkdir_tests=
01) failed. =A0errno:2 =A0No such file or directory&quot;</div><div>duratio=
n=3D0 termination_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dmv_tests01 stime=3D=
4106</div><div>&quot;mdline=3D&quot;mv_tests.sh</div><div>contacts=3D&quot;=
&quot;</div>


<div>analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><di=
v>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag mv_tests01)=
 failed. =A0errno:2 =A0No such file or directory&quot;</div><div>duration=
=3D0 termination_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dsize01 stime=3D4106=
</div><div>&quot;mdline=3D&quot;size01</div><div>contacts=3D&quot;&quot;</d=
iv><div>


analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag size01) failed. =
=A0errno:2 =A0No such file or directory&quot;</div><div>duration=3D0 termin=
ation_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dsssd01 stime=3D4106=
</div><div>&quot;mdline=3D&quot;sssd01</div><div>contacts=3D&quot;&quot;</d=
iv><div>


analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag sssd01) failed. =
=A0errno:2 =A0No such file or directory&quot;</div><div>duration=3D0 termin=
ation_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dsssd02 stime=3D4106=
</div><div>&quot;mdline=3D&quot;sssd02</div><div>contacts=3D&quot;&quot;</d=
iv><div>


analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag sssd02) failed. =
=A0errno:2 =A0No such file or directory&quot;</div><div>duration=3D0 termin=
ation_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dsssd03 stime=3D4106=
</div><div>&quot;mdline=3D&quot;sssd03</div><div>contacts=3D&quot;&quot;</d=
iv><div>


analysis=3Dexit</div><div>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>&#39; (tag sssd03) failed. =
=A0errno:2 =A0No such file or directory&quot;</div><div>duration=3D0 termin=
ation_type=3Dexited termination_id=3D2 corefile=3Dno</div>


<div>cutime=3D0 cstime=3D0</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>=
<div>incrementing stop</div><div>INFO: ltp-pan reported some tests FAIL</di=
v><div>LTP Version: 20130904</div></div><div><br></div><div>Thanks,</div><d=
iv>


Asha</div></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--047d7b86df6620a9f704efed9a1c--


--===============8897692193479295829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
--===============8897692193479295829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8897692193479295829==--

