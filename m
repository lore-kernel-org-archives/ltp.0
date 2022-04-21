Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA94C433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 06:44:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF403CA6D5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 08:44:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944BC3C6934
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 08:44:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF6F01400346
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 08:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650523468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wj8OMsg3jHdKwLk5Jpm6DAxQoU7QGMGAvel+v17vN0=;
 b=W1btkcwGEpAqoJP5pZZKvmazmBN4emvJ9Zu6DqDGacdueIFHIWSPqjBxpDsV+NDbm597Fp
 0oaqBlSIS/TGPu5h15wSbOYvDt912kfG3L25f2/p/Ht2btA62aT/WZcPHPx6F2Jfjeyoz/
 tEbHKInKsOb9rJ7Nz+XUlv9sLSskV/Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-k-6A7tDZMDKhdvuwy6LfQQ-1; Thu, 21 Apr 2022 02:44:26 -0400
X-MC-Unique: k-6A7tDZMDKhdvuwy6LfQQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2f18a73fabeso35708627b3.20
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 23:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8wj8OMsg3jHdKwLk5Jpm6DAxQoU7QGMGAvel+v17vN0=;
 b=VJ+sNPO1KYeAGeSO+sN3naSjkfxRdMc45/DiJU3zUm1ceL53eJfTsHouYpau6f8ZU4
 Cr7nrm6q2TXIVVlH/3a/SNgjoNYAGJFHzJW3ecfA2V5RDyHbEQBmtqAKgXjDEfSOEU1k
 eBqEhYtDi2wEVYV736bcx2HNYkH2oCACx26h0oz4QF5ZckuAsV+iTggZ+KcBuabZtzEm
 STITZSvZ71e4/LAYJ2djiaziOIt3wmS1hrA595aGwDmg+Q88/lCuv7/JYJOAaTPIsvRS
 HJoPWe/rLIfIRAoo8xoZDbOqsJbQIfoX8PxGFCH5UU87nt9lun8FV2xLUtN1DNs5SpFq
 3iMA==
X-Gm-Message-State: AOAM531Vvp5fxT4ISXNDKNGEdS9A3gYINLEETGT1U50WjBkQXAOBGBR2
 sl9cNXgF5iI0b/toXmcwKThdXWHb6Ozo1OPEQRp2JU3eH8EkpvEhDR/8t5yyXuui7P516GDtTi9
 4JBWnym8xnSVJ2sgvc/nr7Iygvzk=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr24878563ywa.19.1650523466181; 
 Wed, 20 Apr 2022 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzszesRQZrJYw9H0TDKCeBdnLsTxibSQWuDF0doNwhhKEXbQ0dN9bBFDGRXMCfv9k9pJ8DoAccVB/39IYzycjc=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr24878553ywa.19.1650523465976; Wed, 20
 Apr 2022 23:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220420114720.1463473-1-liwang@redhat.com>
 <20220420114720.1463473-2-liwang@redhat.com>
 <YmBzdLLeX3kNfbvu@pevik>
 <CAEemH2dBCRC2CRERBQw_Tj6SBrCZazKg-WXrJ+4qMLR3Zp=8Dg@mail.gmail.com>
In-Reply-To: <CAEemH2dBCRC2CRERBQw_Tj6SBrCZazKg-WXrJ+4qMLR3Zp=8Dg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Apr 2022 14:44:11 +0800
Message-ID: <CAEemH2d=r90AUhNzqHFc8mQFHd-eQeEHLebUaJhXNNwUVb=rpA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mkswap01: wait for the triggered events to
 complete
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
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1638469509=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1638469509==
Content-Type: multipart/alternative; boundary="000000000000e2254d05dd2470d4"

--000000000000e2254d05dd2470d4
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 21, 2022 at 10:18 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Thu, Apr 21, 2022 at 4:56 AM Petr Vorel <pvorel@suse.cz> wrote:
>
>
>>
>> > -     udevadm trigger --name-match=$TST_DEVICE
>> > +     udevadm trigger --name-match=$TST_DEVICE --settle
>>
>> >       if [ -n "$device" ]; then
>> >               mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
>> "$dev_file"
>>
>> --settle option for udevadm trigger has been added in v238 (in 2018) [1].
>> This mean on SLES 12-SP5, RHEL-7.9, 18.04 LTS bionic, ... we get:
>>
>> trigger: unrecognized option '--settle'
>>
>
> Thanks for pointing out this, Petr.
>
>>
>> Do we ignore backward compatibility hoping that all distros aren't tested
>> with
>> newer LTP?
>>
>
> Actually, we only use fixed older-version of LTP for long-term supported
> distros (e.g RHEL6/7) testing, as it falls into maintaining phase and no
> new
> features are added in. So this won't be a problem for us.
>
> But if we consider fully backward compatibility of newer LTP for old
> distros,
> this is a burden to maintaining work. We might need to make a balance on
> the patch accept or reject.
>
> With regard to this simple patch, if you think it's a problem to SLES
> 12-SP5, I'm
> fine to NAK and rewrite with another way (at least for ioctl09 I will do
> that).
>
> But if you're OK with making use of fixed LTP on older distros, feel free
> to apply this one :).
>


