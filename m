Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA2C021BB
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423215; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=zdaV3VoBBAY93bFk1DvBbiH0uM15P4ZyvE5OsUzJfWw=;
 b=X8xNKEcO697KHMr+TqkjRRTKaGjgSxiDn+JUbDtd+c3mTRfdMuwpo9sQo4JNzdn1qfedI
 YUgxZg3oVKHEC7xRADgYnK93HyWu0K6BP9sIBlrEB7GRLBjeviGOTTaC09fjVES+N2gcY0o
 NTyqwGt5C0KspzYkza/IG3K+FYSEHCQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0B7A3C9A47
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:53:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C6E73C9911
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:11 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA3FF141CA15
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:10 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso733934766b.0
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423190; x=1741027990; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nohMdolp+cEV7zBIA/QjX3DwiYHum8ypjFfXTf/sJFA=;
 b=U3LEpMQADgOOp0HAgTKu6M5y56RpQOMCNGdtQwpto9oo42DMwjOG7UYXs0UAClkKxH
 qk//isojuY3RTki0PEJq6E7HP/Y2+jl9Y3jao7jWIN79ICUM98nWlPbzClBgIlriFhR0
 Q/3ZCYxe2rfp8viEi6JUJcDG8YGNobldl60d1maBTfIHMNbsB5uZybyinSTRiHtruCzE
 m7bBOCvvosAu9d8TPPSvBXb+7RlBgP40/YED6t885z8pKw+KkqHxXl15QPoDP1iEUxLv
 GTDDRQ55WMvoXM7uwMc1oXSk6rKQKquYWfk70xcz0RNS115hkLemcsIHeDakKJGk912v
 JXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423190; x=1741027990;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nohMdolp+cEV7zBIA/QjX3DwiYHum8ypjFfXTf/sJFA=;
 b=bccUBADI5RApB/Vy6hTlx+eqe6wSMJYiffmr95wgcvDUy1Vatv0mWUzLa7EACmK/Bp
 97LVOiO3JE6cp+IjlLX0jXpsmjLnMizA2GBzcJXtDfBXADtcQts0L9cWZybyjJW0S3dV
 dLH0U+D5wA/Gv5gsXCj+YFuY5Se+jfbw5nBKcicCOEuyxBriX0A1J7YKxFLB26TxNqfL
 AiP668G6VzoEEGH2EuYB3+J67GGbNn4XCxmNPGk02QQh5i5qYYUvOkYLZVZoNt0+0Cro
 VMeRN5PgQgLF6e8xFXuGX6TswF9Tefyj8iW1+8Qxe/7NK8lBKNGa3XVnlfpuAO4VO7KH
 jhKg==
X-Gm-Message-State: AOJu0Yx1wopRyB4gK4MNOioaMTbZmmk+AvxP2oO7rECa32qKrSIBPED6
 RQ+CAKZfVl/Rbj/ZoDaeTCCH8cSF2tQqOEHaRKho4qo7BhV++r2kUqJd3ghivTA=
X-Gm-Gg: ASbGncupC877SnhTI5QakE9yCy5MLgcyzijB85Xc0gkeDrjccpVabaNyPMg4BgRDU68
 dGhbXhBc71WBJ7MOR7xvvWKZGaPqKL5pd0HeeMsrtRZEkAOxjd918jF8BRjEbRsa7GQSC4kA/H0
 8cz0GWWY74NU1oEK4wY7YNF9u88jZ9QYR32QdPr8aF/UyRinwEB32GFAXu+v8zIRmL/BmMyGmrm
 JGvoa7MG6G9hoCuMjgWk8Vfu7mHqAkXr8bS8Ma4QL9fL9j+pTtMckJN1dLriaCqPuXp6eKt15La
 +1JRAiYnlbItREw=
X-Google-Smtp-Source: AGHT+IFoslOK6LhAmdbDeOVLNZAkFUGGyKlbNnciOxE22qLCHSgFC74ZEcT81XBOm/Toy29zApTpzw==
X-Received: by 2002:a17:906:32c4:b0:ab6:cdc2:bf57 with SMTP id
 a640c23a62f3a-abc099eb5cfmr1318053966b.1.1740423190077; 
 Mon, 24 Feb 2025 10:53:10 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-adb57c5dca1sm19543088a12.5.2025.02.24.10.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:09 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:01 -0300
Message-Id: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA3AvGcC/32NzQ6DIBAGX8VwLgbwD3vyPRoPgGslqWgWS9oY3
 73gqYemx9nMzrcTD2jBk2u2E4RgvV1chOKSETMpdwdqh8hEMFExwRtqFhcAk+bpqp4eaKnbodR
 QjLKpSfxbEUb7Opu3PrJWUdKonJlSaVZ+A0ziZP224PvcDjzp/2YCp4xqkBpKbjSvym5W+LCAk
 DvYSFoK4jsif0VEjEjTiLZmI3AwnY/n3Cwz6Y/j+ADNqLGwDwEAAA==
