Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA8FE5214
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777031882; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uNrKRWUUNQ8h/Tf3Sghb7NhtT4B+0QuSaP2tqquf+y0=;
 b=F3ZzIPsOL4ioWysZpV5X6izO2gaTK5qwz2RqkQu8xymiFa1Xal3w9DUzgRW2S1WJzNNvd
 bKfj8rPb6z9w4U6+I+mnXrvuZmANfGusUZ3VWYaTepuSlOFpJ4aOOuyEOunJmClH/F+hsOD
 gK23tkqUlPTDYXV7hvyLPRv7ZOvb1X4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153943E2584
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 13:58:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B4BF3E1B9D
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:57:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D791600ACD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:57:38 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso77362285e9.1
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777031858; x=1777636658; darn=lists.linux.it;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+gegLB7lENwlk3BLkjOsmJEMCA00HIRDtFt+9kdeQk=;
 b=Ol85mRxN+PqQb1t3ZdBqjKWQ/vCUIE3UaIXOUlb/enLj7EjTvirIWQZuk8IzDFMmpK
 euRz1pEZDdp8E93xXJLs3uHIHgpy9Bk+d5/Mfvg6nSaQXbt3LXSaCFg8ONhfpVbnFHv3
 p6abOQbal+VLq4XxDlqV25pojBSPv1Z79vDvAe6B39Lzefyi9+Ly0JAyyXFLUnTVCEZN
 GxHxDXX7Cd7jzSEfk+3zzT7kB7PHI8t5jKOyAEhT5TS6kdNQkTMWZbZR9Pe7IMlMDjqT
 hjlkqD+69x8zcCbKWH9eFUB0LmhWs7LcxYB9/fhHM2q2lrZflZ+LrByERsFIPyPlu6gX
 DXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777031858; x=1777636658;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m+gegLB7lENwlk3BLkjOsmJEMCA00HIRDtFt+9kdeQk=;
 b=SSqknl5brBjTQIFHxqpdOI9hRV2CJJvZsYrfPn4+rG0/WndcB2+CnmLS4cc8suH+fT
 d1iQjyccnGGWfc3yIEFvz1pH+cM0+Wf9ucJSkGlLQRMFTDcpnEHECt2NBjTF5wum8EMB
 UvkqxpZ5wjBojD8p8WeBQi5TUgAw4jB+5kFzkbM+S9Jt3ylWIOtsYtC8OtIYBXOzaNp4
 /uQGv8FwuKt29APe2XN1IMi6tBZ7fGjmkG67EeECX26EDjPLYHUZFHKVBzuOGiDeODCe
 +89PRYCTnr8pn8OFYF7mF7aj8VHO6jKsy+HACk1Gs4bJE/zUxMgcChULqcNNq4r+Mlyo
 HLlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TfkvQdmnGxlQBL/v5ZPfoCxaC1QjVVItF4zj+OMc2CJQ9F6NOFMcu78EsHIGN3Einiug=@lists.linux.it
X-Gm-Message-State: AOJu0YyVvxnwj5NMCDLIOM83Hc3s1LpryW2gZ+k9vWAxZa/gGyXVPThP
 aRslOJyoqp9Aof4Su5expyIr4nlkeHr5/9vnvH3c2rFwuZtZBTx5EW0KSq5QmnQJGT0=
X-Gm-Gg: AeBDievurPU+QohVoR2YmXqm+flRUuRwxXIhEel7MsBtQiQdPEbSbKr8TXx8onzv6QG
 kyuoMCyqKnWIkcqTFWNhiNQeTguexl20HtgurkwpFI4LikP+ytbeMViOuE+0aT/JLwYS133HDHn
 +H3KYTyGROFEkIKRWFYQVnHwqSQMDDlkZ+d/L8RYKpmIGlUG+LKBXPffa1N/+LXexFOolz8OgXg
 iLf3hp9+se2na8alRkVgWcXsTDysVsIxPiJzniDs/10/WgTrpx6H9NQ+PxK+W4i1WpxwEp5gDha
 uT4Si2ESHbD2GdTJdMQDwnXmY8SH+zGSRB/u9WMMnqBQh7cV4TmKIQo5P1Bg7varZcXx+n9NtjB
 +gLWNWs533ZPywLDKETFhKIrKT2F7JVYoHgWde2c5P2KSvrttYqQEB6cnJpKJjpl498DDhDcnQX
 AYCKmtRliJkP5LECD5kd0REFs=
X-Received: by 2002:a05:600c:2288:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-488fb881ee2mr299806365e9.1.1777031857597; 
 Fri, 24 Apr 2026 04:57:37 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c831d5b29sm34211790c88.8.2026.04.24.04.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 04:57:36 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 24 Apr 2026 08:57:33 -0300
Message-Id: <DI1D7VK7616J.RBUN51CEDKHM@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260424093919.500059-1-pvorel@suse.cz>
In-Reply-To: <20260424093919.500059-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] checkpatch: Add .checkpatch.conf
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpIEFwciAyNCwgMjAyNiBhdCA2OjM5IEFNIC0wMywgUGV0ciBWb3JlbCB3cm90ZToKPiBF
bmhhbmNlbWVudCB0byByZWR1Y2UgZHVwbGljaXR5ICsgYWRkIG1vcmUgY2hlY2tzLgo+Cj4gUGV0
ciBWb3JlbCAoNCk6Cj4gICBVcGRhdGUgc3BlbGxpbmdzIHRvIG5leHQtMjAyNjA0MjMKPiAgIGNo
ZWNrcGF0Y2g6IFVwZGF0ZSB0byB1c2UgbmV3IGZlYXR1cmVzCj4gICBBZGQgLmNoZWNrcGF0Y2gu
Y29uZiBmb3IgY2hlY2twYXRjaC5wbAo+ICAgY2hlY2twYXRjaDogRW5hYmxlIG1vcmUgY2hlY2tz
LCBkaXNhYmxlIEVOT1NZUwo+Cj4gIC5iNC1jb25maWcgICAgICAgICAgICAgfCAgIDUgKy0KPiAg
LmNoZWNrcGF0Y2guY29uZiAgICAgICB8ICAxOSArKysKPiAgLmdpdGlnbm9yZSAgICAgICAgICAg
ICB8ICAgMyArCj4gIGluY2x1ZGUvbWsvZW52X3Bvc3QubWsgfCAgIDIgKy0KPiAgc2NyaXB0cy9j
aGVja3BhdGNoLnBsICB8IDEzMyArKysrKysrKysrKysrKy0tLQo+ICBzY3JpcHRzL3NwZWxsaW5n
LnR4dCAgIHwgMzMxICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4g
IDYgZmlsZXMgY2hhbmdlZCwgMzAzIGluc2VydGlvbnMoKyksIDE5MCBkZWxldGlvbnMoLSkKPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IC5jaGVja3BhdGNoLmNvbmYKCk5pY2UgaW1wcm92ZW1lbnQsIHRo
YW5rcyEKClJldmlld2VkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
