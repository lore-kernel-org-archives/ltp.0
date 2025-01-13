Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B079AE7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 10:23:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2C83C777E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 11:23:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2063C2ECE
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 11:23:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF80A1BD8F7D
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 11:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736763788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thUOS+JuD26kNN0vTFkYPjg/cSHtzTBS0+HInaYmADE=;
 b=Rbz70ga4O4/jdfMdQFbsVCesU5KrGiewgbnz82KQ+Dp+qj7iqoLxt2Fb7Q0F9jfPDc+Cm3
 mqz9avBB8lD6dcy3DCBU6ku2d3Tk1Bgjb6mndzHDxyyzRZuBpnNWeK2u2jKWspDotmMwyG
 ZdINfjjhq+t5FFg3+WO0dBNj0F8+zTI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-eIKtYDMAPH6HbelpVA0TTg-1; Mon, 13 Jan 2025 05:23:06 -0500
X-MC-Unique: eIKtYDMAPH6HbelpVA0TTg-1
X-Mimecast-MFC-AGG-ID: eIKtYDMAPH6HbelpVA0TTg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2efa0eb9cfeso7311401a91.0
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 02:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736763785; x=1737368585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thUOS+JuD26kNN0vTFkYPjg/cSHtzTBS0+HInaYmADE=;
 b=e5yeNhuVLERf9ytP1uvHNVURuhrAPT3YU7UEpCIbXDYUOunxACLEr0BE317SFz7LoG
 LgUduz5Fg/6Q9qoWgckkWUXMFlYxYbjzyD2rPEgZmNFyE/Z1lMzgU07AC6Zm8wVEg5k7
 94lcb7uOPT2gBvDl9reba9uEV7N3JqKR1fur8BxD0/sTXQy/f85hDZDtw37ABrt9LwO3
 SiIg7R/+oVOXxLQR/yiTlPW/TYu1SSZy+J+J20dhu/v08gk7zQUQ4UBRPZuANLoPzUwM
 ntuEHDeqQn0LKZpXP9hbdkqNI5vJ1+9D3/hM3Mzly7jq3vosTenuBxHGMGGv/1fSTqc1
 0zIw==
X-Gm-Message-State: AOJu0YxDznbFPaJbNnQGore1MvlDgnLJCXKQc3nvjs5np3Sjzii86ceP
 isFxUPzMvXieE8dy9nzzbi0W4NWVCLE6EL35Lz3CUo1/Q6o2SkChuASZHr6iuhZXbRGWmVErLAk
 hCJTe4Os/+3jQQquU6BQ9+XTUh6vT4XgRrNgHrFg5rRdcMT173jNITbjlEcP2L5hgqRNr1/K14u
 T7QEooQIGGk3rRZTGd9RMX/QM=
X-Gm-Gg: ASbGnctQi6gvSZx62YY9q9Yc21EmJGSezm7pSjs4t1uUcY7ksI3SiAeQWw/PFKEsIKb
 SyDHU0BWX0BqJPPTgwdPNLor/z/MZhRlJ/Q6pGaM=
X-Received: by 2002:a17:90b:2d0d:b0:2f2:e905:d5ff with SMTP id
 98e67ed59e1d1-2f55833cee6mr22585822a91.6.1736763785383; 
 Mon, 13 Jan 2025 02:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH86Dm4kX6XoWFqMQUYKoHcAm6xSTm+NEb8MNdn6LiBd9QNczEjb7xmFi4LY3N1cA+Mf8HXh8d2clsebal2zik=
X-Received: by 2002:a17:90b:2d0d:b0:2f2:e905:d5ff with SMTP id
 98e67ed59e1d1-2f55833cee6mr22585801a91.6.1736763785082; Mon, 13 Jan 2025
 02:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20250109130032.50480-1-liwang@redhat.com>
 <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
 <20250110171304.GB413134@pevik> <20250110172306.GA429264@pevik>
In-Reply-To: <20250110172306.GA429264@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Jan 2025 18:22:53 +0800
X-Gm-Features: AbW1kvblfBo_jYmbgOPy3AK2rfc8KQb6jnN0MbpWT1_tOKHRVHro57Q2jyJhpAY
Message-ID: <CAEemH2dmB6MXF+8fG1WiP8s7tsHq3c-1Y=4C595SudFo+_qPYQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DqSz1zqjjqIo-Ar_7Lxn6y8_MGUYWMiSObjzYCMlUsI_1736763785
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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

T24gU2F0LCBKYW4gMTEsIDIwMjUgYXQgMToyM+KAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gSSBhbHNvIGRpZCBzb21lIHRlc3RzIG9u
IGN2ZSBhbmQgc3lzY2FsbHMuIFNvIGZhciBsb29rcyBnb29kLAo+IHRlc3RpbmcgYWxzbyBuZXQu
bmZzICsgYWlvZGlvLgo+CgpUaGFua3MsIHBhdGNoIG1lcmdlZCB3aXRoIHlvdXIgYm90aCBzdWdn
ZXN0aW9ucy4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
