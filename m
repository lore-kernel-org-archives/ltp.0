Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB20C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 05:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A809E3C9423
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 06:39:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02333C6355
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 06:39:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB676600579
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 06:39:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647495549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRiNs5NsLjDnm0/WKedJ+WC+lt+B9unfYl7FhYuU+N4=;
 b=H3Kr4EQh9dtSL9fUzIG4t5kRNS7jYqHjdUmxnp85X/lqmpdTnRxty2LN5ZD1awSr9Od0nq
 FB2QvLShar8lBs613zbE9BqLYKpgUtH+Qo3oN+xv/6MTtdEDHgRzZCsq7aK7BZ/PBQ/YOI
 oYk4X98a9BqZTEwQweYCm9zdQZJBrzg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-dGcPJGEHObOmbKzAWNFKRw-1; Thu, 17 Mar 2022 01:39:07 -0400
X-MC-Unique: dGcPJGEHObOmbKzAWNFKRw-1
Received: by mail-yb1-f200.google.com with SMTP id
 n66-20020a254045000000b0062883b59ddbso3684549yba.12
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 22:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BS45h6X6aqpDkN/tlOaFd3tZlAg3vXv8fHCP3hQIRq4=;
 b=Z64RbGhPe7jUVNSHpCLcnRRImUWDTJ+J/GqPB8t4ZGZe4iJio2ZIIouQb4IBiMWXdE
 SnX61n/xE24VR/FyK/f3Yq/td3wIdNkOgZsLPRzgRJ7SmuuA6prUQVHaEZuPlX/i0Vjx
 +Q7JJUF/jeyJEkOre3QvjrVAZEAHXlWvNLkneCOEYJ7bonXi9NpYjFnIDxb75FNqgsRQ
 D8idau56sr1hzhKug/e79k5hr3Xk+yOrh0o/kBIkqlT1xqEdVfLFbceAoRoQxkKeSXiB
 giduBRja+/Y086bDorIyyNE23oHNxh/OtyxwyFqE/sQ4aB6+jWopUadjcWOH90tQ6jHX
 MuyA==
X-Gm-Message-State: AOAM532QLiS+BdYhPbDIyqCe08kVUzhSMwTrch7HTEu1MMs3XCA/PQbt
 iFRmWGcNnKh5zufWB9+10jG0HCOsY4FP9FwD/ICGuAsBaDceZnIpipcNDXRh7lPgjBDXIUAtoZk
 pg1R8JroBe1c9vEsmQfKR4/ExQBI=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr3575392ybt.211.1647495546574; 
 Wed, 16 Mar 2022 22:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV4wUDrMk5OuB/4d6YPe0oxe47ugbxYFoSbjqkwFIo1ZDGsN09ntcENDISB3RTXEC6HmXm4qkTTqgfv/B7qxE=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr3575381ybt.211.1647495546317; Wed, 16
 Mar 2022 22:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <87wnh6m2fp.fsf@suse.de> <87ilsqm1kg.fsf@suse.de>
 <CAEemH2fZN6k1hY1BE1dDWtQRi_8w2vBQH9c4EGxz-bRdaYNrFA@mail.gmail.com>
 <CADS1e3dCbihDEGoiAT7ygQgYeHcSw8WbUwrqY9JuxGcXU1QRLg@mail.gmail.com>
In-Reply-To: <CADS1e3dCbihDEGoiAT7ygQgYeHcSw8WbUwrqY9JuxGcXU1QRLg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Mar 2022 13:38:54 +0800
Message-ID: <CAEemH2fu0S_fWa_my7RfPysqx_3Jy0fhkhuyFiP4J-9BzOd9rg@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1168181731=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1168181731==
Content-Type: multipart/alternative; boundary="000000000000ced0ec05da63727b"

--000000000000ced0ec05da63727b
Content-Type: text/plain; charset="UTF-8"

Hi Luke,

