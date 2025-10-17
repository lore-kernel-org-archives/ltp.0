Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA45CCD19A
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760693959; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=r6HKf7iYn7ItflPEjsc69ghIwugk/IM/lCcPrteyES8=;
 b=M+Obfgv4n4fbL5ow3NvqKSZMmyfT5gltuJAdjG+mybLVay5oAvgZPxRdp3GalE/a16FJs
 BzDVQeEfgqpSdv0R3MtJxM8ktRsN7JhdnAm/VP6SIMF2kJ7G2QM0088ikzfHqbw6AgbAm/v
 Qys4/AT/zWMZWtQ6q+yaeVVaOXSydr8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044E13CEE5D
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 11:39:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D763A3CEE18
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:38:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E41686002DF
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760693936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRZrXIMPggorJxBt3KsJqERMfzaOibcK9TxjTe8YAVU=;
 b=Op2HqYvL/MqY5/+woGbLFO1PRbrjKKEIBKggoyghnGYXun1JB75+65+yOUj2p7aXHNfNUb
 ldYvQl4tD8D0EmG/mUoCmqcLRQ5EUr2K1zll2SDV0dn31KaQzXMddfyvZUeUAbWixzGDTt
 GSlkiQ/eUNsqBY4i7w2RSj+bkkmJqMw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8a4p_bXzPrijUofurPIW7Q-1; Fri, 17 Oct 2025 05:38:54 -0400
X-MC-Unique: 8a4p_bXzPrijUofurPIW7Q-1
X-Mimecast-MFC-AGG-ID: 8a4p_bXzPrijUofurPIW7Q_1760693934
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-272ed8c106eso12001235ad.2
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 02:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760693933; x=1761298733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRZrXIMPggorJxBt3KsJqERMfzaOibcK9TxjTe8YAVU=;
 b=go+2ILeofNG4MqZf304d56LhdDTx2icHAdy7BlnVwiaYwHMtQhU6upEBk1m0CUHp0D
 dkYirznl0BPS9ZXLG4Ct2jTDFMYzUXo3TIHktM7TREemBLPXN0MR+wsAfWLdPj0i3FSB
 NVcwHQvE+yq4TIB+v+v3Wnv/w9QETBV7dgJD2EjI4qVnvfWx0f2AxnFwhq3BIRK/Xje6
 igv51AGxoggaW2gpOOO8zWYdY8WxQGPrmJr1WJPEfOjzH4zrgJhaSrQELlA4Ymj+1RwX
 qmmfIPJMeDI9hY0D9oZSKOlbSKh38tcPpyVPQpphJY8c7sLLbWd2fy8a2ruBfdh4FyIu
 FTVw==
X-Gm-Message-State: AOJu0Yy/PMXXyl7B6q20/uSFiI2lT4azGfhPqWDZBiCjc4xbJ9wCOEFa
 1b2lF8zzHK24vouNsB1ZdwEqge/vVXZh4zWulyQs5Mg5LmYe6By4Tqz5iIPRR3AMzVuYEbzBH9z
 Kn5Tda+g1k2HbiwobFp0PoLyoMyxTQCrr7IV3YPCWViTRaLRkuxz7ALSUoSp+beVz+EEacsuIgW
 20VgI1mVmfjF6kL5EZ8aMB9yEb1oU=
X-Gm-Gg: ASbGncsYCg9cUQYOBfF1J1GxL3O2SBiuNAlzMCzqyt6jV9W9j5rQMnubgQrISgaFNHo
 87nuSXB/rOVS6uPJTQoucvEcJfDOpcIjma5N0/rzt+li7CDKtjemfMCtoxVWrPwI1X90qEZRquN
 RqVj8Pejhk7LRf9IwHlyYwGQ9XgmBn7Ot2x6IFmjF1j7yMEMIi8+v7iGxy
X-Received: by 2002:a17:903:3bce:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-290c9c8977amr34585765ad.2.1760693933509; 
 Fri, 17 Oct 2025 02:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHJlU8GrqgWjTY04jKhPm1qQFRIIrGfhExYFWQHPJmRrsO7w9do1zMu+etr2Lv2BnPW2030xJkh6MA68bADVU=
X-Received: by 2002:a17:903:3bce:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-290c9c8977amr34585445ad.2.1760693932925; Fri, 17 Oct 2025
 02:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251016140303.1645478-1-ben.copeland@linaro.org>
