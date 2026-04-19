Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A4EA719A
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 14:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 815153E2DB4
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 16:46:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1E13C0926
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 16:46:38 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EEEF20033E
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 16:46:38 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so8964055ad.2
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776609997; x=1777214797; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjA7KfG2zuz+YgD+ldmXW7Th/iFH9k6m5QO8Vxpaq2U=;
 b=iFul0tVT2z2Oby3eJ6aF9uHwvRVaA9dKnDNdyJckNPUfbzz5DDQ79i4xXI454zLile
 opJ9jQZwVWierD+KFjvjWU4koZ0nq6n2w5LDjNrGlN3KoMXk0OdeUSUK5QcY2ZCC7ehL
 jwPTnRzyHG9gfAzVePDJYgWJdp/O9TDYE49XaZ9NIe+4sSVEbwTNFooAe6MxA9TUPsWM
 JUgO4MK+XdJ0tXOuMpWC+ltJ1lvcovcbjdnyqMZFbx2qTjyXWWNi5pJYVHUH4blavqlT
 X9sRnfggjTXCI6jZlxA1xGprAyI+nQztmTwONFncHY8DMNxLkOQVKx5Muw6fl1oVYd6Z
 X/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609997; x=1777214797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjA7KfG2zuz+YgD+ldmXW7Th/iFH9k6m5QO8Vxpaq2U=;
 b=gG5pw/fcK6UXskZ8tUn4xIkNkp8FF9ivXtIn1tkFF5bR9WeU4vJw49CZWFXaAl46Wj
 YcMQWgano50jmaWemurBrCnAKQ0eQEdK3rDAJHNsOuJWPrb1j/e18dNLLSzpUn1Q7i69
 2mP6J0pifXYMnBlEJwRIe/xmcQUZ5KSo69hJ9LIax2cHz+9EWqfeln0kZCi9Y1JpUdoe
 QFPBtDvSvA61A111ayt6Qom/RZEZpgXMWiwILHWnVXPS1UlXQY1m/DaS0PzEfWs+ATMj
 jPPFeATKxDNFTSBeLmNXZ4BsVa7bwo+bYtQRY3o0KKU0zc3gj4akzuR0CJ4fHBiyAAFu
 bZRA==
X-Gm-Message-State: AOJu0Yw1qRpSP2gxJtqMiUmsKxAfFRVSmJ2eBP3A1JFeiUuLkaudSvgL
 Y/asM415IhpR7HjBxcIpj3iGCo3s0s+oAk6u5oSIdpQjfdmoBVtFObKB
X-Gm-Gg: AeBDievv7s9j2eGe608z8UnS0nbPO9QYWn/Go5hTRr+Y8Ag2PRADOQJ8KvxIF/60SgI
 Q7595cawnTLyxVLmbX+pO8/ni40/4gtl0ywWt/lexOw1vbUOWvVY/YuZugy3XoGt8p1YguvfOoo
 eDzftIF0KCSn+lW67OxG2COSvXC1hhZ8RtuxoS+dEYh6Tw5D9+uVtU+4TSiKqyWCl6PVoyJfOQk
 pr0HIyX1IeXanli/VeyjqYMgDHYnaFiDBv1ndlTf9MHLBamzCPXhus7I4zT6hwfnxnYmah2sgeR
 H3YYglpAWL7lKsaxNOGUUUgz/Y849kCAywgXO18tV4vkfAgTVkN/mq+LOvqduxl2X7/5+MuUwvj
 gXEqWF2Q7E1DHM+mNNv6FIUpteQH9DG7lTvpFjoqx7tmm9hoAJ03+RQ5hIF1HTG+fr7eB2kCr4g
 9P64SvkNIptLYI3oYUYyoSxUb9d9JUMkCNXe6ArAmnAIwREAXA1+2u9uiO31bsneypmf7emcjcM
 28kc4eFUBpS+KFv7U6Cevn7TTRCsx3P0KUyxPLYSaKXYQ==
X-Received: by 2002:a17:903:b47:b0:2b0:c90f:449d with SMTP id
 d9443c01a7336-2b5f9f1ca53mr101244325ad.19.1776609996719; 
 Sun, 19 Apr 2026 07:46:36 -0700 (PDT)
Received: from
 runnervmeorf1.lm5voez41cuu5k0eg3hjwl50ja.xx.internal.cloudapp.net
 ([4.154.22.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20e80sm78447435ad.57.2026.04.19.07.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:46:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Sun, 19 Apr 2026 14:46:35 +0000
Message-ID: <20260419144635.4080-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419130053.13996-1-mmenashe@redhat.com>
References: <20260419130053.13996-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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

SGkgTWljaGFlbCwKCk9uIFN1biwgMTkgQXByIDIwMjYsIE1pY2hhZWwgTWVuYXNoZXJvdiB3cm90
ZToKPiBmdXRleDogQWRkIGVycm9yIGNvdmVyYWdlIHRlc3RzIGZvciB3YWl0LCB3YWtlIGFuZCBj
bXBfcmVxdWV1ZQoKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4
X2NtcF9yZXF1ZXVlMDMuYyAobmV3KQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZnV0ZXgvZnV0ZXhfd2FpdDA2LmMgICAgICAgIChuZXcpCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mdXRleC9mdXRleF93YWl0MDcuYyAgICAgICAgKG5ldykKPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dha2UwNS5jICAgICAgICAobmV3KQoK
RWFjaCBvZiB0aGVzZSBpcyBhbiBpbmRlcGVuZGVudCB0ZXN0IGNhc2UuIExUUCBwb2xpY3kgcmVx
dWlyZXMgYXQgbW9zdApvbmUgbmV3IHRlc3QgY2FzZSBwZXIgY29tbWl0IOKAlCBwbGVhc2Ugc3Bs
aXQgaW50byBmb3VyIHNlcGFyYXRlIHBhdGNoZXMuCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21w
bGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91
bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLWFnZW50L2Fj
dGlvbnMvcnVucy8yNDYzMTU4MjI3NQoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBm
YWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJ
ZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVt
YWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
