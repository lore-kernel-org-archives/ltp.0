Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999FC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 21:47:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32F323C9409
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 22:47:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BB5C3C1B7F
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 22:47:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 158321A006FD
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 22:47:19 +0100 (CET)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87BEE3F1AB
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1647467229;
 bh=8qPg52aHqzAUzcvD0/p6+41Q4L3QJY5suXjmdJQ2UkA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=sTuEl+5dJah+22AqoGF52omzcgvXt27a+lY5jKFOjbwiMHfFE5BKFn0YNiVdP35Cn
 H+TzLW7fAZMYoEOQCSJXp/Lwtqyi5zfHOyoxXX75NA9r0cXcByLsCP7OWGrPqoc7Ol
 AdxkqTTn5oKLYNB4n1OzGZOPDfeogDUjGuwzIESTvJ7iZSoy4lgYn/mItBYZwwCX33
 KlwTP0UIrWQ24blJ3mg/LedwUhqaPIA4Kjjg8hAGZYe40lhlQXUJzQPCXupDgg/IFU
 zj9Np9mY9QTTFiKMuOy3hGxqAYMETgpbZX4bptvsb3yzaetg0PGp2Dsr5ulusDotCK
 LLr+NHaGuLLrw==
Received: by mail-ed1-f69.google.com with SMTP id
 k25-20020a50ce59000000b00418b9066e47so1989962edj.22
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 14:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8qPg52aHqzAUzcvD0/p6+41Q4L3QJY5suXjmdJQ2UkA=;
 b=KShfySOIRSqCxvxY5vOli7/njMXL7SMfAgSfLO3DId8Zc4Km0c6If4aE6SeoQmHTh5
 kdqp2/KQLkWaM2iH6+3z0e9MrJgZqt1QL6kSgYwbylBYz+o9W4pER7rb+PUNDzvqu7G8
 lDbrhaluk2NMYVywfm/cDqIa+1P4RmLkIpIRIax5DxIPk64ph3gLBPHPXZ+YI4aPBkNY
 gUPsPtd7lrRR08QWAAmdfyIDjQ5I+7D+mPmNBrNk8x+VKeRF0f4TX2rqRpI/s0V8U2xs
 B3ZpOgY9zm7jxr7zhGEEYMNpjNr9DJ5cMY8tPQeW5RK6x1vxLHFKLZzHJnqfj4MPZzLi
 kFkw==
X-Gm-Message-State: AOAM532SbubhXNACO0h3PCY5sC6RTKnXAXofOhrmn7bhyVCyWq6lnA82
 8BRzehQaauB4QGzNI7X8bsoerrQocRwDzDCHW1oRG6y0wnCSga/GT2WiqU3+AMbHzZKK6iy64C6
 lIjmurQ+w7ONcP5npyEp/9kTBaDBPtSslRCszz3/V3cYh
X-Received: by 2002:a17:906:fc5:b0:6db:30df:df23 with SMTP id
 c5-20020a1709060fc500b006db30dfdf23mr1677285ejk.396.1647467228832; 
 Wed, 16 Mar 2022 14:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHQbmBaAg6tbk1R2CEHdrhi9DF5j4eNuaD45xf+k7TLMPHeI+7Sh3GwiaOrCVj8FYM/HLvCnConKFELq45edI=
X-Received: by 2002:a17:906:fc5:b0:6db:30df:df23 with SMTP id
 c5-20020a1709060fc500b006db30dfdf23mr1677269ejk.396.1647467228546; Wed, 16
 Mar 2022 14:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <87wnh6m2fp.fsf@suse.de> <87ilsqm1kg.fsf@suse.de>
 <CAEemH2fZN6k1hY1BE1dDWtQRi_8w2vBQH9c4EGxz-bRdaYNrFA@mail.gmail.com>
In-Reply-To: <CAEemH2fZN6k1hY1BE1dDWtQRi_8w2vBQH9c4EGxz-bRdaYNrFA@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 16 Mar 2022 14:46:32 -0700
Message-ID: <CADS1e3dCbihDEGoiAT7ygQgYeHcSw8WbUwrqY9JuxGcXU1QRLg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/16] controllers: Expand cgroup_lib shell
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
Content-Type: multipart/mixed; boundary="===============1946558159=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1946558159==
Content-Type: multipart/alternative; boundary="000000000000efe32705da5cda07"

--000000000000efe32705da5cda07
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

