Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BE2C28D13
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 02:53:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6503CA255
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 04:53:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D6C3C98BF
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:53:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD0C71000604
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660963989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7egV5Sx5TkkmW6K0gLcKSVqgmpMwvMD9pgLKk/nIpKY=;
 b=A2WwN1aCko3NSiRKVS3FR15vME9Miv5Lct84Mn26biOUSr1M7N0FHP9EJezxhlHTBMgP+y
 X/WXQajtHH0Z6NqsMB5iK5UdaWPRJQHRu78dLmdXbUdjRg6+OpIaF/WdbfrELBGyAXcae+
 cXKtEZD3VOQeyVTPPSq2+OSI570EgZE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-8ucaRAWZPSKszYXXbkOp6Q-1; Fri, 19 Aug 2022 22:53:05 -0400
X-MC-Unique: 8ucaRAWZPSKszYXXbkOp6Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-3339532b6a8so104817457b3.1
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 19:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=7egV5Sx5TkkmW6K0gLcKSVqgmpMwvMD9pgLKk/nIpKY=;
 b=g3W7q2g5af2/WwKwT2LJKQp4tVON4P3a0i55WPuDyAOFwmw/SYTtTadG4klAYEGfvh
 RPXf682SZrTME5x43b3ATZhfglcFRBqKNwX1MdkK6YzIe8s2oMIaRXsvCxrmpsRHP8yf
 ugB/tWsFcmZG1O0t03XeHALGtS9RgGtNO8M91ACG3GGcqwB0/x3VkLbTdfyx4vG0O1qb
 K2lZuJenfDI5411yrN6RrkQ5ZfWppWj+vL9Vu/dwNfFIuMr4xuaCuoLyGefu0ZPcoT3c
 GMqlKc8hc5DfSi/5mLfAdfmhtDoQ4kJ9PiZaksPzCv/YTg3Bk38j7x8VpiZu+sp02DWt
 vaqQ==
X-Gm-Message-State: ACgBeo0R3jnzf9WDBzr1kNbEn7l/IfOmx8fxi6cr4pca5ZjBy2BlwJBY
 fQL6ltrCRQLnQ+84ctNxzIk9rZ0n74zISqBVWyvsnhprwF9LF/iiQn+5QF+YXHT9QWCdc0c9ak/
 ISD03GAdO//X5jL36nwC3p4XMPrs=
X-Received: by 2002:a81:124c:0:b0:334:d633:f3c9 with SMTP id
 73-20020a81124c000000b00334d633f3c9mr10641184yws.437.1660963985163; 
 Fri, 19 Aug 2022 19:53:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4HNo1hIjUs0iDfGZBNs3eoU4jNg3hIOiNZC5d88d4aP7Iu5bLbi0sVVzT96YDsddIjZZSTHd0G4FXtZrn3Vms=
X-Received: by 2002:a81:124c:0:b0:334:d633:f3c9 with SMTP id
 73-20020a81124c000000b00334d633f3c9mr10641162yws.437.1660963984931; Fri, 19
 Aug 2022 19:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv4MBF79PnJKJbwm@yuki>
In-Reply-To: <Yv4MBF79PnJKJbwm@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Aug 2022 10:52:53 +0800
Message-ID: <CAEemH2cvBxQY_SkF_43MzZnytqCJpoqob9yZjy7goq2UrUfv+g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, automated-testing@yoctoproject.org,
 LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============2060295838=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2060295838==
Content-Type: multipart/alternative; boundary="0000000000004e9cd405e6a350db"

--0000000000004e9cd405e6a350db
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 18, 2022 at 5:51 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> I'm starting to wonder if we should start tracking minimal FS size per
> filesystem since btrfs and xfs will likely to continue to grow and with
> that we will end up disabling the whole fs related testing on embedded
>

So from this point, it still seems to make sense to have this patch[1].
Canceling the limit of 300MB for XFS will benefit embedded system.

[1] export TEST_DIR=1 TEST_DEV=1 QA_CHECK_FS=1


-- 
Regards,
Li Wang

--0000000000004e9cd405e6a350db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Aug 18, 2022 at 5:51 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
I&#39;m starting to wonder if we should start tracking minimal FS size per<=
br>
filesystem since btrfs and xfs will likely to continue to grow and with<br>
that we will end up disabling the whole fs related testing on embedded<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">So from this point, it still seems to make sense to have this p=
atch[1].</div><div class=3D"gmail_default" style=3D"font-size:small">Cancel=
ing the limit of 300MB for XFS will benefit=C2=A0embedded system.</div><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">[1] export TEST_DIR=3D1 TEST_DEV=
=3D1 QA_CHECK_FS=3D1</div></div></div><br clear=3D"all"><div><br></div>-- <=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards=
,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000004e9cd405e6a350db--


--===============2060295838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2060295838==--

