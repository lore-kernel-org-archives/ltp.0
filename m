Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344F1C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 02:19:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3133CA6C6
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 04:18:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE81F3C217A
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 04:18:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6FF3110008F8
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 04:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650507525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXB4B6NM7cATKg+GCF5pGA+pb4yv/8D8JqOjhgtvv7g=;
 b=PUZ967RQODBF0UETNmSh28cf+B6JdIQPfAqPIGVsc34Y8XO1vWDPVtqse9BcUfLRix2u0+
 US9mXjS7myabGhTMznod9ft7sdkxWYezsOxLIFwjykj7zuLrh/GeXtJ8Ub29lcmPAEYwGT
 8YXxC+FS5Bl9NZEPMi/g1e4Bx1pu85E=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-V7pZU1FOMoKJoDW6heUFgw-1; Wed, 20 Apr 2022 22:18:44 -0400
X-MC-Unique: V7pZU1FOMoKJoDW6heUFgw-1
Received: by mail-yb1-f198.google.com with SMTP id
 l16-20020a25cc10000000b006456cb3d1deso1812689ybf.14
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 19:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pXB4B6NM7cATKg+GCF5pGA+pb4yv/8D8JqOjhgtvv7g=;
 b=kJ8/g5MJAPhEoVYfRhJJPvlWTeq0E/q6Qxb8WnAtsSZY03UFjZp/blbIcOr9qGPYZO
 VrlmhYOKoJKnsAVNwKGIkAs12ekBJyPcqHf2VGKq6L9YERZQKVb8iYo9/TsyXX4p2otH
 5DUzntRQcIk1ofFQ7tDIcEl3QKDA9v8sPcSrKQO/FhQT1tChNDlbUD9MQ3seJdmdWtOY
 KAgCz2yp1rzvPWsMvAOyN2vTIFRaDhpVYhY9dvaVA/z+1oUXxr0ZdUcWbb856whtRuBh
 tVEf/jsd6yduidcgTvcLfz1hUnbLmWJ15Cx/efiDy7SLayxTLKIwgLLLZPAQ4rMkIs0k
 MPLQ==
X-Gm-Message-State: AOAM533uKK4Hcx/h5F9gSBC1zfzDldOWrCZv2Uqjv4jxtA+o9B8ZkySl
 1ad0yalH+Ct+uWFfQcudGAVUufNYBcSp4M9kHdmJD9py33Z0v0CK6FEw2MPJg1XBIhhj2da53E5
 5QX1MLOzj6dqiapIq9hJ6ip8fUU0=
X-Received: by 2002:a25:d789:0:b0:642:8b3:a5b8 with SMTP id
 o131-20020a25d789000000b0064208b3a5b8mr22884968ybg.273.1650507524014; 
 Wed, 20 Apr 2022 19:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/sQEZ/RycLCpmZVMLoGLyxRC63L8bxjzc1HSa/KuGh3YNcoNBcnKKkP+su0I00HWD4mD+T7fNtIYdL5PgUtA=
X-Received: by 2002:a25:d789:0:b0:642:8b3:a5b8 with SMTP id
 o131-20020a25d789000000b0064208b3a5b8mr22884953ybg.273.1650507523661; Wed, 20
 Apr 2022 19:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220420114720.1463473-1-liwang@redhat.com>
 <20220420114720.1463473-2-liwang@redhat.com>
 <YmBzdLLeX3kNfbvu@pevik>
In-Reply-To: <YmBzdLLeX3kNfbvu@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Apr 2022 10:18:24 +0800
Message-ID: <CAEemH2dBCRC2CRERBQw_Tj6SBrCZazKg-WXrJ+4qMLR3Zp=8Dg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============2019349929=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2019349929==
Content-Type: multipart/alternative; boundary="000000000000a5b72805dd20baea"

--000000000000a5b72805dd20baea
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 21, 2022 at 4:56 AM Petr Vorel <pvorel@suse.cz> wrote:


>
> > -     udevadm trigger --name-match=$TST_DEVICE
> > +     udevadm trigger --name-match=$TST_DEVICE --settle
>
> >       if [ -n "$device" ]; then
> >               mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
> "$dev_file"
>
> --settle option for udevadm trigger has been added in v238 (in 2018) [1].
> This mean on SLES 12-SP5, RHEL-7.9, 18.04 LTS bionic, ... we get:
>
> trigger: unrecognized option '--settle'
>

Thanks for pointing out this, Petr.

>
> Do we ignore backward compatibility hoping that all distros aren't tested
> with
> newer LTP?
>

Actually, we only use fixed older-version of LTP for long-term supported
distros (e.g RHEL6/7) testing, as it falls into maintaining phase and no new
features are added in. So this won't be a problem for us.

But if we consider fully backward compatibility of newer LTP for old
distros,
this is a burden to maintaining work. We might need to make a balance on
the patch accept or reject.

With regard to this simple patch, if you think it's a problem to SLES
12-SP5, I'm
fine to NAK and rewrite with another way (at least for ioctl09 I will do
that).

But if you're OK with making use of fixed LTP on older distros, feel free
to apply this one :).

-- 
Regards,
Li Wang

--000000000000a5b72805dd20baea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Apr 21, 2022 at 4:56 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
div><div class=3D"gmail_default" style=3D"font-size:small">Thanks for point=
ing out this, Petr.</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Do we ignore backward compatibility hoping that all distros aren&#39;t test=
ed with<br>
newer LTP?<br></blockquote><div><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Actually, we only use fixed=C2=A0older-version of LTP=
 for long-term supported</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">distros (e.g RHEL6/7) testing, as it falls into maintaining phase=
 and no new</div><div class=3D"gmail_default" style=3D"font-size:small">fea=
tures are added in. So this won&#39;t be a problem for us.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">But if we consider=C2=A0fully backward c=
ompatibility of newer LTP for old distros,</div><div class=3D"gmail_default=
" style=3D"font-size:small">this is a burden to maintaining work. We might =
need to make a balance on</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">the patch accept or reject.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div></div><div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">With regard=C2=A0to this simple patch, if you thin=
k it&#39;s a problem to <span class=3D"gmail_default"></span>SLES 12-SP5, I=
&#39;m</div><div class=3D"gmail_default" style=3D"font-size:small">fine to =
NAK and rewrite with another way (at least for ioctl09 I will do that).</di=
v></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">But if you&#39;re OK w=
ith making use of fixed LTP on older distros, feel free to apply this one :=
).</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--000000000000a5b72805dd20baea--


--===============2019349929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2019349929==--

