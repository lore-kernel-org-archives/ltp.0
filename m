Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC70CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 03:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754970235; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R4z+mrJc/iE3BUDVaygJ3etlNlrvmvLzfyXvqcHK+zU=;
 b=P2lkEdUul0Ov0ACCfLTrTKmPwHUu64qhkQeSBo0+4GBaVrN3pzYan6f6XR7XYuNsLnf4y
 t5Gv4OjJGPkRYDCGs0f4ZjUSWceGJZBhpKdgHyZXPEBbch2Iz5UrmxQ9/QuTB7f7lDKh2WC
 xDAjLXzvhEFvTGx/7rkQdZZTFjWPPgc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6CF83CB0BA
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 05:43:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 413B23C5DF4
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 05:43:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4353460080C
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 05:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754970211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfDuJVf4o8/HG62LSEgkRxCbk/5vgF+U4p673/thp/Q=;
 b=c3qs9SRuS19OfSocRAnGdit9IOYtUE5gOKJcjeC2lE6SIxdDg7GEWS3QRnJ0ADNarpvutA
 xWNzjldPrv9RDd72V8q/Dy1ycpady8XE6OK2waT2zy4uw7k27E5GmTBpcXSRngQWfN9HPf
 Oaz4qdgRgu0MpSUu87w/bNwjHb6ASl8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-fllqy6S6MGuf-pDv5LhFTw-1; Mon, 11 Aug 2025 23:43:29 -0400
X-MC-Unique: fllqy6S6MGuf-pDv5LhFTw-1
X-Mimecast-MFC-AGG-ID: fllqy6S6MGuf-pDv5LhFTw_1754970208
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-76bcfe2a8a4so5112549b3a.0
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 20:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754970208; x=1755575008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfDuJVf4o8/HG62LSEgkRxCbk/5vgF+U4p673/thp/Q=;
 b=NX0yPU9llAgckRCi9wHQIEdCEmoY4a49JiQqo4q7TM7BT9IpYJjFq89HZ6j2g7zgnH
 QmeWYOKukl86esorX4vlzWz8hsWqkLc1IHqiGNkmpZT3k5ggCLEqHHBp5+a8TE/uXPxs
 BQQn8UmzCOcMPwcVoJevzKb/3kPENTMOdtzX9o+Y+jlnJJAw0O7BqUFByTu0ko3MNTJW
 hEXIxlF1J/coq4VcnvVdxyKtpu4SCLhiDONDkl1FAAcJzohU5r/xfCP6KApYhubgV/SF
 WLts2iU3ZQEmjzUgPvlAfIa4nKW5U2NbSwxAsB+DlixqlIpnvH2vhMLUZSOJykuKMYte
 oung==
X-Gm-Message-State: AOJu0YwCajnOI8qjRNt7CEE70dLV4PO/eGSihbgGm8ynzp51z7fPuo3x
 ia/2gjc9jN5dzOY+cq7oIDelrF59Yay1gXNAn2rz37r7QN2ry6kSBzrSYF9sdtkDKKaac6XPW5n
 EmUf7jEbrxk135xDUHHZzlX8AiHPrgwXQ2tlxTEIR4/3ifYGD3Q3KDqgLE8DgpW6HD5fudt6TUP
 cDorsillI+WJwc6YwVoduZgb3zVng=
X-Gm-Gg: ASbGncvZ+CgbxVC73e3txJCoXRVeUKM7wA1tg1MhdKBQtXcMWGal7W+mzcspXL4nOc9
 ngO9n2p4UtoNRcdS42IhlQrjvbVeuvJzRUTdxP7KBYNfOq0w932m+DIQm77HydfgVfU3z9fzH8p
 Rh06ioQ1lnvZOxH/3L7w+KNA==
X-Received: by 2002:a17:903:2392:b0:23f:cf96:3071 with SMTP id
 d9443c01a7336-242fc366850mr29742355ad.49.1754970208038; 
 Mon, 11 Aug 2025 20:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYCX8wtOfYXS58R9CmGJU4P+bpHOWVqBxjjpvNc3Lr6JASRFGkbAfCinwii5sr+OMizk3vod9eWzIwvGw7k3E=
X-Received: by 2002:a17:903:2392:b0:23f:cf96:3071 with SMTP id
 d9443c01a7336-242fc366850mr29742195ad.49.1754970207606; Mon, 11 Aug 2025
 20:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190102131913.GA26215@rei.lan>
 <20250806074405.14890-1-liwang@redhat.com>
 <aJMf-6DEu-9NzLAJ@yuki.lan>
 <CAEemH2dFjv2Mn-CfM6HEZxT7BR45PAHuwQcMa6dckxemf0tvzg@mail.gmail.com>
 <aJn8ObtEEaAf1H-a@yuki.lan>