On Wed, Mar 16, 2022 at 2:46 AM Li Wang <liwang@redhat.com> wrote:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>
>
>> >> +
>> >> +    _cgroup_state=$(tst_cgctl require "$ctrl" $$)
>> >> +
>> >> +    [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No
>> >state was set after call. Controller '$ctrl' maybe does not exist?"
>>
>> Perhaps we can just check the return status of tst_cgctl and exit the
>> script if it is >0?
>>
>
> That should be work, but we need to check the _cgrou_state
> at other places because many shell APIs require getting Cgroup
> info, I guess this does not make things more easily if check the
> return value only one time.
>
>
>
An idea I had to make the failure of tst_cgctl more graceful when there is
a tst_brk and when it exits is to check the return of tst_cgctl and
basically just mirror the error with a better message. E.g.

tst_cgroup.c:702: TCONF: IO controller found on V2 root, skipping blkio
mount that would unmount IO controller
cgroup_fj_function 1 TCONF: cgroup_require: tst_cgtl require exited

Something that would look like this:
_cgroup_state=$(tst_cgctl require "$ctrl" $$)

_cgroup_check_return "$?" "cgroup_require: tst_cgctl require exited"

[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was
set after call to tst_cgctl require?"

Where in _cgroup_check_return we would do the appropriate tst_brk for the
return and then return a nice message (not exactly sure what it should be
but it should be obvious that one error is caused by the other). Because if
there was an error in tst_cgroup we would definitely want to break the test
because the _cgroup_state was most likely not set. Then it would fall
through to checking the _cgroup_state if everything looked good per normal
which now should never happen if tst_cgctl returned a non error.

Let me know what you think :)

-- 
> Regards,
> Li Wang
>

Thanks,
- Luke

--000000000000efe32705da5cda07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li, <br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 16, 2022 at 2:46 A=
M Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:small">Richard Palethorp=
e &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@=
suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 _cgroup_state=3D$(tst_cgctl require &quot;$ctrl&quo=
t; $$)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 [ &quot;$_cgroup_state&quot; =3D &quot;&quot; ] &am=
p;&amp; tst_brk TBROK &quot;cgroup_require: No<br>
&gt;state was set after call. Controller &#39;$ctrl&#39; maybe does not exi=
st?&quot;<br>
<br>
Perhaps we can just check the return status of tst_cgctl and exit the<br>
script if it is &gt;0?<br></blockquote><div><br></div><div style=3D"font-si=
ze:small">That should be work, but we need to check the _cgrou_state</div><=
div style=3D"font-size:small">at other places because many shell APIs requi=
re getting Cgroup</div><div style=3D"font-size:small">info, I guess this do=
es not make things more easily=C2=A0if check the</div><div style=3D"font-si=
ze:small">return value only one time.</div><div style=3D"font-size:small"><=
br></div></div><div><br></div></div></blockquote><div><br></div><div>An ide=
a I had to make the failure of tst_cgctl more graceful when there is a tst_=
brk and when it exits is to check the return of tst_cgctl and basically jus=
t mirror the error with a better message. E.g. <br></div><div><br></div><di=
v><div class=3D"gmail_default" style=3D"font-size:small">tst_cgroup.c:702: =
TCONF: IO controller found on V2 root, skipping blkio mount that would unmo=
unt IO controller</div>cgroup_fj_function 1 TCONF: cgroup_require: tst_cgtl=
 require exited<br></div><div><br></div><div>Something that would look like=
 this:</div><div>_cgroup_state=3D$(tst_cgctl require &quot;$ctrl&quot; $$)<=
br><br>	_cgroup_check_return &quot;$?&quot; &quot;cgroup_require: tst_cgctl=
 require exited&quot;<br><br>	[ &quot;$_cgroup_state&quot; =3D &quot;&quot;=
 ] &amp;&amp; tst_brk TBROK &quot;cgroup_require: No state was set after ca=
ll to tst_cgctl require?&quot;</div><div><br></div><div>Where in _cgroup_ch=
eck_return we would do the appropriate tst_brk for the return and then retu=
rn a nice message (not exactly sure what it should be but it should be obvi=
ous that one error is caused by the other). Because if there was an error i=
n tst_cgroup we would definitely want to break the test because the _cgroup=
_state was most likely not set. Then it would fall through to checking the =
_cgroup_state if everything looked good per normal which now should never h=
appen if tst_cgctl returned a non error. <br></div><div><br></div><div>Let =
me know what you think :)<br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div></div>-- <br><div dir=3D"ltr=
"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div=
></div></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke <br><=
/div></div></div>

--000000000000efe32705da5cda07--

--===============1946558159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1946558159==--
