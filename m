Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEF1C00140
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 19:25:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B029E3C1DFE
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 21:25:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3F0A3C08D9
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 21:25:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D92231000A66
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 21:25:22 +0200 (CEST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 548723F0DA
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 19:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658863521;
 bh=B94RTLZvHzrAbiBsiO9TtYGq89dSf0binR18kCUwXBo=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=MTFQwAV+no9s8WJRYMgmgkDwUzLOQutCZHHV/fuwS587xnBeSeV5NHxdQlKLnV8w7
 TXx3r2PCrrqc65bT2tUwcXjKybl8QsAWdjtXStw5hS2bImL0dALGi++7Yqt9itGR97
 QZCpx3FuA6HWcv9JXgo/+wZoA/+EYS3A8/wwNZVF4hiFVfknZk0uDgGWUwDRQiIXSa
 4NE9QQ+LYChfC0XhYUfea8Nu97/vU21eYXzAf3ORx3U9y7X5SnGfcP0NX1SLovTF7I
 t142avXtuI9/dfs+OnaZSp+On9gvBjts3+8SL87KVh2RdMW5cxbv8OmGH7bZ530OQg
 V4CGd8efAD9wA==
Received: by mail-ed1-f69.google.com with SMTP id
 g15-20020a056402424f00b0043bff7a68dbso3984970edb.10
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 12:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=B94RTLZvHzrAbiBsiO9TtYGq89dSf0binR18kCUwXBo=;
 b=mfsbSSTgAEOYIRt/5YCkswO0k/OoqsFRMx5QwvW/zH6BpSmB2RtxAkZ9HubdsiZhwA
 Wpy1nZVs2ewOSl7evznw05j0T8d60JN8/ai714U6tOHyUd8pFjGnAscx4e0WhQir3IHz
 pakxTCk+Ma8j51Uy9f0PKrXzV70Fd4Z3xaGtnjx7Yehi3eF0npvMP45lY/NgVMwZuoXP
 gd2wrOLVpU01Yyr9qFWmJyRzPv8VG24PqfXmNjTOwlqLrvv6bH1p892uu99CRMIWPa1J
 pSuAO9vSKoNnzuLTRLzo7zXL0dC2/7TypVg+dopOADbjD+nmfGmswtzluWqjIQ0oAWG1
 tEHA==
X-Gm-Message-State: AJIora9uGX1V5LrRX326u3eR/2jPXqb7Guga2aP1aIOdlTdwmzj2XNKl
 cSD5OsVf0BdZbUlDc0guE3tAjcjUUHEThwekkqzuCiSTvPBkXhSJHEelvNrHvVTbmc8wEgER9E7
 OGhjV+7Ae2v1tXWhpV3hyshvnUNdoNmOWnQr66nKJFEm1
X-Received: by 2002:a17:907:3f1a:b0:72b:394b:ad32 with SMTP id
 hq26-20020a1709073f1a00b0072b394bad32mr15064600ejc.445.1658863521048; 
 Tue, 26 Jul 2022 12:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vEEbLqyj5h2ZavDjJFAKrj5n44OU/q9c+HKlOaFRM/SQfGZug+IRYwbVxkzlKPb6d8YRaZKD2/iBlUCTx2pdE=
X-Received: by 2002:a17:907:3f1a:b0:72b:394b:ad32 with SMTP id
 hq26-20020a1709073f1a00b0072b394bad32mr15064583ejc.445.1658863520786; Tue, 26
 Jul 2022 12:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <d2355625a3b0bd7cac07fc2e80098ca2c59d10b1.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <Yt/oOuaJU3ExV5f9@pevik>
In-Reply-To: <Yt/oOuaJU3ExV5f9@pevik>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Tue, 26 Jul 2022 12:24:44 -0700
Message-ID: <CADS1e3f=RhQA51Ee3HDJfThQycupyH=uR3nG2dNrMgjHHohZeA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 10/18] controllers: Expand cgroup_lib shell
 library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0840964310=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0840964310==
Content-Type: multipart/alternative; boundary="000000000000e3467a05e4ba42db"