In-Reply-To: <aJn8ObtEEaAf1H-a@yuki.lan>
Date: Tue, 12 Aug 2025 11:43:15 +0800
X-Gm-Features: Ac12FXzL_Oy4MUQ4i1s28VTR2_HVRD6NGdDs4sptLfdAuQQLz0wpvZfV3EYUpeU
Message-ID: <CAEemH2ePTzTRQ_Urh0LK33hNFFkxz26CbiW-mX7RjZfyQpaOpA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FHh_Lj2r_ekm_RTUK2zmE_fNc5lMBlG3GjNGcPeNFzU_1754970208
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_umount: Retry open() after umount to handle
 delayed device release
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMTEsIDIwMjUgYXQgMTA6MTnigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gRnJvbSB0aGUgYnBmc3RyYWNlIGxvZ3MsIHRoZXJl
IHNlZW1zIHVkaXNrc2QgbGlzdGVuaW5nIHRvIHRoZSBzYW1lCj4gPiB1ZGV2ZXZlbnRzIGFuZCBw
cm9iZXMgdGhlIGRldmljZSB2aWEgbGliYmxvY2tkZXYvYmxraWQsIHBlcmZvcm1pbmcKPiA+IHJl
YWwgT19SRE9OTFkgb3BlbnMgKGZsYWdzPTB4MCkuIFRoZXNlIE9fUkRPTkxZIG9wZW5zIGZyb20K
PiA+IHVkaXNrc2QgcmFjZSB3aXRoIG1rZnMuZXh0M+KAmXMgT19FWENMIG9wZW4sIGludGVybWl0
dGVudGx5IGNhdXNpbmcKPiA+IOKAnGFwcGFyZW50bHkgaW4gdXNlIGJ5IHRoZSBzeXN0ZW3igJ0g
KEVCVVNZKS4KPiA+Cj4gPiBEb2VzIHRoaXMgYW5hbHlzaXMgc291bmQgcmVhc29uYWJsZSB0byB5
b3U/Cj4KPiBZZXMuIFNvIHdlIGhhdmUgYW5vdGhlciBkYWVtb24gdGhhdCBwcm9iZXMgYmxvY2sg
ZGV2aWNlcyBvbiBlYWNoIGNoYW5nZS4KPgo+IEkgc3VwcG9zZSB0aGF0IHR1cm5pbmcgb2ZmIHVk
aXNrc2QgZml4ZXMgdGhlIHByb2JsZW0gcmlnaHQ/IElmIHRoYXQgaXMKPiBzbyBJIHdvdWxkIGJl
IGluY2xpbmVkIGp1c3QgdG8gcHJpbnQgYSBtZXNzYWdlIHRvIHR1cm4gb2ZmIHVkaXNrc2QgaWYK
PiBta2ZzIG9uIGEgbG9vcCBkZXZpY2UgZmFpbHMuLi4KPgoKVGhhdCdzIHJpZ2h0LCB0aGlzIGlu
dGVybWl0dGVudCBFQlVTWSBpcyBub3QgcmVsYXRlZCB0byBMVFAgKGFuZCBub3QKYmUgYSBiaWcg
ZGVhbCksIGEgaGludCBwcmludCBzaG91bGQgYmUgdXNlZnVsIGVub3VnaCwgd2UgY2FuIGxlYXZl
CnN0b3BwaW5nIHVkaXNrczIgb3BlcmF0aW9uIHRvIHRoZSB0ZXN0ZXIgZW52IHNldHVwLgoKV2hh
dCBhYm91dCB0aGlzIGFtZW5kbWVudDoKCi0tLSBhL2xpYi90c3RfbWtmcy5jCisrKyBiL2xpYi90
c3RfbWtmcy5jCkBAIC0xMDcsNiArMTA3LDEzIEBAIHZvaWQgdHN0X21rZnNfKGNvbnN0IGNoYXIg
KmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCnZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAogICAgICAg
ICAgICAgICAgICAgICAgICAiJXMgbm90IGZvdW5kIGluICRQQVRIIiwgbWtmcyk7CiAgICAgICAg
YnJlYWs7CiAgICAgICAgZGVmYXVsdDoKKyAgICAgICAgICAgICAgIHRzdF9yZXNtXyhmaWxlLCBs
aW5lbm8sIFRJTkZPLAorICAgICAgICAgICAgICAgICAgICAgICAiQ2hlY2sgaWYgbWtmcyBmYWls
ZWQgd2l0aCB0aGUgKGxvb3ApIGRldmljZSBidXN5LiAiCisgICAgICAgICAgICAgICAgICAgICAg
ICJCYWNrZ3JvdW5kIHByb2JpbmcgKGUuZy4sIHVkaXNrczIpIGNhbiBjYXVzZSB0aGlzLgpcbiIK
KyAgICAgICAgICAgICAgICAgICAgICAgIkNvbnNpZGVyIHRlbXBvcmFyaWx5IHN0b3BwaW5nIHVk
aXNrczIgZHVyaW5nIHRoZQp0ZXN0OlxuIgorICAgICAgICAgICAgICAgICAgICAgICAiICBzeXN0
ZW1jdGwgc3RvcCB1ZGlza3MyLnNlcnZpY2VcbiIKKyAgICAgICAgICAgICAgICAgICAgICAgImFu
ZCByZXN0YXJ0IGFmdGVyd2FyZDpcbiIKKyAgICAgICAgICAgICAgICAgICAgICAgIiAgc3lzdGVt
Y3RsIHN0YXJ0IHVkaXNrczIuc2VydmljZSIpOwogICAgICAgICAgICAgICAgdHN0X2Jya21fKGZp
bGUsIGxpbmVubywgVEJST0ssIGNsZWFudXBfZm4sCiAgICAgICAgICAgICAgICAgICAgICAgICIl
cyBmYWlsZWQgd2l0aCBleGl0IGNvZGUgJWkiLCBta2ZzLCByZXQpOwogICAgICAgIH0KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
