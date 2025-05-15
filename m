Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0261AC2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747300376; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Bym+CgbQOvvZM1lQwiyrbH2Wr3fBotP/xG6sErGSwmM=;
 b=MWeL7Ig/EIS+SIUDceeLnkQWwKxsyOdQxgre3+KVoI77bfqBT94XyYZonxktxAdDYMQER
 gSS4aO8Ho7CDRiDSbPlF5KITZWjIcfIEkGGIjUQNpgMFHdOK4eV6paeLNj0/QYwQZsiXmoQ
 gz4J7Ah3YPFTic9AfXbTioMqqA0+cxg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 995EC3CC495
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:12:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09DD73CC438
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15B7410009E2
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:49 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so326613f8f.2
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747300308; x=1747905108; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1s+BS7OT9bxBdBoCc6GH1XjA1HvOiwP+5mgaUUsWH3A=;
 b=KjGu+l/gU/Qr12UZNrHpCEFdw2s2NpHAUkui2p8tktdWZpuf78VWJGGZBG377lVeDR
 5Bvv+AiopG0MzyTmgXWrPhPMVyfxY35XIX7325/99PxEdJpRlMuM5jERvRBX3AX4bwfx
 yW088hZHctkL6cff3UAhvt5hAyV++tKbWWI/fQA8rPZB0l6RnSeUfSU++uEdsYiD1lvr
 zvBRYeLoOSiO36W0zGcYkPfDcpAxLqOroB27rXix2/T9DGHG/UFfdiu8qY5+6VK9qqpb
 NBjXB0CfBF0q2X4GiH+PY0u8UrcoQ/2IjwdGY0+tXo+Mga7O+2Ad1ZOhddRzK7aVVg+E
 ngsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747300308; x=1747905108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1s+BS7OT9bxBdBoCc6GH1XjA1HvOiwP+5mgaUUsWH3A=;
 b=Ii9hVORsMH+wfzrCSqYAs+H8Yr6/xd3WPvqgHlWSrt0+KD8eSUGqyu2BoOP1IKx3uW
 q2586QzCar/L8/v1hxvROS/Ij48uYF74gfgosx+YOHoS9BFh9caer/mjytFQoGJqhoJF
 Bx5M4RFV13Sx0BzsTQtlhczsbhor4oY4pzZdUjtB3SO94xY5er3E/Itas1AUiglgO/dt
 FJE9UawZRKrWCm2pooPe97fkiVrS4obytw0Ekfkh1PK3HLAMEUr7P/Tp3iRhHALronbb
 lA5ivliCaKBqpMNiMaqThy1UQpBvtlDZw/EcbdsrVzCWjnTYpSlIlPHFCc79gVRZ0pE1
 YcQA==
X-Gm-Message-State: AOJu0YxQA9FsFKn3R9NUl+j9VpPloIhn1OLKFPlJEbnLCwaFpI/SD85X
 jcZVht6590d0GNUmArUnY76XIpZebtTr7s4RD1Q8T7MsLT+gVBADl8f70XgcM18=
X-Gm-Gg: ASbGnctESMQ/ymkjgyS/lAWg+7ydaGeaV+BPTykgn2WebZLgCMzQmdi45DfNa+0HPw/
 TezNaLb/s5yMh4iX2vmXcE+3v8+rguAatANfznPLR67T7gfyu40dwbX11PFoOa4/WgSfYQ/qQ89
 HXJzEOBQh7rz8/FRcrLR2fhRSbO+pql0NKgSuhG14i1T6vq+NbUY/R/PDav+AM5AvB8mOF2qP2E
 GYl6a4M0wRZu825OEUSt8PeQcnisr349HNThfXAaOVuhAxI1BysQziOX+FNBCErcjf+ATDs99xU
 MUhU5T8zjUTVBqIbcumBsu351k19YYCbXKY3Ih0=
X-Google-Smtp-Source: AGHT+IGs/z7E70DRBATKzE2KZ9pApux/GAWyb4RafkZj3ouLrjWCQctNZCmrTlYG6eZYKQ0qGzqXGg==
X-Received: by 2002:a05:6000:18a7:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-3a3537487bdmr1399725f8f.32.1747300308486; 
 Thu, 15 May 2025 02:11:48 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52db6e69b37sm55817e0c.39.2025.05.15.02.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 02:11:48 -0700 (PDT)
