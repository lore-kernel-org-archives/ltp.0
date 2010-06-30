Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1OTqDS-00026m-AI
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 05:52:10 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTqDR-0006Mk-8x
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 05:52:10 +0000
Received: by pvg13 with SMTP id 13so248892pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Jun 2010 22:52:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
References: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
	<AANLkTimZ-GQtuu-_1pB_Llzrr46CE0EbEFnd_OnjnjmF@mail.gmail.com>
	<AANLkTim0JhFpvTVlo-DMkhjdWzcuf1ob3nUWpkK-vT9y@mail.gmail.com>
	<AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
Date: Wed, 30 Jun 2010 11:22:03 +0530
Message-ID: <AANLkTikq5Jm3gSg9v51GAzi55i9ToNw92lICYf8NXVIL@mail.gmail.com>
From: vishwanath govind <vishwa.hochihally@gmail.com>
Subject: Re: [LTP] Not cloning all the files from ltp-dev
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4189746626828161569=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4189746626828161569==
Content-Type: multipart/alternative; boundary=00504502ad41ffcb34048a38f30e

--00504502ad41ffcb34048a38f30e
Content-Type: text/plain; charset=ISO-8859-1

Hi,
+ I try to make install as non-root user here. Any thoughts?

Regards
Vishwa

On Tue, Jun 29, 2010 at 5:22 PM, vishwanath govind <
vishwa.hochihally@gmail.com> wrote:

