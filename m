Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8BC433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 10:18:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36292611C9
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 10:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36292611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8B593C2FCF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 11:18:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 078953C2FCF
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 11:18:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 663801401116
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 11:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636021115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6j+UWQ4hCyIBxMGaogSF32NmIiIwj8hIIBMcEs5HgQ=;
 b=gbAgi6VNlz9W+feyRkrtZBqjVxVZuHEQk9CSJzdedN3N9wozmproPuE/iFIcNYUORQmacR
 0o7vN9OT8DHcwTAgHNvnwNB4ZSEvqgw2DVuNpMdfNSn6tZiQKG744jMMOdWsC0k5fbq9FO
 eJz5LNFzXjFahnVUs+wLbJKWyisgDEY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-eV_0emMHMZWAlbJDaCTKeg-1; Thu, 04 Nov 2021 06:18:34 -0400
X-MC-Unique: eV_0emMHMZWAlbJDaCTKeg-1
Received: by mail-yb1-f198.google.com with SMTP id
 l28-20020a25b31c000000b005c27dd4987bso7953592ybj.18
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 03:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C6j+UWQ4hCyIBxMGaogSF32NmIiIwj8hIIBMcEs5HgQ=;
 b=rwcg9LKvWii4w1M6SU0/jU0CVSpwgLiBtxfpUPdO95+/wpxN3F44UycMVa7Fz9xGfs
 Ghqr/nfMK1tYmS8GuQ7NES/ouVCC9DsiXckMkFj8U4CrW+w+LtMi7nXYs0NiccWScMBg
 FDbNV7C+Oobs8QMwH28tFwNlep45p1oWIE4UKHgpSi4KBxSmN2mW0XwY2Fy1vz8psIYz
 vIFwsYvx9qk236i45QpBqSRHpp07qP1pL2pJztzakfR87MlpGHpDh+Vk0926yuwQA7Hd
 asTRLr/vL9k9v9nahQ5zM4jJI0kpT13ORjDJuLvPT0H7P4A1lCLMNaKf0fPr6UujNkLK
 AQYA==
X-Gm-Message-State: AOAM530Chl6l7Xy0cQXbpE2VUHk8TYEnaTYpisCkGTxt387kOj0j1zuC
 /y1UGZsiAl0Qth5I0wYQ4EtHP8W6SaP3GupWcF0IO0diNjaRNe7rnSHpGkNqZXQjwbION187uNM
 kLbvTzTvMu1IPCmX6gqABzImyHcs=
X-Received: by 2002:a25:c608:: with SMTP id k8mr39875654ybf.316.1636021113701; 
 Thu, 04 Nov 2021 03:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJqAPJhdGSCP5WyRhMAHT6u79Om6quoXIuJFCtC3K1olfDmPX4iEwhScdERgZsXo029CiakJTcbsKqDewGxMw=
X-Received: by 2002:a25:c608:: with SMTP id k8mr39875623ybf.316.1636021113366; 
 Thu, 04 Nov 2021 03:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190615042048.29839-1-liwang@redhat.com> <877ddpo35n.fsf@suse.de>
 <CAEemH2fDxJ1xQ9qNejHDxv0p_Cx2cq5LsXTesuhAEBrDe43Hmg@mail.gmail.com>
 <YYKYR4kspdlXuoDB@yuki>
In-Reply-To: <YYKYR4kspdlXuoDB@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Nov 2021 18:18:21 +0800
Message-ID: <CAEemH2e4sp_CYbAF05EA80Y1ggVG6yjRFp=-4EOudGBjTh7Wkg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
 structure
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
Content-Type: multipart/mixed; boundary="===============1228014075=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1228014075==
Content-Type: multipart/alternative; boundary="0000000000004ec30105cff3d9fa"

--0000000000004ec30105cff3d9fa
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 3, 2021 at 10:09 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Um, I can't recall why the V3 development for .arch
> > was suspended.
> >
> > Maybe we thought there is not much sense to replace
> > ifdef __arch__ from code at that moment.
> >
> > Now, if that can benefit the tst_test metadata more in the next
> runltp-ng.
> > Should we keep going to work out the patch V3?
> >
> > @Cyril Hrubis <chrubis@suse.cz>  any suggestions?
>
> Hmm, I guess that I said that it still makes to add the metadata, at
>

Agreed.



> least array of supported architectures in the test_test structure would
> be a good addition.
>

I guess defining .arch as a string and making a valid check will be enough.
Array for that sounds a bit complicated in use.


>
> However the hard part would be keeping the actual code and metadata in
> sync, we still have to keep the ifdefs in the code.
>

Yes, some inline assemble require ifdefs.

Btw, I look back at the reviews and find Jan said:
    "I can see how tst_on_arch() would be useful. Test is valid
     on all arches, but needs different input/constants/code/etc."

That may be a slight reason for keeping tst_on_arch.

-- 
Regards,
Li Wang

--0000000000004ec30105cff3d9fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"></d=
iv><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Wed, Nov 3, 2021 at 10:09 PM Cyril Hrubis &lt;<a href=3D"mailt=
o:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Um, I can&#39;t recall why the V3 development for .arch<br>
&gt; was suspended.<br>
&gt; <br>
&gt; Maybe we thought there is not much sense to replace<br>
&gt; ifdef __arch__ from code at that moment.<br>
&gt; <br>
&gt; Now, if that can benefit the tst_test metadata more in the next runltp=
-ng.<br>
&gt; Should we keep going to work out the patch V3?<br>
&gt; <br>
&gt; @Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank"=
>chrubis@suse.cz</a>&gt;=C2=A0 any suggestions?<br>
<br>
Hmm, I guess that I said that it still makes to add the metadata, at<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Agreed.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
least array of supported architectures in the test_test structure would<br>
be a good addition.<br></blockquote><div><br></div><div><div class=3D"gmail=
_default" style=3D"font-size:small">I guess defining .arch as a string and =
making a valid check=C2=A0will be enough.</div><div class=3D"gmail_default"=
 style=3D"font-size:small">Array for that sounds a bit complicated in use.<=
/div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
However the hard part would be keeping the actual code and metadata in<br>
sync, we still have to keep the ifdefs in the code.<br></blockquote><div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-size:small">Yes, so=
me inline assemble<span style=3D"color:rgb(51,51,51);font-size:14px">=C2=A0=
require ifdefs.</span><br></div><div class=3D"gmail_default" style=3D"font-=
size:small"><span style=3D"color:rgb(51,51,51);font-size:14px"><br></span><=
/div><div class=3D"gmail_default" style=3D"font-size:small"><span style=3D"=
color:rgb(51,51,51);font-size:14px">Btw, I look=C2=A0back at the reviews an=
d find Jan said:</span></div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><span style=3D"color:rgb(51,51,51);font-size:14px">=C2=A0 =C2=A0 &=
quot;</span>I can see how tst_on_arch() would be useful. Test is valid=C2=
=A0</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 =C2=A0on all arches,=C2=A0but needs different input/constants/code/etc.=
&quot;</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">That may be=C2=A0a=
 slight reason=C2=A0for keeping tst_on_arch.</div></div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000004ec30105cff3d9fa--


--===============1228014075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1228014075==--

