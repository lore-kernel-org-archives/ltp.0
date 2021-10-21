Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F041C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:05:59 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3751560EB2
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 08:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3751560EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8423C55BB
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 10:05:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FA7D3C14F3
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:05:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2DB151000610
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 10:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634803543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viZK/ckXn6j5+pVKVEd/IKcmFTzTAdcvRKpIURL84DU=;
 b=jVycEo2aGqcKj35cat+CFfyNg0coWEkYSF6dl7BQHFkmmeh4n2PJbPGGNDDeckSHfZqRV/
 rjjlnSOb47l33vhiZlQH7VN2x0zLS0wiA80pujsLarUyVQ1LukaSxChHXtcPN1AIn+uyf4
 qZDdzGfizREqQbLmJcG6mIb/P0FLYjc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OskvLPa0O8eElRXeBoLjag-1; Thu, 21 Oct 2021 04:05:40 -0400
X-MC-Unique: OskvLPa0O8eElRXeBoLjag-1
Received: by mail-qt1-f198.google.com with SMTP id
 f19-20020ac87f13000000b002a7e8f71b13so3802056qtk.5
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 01:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=viZK/ckXn6j5+pVKVEd/IKcmFTzTAdcvRKpIURL84DU=;
 b=C3sI8z1J8jZ3YqpTulMIo1n7G/xvwUQZ/7gQH/2ToPwGWs3I4U/BF4TRAHLTz0NG2a
 XWfd4c2qeV51jpIUO/MV2quNviRPKrTuvBkUYyiXz29fPMg/wzbOC/4Lfpxz+hqJDqub
 tJBowRe93y2XJSTCuqBaaKIPYegWhwOP2lEMmWHc5JS88VghjvAUjUmwQIkvkt/K4quo
 86K438491K+GCf96iN24EGU0t0Hd2u6Ai8GWuveWcoVscHDWlgxh2dRi8Gr6mTEExHhN
 vyzbBYk+B3SOIpZmipIU4hdTD9YBcd+AY3G1NfSIoFDb087rqNczYj8R3kDNN0phMw9u
 Anrg==
X-Gm-Message-State: AOAM531ownHea0keudm8Zu6Fc1nCDR3lET0T2zDe7Px12PhY/lLZapkZ
 XDmDDf7eIIpd0ubnqr57Vwis7yjHBASgUtWSC962bf2PpaJrJkVCveIrzegB6x/KkDXmHT3CUmU
 qhsfS121nlIkgtMfSYuxVck5qqO8=
X-Received: by 2002:a25:d394:: with SMTP id e142mr4189807ybf.186.1634803539629; 
 Thu, 21 Oct 2021 01:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytDqbwvu8XcILrJo/1YRaQ35G+yF/V07I/VjMQzL8nIBucdRy/aXUF1FbHW7mWzeW09eVs6mIh6YPZFMXdYVw=
X-Received: by 2002:a25:d394:: with SMTP id e142mr4189787ybf.186.1634803539368; 
 Thu, 21 Oct 2021 01:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211020091353.90731-1-krzysztof.kozlowski@canonical.com>
 <CAEemH2cPDbcekuQ=j9SmoUFQ1e-LRLzFqKSOd2_bXELTSmus=A@mail.gmail.com>
 <2866a54f-ebee-1bd5-82ab-92084d0fd74a@canonical.com>
 <9771a472-9bda-3600-8cd2-05f297bc9a8d@canonical.com>
In-Reply-To: <9771a472-9bda-3600-8cd2-05f297bc9a8d@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Oct 2021 16:05:27 +0800
Message-ID: <CAEemH2fOS3JAAAfKaBpdYLDdbRKHN-XXd-m1KYcm50Kd19mXBA@mail.gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: memutils: respect minimum memory
 watermark when polluting memory
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
Content-Type: multipart/mixed; boundary="===============1549923165=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1549923165==
Content-Type: multipart/alternative; boundary="0000000000003df62c05ced85c03"

--0000000000003df62c05ced85c03
Content-Type: text/plain; charset="UTF-8"

> >> Therically this is correct, and I believe it will work on your tested
> >> machine.
> >>
> >> But my concern is ioctl_sg01 still fails on the special system which
> >> MemAvai < MemFree.
> >>
> >> Just like the one Xinpeng mentioned before:
> >> https://lists.linux.it/pipermail/ltp/2021-January/020817.html
> >> <https://lists.linux.it/pipermail/ltp/2021-January/020817.html>
> >>
> >> [root@test-env-nm05-compute-14e5e72e38
> >> <mailto:root@test-env-nm05-compute-14e5e72e38>~]# cat /proc/meminfo
> >>
> >> MemTotal:       526997420 kB
> >> MemFree:        520224908 kB
> >> MemAvailable:   519936744 kB
> >> ...
> >>
> >> [root@test-env-nm05-compute-14e5e72e38 <mailto:
> root@test-env-nm05-compute-14e5e72e38> ~]# cat
> /proc/sys/vm/min_free_kbytes
> >> 90112
> >>
> >>
> >> There even reserve the safety to the 128MB, still less than the gap
> >> between MemFree and MemAvailable.
> >>
> >> MemFree (520224908 kB) - MemAvailable (520224908 kB) = 288164 kB  >
> safety
> >
> > I don't have such case and I am not sure it is reasonable.
> >
> > As mentioned in the thread there it looks unusual to have less available
> > memory than free. Maybe the system has some weird memory accounting
> > because MemAvailable is counted from MemFree by adding memory which can
> > be reclaimed. When adding a non-negative number, you should not end up
> > with lower MemAvailable than MemFree. :)
> >
> > Maybe that's the reason why that patch was not accepted - the system is
> > not vanilla, not common?
>
> OK, I found a possible explanation (on vanilla kernel) - the
> totalreserve_pages. This is the only subtraction from free memory when
> counting available. This could happen if someone was setting sysctl
> lowmem_reserve_ratio or min_free_kbytes.
>