> Hi,
> I am facing one more issue now. I am able to build but not able to install
> properly. Here are my steps. Since I am working on server,  root permisision
> is restricted and have 777 permission on directory that i am working. There
> is no autconf/aclocal tools too
>
> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
> # cd ltp
> # cp include/config.h.default  include/config.h
> #cp include/mk/config.mk.default   include/mk/config.mk
> # Mention the PATH for cross-compiler path for CC, AR, STRIP etc and also
> prefix(/*home/vgovinda/ltp_install')*
> # make
> # make install
>
> Here it's not able to create `/projects/test/ltp/ltp_install` and why is it
> creating dir /share instead of /*home/vgovinda/ltp_install/share.*
>
> =================================================================
>
> *Makefile:176: warning: overriding commands for target
> `//home/vgovinda/ltp_install'
> Makefile:106: warning: ignoring old commands for target
> `//home/vgovinda/ltp_install'
> *make: Circular //home/vgovinda/ltp_install <- //home/vgovinda/ltp_install
> dependency dropped.
> make -C "doc" \
>                 -f "/projects/test/ltp/doc/Makefile" install
> make[1]: Entering directory `/projects/test/ltp/doc'
> make[2]: Entering directory `/projects/test/ltp/doc/man1'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:90: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> mkdir -p "/share/man/man1"
> mkdir: cannot create directory `/share': Permission denied
> ===========================================================================
>
> Any thoughts on this would be appriciated?
>
> Regards
> Vishwa
>
>   On Mon, Jun 28, 2010 at 2:33 PM, vishwanath govind <
> vishwa.hochihally@gmail.com> wrote:
>
>> Thanks Garrett.
>> Regards
>> Vishwa
>>
>>   On Mon, Jun 28, 2010 at 1:22 PM, Garrett Cooper <yanegomi@gmail.com>wrote:
>>
>>>  On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind
>>> <vishwa.hochihally@gmail.com> wrote:
>>> > Hi,
>>> >  I have tried to clone the latest LTP source through GIT but missing
>>> > "configure" file in it.
>>> >
>>> > Here are my steps:
>>> >
>>> >   # git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
>>> >
>>> >  # ls ltp
>>> > COPYING  ChangeLog   INSTALL   Makefile.release  README.ltp-devel.in<http://readme.ltp-devel.in/>
>>> > TODO          doc         include  ltp-devel.spec.in  m4   result
>>> > runltp         runtest  testcases    tools  ver_linux
>>> > CREDITS  IDcheck.sh  Makefile  README            README.mk-devel
>>> > configure.ac  execltp.in  lib      ltpmenu            pan
>>> runalltests.sh
>>> > runltplite.sh  scripts  testscripts  utils
>>> > Why is "configure" file is missing here?
>>> >
>>> > Please let me know your thoughts?
>>>
>>> configure should never be checked in to git.
>>>
>>> Read INSTALL for more details on how to generate it.
>>>
>>> Thanks,
>>> -Garrett
>>>
>>
>>
>

--00504502ad41ffcb34048a38f30e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>+ I try to make install as non-root user here. Any thoughts?<br>=A0<=
br>Regards<br>Vishwa<br><br>
<div class=3D"gmail_quote">On Tue, Jun 29, 2010 at 5:22 PM, vishwanath govi=
nd <span dir=3D"ltr">&lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vis=
hwa.hochihally@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi,</div>
<div>I am facing one more issue now. I am able to build but not able to ins=
tall properly. Here are my steps. Since=A0I am working on server,=A0 root p=
ermisision is restricted and=A0have 777 permission on=A0directory that i am=
 working. There is no autconf/aclocal=A0tools too</div>

<div>=A0</div>
<div># git clone git://<a href=3D"http://ltp.git.sourceforge.net/gitroot/lt=
p/ltp-dev.git" target=3D"_blank">ltp.git.sourceforge.net/gitroot/ltp/ltp-de=
v.git</a> ltp</div>
<div># cd ltp</div>
<div># cp include/config.h.default=A0 include/config.h<br>#cp include/mk/co=
nfig.mk.default=A0=A0 include/mk/<a href=3D"http://config.mk/" target=3D"_b=
lank">config.mk</a></div>
<div># Mention the PATH for cross-compiler path for CC, AR, STRIP etc and a=
lso prefix(/<strong>home/vgovinda/ltp_install&#39;)</strong></div>
<div># make=A0</div>
<div># make install=A0=A0</div>
<div>=A0</div>
<div>Here it&#39;s not able to create `/projects/test/ltp/ltp_install` and =
why is it creating dir /share instead of /<strong>home/vgovinda/ltp_install=
/share.</strong></div>
<div>=A0</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>=A0</div>
<div><strong>Makefile:176: warning: overriding commands for target `//home/=
vgovinda/ltp_install&#39;<br>Makefile:106: warning: ignoring old commands f=
or target `//home/vgovinda/ltp_install&#39;<br></strong>make: Circular //ho=
me/vgovinda/ltp_install &lt;- //home/vgovinda/ltp_install dependency droppe=
d.<br>
make -C &quot;doc&quot; \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
-f &quot;/projects/test/ltp/doc/Makefile&quot; install<br>make[1]: Entering=
 directory `/projects/test/ltp/doc&#39;<br>make[2]: Entering directory `/pr=
ojects/test/ltp/doc/man1&#39;<br>
../../include/mk/<a href=3D"http://env_post.mk:91/" target=3D"_blank">env_p=
ost.mk:91</a>: warning: overriding commands for target `/home/vgovinda/ltp_=
install&#39;<br>../../include/mk/<a href=3D"http://env_post.mk:90/" target=
=3D"_blank">env_post.mk:90</a>: warning: ignoring old commands for target `=
/home/vgovinda/ltp_install&#39;<br>
../../include/mk/<a href=3D"http://env_post.mk:91/" target=3D"_blank">env_p=
ost.mk:91</a>: warning: overriding commands for target `/home/vgovinda/ltp_=
install&#39;<br>../../include/mk/<a href=3D"http://env_post.mk:91/" target=
=3D"_blank">env_post.mk:91</a>: warning: ignoring old commands for target `=
/home/vgovinda/ltp_install&#39;<br>
../../include/mk/<a href=3D"http://env_post.mk:91/" target=3D"_blank">env_p=
ost.mk:91</a>: warning: overriding commands for target `/home/vgovinda/ltp_=
install&#39;<br>../../include/mk/<a href=3D"http://env_post.mk:91/" target=
=3D"_blank">env_post.mk:91</a>: warning: ignoring old commands for target `=
/home/vgovinda/ltp_install&#39;<br>
../../include/mk/<a href=3D"http://env_post.mk:91/" target=3D"_blank">env_p=
ost.mk:91</a>: warning: overriding commands for target `/home/vgovinda/ltp_=
install&#39;<br>../../include/mk/<a href=3D"http://env_post.mk:91/" target=
=3D"_blank">env_post.mk:91</a>: warning: ignoring old commands for target `=
/home/vgovinda/ltp_install&#39;<br>
mkdir -p &quot;/share/man/man1&quot;<br>mkdir: cannot create directory `/sh=
are&#39;: Permission denied<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>=A0</div>
<div>Any thoughts on this would be appriciated?</div>
<div>=A0</div>
<div>Regards</div>
<div>Vishwa<br><br></div>
<div>
<div></div>
<div class=3D"h5">
<div class=3D"gmail_quote">On Mon, Jun 28, 2010 at 2:33 PM, vishwanath govi=
nd <span dir=3D"ltr">&lt;<a href=3D"mailto:vishwa.hochihally@gmail.com" tar=
get=3D"_blank">vishwa.hochihally@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Thanks Garrett. </div>
<div>Regards</div>
<div>Vishwa<br><br></div>
<div>
<div></div>
<div>
<div class=3D"gmail_quote">On Mon, Jun 28, 2010 at 1:22 PM, Garrett Cooper =
<span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com" target=3D"_blan=
k">yanegomi@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div>On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind<br>&lt;<a href=3D"=
mailto:vishwa.hochihally@gmail.com" target=3D"_blank">vishwa.hochihally@gma=
il.com</a>&gt; wrote:<br>&gt; Hi,<br>&gt; =A0I have tried=A0to clone the la=
test LTP source through GIT but missing<br>
&gt; &quot;configure&quot; file in it.<br>&gt;<br>&gt; Here are my steps:<b=
r>&gt;<br>&gt; =A0 # git://<a href=3D"http://ltp.git.sourceforge.net/gitroo=
t/ltp/ltp-dev.git" target=3D"_blank">ltp.git.sourceforge.net/gitroot/ltp/lt=
p-dev.git</a> ltp<br>
&gt;<br>&gt; =A0# ls ltp<br>&gt; COPYING=A0 ChangeLog=A0=A0 INSTALL=A0=A0 M=
akefile.release=A0 <a href=3D"http://readme.ltp-devel.in/" target=3D"_blank=
">README.ltp-devel.in</a><br>&gt; TODO=A0=A0=A0=A0=A0=A0=A0=A0=A0 doc=A0=A0=
=A0=A0=A0=A0=A0=A0 include=A0 <a href=3D"http://ltp-devel.spec.in/" target=
=3D"_blank">ltp-devel.spec.in</a>=A0 m4=A0=A0 result<br>
&gt; runltp=A0=A0=A0=A0=A0=A0=A0=A0 runtest=A0 testcases=A0=A0=A0 tools=A0 =
ver_linux<br>&gt; CREDITS=A0 IDcheck.sh=A0 Makefile=A0 README=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 README.mk-devel<br>&gt; <a href=3D"http://configure.a=
c/" target=3D"_blank">configure.ac</a>=A0 <a href=3D"http://execltp.in/" ta=
rget=3D"_blank">execltp.in</a>=A0 lib=A0=A0=A0=A0=A0 ltpmenu=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 pan=A0 runalltests.sh<br>
&gt; runltplite.sh=A0 scripts=A0 testscripts=A0 utils<br>&gt; Why is &quot;=
configure&quot; file is missing here?<br>&gt;<br>&gt; Please let me know yo=
ur thoughts?<br><br></div></div>configure should never be checked in to git=
.<br>
<br>Read INSTALL for more details on how to generate it.<br><br>Thanks,<br>=
<font color=3D"#888888">-Garrett<br></font></blockquote></div><br></div></d=
iv></blockquote></div><br></div></div></blockquote></div><br>

--00504502ad41ffcb34048a38f30e--


--===============4189746626828161569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4189746626828161569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4189746626828161569==--