--000000000000e3467a05e4ba42db
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Tue, Jul 26, 2022 at 6:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Luke,
>
> ...
> > +# Gets the cgroup version of the given controller
> > +# USAGE: cgroup_get_version CONTROLLER
> > +# RETURNS: "1" if version 1 and "2" if version 2
> > +# Must call cgroup_require before calling
> > +cgroup_get_version()
> >  {
> > -     local subsystem=$1
> > -     local mntpoint
> > +     local ctrl="$1"
> > +     local version
>
> > -     [ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem
> not defined"
> > +     [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not
> defined"
> NOTE: this will always pass, because you pass variable in ""
> (thus $1 = "" and $# = 1):
> cgroup_get_task_list()
> {
>         local ctrl="$1"
>         version=$(cgroup_get_version "$ctrl")
>
>
Yes this is true when using this function by other functions in the
library. The use case where this would fail is when someone calls it from a
test and forgets to pass a controller to it or something like that.


> > +     [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No
> previous state found. Forgot to call cgroup_require?"
>
> > -     mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{
> print $2 }')
> > -     [ -z "$mntpoint" ] && return 1
> > +     version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print
> $2 }')
> > +     [ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could
> not find controller $ctrl"
> > +
> > +     echo "$version"
>
> > -     echo $mntpoint
> >       return 0
> >  }
> ...
>
> > +# Mounts and configures the given controller
> > +# USAGE: cgroup_require CONTROLLER
> > +cgroup_require()
> > +{
> > +     local ctrl="$1"
> > +
> > +     [ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not
> defined"
> > +
> > +     [ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support
> control groups"
> > +
> > +     _cgroup_state=$(tst_cgctl require "$ctrl" $$)
> > +
> > +     if [ $? -eq 32 ]; then
> > +             tst_brk TCONF "'tst_cgctl require' exited. Controller is
> probably not available?"
> > +     fi
> > +
> > +     if [ $? -ne 0 ]; then
> > +             tst_brk TBROK "'tst_cgctl require' exited."
> > +     fi
> FYI if cgroup_require is called from cleanup function tst_brk does not
> exit the
> code:
>
> tst_brk()
> {
>         local res=$1
>         shift
>
>         if [ "$TST_DO_EXIT" = 1 ]; then
>                 tst_res TWARN "$@"
>                 return
>         fi
>
>         tst_res "$res" "$@"
>         _tst_do_exit
> }
>
> IMHO that means that $? became 0 even it was previously 32.
> It's always safer to save $? into local variable if needed to store exit
> code
> (otherwise using if, e.g. "if ! foo; then" is preferred).
>
>
That's a good point. I'll just save the return and propagate the return
code.



> NOTE: Maybe at this point it might be safer if you post next version
> where you do fixes yourself. I'll try to review the rest of the shell
> scripts
> today (C code looks correct to me).
>
>
Yeah, I will rebase and resubmit with the fixes people have mentioned.


> Kind regards,
> Petr
>

--000000000000e3467a05e4ba42db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Petr, <br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 26, 2022 at 6:12 AM Petr Vor=
el &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Luke,<br>
<br>
...<br>
&gt; +# Gets the cgroup version of the given controller<br>
&gt; +# USAGE: cgroup_get_version CONTROLLER<br>
&gt; +# RETURNS: &quot;1&quot; if version 1 and &quot;2&quot; if version 2<=
br>
&gt; +# Must call cgroup_require before calling<br>
&gt; +cgroup_get_version()<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0local subsystem=3D$1<br>
&gt; -=C2=A0 =C2=A0 =C2=A0local mntpoint<br>
&gt; +=C2=A0 =C2=A0 =C2=A0local ctrl=3D&quot;$1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0local version<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quot;get_c=
group_mountpoint: subsystem not defined&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quot;cgrou=
p_get_version: controller not defined&quot;<br>
NOTE: this will always pass, because you pass variable in &quot;&quot;<br>
(thus $1 =3D &quot;&quot; and $# =3D 1):<br>
cgroup_get_task_list()<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local ctrl=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 version=3D$(cgroup_get_version &quot;$ctrl&quot=
;)<br>
<br></blockquote><div><br></div><div>Yes this is true when using this funct=
ion by other functions in the library. The use case where this would fail i=
s when someone calls it from a test and forgets to pass a controller to it =
or something like that.<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0[ &quot;$_cgroup_state&quot; =3D &quot;&quot; ] &=
amp;&amp; tst_brk TBROK &quot;cgroup_get_version: No previous state found. =
Forgot to call cgroup_require?&quot;<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mntpoint=3D$(grep cgroup /proc/mounts | grep -w $=
subsystem | awk &#39;{ print $2 }&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[ -z &quot;$mntpoint&quot; ] &amp;&amp; return 1<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0version=3D$(echo &quot;$_cgroup_state&quot; | gre=
p -w &quot;^$ctrl&quot; | awk &#39;{ print $2 }&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[ &quot;$version&quot; =3D &quot;&quot; ] &amp;&a=
mp; tst_brk TBROK &quot;cgroup_get_version: Could not find controller $ctrl=
&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0echo &quot;$version&quot;<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0echo $mntpoint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
&gt;=C2=A0 }<br>
...<br>
<br>
&gt; +# Mounts and configures the given controller<br>
&gt; +# USAGE: cgroup_require CONTROLLER<br>
&gt; +cgroup_require()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0local ctrl=3D&quot;$1&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quot;cgrou=
p_require: controller not defined&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[ ! -f /proc/cgroups ] &amp;&amp; tst_brk TCONF &=
quot;Kernel does not support control groups&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_cgroup_state=3D$(tst_cgctl require &quot;$ctrl&q=
uot; $$)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ $? -eq 32 ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk TCONF &quot;&=
#39;tst_cgctl require&#39; exited. Controller is probably not available?&qu=
ot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk TBROK &quot;&=
#39;tst_cgctl require&#39; exited.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
FYI if cgroup_require is called from cleanup function tst_brk does not exit=
 the<br>
code:<br>
<br>
tst_brk()<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local res=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 shift<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$TST_DO_EXIT&quot; =3D 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TWARN &quot=
;$@&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res &quot;$res&quot; &quot;$@&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 _tst_do_exit<br>
}<br>
<br>
IMHO that means that $? became 0 even it was previously 32.<br>
It&#39;s always safer to save $? into local variable if needed to store exi=
t code<br>
(otherwise using if, e.g. &quot;if ! foo; then&quot; is preferred).<br>
<br></blockquote><div><br></div><div>That&#39;s a good point. I&#39;ll just=
 save the return and propagate the return code.<br></div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
NOTE: Maybe at this point it might be safer if you post next version<br>
where you do fixes yourself. I&#39;ll try to review the rest of the shell s=
cripts<br>
today (C code looks correct to me).<br>
<br></blockquote><div><br></div><div>Yeah, I will rebase and resubmit with =
the fixes people have mentioned.<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
Kind regards,<br>
Petr<br>
</blockquote></div></div>

--000000000000e3467a05e4ba42db--

--===============0840964310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0840964310==--
