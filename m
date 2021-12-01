Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F5BC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 09:13:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE1083C8E72
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 10:13:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A48343C21FF
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 10:13:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A885140121A
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 10:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638350010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZD6Jxpbx1iXwgdTfg+g0MkawNHwTIsNtbcyVsWF83vE=;
 b=IjttTg+2rPxX5IkPbIl5FOsHJsd9j7tWpi4jHyti0z8+TUcgvBUiZJxCESTrwvxJ7V4HeB
 HlTM5rxRHotG7nBcgeVe44wnGY6TVHRfhv5lMjGJRWsfshz8XbG9VVJ0o5GBiWecDVEI0w
 SI6LCyFErygxMYehPkTvSmD6cl4WCm8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-h-Iug9sxNl-EDPoKkRdigA-1; Wed, 01 Dec 2021 04:13:28 -0500
X-MC-Unique: h-Iug9sxNl-EDPoKkRdigA-1
Received: by mail-yb1-f200.google.com with SMTP id
 g25-20020a25b119000000b005c5e52a0574so34968200ybj.5
 for <ltp@lists.linux.it>; Wed, 01 Dec 2021 01:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZD6Jxpbx1iXwgdTfg+g0MkawNHwTIsNtbcyVsWF83vE=;
 b=tMkjtZOHjzSt/7STbsglS5vFguUyf0GE6P3rWzEY40juwN1H7+kyQlQTvPT1KaaNhS
 rMhfUErPr/3K/aTH0KFOJueD3/qLMNVT+HQOokuyNTVW/UPXxW0Y54igNlTiNDorNLEp
 Xl+3ZQwFuLZXLD9mEl6YyXn/+hMmfKbaGno5kWryb01nWUnc7cqjLw5NXEM8TxE3OPE5
 zkDz0fezaryKltNeXEUKcTdbeCg5J6LesyNVWVLPtZWoriwnuKw2HhG7FnZxk2hxs/Sr
 RKhA2pPsuX3Ul1PAwWynQE+nK1mAf4Jb+Rmd9cMxhn0Y7v4qMQ2frHhu8lx9jakPerlE
 ZBMg==
X-Gm-Message-State: AOAM530TBlaaMhV6WGmltzR9wEX3NcKhEgsPd6w0kBvPdrvljWebMZA2
 SEm8QtvJizc6ePUsSfipp09m3C8xPESpXnni6pzdiDKzoIpL0E5bmlOEWdJASXNdqQJWzvwHOD2
 MevbbDUvckWLTV3Vv91swO3xotnc=
X-Received: by 2002:a25:da06:: with SMTP id n6mr5747225ybf.763.1638350007624; 
 Wed, 01 Dec 2021 01:13:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoW0ERSwRgAJrJJ4JLePtike3WiVdMat8YJpsA8cnzAS1GrKnPud5r+nbqC7FymiWfqfxGwi8vlewVemLaGV4=
X-Received: by 2002:a25:da06:: with SMTP id n6mr5747205ybf.763.1638350007427; 
 Wed, 01 Dec 2021 01:13:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Dec 2021 17:13:13 +0800
Message-ID: <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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
Content-Type: multipart/mixed; boundary="===============1400583967=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1400583967==
Content-Type: multipart/alternative; boundary="00000000000036012405d2121606"

--00000000000036012405d2121606
Content-Type: text/plain; charset="UTF-8"

Hi Luke,

Thanks for looking into this.

On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Update tests to be able to work when memory controller is mounted under
> cgroup2 hierarchy.
>

I'm thinking whether we could achieve these setup functions
more generic in cgroup_lib.sh, which to avoid the redundancy
behavior over and over again in each cgroup sub-test.

About the compatibility of cgroup V1 and V2 in test, I'd suggest
following what the LTP C library did in include/tst_cgroup.h.
https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2024

The solution may be briefly as:

  1. scan system mounted CGroup path, and judge the situation as one of
below:
     * only CGroup V2 mounted
     * only CGroup V1 mounted
     * both CGroup V2 and V1 mounted
     * no CGroup mounted
  2. make use of the system mounted CGroup V2 or TSKIP
      * goto step 5
  3. make use of the system mounted CGroup V1
      * goto step 5
  4. do mount Cgroup as what we needed (V1 or V2) in test
      * goto step 5
  5. do cleanup

What do you think?

-- 
Regards,
Li Wang

--00000000000036012405d2121606
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Luke,</div></div><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Thanks for looking into this.</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat=
, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luk=
e.nowakowskikrijger@canonical.com">luke.nowakowskikrijger@canonical.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Upda=
te tests to be able to work when memory controller is mounted under<br>
cgroup2 hierarchy.<br></blockquote><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-size:small">I&#39;m thinking whether we could achiev=
e=C2=A0these setup functions</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">more generic in cgroup_lib.sh, which to avoid=C2=A0the redund=
ancy</div><div class=3D"gmail_default" style=3D"font-size:small">behavior o=
ver and over again in each cgroup sub-test.</div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">About the compatibility=C2=A0o=
f cgroup V1 and V2 in test, I&#39;d suggest</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">following what the LTP C library did in includ=
e/tst_cgroup.h.</div><div class=3D"gmail_default" style=3D"font-size:small"=
><a href=3D"https://github.com/linux-test-project/ltp/blob/master/doc/c-tes=
t-api.txt#L2024">https://github.com/linux-test-project/ltp/blob/master/doc/=
c-test-api.txt#L2024</a></div><br></div><div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">The solution may be briefly as:</div></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 1. scan system mounted =
CGroup path, and judge the situation as one of below:</div><div class=3D"gm=
ail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0* only CGroup V2=
 mounted</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=
 =C2=A0 =C2=A0* only CGroup V1 mounted</div><div class=3D"gmail_default" st=
yle=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0* both CGroup V2 and V1 mounted=
</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =
=C2=A0* no CGroup mounted</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">=C2=A0 2. make use of the system mounted CGroup V2 or TSKIP</div=
><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0 * goto step 5</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">=C2=A0 3. make use of the system mounted CGroup V1=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto st=
ep 5</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 4. =
do mount Cgroup as what we needed (V1 or V2) in test</div></div><div class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto st=
ep 5<br></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=
 5. do cleanup=C2=A0</div><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">What do you think?</div></div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000036012405d2121606--


--===============1400583967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1400583967==--

