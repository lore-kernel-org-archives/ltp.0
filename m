Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C918C433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 01:14:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0975B3CDADE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 02:14:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56BA3C0796
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 02:14:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CFF276008B7
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 02:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667870080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QVyS9UZq/2VwgR4IUHbhOanTfdKIWFhcr7qaOC1hz1w=;
 b=D2n2LuewuFBw861Jkw0DYLYB1z1MZXy01mjRl7z3CGq0sNS3HSsViOcLZraYueTimoo/Xn
 ojuIhMvV4u1807cP4tQzo1iA32VszOEe3/3/L7GW1o/IOCWULucEfPr5vbwWsfhYzbuCzw
 mVOwv4TK9/zakSdp+Fcf5MyEJpj/EgM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-G7fDjWc0OoC4yDb_53JPhQ-1; Mon, 07 Nov 2022 20:14:38 -0500
X-MC-Unique: G7fDjWc0OoC4yDb_53JPhQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 n19-20020a0568301e9300b0066c3b6f5dd0so6319400otr.19
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 17:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVyS9UZq/2VwgR4IUHbhOanTfdKIWFhcr7qaOC1hz1w=;
 b=Lp4qArDiHy4qHVadPvOXBpyim/4zzswiRqo9KkzVdmO8d69MNY8v4fnKTXmDWjMVvy
 JdhOAmKn35IZ+AXRikJkuLpsbh3BCitKw5DMDUWiNCU5lS7HO7GPKQQR6Pifq7bya1MX
 aILR39s/uK0DHxjbgtOsK36wXI8psF4JpvOpjKENsQvPb6P5vMsQBsA2DaTxWe6NSQ9u
 41okr2K/X37Fn067k8b+2fjN3eLY69CXAzRIRe/+PeoeEqbh0kPcCu/YWU9dTG5kUGaU
 2we544B1RxDPLoHCdHcDyDVTaORIN8orKh79pAyUT0ToRNSS+IGoCcEGeUXBloqGbnUF
 4kMQ==
X-Gm-Message-State: ACrzQf2nZoS1i0Gxeu3u+lVE1MB7uOhdB5Y9s1q195a3BlwNyNsA8OpB
 3TnVj6ibh4M+xMAu9OTKIlmpkXGs2w2shoc2+1JQyhR8BZpOBbbQeMeponAg3DnYnqT/ScuA6uF
 TBQGCf3805B5rv4y8s19yIZiDXGg=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr18944993otq.160.1667870077803; 
 Mon, 07 Nov 2022 17:14:37 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6ZHrGH64GVSg5zQs0aXknKo9/bsv3UDARKme3NvQQTEvCIkhZHiVSGtaKUl4O3Hafe84BhJMIJisN0RRIPKB0=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr18944983otq.160.1667870077521; Mon, 07
 Nov 2022 17:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20221025121853.3590372-1-liwang@redhat.com>
 <CAEemH2ciCbmVhVtm+oMV2JqnWf10qK-GAZNp1bZOiC2ks4cnuQ@mail.gmail.com>
 <87r0yfvu6y.fsf@suse.de>
In-Reply-To: <87r0yfvu6y.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Nov 2022 09:14:24 +0800
Message-ID: <CAEemH2f0YzD8tSKvQt=kx-YzOirrWB22oZaT7w0Z6S7guq9i_g@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0633205950=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0633205950==
Content-Type: multipart/alternative; boundary="00000000000080aec205eceb4353"

--00000000000080aec205eceb4353
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 7, 2022 at 8:13 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Plz ignore this patch, it needs code rebase after Anderea's work:
> >
> >     b606a7c7d setitimer01: Fix checking of setitimer() parameters
> >
> > --
> > Regards,
> > Li Wang
>
> I'll set to "changes requested" in patchwork. Plase can you update
> Patchwork in the future?
>

Yes, I should do that but I somehow forget. sorry~

-- 
Regards,
Li Wang

--00000000000080aec205eceb4353
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 7, 2022 at 8:13 PM Richard Palethorpe &=
lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello Li,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; Plz ignore this patch, it needs code rebase after Anderea&#39;s work:<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0b606a7c7d setitimer01: Fix checking of setitimer() =
parameters<br>
&gt;<br>
&gt; -- <br>
&gt; Regards,<br>
&gt; Li Wang<br>
<br>
I&#39;ll set to &quot;changes requested&quot; in patchwork. Plase can you u=
pdate Patchwork in the future?<br></blockquote><div><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Yes, I should do that but I someh=
ow forget. sorry~</div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--00000000000080aec205eceb4353--


--===============0633205950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0633205950==--

