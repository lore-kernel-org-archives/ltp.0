Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD305C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 09:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C634A3C9E17
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 10:28:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9953B3C5F90
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 10:28:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B197600F0A
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 10:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644485304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sr1/fAReLK1E8chovgsfuHpqAuDyR0qFRwzSuRIWJnU=;
 b=chv5nLh8jPspB1MUPBUcGKVq0SryP4X+UA1zw1isJdt0pZjT4JMF3aX40CKU6unOftHM70
 V5RG466W8nNUvqkvaUXUDkj5kpSCgpuFNVTPF01M9qK4lWjEhbqllzKM5JWtIl/fvwRN7c
 s1WeyXJ7tza1FxWatNBMYtCi+PPaB/w=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-_VynyHVHOtaIi9ga_oSXVw-1; Thu, 10 Feb 2022 04:28:22 -0500
X-MC-Unique: _VynyHVHOtaIi9ga_oSXVw-1
Received: by mail-yb1-f199.google.com with SMTP id
 v10-20020a05690204ca00b0061dd584eb83so10672061ybs.21
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 01:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sr1/fAReLK1E8chovgsfuHpqAuDyR0qFRwzSuRIWJnU=;
 b=WFJjH3yRi1etBNWGBZ7EDYa2z9GEeKZKQ/mKrzECz97F5ZwQxIMzJK+k5REBSD8L+g
 b2VbAWcNv9FQQB/Qjn26AmtvQlaqql+7AC7TR7An/MwRYJCsP08v+SwVGNvyUnXulrvI
 DJaetRC57DQbZOl38hgIF7tUJ9i0A20pi8mfXbWvZzoiTgbdZrZG1+ZAqTDbXhH9orb3
 0+P1MqB20If/Tr9VswieTKIsLFVJqfxU+pmmUBq11q/oyYaIt2PrNLMErka14UiviQOJ
 C1kA4hFBsG7a8JvtDKqkC7FPShNP6wYXng4GHredBoADA+7+jUOUNgqHxQBRYsXifKzm
 pJAA==
X-Gm-Message-State: AOAM531iEaS+7freeUUJxnurJY8vOgZt+I9R52Hj2CStO4K5TwxVse+q
 eF329hAwvsOYhNIM6wrQ6tQbxsN6Z721NeDKMVVplRcqDMPLOfSDkpq2HRyglpg+xjX/LWr5YPh
 yk8W6REuoq3/q51+6jUrv+ht8w5U=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr6196680ybt.398.1644485301575; 
 Thu, 10 Feb 2022 01:28:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz2dkDP8hYjI48X22LmLhAbr5cPbn7XFByIkJNmXaw3tTUfiByy/xlIUPwTpzczeG/8FJarXd8W0b1oLu7Rt8=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr6196662ybt.398.1644485301063; 
 Thu, 10 Feb 2022 01:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20220209085700.2882422-1-liwang@redhat.com>
 <CAASaF6z1J4UGTse_8fDRGQSsNp+nHYCi2RNHKjfRd1_-LhCb-w@mail.gmail.com>
In-Reply-To: <CAASaF6z1J4UGTse_8fDRGQSsNp+nHYCi2RNHKjfRd1_-LhCb-w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 17:28:07 +0800
Message-ID: <CAEemH2di0t75N_FE7eWM6ndD1LHctxf_YHhQ86grQ+O=7-ziJA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add .min_mem_avail in tst_test struct
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
Content-Type: multipart/mixed; boundary="===============1412482784=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1412482784==
Content-Type: multipart/alternative; boundary="000000000000357a8305d7a692bc"

--000000000000357a8305d7a692bc
Content-Type: text/plain; charset="UTF-8"

Pushed.

-- 
Regards,
Li Wang

--000000000000357a8305d7a692bc
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Pushed.</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000357a8305d7a692bc--


--===============1412482784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1412482784==--

