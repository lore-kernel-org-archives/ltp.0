Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4EEC7EE32
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751103049; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C9AT/+fH/ua+bdoeO0pz5PHmv4HLBwGP1kwraqSp1lY=;
 b=ceoegJx8EqbDEna0Cl0KaRYMXMGSEb6As50BZ01oVHf4+FHn13nGon3BzAtYKT8EgYbC2
 OzcyN9pNAlyJp1PkFPv1AHohvTpgTqlwPgRcEAAPr7pKdPxu7p/FzjsseU+ZWN55wN8HwUz
 mPQXI+bk5p1zh3bJAsoAtLtQYuWYYA4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 945753C9BE7
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 11:30:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009A73C937D
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 11:30:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 21BB460004C
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 11:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751103024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQZUiPsHZLTGywVKegmwuUUJ9x6Ug8mqAZo2C0O0U88=;
 b=KIF32FzQkg8iAGY6g/gekGdaVzMbF+5DPknEoIhZKPYPsHXMJhY8m1VacTpxMkRwqVt559
 iAmcpoI9ChO5ged6EK/XEP8zAopCdZA8NQ09fFt4XUfP8waVZ7NGxps13jAclQBaYQnxAg
 1lDdPgaHtW2nmsVAp7j+hzWCXzQaF0s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-S0nTMJMhN6GMvZ4PRyir0Q-1; Sat, 28 Jun 2025 05:30:21 -0400
X-MC-Unique: S0nTMJMhN6GMvZ4PRyir0Q-1
X-Mimecast-MFC-AGG-ID: S0nTMJMhN6GMvZ4PRyir0Q_1751103020
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3138e671316so2189534a91.0
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 02:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751103020; x=1751707820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQZUiPsHZLTGywVKegmwuUUJ9x6Ug8mqAZo2C0O0U88=;
 b=T//IXtQATZmJ4XmoICURUM28BahZydm5COUQeBm2Q2S563F/4QLT4Pyl7EcZrWExKM
 NrxWQcwQfd3cEr2hrg5+QbOAhPvmAB7RNiM1EDfTfvAIB4Wfy7HjTA74THzyN78/4ZyR
 NFQu+r+0FIQhgaXtQ96VOt6jaWmd+0ixCRUNBATZsqN+8+RDW5d8II7O8Cmpq+0pFSoZ
 wR17g/wsOa2Pn3aNqgIVGX9TKO+cdTpr7mxXkDDQqmO+08VdM9jOS7Jmajx65rx0O+GD
 TS+F2bkz49RyhM8yhDtzsrQ0lCPRB+RLQ/Qf+VGPwHcsznFxfEd4bKPaXeF1oMEa48Ph
 LK2Q==
X-Gm-Message-State: AOJu0YxqZnVOYnlDR/1Gk6+QAcRHAOX11ekXqhP+fe1hXPxX8KVdnK+2
 +lFroHFSMWcgNOVsAinzIR4aW7Qe561UoHYXBGdZmx+UdxJ8HmKkK17D2XsuSpYOzmMN++LW9x6
 cscsYGqY+l2xwAUxX5xkN3osQpC/y/E7GuPkf5qA71Ej4ztoElKX0q+M90bsK0v3XICfaBJNF4B
 i0xMeYUcSdZeR2UiaLdRdRShJmx/Q=
X-Gm-Gg: ASbGncvyhSOiSDQMvEbBI2KxK9VHajjNpxf/Ib8W3ooWzAmpMSeChQ9geHegmrPFWMq
 Vq6BaWvA1dfiSAlopwRWL7JL+lVdXHrGeptIwqA//sUK3V8EayfMBZ04b0bXOyNR8FDLr3gd+FF
 dt5/or
X-Received: by 2002:a17:90b:5408:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-318c929aae1mr8706711a91.10.1751103020161; 
 Sat, 28 Jun 2025 02:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtFir0crCvm/jRFXEB+9S3hFM61OCyS9gmNEzv12jtDdTRcmolWhuaEY5MdKoTH6ECoE8u3Ny7RUnJMNBlXKE=