X-Change-ID: 20250217-conversions-pause-4b9d4be3f876
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=rbm@suse.com;
 h=from:subject:message-id; bh=UmEO4ZRLMfjhTmErVjBR6acNXW/QbvrReh2BtJ3OHmc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMAR3aKXqTM8ZCxDMsoCugmiv69OOzaadQJew
 rCXJfcaLD2JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEQAKCRDJC4p8Y4ZY
 pmmXD/9N60otqNUuIehDFaM/y4f2+g9Rrm95ESI2guWiX53IjkBk9ikjztD6YwFXr8T+wep5F/0
 zpIE8+B27LTroMUmsvvluWJNI0HlIx29/IvfkEc7zW7fnZimneR7zMK5sMlO3QG07/pF6H1w1zz
 U9USPOeXUMdaIUDwthlKzY8bAFv9jkB1shw5/r/o24uHhAP4A8aDyxdWBp/WjLq9RJl/Etek7jU
 rKMe+SV6JrPRYtldZY8BMlepeFaCEu6fbz/IczujOswksCppp+fgNXRUg1NUfr7iGXUIVYJVFd/
 vkGOqeR9Vejh4AgA9ziWt4oxvltvF2mH2g1cvFL5vror0eBH18w5bRjpMTlYJHyY2iQ7GgKKzYw
 eTlxEaW/1Tmn2rEh6hfTBXFMsoNhzNj7XpkjVeyipiZDFaJfBmVpk8FF29eUSqdUuNZMAEAQU5d
 V4zLxAnzpRtSEH95c5rW5kg+SqKTRLu+n1t4xB96yH2SR3EBcI2rR02gVmDgihAxtF+Qn+CdBX1
 KvzXoDOCTI+1laxToEl+N5bQJQAbLX0/iKpf6DcES7rEde0tR0OwwCR83ZfC2qBHiXAIeIRA8ji
 dXlhLc7W7bOBjjUFQXaQ1pgmCzVgS9SVC0k7BVf9/iWhQ8QdVqIWQVhGTYHm3eeB4ra2twQCNKm
 7gNnEInYFZm/Eag==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/5] syscalls/pause: Refactor tests
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
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJpY2FyZG9AbWFybGllcmUubmV0
PgotLS0KQ2hhbmdlcyBpbiB2MyAoc3VnZ2VzdGlvbnMgYnkgQ3lyaWwpOgotIFJlbW92ZWQgcGF1
c2UwMi4KLSBFeHRlbmRlZCBwYXVzZTAxIHRvIGNvdmVyIG90aGVyIHNpZ25hbHMuCi0gRml4ZWQg
dGhlIGNoZWNrcG9pbnRzIHVzYWdlLgotIFVzZWQgdHN0X3N0cnN0YXR1cyBpbiBwYXVzZTAzLgot
IFJlbmFtZWQgcGF1c2UwMyB0byBwYXVzZTAyLgotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTAyMTgtY29udmVyc2lvbnMtcGF1c2UtdjItMC04YzcyOTYwZmUxZWNA
c3VzZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gQWRkZWQgYSBjbGVhbnVwIGNvbW1pdCBmb3IgcGF1
c2UwMQotIE1hZGUgdXNlIG9mIExUUF9BVFRSSUJVVEVfVU5VU0VELCBUU1RfRVhQX0ZBSUwsIFRT
VF9FWFBfRVhQUiwgU0FGRV9LSUxMCiAgYXMgc3VnZ2VzdGVkIGJ5IEFuZHJlYS4KLSBGaXhlZCB0
ZXN0IGRlc2NyaXB0aW9ucwotIEFkZGVkIDIwMjUgY29weXJpZ2h0Ci0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDIxNy1jb252ZXJzaW9ucy1wYXVzZS12MS0wLWJl
OGJlNDFjYjE1NEBtYXJsaWVyZS5uZXQKCi0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAoNSk6CiAg
ICAgIHN5c2NhbGxzL3BhdXNlMDE6IENsZWFuIHVwCiAgICAgIHN5c2NhbGxzL3BhdXNlMDE6IEV4
dGVuZCB0ZXN0IHRvIG90aGVyIHNpZ25hbHMKICAgICAgc3lzY2FsbHMvcGF1c2UwMjogRGVsZXRl
IGR1cGxpY2F0ZWQgdGVzdAogICAgICBzeXNjYWxscy9wYXVzZTAzOiBSZWZhY3RvciBpbnRvIG5l
dyBBUEkKICAgICAgc3lzY2FsbHMvcGF1c2UwMzogUmVuYW1lIHRvIHBhdXNlMDIKCiBydW50ZXN0
L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDEuYyB8ICA2NCArKysrKystLS0tLS0KIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMi5jIHwgMTU5ICsrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMg
fCAxMDQgLS0tLS0tLS0tLS0tLS0tLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCA2MyBpbnNlcnRpb25z
KCspLCAyNjUgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogYWY0ZGEzZTQzNmY4OTFkZjUw
MGM1NTJhMTM5NjkyNWFjZjIwNDQ1NwpjaGFuZ2UtaWQ6IDIwMjUwMjE3LWNvbnZlcnNpb25zLXBh
dXNlLTRiOWQ0YmUzZjg3NgoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUg
PHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