Or, just go with the traditional way for compatibility:

--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -128,7 +128,8 @@ mkswap_test()
                return
        fi

-       udevadm trigger --name-match=$TST_DEVICE --settle
+       udevadm trigger --name-match=$TST_DEVICE
+       udevadm settle --exit-if-exists==$TST_DEVICE

        if [ -n "$device" ]; then
                mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
"$dev_file"


-- 
Regards,
Li Wang

--000000000000e2254d05dd2470d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Apr 21, 2022 at 10:18 AM Li Wang &lt;<a hre=
f=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 21, 2022 at 4=
:56 AM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">p=
vorel@suse.cz</a>&gt; wrote:</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0udevadm trigger --name-match=3D$TST_DEVICE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0udevadm trigger --name-match=3D$TST_DEVICE --sett=
le<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -n &quot;$device&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mkswap_verify &q=
uot;$mkswap_op&quot; &quot;$op_arg&quot; &quot;$device&quot; &quot;$size&qu=
ot; &quot;$dev_file&quot;<br>
<br>
--settle option for udevadm trigger has been added in v238 (in 2018) [1].<b=
r>
This mean on <span class=3D"gmail_default" style=3D"font-size:small"></span=
>SLES 12-SP5, RHEL-7.9, 18.04 LTS bionic, ... we get:<br>
<br>
trigger: unrecognized option &#39;--settle&#39;<br></blockquote><div><br></=
div><div style=3D"font-size:small">Thanks for pointing out this, Petr.</div=
><div style=3D"font-size:small"></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
Do we ignore backward compatibility hoping that all distros aren&#39;t test=
ed with<br>
newer LTP?<br></blockquote><div><br></div><div style=3D"font-size:small">Ac=
tually, we only use fixed=C2=A0older-version of LTP for long-term supported=
</div><div style=3D"font-size:small">distros (e.g RHEL6/7) testing, as it f=
alls into maintaining phase and no new</div><div style=3D"font-size:small">=
features are added in. So this won&#39;t be a problem for us.</div><div sty=
le=3D"font-size:small"><br></div><div style=3D"font-size:small">But if we c=
onsider=C2=A0fully backward compatibility of newer LTP for old distros,</di=
v><div style=3D"font-size:small">this is a burden to maintaining work. We m=
ight need to make a balance on</div><div style=3D"font-size:small">the patc=
h accept or reject.</div><div style=3D"font-size:small"><br></div></div><di=
v><div style=3D"font-size:small">With regard=C2=A0to this simple patch, if =
you think it&#39;s a problem to <span class=3D"gmail_default"></span>SLES 1=
2-SP5, I&#39;m</div><div style=3D"font-size:small">fine to NAK and rewrite =
with another way (at least for ioctl09 I will do that).</div></div><div sty=
le=3D"font-size:small"><br></div><div style=3D"font-size:small">But if you&=
#39;re OK with making use of fixed LTP on older distros, feel free to apply=
 this one :).</div></div></blockquote><div><br></div><div><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Or, just go with the tradit=
ional way for compatibility:</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div>--- a/testcases/commands/mkswap/mkswap01.sh<br>+++ =
b/testcases/commands/mkswap/mkswap01.sh<br>@@ -128,7 +128,8 @@ mkswap_test(=
)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 udevadm tri=
gger --name-match=3D$TST_DEVICE --settle<br>+ =C2=A0 =C2=A0 =C2=A0 udevadm =
trigger --name-match=3D$TST_DEVICE<br>+ =C2=A0 =C2=A0 =C2=A0 udevadm settle=
 --exit-if-exists=3D=3D$TST_DEVICE<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if [ -n &quot;$device&quot; ]; then<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 mkswap_verify &quot;$mkswap_op&quot; &quot;$op_arg&quo=
t; &quot;$device&quot; &quot;$size&quot; &quot;$dev_file&quot;</div><br cle=
ar=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000e2254d05dd2470d4--


--===============1638469509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1638469509==--

