Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BCAFF8850
	for <ltp@archiver.kernel.org>; Sun, 26 Apr 2026 05:42:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 476A23E1CF9
	for <ltp@archiver.kernel.org>; Sun, 26 Apr 2026 07:42:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5C923E196B
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 07:42:17 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CD571400450
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 07:42:17 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8e8c0c2d2bcso505619885a.1
 for <ltp@lists.linux.it>; Sat, 25 Apr 2026 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777182136; x=1777786936; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KY5CiHWRURA5VeIprY7xlKAZeRrxpQZ8Z5dgvqo9Ik=;
 b=ErYubdZ8ZUeOxryXudDRTvmvxiO7PMn5/P+4NDEn1ATmW1A/V+N258wk1cQtcbWz68
 bhba/EuBGQ18HkXk4uQR006+UeXLKP1aVqGumDGWnFq23qtH6TKvhTtRfFNykHUEUssG
 gk8T/cPXpq6PxkfSvMhv8uGbXew68n6m/C1Hoq9mtXSCdENQF3TRwn4LeouZW4Ub6iSd
 Z34UiHXaieHzMvtEdmy+afADiOCCczDUMa+HtfkZaDx7Yog04X+z6wPh33341wCnBqI7
 p1hgR0KqmHhQqwiEu/5P/zGYzTxiZOtEXZqjTy2oiCbFzN/rtt0S5dpQ2zpcPtO/08A1
 l2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777182136; x=1777786936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KY5CiHWRURA5VeIprY7xlKAZeRrxpQZ8Z5dgvqo9Ik=;
 b=lj+Gtl6Veco34zUOHsVj9cFNJkW8r4zPLkWfCxCyS2itmlBL+ZsSTWhJA0CqUrEGeT
 kQp/snJpOCRGiPQH1KFih4tcn0BCAavWr1tWEmqhfQKpnkJ3JTkLQqAMQUR9OylXvtCm
 7ANwS+dtqyFAb8YCSdZLex/xfkgfoIAOzzUus4JhEdCOAoZ8FQSyRgTJR8NdlQdO7u2B
 OWEERoN6u2GnO1DQWfJy6RXTkKqiuS9I+ZGs/k1qvl7g+TS5gs2SnyQ+enLCkoZ+OjF8
 4hsV5mJ8sZaRyr3lubeb4lXY4wanJEK0tpDTJrr8NmcmXSM8YGG8XjKVNBPrkJw+KIpA
 1J8w==
X-Gm-Message-State: AOJu0YwnzqZ+6dG3hKIxeY9p623iGxyPhLs8eGkkFdRatOboW6A5vDqB
 kxoX6BGm494v5wTAIeyTBNpVgBmi9cxDZPQP3FTOm3/glNC/larePD+H
X-Gm-Gg: AeBDiev9XIjkn3v+Hj8+/Xsfs8HANehZXZTKisQlvhuzGTb7LclgU09FkkA16ZiebUZ
 j4pLT9mrV4Cf7t4hPfnYL1RcCXL+9QH+0lcVkeniMobXtjGNmjozj3KKeru+Vum0JuWc0QKLY3l
 hDrh5dXGzKI8K9NTlDmjXMakHCRK27rwy8KRxuokVtwiSxrb72zUVUojM4aw6y9SzpYB2qJiYUx
 G0Tnxmd8msoQVqQbZThaFrgXRX42rnUC+5pr7WQGyX7EMvpl9FvDOfhsXua8QJWkFIZoujxOlHz
 SXH+vfNNiKBSWmffeXVUEPkBW+qwCC7hr7g4aO7cSNHrEqagfTC1vNHBFkgq1GaGs5jq6dScETL
 8uxM+NH9QnBkH6JCnGM5JmRmnqlPe5yKWU0bwbzTiqrHwHpGt0Fssvb8MD2jnmTlV5SzAUoBhqM
 tFM09Eiyw7u0y9ScR8qC3ROP1eWvJCEVLWistdr7lqc0QdyNGrzXu5txZOEI7iB1wdGBt4tJkt1
 yfK8RrVvvUae8a/ZDJLSy61oX2o6Gn1IphAjaqCngCcE9AbZw==
X-Received: by 2002:a05:620a:459e:b0:8cd:b6b7:1e6c with SMTP id
 af79cd13be357-8e7916b1065mr5291590685a.35.1777182135993; 
 Sat, 25 Apr 2026 22:42:15 -0700 (PDT)
Received: from
 runnervmeorf1.1baynwzsqolufha0zuf3dtedeg.ex.internal.cloudapp.net
 ([52.237.143.49]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d64cce76sm2419161185a.14.2026.04.25.22.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 22:42:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Sun, 26 Apr 2026 05:42:14 +0000
Message-ID: <20260426054214.3882-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426035823.3634607-1-chihsheng@google.com>
References: <20260426035823.3634607-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/mmap09: Drop hardcoded /tmp path
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

SGkgRGFycmVuLAoKT24gU3VuLCAyNiBBcHIgMjAyNiwgRGFycmVuIENoYW5nIHdyb3RlOgo+IHN5
c2NhbGxzL21tYXAwOTogRHJvcCBoYXJkY29kZWQgL3RtcCBwYXRoCgo+IC0gICAgICAgZmQgPSBT
QUZFX09QRU4oIi90bXAvbW1hcHRlc3QiLCBPX1JEV1IgfCBPX0NSRUFULCAwNjY2KTsKPiArICAg
ICAgIGZkID0gU0FGRV9PUEVOKCJtbWFwdGVzdCIsIE9fUkRXUiB8IE9fQ1JFQVQsIDA2NjYpOwoK
Q29ycmVjdCBmaXgg4oCUIC5uZWVkc190bXBkaXIgPSAxIGFscmVhZHkgY2hkaXJzIGludG8gdGhl
IHRlbXAgZGlyZWN0b3J5LApzbyB0aGUgcmVsYXRpdmUgcGF0aCBpcyB0aGUgcmlnaHQgYXBwcm9h
Y2guCgpSZXZpZXdlZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWlAbm9yZXBseS5naXRodWIu
Y29tPgoKUHJlLWV4aXN0aW5nIGlzc3VlcyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2Rl
IChub3QgaW50cm9kdWNlZApieSB0aGlzIHBhdGNoKToKCi0gbW1hcDA5LmM6NTcg4oCUIGNsZWFu
dXAoKSBndWFyZHMgU0FGRV9DTE9TRSB3aXRoIGBpZiAoZmQpYCwgYnV0IGZkIGlzIGEKICBzdGF0
aWMgaW50IHRoYXQgZGVmYXVsdHMgdG8gMCAoc3RkaW4pLiBVc2UgYGlmIChmZCA+PSAwKWAgd2l0
aCBmZAogIGluaXRpYWxpemVkIHRvIC0xLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVk
IHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVj
ZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5l
LiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlz
IGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3
ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