That's exactly, beside the two controllers, you could also get such
a system with enabling smaller swap space on aarch64/x86_64.

(I did that and found that 'MemFree > MemAvail' is common to see)


> When setting min_free_kbytes, this will be reflected in
> /proc/sys/vm/min_free_kbytes, so we are good.
>
> When setting vm.lowmem_reserve_ratio, this will be missed by my patch
> and MemAvailable could be lower than MemFree.
>

Yes, we have to face different kinds of system configuration in testing.

Maybe we'd better keep the (info.freeram/64) in MAX() as well,
Or, do a comparison between MemFree and MemAvail to choose
the smaller one as baseline.

-- 
Regards,
Li Wang

--0000000000003df62c05ced85c03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt;&gt; Therically this is correct, and I believe=C2=A0it will work on you=
r tested<br>
&gt;&gt; machine.<br>
&gt;&gt;<br>
&gt;&gt; But my concern is ioctl_sg01 still fails on the special system whi=
ch<br>
&gt;&gt; MemAvai &lt; MemFree.<br>
&gt;&gt;<br>
&gt;&gt; Just like the one Xinpeng mentioned before:<br>
&gt;&gt; <a href=3D"https://lists.linux.it/pipermail/ltp/2021-January/02081=
7.html" rel=3D"noreferrer" target=3D"_blank">https://lists.linux.it/piperma=
il/ltp/2021-January/020817.html</a><br>
&gt;&gt; &lt;<a href=3D"https://lists.linux.it/pipermail/ltp/2021-January/0=
20817.html" rel=3D"noreferrer" target=3D"_blank">https://lists.linux.it/pip=
ermail/ltp/2021-January/020817.html</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; [root@test-env-nm05-compute-14e5e72e38<br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:root@test-env-nm05-compute-14e5e72e38=
" target=3D"_blank">root@test-env-nm05-compute-14e5e72e38</a>&gt;~]# cat /p=
roc/meminfo<br>
&gt;&gt;<br>
&gt;&gt; MemTotal:=C2=A0 =C2=A0 =C2=A0 =C2=A0526997420 kB<br>
&gt;&gt; MemFree:=C2=A0 =C2=A0 =C2=A0 =C2=A0 520224908 kB<br>
&gt;&gt; MemAvailable:=C2=A0 =C2=A0519936744 kB<br>
&gt;&gt; ...<br>
&gt;&gt;<br>
&gt;&gt; [root@test-env-nm05-compute-14e5e72e38 &lt;mailto:<a href=3D"mailt=
o:root@test-env-nm05-compute-14e5e72e38" target=3D"_blank">root@test-env-nm=
05-compute-14e5e72e38</a>&gt; ~]# cat=C2=A0 /proc/sys/vm/min_free_kbytes<br=
>
&gt;&gt; 90112<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; There even reserve the safety to the 128MB, still less than the ga=
p<br>
&gt;&gt; between MemFree and MemAvailable.=C2=A0<br>
&gt;&gt;<br>
&gt;&gt; MemFree (520224908 kB) - MemAvailable (520224908 kB) =3D=C2=A02881=
64 kB=C2=A0 &gt; safety<br>
&gt; <br>
&gt; I don&#39;t have such case and I am not sure it is reasonable.<br>
&gt; <br>
&gt; As mentioned in the thread there it looks unusual to have less availab=
le<br>
&gt; memory than free. Maybe the system has some weird memory accounting<br=
>
&gt; because MemAvailable is counted from MemFree by adding memory which ca=
n<br>
&gt; be reclaimed. When adding a non-negative number, you should not end up=
<br>
&gt; with lower MemAvailable than MemFree. :)<br>
&gt; <br>
&gt; Maybe that&#39;s the reason why that patch was not accepted - the syst=
em is<br>
&gt; not vanilla, not common?<br>
<br>
OK, I found a possible explanation (on vanilla kernel) - the<br>
totalreserve_pages. This is the only subtraction from free memory when<br>
counting available. This could happen if someone was setting sysctl<br>
lowmem_reserve_ratio or min_free_kbytes.<br></blockquote><div><br></div><di=
v><div class=3D"gmail_default">That&#39;s exactly, beside the two controlle=
rs, you could also get such</div><div class=3D"gmail_default">a system with=
 enabling smaller swap space on aarch64/x86_64.</div><div class=3D"gmail_de=
fault"><br></div><div class=3D"gmail_default">(I did that and found that &#=
39;MemFree &gt; MemAvail&#39; is common to see)</div></div><div><br></div><=
div class=3D"gmail_default" style=3D"font-size:small"></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
When setting min_free_kbytes, this will be reflected in<br>
/proc/sys/vm/min_free_kbytes, so we are good.<br>
<br>
When setting vm.lowmem_reserve_ratio, this will be missed by my patch<br>
and MemAvailable could be lower than MemFree.<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Yes, we have =
to face different kinds of system configuration in=C2=A0testing.</div><div =
class=3D"gmail_default"><br></div><div class=3D"gmail_default">Maybe we&#39=
;d better keep the (info.freeram/64) in MAX() as well,</div><div class=3D"g=
mail_default">Or, do a comparison=C2=A0between MemFree and MemAvail to choo=
se</div><div class=3D"gmail_default" style=3D"font-size:small">the smaller =
one as baseline.</div></div><div><br></div></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--0000000000003df62c05ced85c03--


--===============1549923165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1549923165==--

