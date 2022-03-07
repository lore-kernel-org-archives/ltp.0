Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D2C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 01:45:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8253E3C1BBA
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 02:45:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5E0E3C1B69
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 02:44:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85184200131
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 02:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646617493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o6UdbjlyNMNbeQ+0aeODmM7rojQ+6o8k9u/uO/mD4N8=;
 b=FaAk9sRbtJpR069jwScQgGzv/NUk4dX2jT/1wv2rIGb5TdrNg/fi9KRs4Ui2IuEVTdQ+Gs
 pDNyAA+fjw5FGyB+UT4PBdjcbktN+RTxZ9ezfOnwgheVaDEVfowOLbOy0A2f50qOch+4Ap
 /Zm1SBzWyMq4gqqTfO3aHSZ0DvOe/aI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-M5RT3wmlMoSzNJGoPiymSg-1; Sun, 06 Mar 2022 20:44:51 -0500
X-MC-Unique: M5RT3wmlMoSzNJGoPiymSg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2dbf52cc4b9so121410467b3.18
 for <ltp@lists.linux.it>; Sun, 06 Mar 2022 17:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o6UdbjlyNMNbeQ+0aeODmM7rojQ+6o8k9u/uO/mD4N8=;
 b=YLp/8oNC3RYsOkuJlEaT8N0BLqj/RolcQB3GvmQQ/cjvTnruixDnbgmc/LQSc9ciqZ
 Dmf1MX48QcX5wJM07zAOHOHXvF+Tf0C7INlaMUc+Ks1c97tcdrwlmkUhPzHU8aWZJ9A/
 JAJ4AbpuPduXikgp9Sm9hcb9SCpEEf+XBzk3AQtpqOpBX20RrKXyREnrih/dN4SJVdNm
 XkldFZrlrKiNs8d9ep3U54j2T3TbRUZbLsgd8m8MloZzymiuXVYugx5H4rZwI/S7MOmx
 XZ18PmDvoPgWJQHXNfFBzdD+qyULv7/fbsxMEdYz24SQs+WIxThUWspqH2AxOKpdGB6Q
 PF+w==
X-Gm-Message-State: AOAM531oTwE2P5GbrouAhpLWZJXg01KOyYnzbpoqMbG26vOvYewo5i2X
 sFp6/gbYK7Lb3FDj1+FkHkvf+KFS9BBxmAPXmbqG5qCg4PuqtdCKZW0f/xjCLh6rfyk03O3TCpj
 ob9AnfiEmO3o5Ecx7+mazB+crdPk=
X-Received: by 2002:a25:76ca:0:b0:628:759f:7990 with SMTP id
 r193-20020a2576ca000000b00628759f7990mr6212319ybc.273.1646617490819; 
 Sun, 06 Mar 2022 17:44:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFJO94sBr+ehw4pwLWytxU8BxEoztjPRochiN6tAsMGBPIYnLqpde5nHWcJVMzjB7hAzzQN8uIK5aNeKHXQsc=
X-Received: by 2002:a25:76ca:0:b0:628:759f:7990 with SMTP id
 r193-20020a2576ca000000b00628759f7990mr6212314ybc.273.1646617490648; Sun, 06
 Mar 2022 17:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-6-chrubis@suse.cz>
 <CAEemH2cnCNdUaoWqe=-dyuFq2Zc7gF79yi8XND8ieTvg8iEaRg@mail.gmail.com>
 <YiH/2240VRU1OlAe@yuki>
In-Reply-To: <YiH/2240VRU1OlAe@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Mar 2022 09:44:37 +0800
Message-ID: <CAEemH2eEJ06UnKJujTjWksutiK2Lmk_HHAwa76nBjAZGpNcVzA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/7] mem/ksm06: Move ksm restoration into the
 tst_test struct
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
Content-Type: multipart/mixed; boundary="===============0766056165=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0766056165==
Content-Type: multipart/alternative; boundary="0000000000009c892605d99702bb"

--0000000000009c892605d99702bb
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 4, 2022 at 8:00 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > The mem library verifies the max_page_sharing validity before
> > setting because some old kernels do not have it. Thus it is fine
> > to use the prefix '?'.
> >
> > +               "?/sys/kernel/mm/ksm/run",
> > > +               "?/sys/kernel/mm/ksm/merge_across_nodes",
> > > +               "?/sys/kernel/mm/ksm/sleep_millisecs",
> > >
> >
> >
> > But for the two knobs(run, sleep_millisecs) that should exist unless
> > the kernel disables KSM. So here we'd better start with prefix '!' and
> > add .needs_kconfg for ???CONFIG_KSM=y' check.
> > (This also fit for other ksm tests)
>
> I guess that if we put ! before the merge_across_nodes that would cause
> TBROK on systems without CONFIG_NUMA or kernels without that feature.
>
> So what about just removing the question marks there and adding
> .need_kconfigs for KSM and NUMA?
>

Er, that's exactly what I meant in the last email, maybe you overlooked
the last sentence:).

i.e.

"
  prefix ! for 'run' and 'sleep_milisecs'
  no prefix for 'merge_across_nodes'
  .need_kconfigs for KSM and NUMA
"

-- 
Regards,
Li Wang

--0000000000009c892605d99702bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Mar 4, 2022 at 8:00 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; The mem library verifies the max_page_sharing validity before<br>
&gt; setting because some old kernels do not have it. Thus it is fine<br>
&gt; to use the prefix &#39;?&#39;.<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/sys/ke=
rnel/mm/ksm/run&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/s=
ys/kernel/mm/ksm/merge_across_nodes&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?/s=
ys/kernel/mm/ksm/sleep_millisecs&quot;,<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; But for the two knobs(run, sleep_millisecs) that should exist unless<b=
r>
&gt; the kernel disables KSM. So here we&#39;d better start with prefix &#3=
9;!&#39; and<br>
&gt; add .needs_kconfg for ???CONFIG_KSM=3Dy&#39; check.<br>
&gt; (This also fit for other ksm tests)<br>
<br>
I guess that if we put ! before the merge_across_nodes that would cause<br>
TBROK on systems without CONFIG_NUMA or kernels without that feature.<br>
<br>
So what about just removing the question marks there and adding<br>
<span class=3D"gmail_default" style=3D"font-size:small"></span>.need_kconfi=
gs for KSM and NUMA?<br></blockquote><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-size:small">Er, that&#39;s exactly what I meant in=
 the last email, maybe you overlooked</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">the last sentence:).</div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">i.e. </div><br></div><div><div=
 class=3D"gmail_default" style=3D"font-size:small">&quot;</div></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 prefix ! for &=
#39;run&#39; and &#39;sleep_milisecs&#39;</div><div class=3D"gmail_default"=
 style=3D"font-size:small">=C2=A0 no prefix for &#39;merge_across_nodes&#39=
;</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=C2=A0<=
span class=3D"gmail_default"></span>.need_kconfigs for KSM and NUMA</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">&quot;</div></div></di=
v><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000009c892605d99702bb--


--===============0766056165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0766056165==--