X-Received: by 2002:a17:90b:5408:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-318c929aae1mr8706667a91.10.1751103019467; Sat, 28 Jun 2025
 02:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250628031302.196715-1-liwang@redhat.com>
In-Reply-To: <20250628031302.196715-1-liwang@redhat.com>
Date: Sat, 28 Jun 2025 17:30:07 +0800
X-Gm-Features: Ac12FXxeCjVsHiBN9VVJ0OHTSZdzTR4LeB4po1Awoi0vQrdI6PpDXOeHfgWuODM
Message-ID: <CAEemH2fYeQipm1J15MteTRmVPsq6pvyxL2wpsy+Tv7M3g7s5Eg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8cKiGIZnIXRCbCEPjirmRUhli2Wcv0wmMUIeM1BrN_k_1751103020
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib/checkpoint: remove deprecated
 tst_checkpoint_init() and legacy macro
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBKdW4gMjgsIDIwMjUgYXQgMTE6MTPigK9BTSBMaSBXYW5nIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IFRoZSBmdW5jdGlvbiB0c3RfY2hlY2twb2ludF9pbml0
KCkgYW5kIG1hY3JvIFRTVF9DSEVDS1BPSU5UX0lOSVQgd2VyZQo+IHVzZWQgYnkgb2xkIGxpYnJh
cnkgdGVzdHMgZm9yIHNldHRpbmcgdXAgY2hlY2twb2ludCBmdXRleCBtZW1vcnkuCj4KPiBUaGVz
ZSBBUElzIGhhdmUgYmVlbiBmdWxseSByZXBsYWNlZCBieSB0c3RfcmVpbml0KCkgYW5kIGluIHRo
ZSBuZXcKPiBjaGVja3BvaW50IGluZnJhc3RydWN0dXJlLgo+Cj4gU28gbGV0J3MgZ2V0IHJpZCBv
ZiB0aGVtIGFuZCByZXdyaXRlIHRoZSBjaGVja3BvaW50IHRlc3RzIGluIG5ld2xpYl90ZXN0cy8u
Cj4KClNlZW1zIHRzdF9pcGNfcGF0aCBzaG91bGQgYmUgZGVsZXRlZCBhcyB3ZWxsOgoKLS0tIGEv
aW5jbHVkZS90c3RfY2hlY2twb2ludC5oCisrKyBiL2luY2x1ZGUvdHN0X2NoZWNrcG9pbnQuaApA
QCAtODYsNiArODYsNCBAQAogICAgICAgICB0c3Rfc2FmZV9jaGVja3BvaW50X3dhaXQoX19GSUxF
X18sIF9fTElORV9fLCBOVUxMLCBpZCwgMCk7IFwKIH0gd2hpbGUgKDApCgotZXh0ZXJuIGNvbnN0
IGNoYXIgKnRzdF9pcGNfcGF0aDsKLQogI2VuZGlmIC8qIFRTVF9DSEVDS1BPSU5UX18gKi8KZGlm
ZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKaW5kZXggMTdjZTkxOTMy
Li4zM2YzY2ZhMGIgMTAwNjQ0Ci0tLSBhL2xpYi90c3RfdGVzdC5jCisrKyBiL2xpYi90c3RfdGVz
dC5jCkBAIC0xMDgsNyArMTA4LDYgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCB0c3RfbWF4X2Z1dGV4
ZXM7Cgogc3RhdGljIGludCBpcGNfZmQ7CiBzdGF0aWMgY2hhciBpcGNfcGF0aFsxMDY0XTsKLWNv
bnN0IGNoYXIgKnRzdF9pcGNfcGF0aCA9IGlwY19wYXRoOwoKIHN0YXRpYyBjaGFyIHNobV9wYXRo
WzEwMjRdOwoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
