Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668D3C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743112725; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Aku8Ve9cM2z6EBq9fh+iU/AvLi33U491AwUVaaily4M=;
 b=a00vfviAoFjkN6xBf9NVQf/PF9KfCK5xQUjJm58YgoQg15qbXSsDZMA1YWH6FQ/gCxVlG
 2hu6k5OeJDxbp6aXJdiTIGsMgp6r09uJrqtdZ2jO6iEq7WWcY6H/Ba0Sb1hFL7hU75O3ZUB
 Xpsq+/yw+kwFevl5gkvnre2NadAXQmg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC833CA17A
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:58:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C493CA159
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:53 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 722581001F25
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:53 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-394780e98easo880937f8f.1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743112613; x=1743717413; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JnhrmRebxYNHLC4RoupUF/4KuUGYhaC2zoXb2k/DOM0=;
 b=gFGQNEjQnuzj1l2+E9hKSRMdKSBcWI3lwPUIP6gu8M8XWo5pbOGBye7c0MUCKOGb72
 4beMBdkGop2IR7iP5KF71PCEb7BvZw1r2TZ8vgUPG5kie8GP8CR6A88lkMI/Ttcgk8DK
 3830wM+QMEewDBSThpz5bSvaTwVyHzrssNH1wT70O/Un1PIY6b68G+FHyMI3RLo5XqrV
 32kabxYju9m0Uqve+GZTppINKm5P18ePToL82zawZVbzmhbPfxE3di5GKo0qj05VARoa
 L5VfQGatLsa9396/pfAnfcVFnVf2Vco1hvhH1g081WjOeJ4QforQ2ppkI/NdaYMbE8xM
 YCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743112613; x=1743717413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnhrmRebxYNHLC4RoupUF/4KuUGYhaC2zoXb2k/DOM0=;
 b=tmCt0t9X08LWk1bfMEkg2QTvG+eRWohcCVHyQyblwXqKGtfntHF1+u34eAldonj+1D
 LjCi6AHIKsW7sETovaV1iWDo3tScGR3shwgVaW1HpBtyJZ7Y3dRzeVW5udjgT01Pm8Ul
 Mov/cRQRnIOxFn4r1xVyL0Ajg+uECVPzu53p8Usid0KPRrtRA3ojdaoOQz7jZeETeX1B
 p+3XGLkR5EK1ZjUBvC2P09PY3RPSssewZSjooTQ0Iqv4zW3g6AKbX+6oSKAWQWX57YWu
 W7KbrLMI80mPHC1S7MrwvJewqheZM2jaosTOrQ9xemiqSV6WJ6LpJyyLe3EJdaJb3OTa
 9hPQ==
X-Gm-Message-State: AOJu0YzkvK34ROEIxJ7V/3kgZQlEwcWwEVe6KTHZ73erx6KA2tDrJbT+
 jtHrnCLnGBL+8NebRsVH0xUGQFYTSsxmzZ2WsqcBKPS5lkqjfU4D9+D4s6bAAQOIbMWyMko8znD
 D
X-Gm-Gg: ASbGncuCw7HVZbsJBzHLjUDJypfu+nDQ1xH4jh2079RX7n5dPBRZT/Ap/on0FdfNaMn
 xGmkapD8vFFG9/P7cZHIQujucmdrQ1uFjVYMOePYIGr342+Yl9qjeBlOPqIuUQo0kAeLW0xYJ7G
 jHAN0soVV6Yv1qe/X06k/d4Mh4YRDcXjNMRD/zH51PleEGDetPEmYsL14ByE1k2E/4TNyvhtzew
 KCsRdEQ1zxjc3kwC+XJSfzfNSDe6YEBfZXEexT7/1C9rsddFaeFd/ab4K7YOJbdVX40cKv+YDmy
 u1oolGla0YbdbTsnhEt/GJVDeTeAznk3pBuso1SpKQS9
X-Google-Smtp-Source: AGHT+IFxFZtVDRbkZD5xKv0pn0LkDQgWbrV3og1FzSJt8x684jd9RR3vTDzcy2Tp8k7ClZPSgKJMDA==
X-Received: by 2002:a05:6000:2913:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-39ad17596e3mr4119549f8f.30.1743112612801; 
 Thu, 27 Mar 2025 14:56:52 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2291f1cf165sm4709135ad.158.2025.03.27.14.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:56:52 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:56:37 -0300