On Thu, Mar 17, 2022 at 5:47 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Hi Richard and Li,
>
> On Wed, Mar 16, 2022 at 2:46 AM Li Wang <liwang@redhat.com> wrote:
>
>> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>
>>
>>
>>> >> +
>>> >> +    _cgroup_state=$(tst_cgctl require "$ctrl" $$)
>>> >> +
>>> >> +    [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No
>>> >state was set after call. Controller '$ctrl' maybe does not exist?"
>>>
>>> Perhaps we can just check the return status of tst_cgctl and exit the
>>> script if it is >0?
>>>
>>
>> That should be work, but we need to check the _cgrou_state
>> at other places because many shell APIs require getting Cgroup
>> info, I guess this does not make things more easily if check the
>> return value only one time.
>>
>>
>>
> An idea I had to make the failure of tst_cgctl more graceful when there is
> a tst_brk and when it exits is to check the return of tst_cgctl and
> basically just mirror the error with a better message. E.g.
>
> tst_cgroup.c:702: TCONF: IO controller found on V2 root, skipping blkio
> mount that would unmount IO controller
> cgroup_fj_function 1 TCONF: cgroup_require: tst_cgtl require exited
>
> Something that would look like this:
> _cgroup_state=$(tst_cgctl require "$ctrl" $$)
>
> _cgroup_check_return "$?" "cgroup_require: tst_cgctl require exited"
>
> [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was
> set after call to tst_cgctl require?"
>
> Where in _cgroup_check_return we would do the appropriate tst_brk for the
> return and then return a nice message (not exactly sure what it should be
> but it should be obvious that one error is caused by the other). Because if
> there was an error in tst_cgroup we would definitely want to break the test
> because the _cgroup_state was most likely not set. Then it would fall
> through to checking the _cgroup_state if everything looked good per normal
> which now should never happen if tst_cgctl returned a non error.
>
> Let me know what you think :)
>

That sounds good to me.


-- 
Regards,
Li Wang

--000000000000ced0ec05da63727b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Luke,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Mar 17, 2022 at 5:47 AM Luke Nowakows=
ki-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com">luke=
.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Richard and Li, <=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Wed, Mar 16, 2022 at 2:46 AM Li Wang &lt;<a href=3D"mailto:liwang@red=
hat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"lt=
r"><div style=3D"font-size:small">Richard Palethorpe &lt;<a href=3D"mailto:=
rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:<b=
r></div></div><div class=3D"gmail_quote"><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
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
v><div style=3D"font-size:small">tst_cgroup.c:702: TCONF: IO controller fou=
nd on V2 root, skipping blkio mount that would unmount IO controller</div>c=
group_fj_function 1 TCONF: cgroup_require: tst_cgtl require exited<br></div=
><div><br></div><div>Something that would look like this:</div><div>_cgroup=
_state=3D$(tst_cgctl require &quot;$ctrl&quot; $$)<br><br>=09_cgroup_check_=
return &quot;$?&quot; &quot;cgroup_require: tst_cgctl require exited&quot;<=
br><br>=09[ &quot;$_cgroup_state&quot; =3D &quot;&quot; ] &amp;&amp; tst_br=
k TBROK &quot;cgroup_require: No state was set after call to tst_cgctl requ=
ire?&quot;</div><div><br></div><div>Where in _cgroup_check_return we would =
do the appropriate tst_brk for the return and then return a nice message (n=
ot exactly sure what it should be but it should be obvious that one error i=
s caused by the other). Because if there was an error in tst_cgroup we woul=
d definitely want to break the test because the _cgroup_state was most like=
ly not set. Then it would fall through to checking the _cgroup_state if eve=
rything looked good per normal which now should never happen if tst_cgctl r=
eturned a non error. <br></div><div><br></div><div>Let me know what you thi=
nk :)<br></div></div></div></blockquote><div><br></div><div><div class=3D"g=
mail_default" style=3D"font-size:small">That sounds good to me.</div></div>=
<div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></=
div></div></div>

--000000000000ced0ec05da63727b--


--===============1168181731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1168181731==--