Date: Thu, 15 May 2025 06:11:36 -0300
MIME-Version: 1.0
Message-Id: <20250515-conversions-kill-v2-2-431063e90b4f@suse.com>
References: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
In-Reply-To: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=rbm@suse.com;
 h=from:subject:message-id; bh=EYIxTbfP2UCPZtnEMNFdXjrOFa77AOgGxmDJ3xlhQZ8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJa/KT7gNsdt7pqaX8Asw8p4DoLucFBHXCzlR4
 pkRQkSxlE2JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCWvygAKCRDJC4p8Y4ZY
 pj3KD/426hQovNOj4A/g2L7gfm6XTsL1t/x4WMFy0Yi1kKpR/qELHEp50aj9aqy1rkkLqAgciSB
 nKGDtnjHm337UHUvsYa1SwGTuBfNHPBk9FotO39PB14BIguM0a7jGgqQ3XJiUf0TBlL2+71bxxD
 vMw0T8Zoya0z3mOlYDcmDTwjjOZ0ymyiijoz1Z9Y1grjIjhXGMqPd6aEIL7BIYfgGJTZ86CG4SP
 d9QZA5noopgLMZMAZzG9KkjLhwzHOQoXF1gih71WCJbSMDsXYLBInj2nHmi8Xzl7riyPM8h0Ltn
 MvwTAiKJsQOvg/iwwvfMSq9i/0aEvFTqSiSM3K+z2Xn+YsaDBwtP5lBDVzjpw8NsHnCLUcRutnC
 bxnkV8r8wxFBCknDSzXzb+0Ij+ltwD6r1OVgn4o7t+Bxb+2jCbTDbssGjLWH8m2c4bz62b/n0Ip
 R7FQIH+lRaduWWOWqHB6XBK1yUAfUR21c6lL5PB/FmzgymILAMi5dj7YPPHIXs2sL+X8HKiPplf
 NXxKrY4gtU+u1HDE7wY251c3QgwVpb4sodST+90ENHsXINs6DrEPdPw4GGXynMPfg1ttIM7Qr5v
 aa/3bUuR5MVGLcC04UQGViD2obTcdmnrXY9lVcYHOKiExH46GdFiZPB2n5krc1BmvBUK3KDVsmL
 wN7kd2H87/6svAg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] syscalls/kill05: Fix test description metadata
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwv
a2lsbDA1LmMgfCA5ICsrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tp
bGwva2lsbDA1LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA1LmMKaW5k
ZXggOGVjNzFiZTQ5YWJjYmIwNzJiODc0NGI1ZGVlMjlkYTk1NDI4YTY0Yi4uM2MzMTdlMmZjYjA4
YzY0NTMxYjU5N2JlMzdmMzlmMmY4YWIzZDQxNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9raWxsL2tpbGwwNS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
a2lsbC9raWxsMDUuYwpAQCAtMiw4ICsyLDYgQEAKIC8qCiAgKiBDb3B5cmlnaHQgKGMpIEludGVy
bmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAxCiAgKgotICogVGVzdCBjYXNl
IHRvIGNoZWNrIHRoYXQga2lsbCgpIGZhaWxzIHdoZW4gcGFzc2VkIGEgcGlkIG93bmVkIGJ5IGFu
b3RoZXIgdXNlci4KLSAqCiAgKiBISVNUT1JZCiAgKgkwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBC
b3llcgogICoKQEAgLTEyLDkgKzEwLDEwIEBACiAgKiAgICAgICAgc2VnZmF1bHQgaW4gY2FzZSBv
ZiBlcnJvciB3aXRoIHRoaXMgc3lzY2FsbCkuCiAgKiAgICAgIC0gRml4IGRlbGV0aW9uIG9mIElQ
QyBtZW1vcnkgc2VnbWVudC4gU2VnbWVudCB3YXMgbm90IGNvcnJlY3RseQogICogICAgICAgIGRl
bGV0ZWQgZHVlIHRvIHRoZSBjaGFuZ2Ugb2YgdWlkIGR1cmluZyB0aGUgdGVzdC4KLSAqCi0gKiBS
RVNUUklDVElPTlMKLSAqCVRoaXMgdGVzdCBtdXN0IGJlIHJ1biBhcyByb290LgorICovCisKKy8q
XAorICogVGVzdCBjYXNlIHRvIGNoZWNrIHRoYXQga2lsbCgpIGZhaWxzIHdoZW4gcGFzc2VkIGEg
cGlkIG93bmVkIGJ5IGFub3RoZXIgdXNlci4KICAqLwogCiAjaW5jbHVkZSA8c3lzL3dhaXQuaD4K
Ci0tIAoyLjQ5LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