MIME-Version: 1.0
Message-Id: <20250327-fix_make_clean-v1-4-8b9ed2a8d96a@suse.com>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
In-Reply-To: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=rbm@suse.com;
 h=from:subject:message-id; bh=8WL3N8LwxMNEjejiJsWQawwAw73V5bkB0guaCllKPKQ=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5cmTHbww8ZukTMTnasZoL8l4wyKrN47fzrSG1
 2hXEtL1/ByJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+XJkwAKCRDJC4p8Y4ZY
 pkEMEACRIkhTnoovccMhFYp+faWa/iuwTDocj+O9eJfTCoP3bWT6h+Cy9+AtMhD0r0dxNtA3c2S
 N+1Mn9pjDElyYy5s77/fWbkYlWMcZR1B34Flrrk+JVh/lRb5rxPV//VE987bS0QuqbGhtjBE9mq
 X0rDVr7RE+62lUwTzxI58vpLGpPoLgtICuxZDjxbr9vN1tYl92NNOUnLuab0K35/Dyaxmgjxx2+
 8PaLPbGvwf6cqhRgVu94qkk/qrs/UMQEnEn022VUZXZ/TTvtNLj79M7drqyaOWvEu8gvlgCiuoc
 QPJGOIzgM1xGIQgDxDDUfRGJ2+gFor/uLtjeSykWPIizYp9QN+2HOEjiWdHBfsurUKyuZpWJhG/
 47eyYjp/JDXDCaFTWemm95h+4EpdQG8FVMZRjsrtrn+sePQ4K1UCHcdb+HdVVqIZKCuR54AhfQV
 JDsY23dFPqygHtqGQuSANbcnZ3/rEmkG5Lt4NnkdY9glgClsPFHVpj6gjOisupb13wodC/1H/Qq
 D67iYzUqcBMWgYN9NJ8CrKCF6EXFUNMiMOmLwnSzIP40mnbm0xemTk2Nm+ajFmLMgApn9qtJvDw
 pJ2poUAxOaECCUMeGGtRpVxB5tkppm+PMcSznahPMA9Z6/xPd1IqCRjPkvPzOpUV5gyKwhA97RP
 gaPjaIIXuKuiQNg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] configure: Add missing files for removal in
 ac-maintainer-clean target
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBhYy1tYWludGFp
bmVyLWNsZWFuIHRhcmdldCBzaG91bGQgYmUgcmVzcG9uc2libGUgdG8gcmVtb3ZlIGFsbApnZW5l
cmF0ZWQgZmlsZXMsIGluIHRoaXMgY2FzZSBmcm9tIGBtYWtlIGF1dG90b29sc2AuIEFkZCB0aGUg
cmVtYWluaW5nIHRvCnRoZSBsaXN0IGFuZCBhbHNvIG1ha2Ugc3VyZSBpdCBoYXBwZW5zIGJlZm9y
ZSBhbnkgY2FsbCB0byBvdGhlciB0YXJnZXRzIGluCm5lc3RlZCBNYWtlZmlsZXMsIHNvIGlmIHRo
ZXJlIGFyZSBhbnkgZXJyb3JzIGluIHRoZW0sIHRoZXkgaGFwcGVuIGxhc3RseS4KClNpZ25lZC1v
ZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogaW5jbHVkZS9t
ay9hdXRvbWFrZS5tayB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWsvYXV0b21ha2UubWsgYi9p
bmNsdWRlL21rL2F1dG9tYWtlLm1rCmluZGV4IGQ5NmRhODMxM2RjOGRjNGY0ZDZkNzI4ZGI3MmIw
Zjc0OWQyNjliZmUuLjQwZmFiMTI0MzcwZDdjOWE3MWZhNTAyZmY3NWUzOWNiMWQzMTE5N2YgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKKysrIGIvaW5jbHVkZS9tay9hdXRvbWFr
ZS5tawpAQCAtNjMsMTEgKzYzLDExIEBAIGFjLWNsZWFuOjoKIAogYWMtZGlzdGNsZWFuOjogYWMt
Y2xlYW4KIGFjLW1haW50YWluZXItY2xlYW46OiBhYy1kaXN0Y2xlYW4KKwkkKFJNKSAtZiAkKEFV
VE9NQUtFX0ZJTEVTKSBhY2xvY2FsLm00IGNvbXBpbGUgY29uZmlnLmd1ZXNzIGNvbmZpZy5zdWIg
Y29uZmlndXJlIG00L01ha2VmaWxlLmluCisJJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS9pbmNs
dWRlIiAkQDsKIAlmb3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElSUyk7IGRvIFwKIAkgICAgJChN
QUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQotCSQoUk0pIC1mIGFjbG9j
YWwubTQgY29uZmlndXJlICQoQVVUT01BS0VfRklMRVMpIG00L01ha2VmaWxlLmluCi0JJChSTSkg
LWYgaW5jbHVkZS8qY29uZmlnLmguaW4KIAogIyBEb24ndCBpbmNsdWRlIGNvbmZpZy5oLCBvciBt
YWtlIHdpbGwgKHJpZ2h0ZnVsbHkpIHdoaW5lIGFib3V0IG92ZXJyaWRpbmcKICMgcnVsZXMuCkBA
IC04MiwxMCArODIsMTAgQEAgQVVUT0dFTkVSQVRFRF9GSUxFUwk9IFwKIAkJCW00L01ha2VmaWxl
CiAKIGRpc3RjbGVhbjo6ICU6IGNsZWFuIGFjLWRpc3RjbGVhbgorCSQoUk0pIC1mICQoQVVUT0dF
TkVSQVRFRF9GSUxFUykKIAlmb3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElSUyk7IGRvIFwKIAkg
ICAgJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQotCSQoUk0pIC1m
ICQoQVVUT0dFTkVSQVRFRF9GSUxFUykKIAogbWFpbnRhaW5lci1jbGVhbjo6IGRpc3RjbGVhbiBh
Yy1tYWludGFpbmVyLWNsZWFuCiAKCi0tIAoyLjQ5LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
