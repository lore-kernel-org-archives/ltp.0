Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55704C021A0
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 03:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A51DD3C9ABA
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 04:41:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059BC3C8F76
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 04:41:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26D90225B4D
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 04:41:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739504480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00FQ+Pctpv6M0d4LH6G0ukF9M7D7rKno3bFre67i+w8=;
 b=FvVIBMmYnBpTusSxPYJXyn63X6MEw8I8qI1+X5viqkwlK8th5seJQX+30Hb1VfgqWP1wE4
 hO3SiIrhpNV667mVrerHnGvviD6iaY3aZwGHF/mPApZ1MuBj15krbsCEnWbUBoPaz0Rcgq
 ZyV/pZ/n/q4xPrX8cZ35SKPujmNExdk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-Xb8v_pU2M-G6HwFvcgIXjg-1; Thu, 13 Feb 2025 22:41:17 -0500
X-MC-Unique: Xb8v_pU2M-G6HwFvcgIXjg-1
X-Mimecast-MFC-AGG-ID: Xb8v_pU2M-G6HwFvcgIXjg_1739504476
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-220e62c4fc2so14816975ad.3
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 19:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739504475; x=1740109275;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00FQ+Pctpv6M0d4LH6G0ukF9M7D7rKno3bFre67i+w8=;
 b=wgAENJLbvNw5vIEoo9bFtvSEJjoebrMRJVi0ce8FF3vORKh+22hjVjcLTAX4zUMlOX
 lbkZLlLy7UFNA1qMN+Wfn4kh5x09ACc+Zymyk/Y8UUkmDMwQp0+4kWCet4yYonlCLD67
 A2aIy5RJGefQ+7K1HmE4kcMB4Ihxoeo93xPk+QyqXJTU5oQL6238kWyDmt7vaHimRnSp
 qjYd0JTpWlIHaDfJf+DPm2iq0A1egMoJAKGSKAiPoiHoz3i7AasGH4zCGaz+Jp55HDGj
 enhVgmNCAxDC66hN3sHwIbigoQixTzP/68BUC6BbQRRvXBCCC3l2C7CYE1HLILq3TWXd
 3q9Q==
X-Gm-Message-State: AOJu0Yzm0IIdM7RYQNUm9oOh352l/HYGJPGT5ZLn/tkrh94UYiV2bUmr
 ff8OIAIpUcVDbUbmC/2LJnaEGR6u2JrEEI2X2kdXDgQQC2oyYE6hSZHagsLM7rbha0AugBRAjXM
 1Wo59Lg4/oAkVFr11lrAhDQWy40LCgECo1AoCPDU0aJpnIw1nl1L99C4csbL8AgB8agOWBqDwdE
 6Rojp3tOs2gbu4Wnzq27TYvn3c+iMDf/qB7w==
X-Gm-Gg: ASbGncssGTgHDzySETas2RlXIsI0dNXCyBZ+f1VOO62nBzyyOEh7lvz1fzOeXR4UwoU
 AJhpL2m1IfpwJFulNoBXFJoC+BIDqSUVko89tmsQz2RwJuP0wglnA0ZZcga3nAZg=
X-Received: by 2002:a17:902:ecd1:b0:220:d81a:bebf with SMTP id
 d9443c01a7336-220d81ac0e3mr62623825ad.0.1739504475023; 
 Thu, 13 Feb 2025 19:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxcNtF1AG+OHcMby9Am33efMLGL0xemW5iSlgYXclxlRBfGYnvNQ9likvmP7Hl/tRp8VlHlwKu5j8WcvB4it4=
X-Received: by 2002:a17:902:ecd1:b0:220:d81a:bebf with SMTP id
 d9443c01a7336-220d81ac0e3mr62623625ad.0.1739504474727; Thu, 13 Feb 2025
 19:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20250211032457.7396-1-liwang@redhat.com>
 <20250211172019.GA1906142@pevik>
 <Z6v0Z486y3h4IvKC@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <CAEemH2c6qa8BGOoqPyXn7J9fTXnbY8CK6N8=mW+a3qEp5P_pxg@mail.gmail.com>
In-Reply-To: <CAEemH2c6qa8BGOoqPyXn7J9fTXnbY8CK6N8=mW+a3qEp5P_pxg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Feb 2025 11:41:02 +0800
X-Gm-Features: AWEUYZnRNLuIc4Ef_7M8ZrELXXObsaZI3ycmcJvLHkJb8gJO9MFYwsAC7Podthk
Message-ID: <CAEemH2dHV=O=SCJVbZV84EV_gwNvC9O4S56btnOLgKkj9CVqoA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qTqvRzzC-xCMceksCDU95rb4GXjocmQs81ka_MsM_1Q_1739504476
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] statx07: Skip test if NFS server is never enabled
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed, thanks.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
