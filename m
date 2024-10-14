Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CFFCF2590
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 04:07:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8BD93C656A
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 06:07:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0C33C01D3
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 06:06:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 088F66331EA
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 06:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728878808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxFalv4wzOiaAOqwSHxWK+ogmvZ8prTfPnpIzvygQZk=;
 b=U+hhkrzoA4kOECNEvlhVBbY4VBddnYd1puN4pwqg1ShAQMQ8K9OetW2+7sO5LYDWwzQDa8
 XvFzD4Uwy9QcTrYMexhQ4sFLax0hJChvoGot/Sw1tdhZIJdHW98pmbmrFvhFj61TgTo6GG
 eGI0n0Jxalrrl+BZ4Kzg3sBUFPypAqQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-Rr477bYLOq-UZpkb_JPvUQ-1; Mon, 14 Oct 2024 00:06:46 -0400
X-MC-Unique: Rr477bYLOq-UZpkb_JPvUQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7e6cc094c2fso3581507a12.1
 for <ltp@lists.linux.it>; Sun, 13 Oct 2024 21:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728878805; x=1729483605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxFalv4wzOiaAOqwSHxWK+ogmvZ8prTfPnpIzvygQZk=;
 b=sNxtFASfWBU93JoXEzF3bHwjWLvgbPN9074nAEWZ5xbkt8mnb0iI+A4AGXXvAgO6zw
 MGzbfujprRNEOK75Q0QOyCbONQ0Xe/m4OeOVJxKgFc4hIwOmMdEdNhF/Zz7cnZdXhkG4
 4/+72SO5XCIYPqXioaP1BbFWyJoNn3xrZCSvhjhNd3eCP9SohIjV7O0zqKhFoO8G4hR6
 t1VAT3aHqLH8ynCEBXZyLER/4JyUaDAKQ00ibqHmenTEfW9v0etlD3sOzbJNHvOeHRcG
 mMLAlQJXL5nccuFyUrb6kpFCOnV6dqIiDyrAEUXsPd6RaWJaQwKgWyHBcfVFgC0HcEhY
 LU8w==
X-Gm-Message-State: AOJu0Yy8W6dl7VXNNSWj5eWH86QHC0Ltsl07G6im1O4P3KUtrX6c6a0d
 BM4VNhX9ipWqdJr8FgqKsf0pFK3cfCkOYt2pP3DU7Z5egpxcOGYrJajj4pnIEQ3imZZ+3q+6tBO
 0slOilOi7okW/yu2wi7z52HqF9lKpiH1FVzb46NLSqFtCjRYDZZEvkOCGTJKa7fvCvnzgGl20Bb
 SfZncRQDM2uP+7a8VsPJFzov0=
X-Received: by 2002:a17:90a:e982:b0:2e2:c744:2eea with SMTP id
 98e67ed59e1d1-2e2f0d7b469mr15712703a91.13.1728878805644; 
 Sun, 13 Oct 2024 21:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuObKjPyhWG1CwH6kZhFAkDlQHA7zlaB0wRnT3yE9tzaNoJZSC5FHH1mdslHlWmChe26rNkgBcAkklSATyvX0=
X-Received: by 2002:a17:90a:e982:b0:2e2:c744:2eea with SMTP id
 98e67ed59e1d1-2e2f0d7b469mr15712672a91.13.1728878805095; Sun, 13 Oct 2024
 21:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241011231007.3549892-1-edliaw@google.com>
In-Reply-To: <20241011231007.3549892-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Oct 2024 12:06:33 +0800
Message-ID: <CAEemH2cTDBrY_mD2Bnyq_B_yYPWwvC5g9TkgVXF-OiRo3kzxZw@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] runtest/mm: create TMPFILE in TMPDIR for
 mmapstress07
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Applied, thanks.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
