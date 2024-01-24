Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18306C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 09:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE4233CE1FB
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 10:31:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77B393C5D1E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 10:31:28 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB8EF61763B
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 10:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706088686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TvPIJDXsfxNNyDOZ7byoY+blagq7hp96Tn3FBgC1iI=;
 b=fBeIEtAPTDJQ+O099gLg7eyA68SU/tqNRqiuJH/lFM9OM7h6k3N+/SPugPOViGl3KE2X5n
 zfqk40d22tgX5d00lsyEgJvINNA+YfmIuyMH6DeOU2mZwONyTRZHYZHpWCvRlruBr4lYeF
 HreB159bMgIia75IawlSB+7Hy+kVDLQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ljh07HnbNuWZykAsCTEuoA-1; Wed, 24 Jan 2024 04:31:24 -0500
X-MC-Unique: ljh07HnbNuWZykAsCTEuoA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da10578363so3357369b3a.3
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 01:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706088683; x=1706693483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TvPIJDXsfxNNyDOZ7byoY+blagq7hp96Tn3FBgC1iI=;
 b=cw2ZWKBWOxohQI96hHz10gvuHJ/nITi8mV3oPXHdeOBybtPDlphTb0sGzUz2uh+REL
 AFmo6yQQVcWD0Fq7gMxJvG4m3c07agrQemZ365LOb76hAxW2aVE0h2MNoMbtwk5Pq52Q
 8ePOatxuaKuo5qWe0sni8lPjjZyW6AKHZ+3eCN2TS2Prvc+wBH2nWBHSWsoeGlfubxn9
 7Lu+Et8kvfj6M/Jg7f8Djo8DtSqM+luI3qzo3RUPBmrq13Bw1woz197b/qUixWkP2D32
 2DMc+r6W98fzoWvxahzxZJ+zQ+8MsmXjyTksKff2ItipfAmb45Vl6qG0NB97uFotqbns
 I1NA==
X-Gm-Message-State: AOJu0Yy0IFTCUERGIBgE0GJNvbg0vfkSp3RWWn4jWPQwje+3jCDhRiwm
 DlbW5BhEX6WkzWuu90HwSgGTrCSQZpeokK/6hwDSV8Ix8LcNPVYMWSx0pJE8EKfJuF5pFJwGeiZ
 H3EcgvR5OME86lkbfYJdYvkYR10B/lxUKNdrwZTmlijbzXqRwAo8eB5jSTHvbQWHhjChgWx2zNH
 O5Ni1ABsJWeREso4xm7B0DqOQ=
X-Received: by 2002:a62:6103:0:b0:6d9:f44f:5ab3 with SMTP id
 v3-20020a626103000000b006d9f44f5ab3mr3785194pfb.37.1706088683304; 
 Wed, 24 Jan 2024 01:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmE05w5upudSrmmgo2STPo4Zi4qpwRU53IaydekWJAMfhYFod2Lc2Llpx8tzFomxU0swQoW557/DXCRPdcChQ=
X-Received: by 2002:a62:6103:0:b0:6d9:f44f:5ab3 with SMTP id
 v3-20020a626103000000b006d9f44f5ab3mr3785179pfb.37.1706088682921; Wed, 24 Jan
 2024 01:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20240123162647.210424-1-pvorel@suse.cz>
In-Reply-To: <20240123162647.210424-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jan 2024 17:31:11 +0800
Message-ID: <CAEemH2cyPj5o89xk3+mHu3mSH38CvJXWMjMkGxdkmBMXbaMDug@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/4] shell: fix regression since 1878502f6
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMjQsIDIwMjQgYXQgMTI6MjfigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIGFsbCwKPgo+IHZhcmlvdXMgdGVzdHMgZmFpbHMgc2luY2UgMTg3
ODUwMmY2Ogo+Cj4gVEJST0s6IHRzdF9icmsgY2FuIGJlIGNhbGxlZCBvbmx5IHdpdGggVEJST0sg
b3IgVENPTkYKPgo+IFRoaXMgc2hvdWxkIGJlIG1lcmdlZCBiZWZvcmUgdGhlIHJlbGVhc2UuCj4g
KG9yIHJldmVydCAxODc4NTAyZjYpLgoKClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