In-Reply-To: <20251016140303.1645478-1-ben.copeland@linaro.org>
Date: Fri, 17 Oct 2025 17:38:40 +0800
X-Gm-Features: AS18NWBMot1sTdg5oRrzmNouAQzNeHVERSnOIOa3efKxdgbqB6LdnlZ2ZvT3p7s
Message-ID: <CAEemH2cXCHg5McoRMpJXCDgL3c+TWm1v6wkGoouDWOhWJ1G_Wg@mail.gmail.com>
To: Ben Copeland <ben.copeland@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _KIiu7liHPDhGWIe5wL0RfdfQh8aIeORKn8fNYzDY0Q_1760693934
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] oom03: use size_t for memory length to fix 32-bit
 overflow
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org, arnd@arndb.de,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBPY3QgMTYsIDIwMjUgYXQgMTA6MDPigK9QTSBCZW4gQ29wZWxhbmQgPGJlbi5jb3Bl
bGFuZEBsaW5hcm8ub3JnPgp3cm90ZToKCj4gVGhlIGFsbG9jX21lbSgpIGZ1bmN0aW9uIGlzIHN1
cHBvc2VkIHRvIHRlc3Qgb3V0IG9mIG1lbW9yeSBjb25kaXRpb25zLgo+IEhvdyBpdCB3b3JrcyBp
cyBpdCBjYWxscyBtbWFwKCkgb24gYSBnaWFudCBjaHVuayBvZiBtZW1vcnkuCj4gSXQncyBlaXRo
ZXIgTEVOR1RIICgyR0IpIG9yICJURVNUTUVNICogMiArIFRTVF9NQiIgKDNHQikgYnl0ZXMuCj4g
VGhpcyBtbWFwKCkgaXMgZ2VuZXJhbGx5IHN1cHBvc2VkIHRvIHN1Y2NlZWQuICBUaGVuIGF0IHRo
ZSBib3R0b20gb2YKPiB0aGUgYWxsb2NfbWVtKCkgZnVuY3Rpb24gd2hlbiB3ZSBhY3R1YWxseSB0
cnkgdG8gdXNlIGFsbCB0aGUgbWVtb3J5LAo+IHRoZSB0aHJlYWQgaXMgc3VwcG9zZWQgdG8gZGll
IHdpdGggYSBTSUdLSUxMLgo+Cj4gVGhlIHByb2JsZW0gaXMgdGhhdCBsZW5ndGggaXMgc2lnbmVk
IHNvIG9uIGEgMzItYml0IHN5c3RlbSBpdCB3aWxsIGJlCj4gbmVnYXRpdmUuIFRoYXQgbWVhbnMg
dGhhdCBhdCB0aGUgYm90dG9tIG9mIHRoZSBmdW5jdGlvbiB3aGVuIHdlIGxvb3AKPiB0aHJvdWdo
IHRoZSBtZW1vcnksIHRoZSBmb3IgbG9vcCBpcyBhIG5vLW9wIGFuZCB0aGVyZSBpcyBubyBTSUdL
SUxMLgo+IEZpeCB0aGlzIGJ5IGNoYW5naW5nIHRoZSB0eXBlIHRvIHNpemVfdCB3aGljaCBpcyB1
bnNpZ25lZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEJlbiBDb3BlbGFuZCA8YmVuLmNvcGVsYW5kQGxp
bmFyby5vcmc+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0t
LQo+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tLmggfCA5ICsrKysrLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20uaAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbS5oCj4gaW5kZXggNDFjYzY4MWY5Li40MmVkMTgxYjAgMTAwNjQ0Cj4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbS5oCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbS5oCj4gQEAgLTYyLDEzICs2MiwxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2V0
X2dsb2JhbF9tZW1wb2xpY3koaW50IG1lbXBvbGljeSkKPiAgc3RhdGljIHZvaWQgc2V0X2dsb2Jh
bF9tZW1wb2xpY3koaW50IG1lbXBvbGljeSBMVFBfQVRUUklCVVRFX1VOVVNFRCkgeyB9Cj4gICNl
bmRpZgo+Cj4gLXN0YXRpYyBpbnQgYWxsb2NfbWVtKGxvbmcgaW50IGxlbmd0aCwgaW50IHRlc3Rj
YXNlKQo+ICtzdGF0aWMgaW50IGFsbG9jX21lbShzaXplX3QgbGVuZ3RoLCBpbnQgdGVzdGNhc2Up
Cj4gIHsKPiAgICAgICAgIGNoYXIgKnM7Cj4gLSAgICAgICBsb25nIGksIHBhZ2VzeiA9IGdldHBh
Z2VzaXplKCk7Cj4gKyAgICAgICBzaXplX3QgaTsKPiArICAgICAgIGxvbmcgcGFnZXN6ID0gZ2V0
cGFnZXNpemUoKTsKPiAgICAgICAgIGludCBsb29wID0gMTA7Cj4KPiAtICAgICAgIHRzdF9yZXMo
VElORk8sICJ0aHJlYWQgKCVseCksIGFsbG9jYXRpbmcgJWxkIGJ5dGVzLiIsCj4gKyAgICAgICB0
c3RfcmVzKFRJTkZPLCAidGhyZWFkICglbHgpLCBhbGxvY2F0aW5nICV6dSBieXRlcy4iLAo+ICAg
ICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZykgcHRocmVhZF9zZWxmKCksIGxlbmd0aCk7Cj4K
PiAgICAgICAgIHMgPSBtbWFwKE5VTEwsIGxlbmd0aCwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwK
PiBAQCAtMTExLDcgKzExMiw3IEBAIHN0YXRpYyB2b2lkIGNoaWxkX2FsbG9jKGludCB0ZXN0Y2Fz
ZSwgaW50IGxpdGUsIGludAo+IHRocmVhZHMpCj4gICAgICAgICBwdGhyZWFkX3QgKnRoOwo+Cj4g
ICAgICAgICBpZiAobGl0ZSkgewo+IC0gICAgICAgICAgICAgICBpbnQgcmV0ID0gYWxsb2NfbWVt
KFRFU1RNRU0gKiAyICsgVFNUX01CLCB0ZXN0Y2FzZSk7Cj4gKyAgICAgICAgICAgICAgIGludCBy
ZXQgPSBhbGxvY19tZW0oKHNpemVfdClURVNUTUVNICogMiArIFRTVF9NQiwKPiB0ZXN0Y2FzZSk7
Cj4gICAgICAgICAgICAgICAgIGV4aXQocmV0KTsKPiAgICAgICAgIH0KPgo+IC0tCj4gMi41MS4w
Cj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
