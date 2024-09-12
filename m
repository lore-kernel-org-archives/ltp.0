Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BFEEB599
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 11:53:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52EBD3C2698
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 13:53:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 023D13C2467
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 13:53:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E18B60068C
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 13:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726142011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U91NoVaTsNRrgqA53qpABwCme3szG9ea4NgMcZKycfA=;
 b=I8wT0ipb7OFWwy5/22eWwpDKHSdFD/GR/faVSvPxnbH/p2coQLNtCwtJtlmRR8NEfbJUou
 kMCVG96QxJTh4oZH+/lM5K4I0yN5HHto3dantslFiorbx7MaC+522ykev5Xij4zPEXEZ0q
 x33EG4UDcRl6sJ/Lo4VBGiWMGJ8Eys4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-wxSkCE4ENeK11vDUgvbIKA-1; Thu, 12 Sep 2024 07:53:29 -0400
X-MC-Unique: wxSkCE4ENeK11vDUgvbIKA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-718d51f33a6so886446b3a.2
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 04:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726142009; x=1726746809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U91NoVaTsNRrgqA53qpABwCme3szG9ea4NgMcZKycfA=;
 b=qB0lffPXqS8U7aCbivj+5YXewtND3l/+OuprO5owhDGX7Z4LkB26tFK0+NnqUbRaiF
 o37KcgeFqWOWGc7zd7EXkhV8qq3PfsjUpw1cO2ZyBC+SruhySTZM2Ym8sfuDklp0rJUd
 UckhNQIRzOzY/LLcdZtKP1e7CRoTzLd5zYHA2Ee/Wg2GqRn3LQGlNInH0it01iqyxWm4
 6Na407Ckpaxq40TZky6Mz6IElMSzL8ZP/hNi65vg1ivzuJYUaetYOUFZCAUh03KbI5OD
 89X0vz2bRyXJjZqo8+8cXmeRCTlLJAy6mvYqOCYYLIIVnnZmktgvFFd+EsRBohnItr3P
 1e2w==
X-Gm-Message-State: AOJu0Yy8owjeveGNkn2+kKPy4AP7mSMS1CutQJG5xxDyqqYodQIY8DfJ
 U/Xx2HpEpIPpOL4CRlDYEGYTUVDQCbdvGBQcMQkYh7sPqXjwjoyf2Q20C/qiJL7+LnH4LxePHiN
 Fxxnx3SftY0bnisr3uFpqu2KpgivnZEvkkeV/qQBqybe2Ynyp5PlFYcP9yDAIx5XEhK6Qgdmso/
 26wN1RunfdpYdVTfcWE+iA8bE=
X-Received: by 2002:a05:6a00:2789:b0:718:e51e:bd25 with SMTP id
 d2e1a72fcca58-719261fa38dmr2916536b3a.25.1726142008796; 
 Thu, 12 Sep 2024 04:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdMm9NGImRuvOz0ye1sxB3p1KwaIWjKuRq2555t47VxA1rjEHUT6KkPpbG+fzmMwnqT/GPB4teVi7h0L5nlyw=
X-Received: by 2002:a05:6a00:2789:b0:718:e51e:bd25 with SMTP id
 d2e1a72fcca58-719261fa38dmr2916515b3a.25.1726142008375; Thu, 12 Sep 2024
 04:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240912083102.3216-1-andrea.cervesato@suse.de>
In-Reply-To: <20240912083102.3216-1-andrea.cervesato@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2024 19:53:16 +0800
Message-ID: <CAEemH2fL6=L1LOUzGF1QuSn6_+PwwEYVgwE5PiVWL7ANeK2Stg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5] Add rename15 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
