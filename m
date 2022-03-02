Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0A4C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 18:09:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852193CA34F
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 19:09:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AED023C9458
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 19:09:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDA9E14012DB
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 19:09:14 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C1C53F164
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646244552;
 bh=6UEwOFi1tdDqjRDPyZlGiKCi4L+wzzKjCmaYRRPugE4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=uiXJ/0AAe1NHdd/FaRk+gy39B6gjBOdnG2RdB6EZm5hFEKcvldeRYgQ/TEYQ/I/mM
 HRlVMyDlLe128+znnq8BTs65Ti8QHP8w+m2U/zULwX/sD9AZFPc4nkhUXL8nMq8jjq
 mJs2xjL8mfEaGhYbSbvVXJWYNxTVTiwqudy75Fjh0sFpqdaPxIF/v1esHrjk9JaEpl
 dyJXkGiITecx84qnyPcv5ozSnU3SK5XI7s/rxYUOlc8Eoi235thnSS0ntrQ/k+qqkT
 +fAEQzjCp0vv6+bdt0eeLTpfqkAdqFXG6qaPLL5roWP456S06WQbYN+2dWFiVss0oA
 h43l3NcFp13OQ==
Received: by mail-ed1-f72.google.com with SMTP id
 d11-20020a50c88b000000b00410ba7a14acso1454613edh.6
 for <ltp@lists.linux.it>; Wed, 02 Mar 2022 10:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UEwOFi1tdDqjRDPyZlGiKCi4L+wzzKjCmaYRRPugE4=;
 b=bxiW8a+8k9Pixj/I09om7vF/rgU4gxW0RcoAlakrRR0l9E6hybaQx6dMo9jfa7q5p2
 6fQRcoUP+NL8RulWscgyP4tI6z+1E16o3RA2DCJtKEcMHUJPzb9KxnDwIMSfL+I7MHjq
 ogqyPAXe3UOCFAcx1gQ61iXF6Gs7+MkD14ePHxVHWCVTfiZnFmYz7uWkDWesyOT7lnq/
 Yj3sDqlrL0OhKE29PG7R6R+RVyxlIOjJsn1bXKkG+s+0d0P4pDjvpYW3ppHSV32V7tHg
 gDehw9NcCu7Bi4XEZ8FEGClQ6rbtV5Sed6vFbi6ZYVCfhrm38z0najPj0cR7e+vTvnBF
 jPrg==
X-Gm-Message-State: AOAM530j1esvFFlYlQpabLZTMUxjl1M4im8vjvl8UdqXDvhG7btR4D2v
 XjKH8x3/7/ypkJ+WpSjPj+b/tr/d53fRlNIXS0+AECG5QCkPvOpqyk5HjDGtski7kC/4/Ixvez/
 T/pgwb+oJ2/JdOyjlWLDn50ud2OACtWUcLU8FOyuRBhDh
X-Received: by 2002:a17:907:7fa5:b0:6d7:cdc:9590 with SMTP id
 qk37-20020a1709077fa500b006d70cdc9590mr5856573ejc.147.1646244551152; 
 Wed, 02 Mar 2022 10:09:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm868UMfUmwxcSzVbE4Gw2FgpV/+yA3tiBVcelsIwaXn1wyfk5iITTZ5ukkHGawcK/Wu43eSojG8fqXebG5Cc=
X-Received: by 2002:a17:907:7fa5:b0:6d7:cdc:9590 with SMTP id
 qk37-20020a1709077fa500b006d70cdc9590mr5856555ejc.147.1646244550913; Wed, 02
 Mar 2022 10:09:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <5a65fad42ee618e0191cc664d8da7feeaa754cc0.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <87bl01z5ld.fsf@suse.de>
In-Reply-To: <87bl01z5ld.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 2 Mar 2022 10:08:34 -0800
Message-ID: <CADS1e3dDLejkczT7U0MPcrU6fs+rcTMw-ut6tZFXS3S_0XcJ3Q@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/16] API/cgroup: Implement
 tst_cgroup_load_config()
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
Content-Type: multipart/mixed; boundary="===============0880904642=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0880904642==
Content-Type: multipart/alternative; boundary="000000000000abd71305d9402d2c"

--000000000000abd71305d9402d2c
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

Sorry for the hiatus and the delay on getting this done. There was some
other stuff keeping me from finishing things up here.

On Mon, Jan 24, 2022 at 4:22 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Luke,
>
> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:
>
> > Implement tst_cgroup_load_config which consumes the state given by
> > tst_cgroup_print_config() to update the internal test state to reflect
> > the given config.
> >
> > This allows for programs using the cgroup C API to load and reload
> > state, allowing functionality such as calling tst_cgroup_require and
> > tst_cgroup_cleanup to function properly between programs or between
> > invocations of a binary using the C API.
>
> I'm afraid I have to say this looks way more complicated than it needs
> to be. We control the input format after all.
>
> If you can make each line the same format then it may be possible to
> just use a single scanf on each line. Note that it's only possible to
> have ~14 controllers, so we can even afford to repeat the root info on
> each line.
>
>
I have read through all the feedback and I agree with all of it. I
implemented something along the lines of what you described here and I
agree that it looks a lot better and much much more simple. Hopefully get
that out to you soon to review.


> --
> Thank you,
> Richard.
>

Thanks,
Luke

--000000000000abd71305d9402d2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li, <br></div><div><br></div><div>Sorr=
y for the hiatus and the delay on getting this done. There was some other s=
tuff keeping me from finishing things up here.</div><div><br></div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 24, 20=
22 at 4:22 AM Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hello Luke,<br>
<br>
Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canoni=
cal.com" target=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wri=
tes:<br>
<br>
&gt; Implement tst_cgroup_load_config which consumes the state given by<br>
&gt; tst_cgroup_print_config() to update the internal test state to reflect=
<br>
&gt; the given config.<br>
&gt;<br>
&gt; This allows for programs using the cgroup C API to load and reload<br>
&gt; state, allowing functionality such as calling tst_cgroup_require and<b=
r>
&gt; tst_cgroup_cleanup to function properly between programs or between<br=
>
&gt; invocations of a binary using the C API.<br>
<br>
I&#39;m afraid I have to say this looks way more complicated than it needs<=
br>
to be. We control the input format after all.<br>
<br>
If you can make each line the same format then it may be possible to<br>
just use a single scanf on each line. Note that it&#39;s only possible to<b=
r>
have ~14 controllers, so we can even afford to repeat the root info on<br>
each line.<br>
<br></blockquote><div><br></div><div>I have read through all the feedback a=
nd I agree with all of it. I implemented something along the lines of what =
you described here and I agree that it looks a lot better and much much mor=
e simple. Hopefully get that out to you soon to review. <br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br></div><div>Thanks, <br></div><div>Luke=C2=
=A0 <br></div></div></div>

--000000000000abd71305d9402d2c--

--===============0880904642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0880904642==--
