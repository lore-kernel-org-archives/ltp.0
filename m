Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E5DECAAD8
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 06:18:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E59773CA709
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 08:18:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22F3D3CA6A8
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:18:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C4401000A36
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661926699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+teeE2+1M0MGvTqW9I7DvUySHuYMI4iwyRHOF74lic=;
 b=RRMcnIQYr3yrGPyje1w9jaX3ENl7fvEbZnTFBovMyz+UtX3MvA8QAk2SUMmJonOEjE6v5t
 RHFEIf2JNbWR+nLPPqDGwmkWZlUGtVJHIUBFZaUBMt4hILGL6HKLD7p+YuX/Zf/E1AMMML
 T9MJONVMXE9sfVRlkugKifhxcrRgKOc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-wIN0Ven8Mu-ipcXZzZXbnQ-1; Wed, 31 Aug 2022 02:18:18 -0400
X-MC-Unique: wIN0Ven8Mu-ipcXZzZXbnQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 p8-20020a258188000000b0069ca52d9f68so1473016ybk.2
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 23:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=X+teeE2+1M0MGvTqW9I7DvUySHuYMI4iwyRHOF74lic=;
 b=47NC80Mt5v5LmBxO/fPG1KkotMKzcu0AKd4nWyY2N8Axgq/PJDdzSdizP08tdNbl6G
 Ik97A58GVnWwEUisUyU0ek8TpG/GdnZhDLSIZsLMRhRNu0dBjNlCSEyvFtvIxC9CjP17
 a7Hd0LEiOSE2C9UEwtxv3Y7XyZ3aHZWr8xF5Kl/9hDqGOK4dV8o6mn1BIbeRXU8EaWZO
 orp7b9vdLD2CvfP+BOCGi0ohWJ4NI5imHwL1dHupcqzUMmce5FeD51odV9SBBErw7Ahs
 OhOqaU0uLerm3cU9w6jTYbARqwLmS6e/D6pXRp5SYFKeTu/XxCpCU+2M5zeTRlIWlc4C
 PwuA==
X-Gm-Message-State: ACgBeo0fnYCnCJrCe2LcRXjBxBItravURnid7Oq0pX9HvT/Qf5G4H+eA
 SpNVwIvmLoH/wCc00BNl/gprRxLy+Zfv6rQIrOaRRqrGtSxmahe+lVRSqdf28fBI7zKwlHyXsFE
 qvME9PmcX+9piovbuTCqT+JOXCus=
X-Received: by 2002:a25:e047:0:b0:695:8f0e:4c91 with SMTP id
 x68-20020a25e047000000b006958f0e4c91mr13795502ybg.301.1661926697642; 
 Tue, 30 Aug 2022 23:18:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Oq/yKd/IfM9QxCJyd9PMB5CeA+QP0j/z1Y/5DGRYicvuybC/UZSTqCIeKqr1ZlepnVn6xIHvJ5Hz3a3t1KJI=
X-Received: by 2002:a25:e047:0:b0:695:8f0e:4c91 with SMTP id
 x68-20020a25e047000000b006958f0e4c91mr13795489ybg.301.1661926697377; Tue, 30
 Aug 2022 23:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220826111202.1533-1-akumar@suse.de>
In-Reply-To: <20220826111202.1533-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2022 14:18:06 +0800
Message-ID: <CAEemH2dcZEKTe2FKJQWtnb9_ciQ-6PNCJNG4XVZFJMzc=UaFgg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getpagesize01: Rewrite using new LTP API
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
Content-Type: multipart/mixed; boundary="===============0005720812=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0005720812==
Content-Type: multipart/alternative; boundary="00000000000070bc2a05e7837656"

--00000000000070bc2a05e7837656
Content-Type: text/plain; charset="UTF-8"

Patch applied, thanks!

-- 
Regards,
Li Wang

--00000000000070bc2a05e7837656
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Patch applied, thanks!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000070bc2a05e7837656--


--===============0005720812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0005720812==--

