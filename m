Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8CDF43693
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 12:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E466D3E5947
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 14:02:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8A473E261D
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 14:02:12 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE9F8140005D
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 14:02:11 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c45281a06so775903c88.1
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 05:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776427330; x=1777032130; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlydvdmNi5w+OuQX3VCNydxqiT+skAWKi6QMomL7xLM=;
 b=Gt1Tk2kjJrozdIFKTchEOwczPoS2whRaxxtGR/Us4US0cKIYGI34PieM8Kg66ls9r8
 1VDZF55bcBtS8Vb0tjrkWoOzB1fioyZYnDRWlpRM51H1C32NZWGKVw9BCOOfs3KKtQdw
 tef46kZuq1JMKKv4d6ZTFKXaYNDfVZG0bfcAcsZ9dIGgRTIrN9fpH8UC8bopKCdtsCcW
 rf7Zcl8Xpa9UHVWy81Jrpaz3gNszy4z/Zo2z6rAgl1tI7/CtnJX/ahrHn+ga4dLwzD1h
 pID1XxF0Oi6YsQXtG2dT3907fA07NAurmgK/TmKubyfkjgn1fVV3XP85PGVwjGtXawxC
 uzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427330; x=1777032130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlydvdmNi5w+OuQX3VCNydxqiT+skAWKi6QMomL7xLM=;
 b=hboxc9sBJEt2XjFXaCjfdp3uDM/CvB8tPc2ZIqjkUEWB+sY257Nl8gHTYtANvlX7TQ
 cZO9S99AT5i4LwWS91R5U/MUGz8GYpxKhQdB2FLDaQ/LstJLXuplBss7L+bW3Eii5Qqs
 0NZZY2htR7nQNbW+JSF0wz57TjVeZVjVrjuvqJ5lvyyZLqyrGS4dCoiALLgd83f12qPm
 2ZxmxbwFPBE5dUw3Ppx3PAeGzs0e7UMJXwv65DTlLoMcUF+xxuJbm7fSg+mF2uPsEG6n
 mMfDOINJkLXzAdZrt6B6GdxNA7h+KkQVk/EoNSJ0W6fOtK6jR7qzHcSQ/4OrwJ4OQ4U3
 l1+Q==
X-Gm-Message-State: AOJu0YwwR8Sp++HammO1DFMOL9wXJCvaYgTDuL4dTCq0vLovc5QvE5g3
 ZrZysmNzFkQX/8XWtgwYnjYJd+qQRqnQZyXpkAhTj9hnhsM6C6FziOSJ
X-Gm-Gg: AeBDietd1T5nisDSfV3x+LAK0N5YKb+k3yElknJZnfWUzpQ+svvJ1i921KR6bBuG+dH
 ZShRsqIPMUPycDWLBLQz1ibSX6zeJx33bz0b5Tg25+4H07/0DtSerStSJiYzhp3sz7wMDZlg2RL
 QEfUaNCEwRP58zfeiCYzCQhbrkmoi1yDbS2yCvxIiwaK57XT6TezdQ6GYzBgmKNwN7aXSZT6/DB
 0y9e2dNSYGSA/iGYkdyTLdILVSRDiQOvorpJmzy67CuKm/HFSNqbnWSDvIsHk/PH4QVASWpNT2h
 4BCkbR4WFnBokXDmdDVdpb0JQLzNlRpKSxrIqHGaGco1W0zDuNsv6XkkrQ2jKmiLxPKcYsCHSHz
 nzBmSQw6tKPQZkHMSqbtSPGYFJeKddlxEPFaeg3q+gC9L9l7xhN/nd/tJvGZe2aTaAgiWS/Mx6d
 laV55KmBB9DUZdleXl2eMmW4GiWsM24EvSyH7fRuUta3jjuhD2f2eL5sP0MfU5FXr7s3bDRponT
 r6oHydNtsYXMXVbuTZaxVs6TGDRi5k0+icab1rOnDd3+zKyudVf
X-Received: by 2002:a05:7300:dc05:b0:2c0:bfe3:b95c with SMTP id
 5a478bee46e88-2e466044086mr991244eec.4.1776427329909; 
 Fri, 17 Apr 2026 05:02:09 -0700 (PDT)
Received: from
 runnervm35a4x.sriysyaqsrbelmpkiefzon32ue.phxx.internal.cloudapp.net
 ([20.169.76.181]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a64e5sm1793981eec.7.2026.04.17.05.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:02:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Apr 2026 12:02:07 +0000
Message-ID: <20260417120207.3845-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-infiniband_rdma-v1-1-9c1bd3e69d29@suse.com>
References: <20260325-infiniband_rdma-v1-1-9c1bd3e69d29@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add fallback rdma_user_cm.h definitions
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gV2VkLCAyNSBNYXIgMjAyNiwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToK
PiBsYXBpOiBBZGQgZmFsbGJhY2sgcmRtYV91c2VyX2NtLmggZGVmaW5pdGlvbnMKCj4gKyNpZmRl
ZiBIQVZFX1JETUFfUkRNQV9VU0VSX0NNX0gKPiArIyBpbmNsdWRlIDxyZG1hL3JkbWFfdXNlcl9j
bS5oPgo+ICsjZW5kaWYKPiArCj4gKyNpZm5kZWYgUkRNQV9VU0VSX0NNX0FCSV9WRVJTSU9OCgpD
b3JyZWN0IGxhcGkgcGF0dGVybiDigJQgY29uZmlndXJlIGNoZWNrICsgZmFsbGJhY2sgZ3VhcmQg
dW5kZXIKUkRNQV9VU0VSX0NNX0FCSV9WRVJTSU9OLgoKWy4uLl0KCj4gZGV2aWNlLWRyaXZlcnMv
cmRtYTogQWRkIHVjbWFfdWFmMDEgdGVzdAoKPiArCXdoaWxlICh0c3RfcmVtYWluaW5nX3J1bnRp
bWUoKSkKPiArCQlzbGVlcCgxKTsKClN0YW5kYXJkIHJ1bnRpbWUtbG9vcCBpZGlvbSwgbm90IHN5
bmNocm9uaXphdGlvbiDigJQgZmluZS4KClsuLi5dCgo+ICsJLnRhaW50X2NoZWNrID0gVFNUX1RB
SU5UX1cgfCBUU1RfVEFJTlRfRCwKPiArCS5uZWVkc19rY29uZmlncyA9IChjb25zdCBjaGFyICpb
XSkgewo+ICsJCSJDT05GSUdfSU5GSU5JQkFORCIsCj4gKwkJIkNPTkZJR19JTkZJTklCQU5EX1VT
RVJfQUNDRVNTIiwKPiArCQlOVUxMCj4gKwl9LAoKR29vZCB1c2Ugb2YgbmVlZHNfa2NvbmZpZ3Mg
dG8gc2tpcCBjbGVhbmx5IG9uIHN5c3RlbXMgd2l0aG91dCBSRE1BCnN1cHBvcnQuCgpSZXZpZXdl
ZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWlAbm9yZXBseS5naXRodWIuY29tPgoKLS0tCk5v
dGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFn
ZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4g
aXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2
aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMu
CgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
