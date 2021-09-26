Return-Path: <SRS0=7mwu=OQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F74C433EF
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:17:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4A460EE0
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D4A460EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E52CA3C8E33
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 09:17:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 261393C70CA
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:17:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CF301496034
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:17:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632640646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6Q6tvwzRjdgB6mAg/5UNKDKbv6AHS5Cy8hjQ2ImLNA=;
 b=ckEeP1fxkT5+JPwKirodSZMcTb5BVQLkNyoj8yWdoKhvzzkM7OXlj/kVveXiSS1dPo4eWK
 LkQbyoYNDWzxNdecVFPZ5sNYI1RElyhRl8dPqfHjZlWW1DZt6WPHleyrVcTZlJrPAr3OHu
 e/QuCySFy7JIe/XhH4j+/3OP/FESj4g=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-4I9BHdC_Mc-bKfI1tXRpHw-1; Sun, 26 Sep 2021 03:17:25 -0400
X-MC-Unique: 4I9BHdC_Mc-bKfI1tXRpHw-1
Received: by mail-yb1-f198.google.com with SMTP id
 83-20020a251956000000b0059948f541cbso10035778ybz.7
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 00:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V6Q6tvwzRjdgB6mAg/5UNKDKbv6AHS5Cy8hjQ2ImLNA=;
 b=0+fkd4xiv7Zb/WmoU8c51DXRVx80KoJ4xyqSG1+hzSTb+u8PRXyfReifN46gF/mvX/
 NmkD2qDb+669C7aW+tRYwypXaoWoqcdn3Ke3Ygp+I36UqyHxvW2+xYLJeBsEd/0Dpk4m
 474AAQKiiPfOx4LJ6cXOD60ti6a8kK929AzGd9glpbZjeDoMCSs7xlMRVPu58UT4u2KQ
 Uedlhzf1vEIl1CnxR21hv2pvggb02S1kLM0NzM9XPGzfNnfsfUdznHc+VatpeOeIFMFk
 zrxYSryjyllsbbB4e0va2u2oGFOSqE+CHANnWTWMfoP6bF+wHYPoJhO5O49rhLOmrcyU
 l0JA==
X-Gm-Message-State: AOAM532tZuWZVVZzLPIV39PGXIMbt5NGoUjv8Pa308yG+EUk3q5az+Wt
 RW3ASpBxorPZcbhLu4AbeaMXSIzjX16QqyMqH28djrDm5sz2iG5WDRyNtjMuYl2CAhHnxezynxA
 Z/DGvHSawI8CC47z9rDj78TL0KCE=
X-Received: by 2002:a25:47d7:: with SMTP id u206mr4224110yba.186.1632640644293; 
 Sun, 26 Sep 2021 00:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuQV6ol5LpufvqWVOWDrEyJDzzWC3DKfLwY5XlOhDJfMvmcSZBEv6d9F+ETm50adkMjNLF1nTyWo2qc4dpvhc=
X-Received: by 2002:a25:47d7:: with SMTP id u206mr4224096yba.186.1632640643986; 
 Sun, 26 Sep 2021 00:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki> <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org> <YU4YOI4yPufWP9uC@yuki>
 <20210924202601.GB4029248@maple.netwinder.org>
In-Reply-To: <20210924202601.GB4029248@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Sun, 26 Sep 2021 15:17:12 +0800
Message-ID: <CAEemH2etvD_1VXsXLFnjN5KHLJZGt-eUADhwi1TBQa3aQXp-Bw@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============1380836028=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1380836028==
Content-Type: multipart/alternative; boundary="000000000000a18d0105cce0c565"

--000000000000a18d0105cce0c565
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 25, 2021 at 4:26 AM Ralph Siemsen <ralph.siemsen@linaro.org>
wrote:

> On Fri, Sep 24, 2021 at 08:26:00PM +0200, Cyril Hrubis wrote:
>
> >That is strange, for me the tmpfs starts to return ENOSPC when the
> >system is getting low on memory.
>
> I've repeated the tests, now with kernel 4.19.198 instead of 5.10.y.
>
> 1) LTP 20210524
>    In the case of tmpfs, it got as far as mntpoint/file4 size 70310993,
>    before returning ENOSPC. It seems it wrote about 134MB in total,
>    which roughly matches the amount of free memory on my system.
>    --> PASS
>
> 2) Latest commit 443cbc1039f5 ("hugeshmat04: try to find unmapped range
> for test")
>    tst_test.c:903: TINFO: Limiting tmpfs size to 512MB
>    OOM during tmpfs after mntpoint/file6 size 90739786
>    Note the total written to tmpfs adds up to approx 225MB, which does
>    not make sense -- this would be all memory except kernel itself.
>    --> FAIL
>
> 3) Revert commit 7338156ac ("increase the fallocate and defallocate size")
>     Exactly the same behaviour as case 2)
>     --> FAIL
>
> 4) Remove .dev_min_size from fallocate05.c
>     tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
>     Otherwise exactly the same behaviour as case 3)
>     --> FAIL
>
> 5) Apply Li's patchset (with v2 of the 3rd patch)
>     Exactly the same behaviour as 4)
>     --> FAIL
>

Can you post the test log for this 5), it shouldn't be similar like 4)
because we limit tmfs-size to 32MB in this case. and If you didn't remove
.dev_min_size=512, it should be skip tmpfs test on your 153MB MemAva
machine.

With remove .dev_min_size=512 from fallocate05 in situation 5).
If it is still OOM with 32MB tmpfs-size, I tend to agree with Cyril that is
very likely you hit a kernel problem or configure issue.



>
> >Also if that one fails as well it's likely that something is wrong at
> >your side.
>
> Well, this is certainly possible, although there are no intentional
> changes in the kernel (esp filesystems). Only drivers for flash,
> architecture support, etc. One possible option would be to try testing a
> generic ARM kernel under qemu, to see if we can reproduce it there.
>
> Note however that case 1) worked, while the others fail. So evidently
> the way that userspace "tickles" the kernel matters. I also previously
> used much older LTP 20200120 and did not have the problem either.
>
> Thanks again for your time,
> Ralph
>
>

-- 
Regards,
Li Wang

--000000000000a18d0105cce0c565
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Sep 25, 2021 at 4:26 AM Ralph Siemsen &lt;<=
a href=3D"mailto:ralph.siemsen@linaro.org">ralph.siemsen@linaro.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, =
Sep 24, 2021 at 08:26:00PM +0200, Cyril Hrubis wrote:<br>
<br>
&gt;That is strange, for me the tmpfs starts to return ENOSPC when the<br>
&gt;system is getting low on memory.<br>
<br>
I&#39;ve repeated the tests, now with kernel 4.19.198 instead of 5.10.y.<br=
>
<br>
1) LTP 20210524<br>
=C2=A0 =C2=A0In the case of tmpfs, it got as far as mntpoint/file4 size 703=
10993,<br>
=C2=A0 =C2=A0before returning ENOSPC. It seems it wrote about 134MB in tota=
l,<br>
=C2=A0 =C2=A0which roughly matches the amount of free memory on my system.<=
br>
=C2=A0 =C2=A0--&gt; PASS<br>
<br>
2) Latest commit 443cbc1039f5 (&quot;hugeshmat04: try to find unmapped rang=
e for test&quot;)<br>
=C2=A0 =C2=A0tst_test.c:903: TINFO: Limiting tmpfs size to 512MB<br>
=C2=A0 =C2=A0OOM during tmpfs after mntpoint/file6 size 90739786<br>
=C2=A0 =C2=A0Note the total written to tmpfs adds up to approx 225MB, which=
 does<br>
=C2=A0 =C2=A0not make sense -- this would be all memory except kernel itsel=
f.<br>
=C2=A0 =C2=A0--&gt; FAIL<br>
<br>
3) Revert commit 7338156ac (&quot;increase the fallocate and defallocate si=
ze&quot;)<br>
=C2=A0 =C2=A0 Exactly the same behaviour as case 2)<br>
=C2=A0 =C2=A0 --&gt; FAIL<br>
<br>
4) Remove .dev_min_size from fallocate05.c<br>
=C2=A0 =C2=A0 tst_test.c:903: TINFO: Limiting tmpfs size to 256MB<br>
=C2=A0 =C2=A0 Otherwise exactly the same behaviour as case 3)<br>
=C2=A0 =C2=A0 --&gt; FAIL<br>
<br>
5) Apply Li&#39;s patchset (with v2 of the 3rd patch)<br>
=C2=A0 =C2=A0 Exactly the same behaviour as 4)<br>
=C2=A0 =C2=A0 --&gt; FAIL<br></blockquote><div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">Can you post the test log for thi=
s 5), it shouldn&#39;t be similar like 4)</div><div class=3D"gmail_default"=
 style=3D"font-size:small">because we limit tmfs-size=C2=A0to 32MB in this =
case. and If you didn&#39;t remove</div><div class=3D"gmail_default" style=
=3D"font-size:small">.dev_min_size=3D512, it should be skip tmpfs test on y=
our 153MB MemAva</div><div class=3D"gmail_default" style=3D"font-size:small=
">machine.=C2=A0</div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">With remove .dev_min_size=3D512 from fallocate05 in situat=
ion 5).</div></div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">If it is still OOM with 32MB tmpfs-size, I tend to agree with Cyril tha=
t is</div><div class=3D"gmail_default" style=3D"font-size:small">very likel=
y you hit a kernel problem or configure issue.</div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;Also if that one fails as well it&#39;s likely that something is wrong =
at<br>
&gt;your side.<br>
<br>
Well, this is certainly possible, although there are no intentional <br>
changes in the kernel (esp filesystems). Only drivers for flash, <br>
architecture support, etc. One possible option would be to try testing a <b=
r>
generic ARM kernel under qemu, to see if we can reproduce it there.<br>
<br>
Note however that case 1) worked, while the others fail. So evidently <br>
the way that userspace &quot;tickles&quot; the kernel matters. I also previ=
ously <br>
used much older LTP 20200120 and did not have the problem either.<br>
<br>
Thanks again for your time,<br>
Ralph<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000a18d0105cce0c565--


--===============1380836028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1380836028==--

