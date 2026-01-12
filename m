Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD2DC9EC90
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768227050; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FyE2hNjELrtLlBN4Grauqc5dQ6cFZPqQfJE3uvkl53U=;
 b=BtszcjeydLciHeBHmfQWAjTwRErrO3Xm10QXbCFa6SBLcdgvW1+0Wljnvfwpvt4G/T9Qi
 lg+6nYNjMsQYF/27mvFWy5NSyQK1bcG3jnQQGDeB2Nt4ZSjB70pgQ7oDEnzRekZIAHKu9AV
 cSU6OK+MDdtr9L9PbKcqhXLAzYvEgPo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3992F3C52E3
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 15:10:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5043E3C4C11
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 15:10:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 961B6600728
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 15:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768227025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEDSAcwpDXxiPTJcGNUppV3D5e/oOuqEeU6hMlgnPQ4=;
 b=YH0XiJUAO6obaq8ZoT/D3uRAEr94Z/3LVtSlSwhHRyA+JXVJtSdXolk0j8NpFPTkizv8dk
 w54GIP3ILW8WPR4yMkXkOTm7kXhYhB7qgWQ7l86baTVSmX4q2FPEtX1IH1OWaKDvEk79zl
 orANDc4dpDmmcvMr8VX0Eg8oSn+vvU4=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-gBUgCU0SOA2Ks3wosvWa5A-1; Mon, 12 Jan 2026 09:10:23 -0500
X-MC-Unique: gBUgCU0SOA2Ks3wosvWa5A-1
X-Mimecast-MFC-AGG-ID: gBUgCU0SOA2Ks3wosvWa5A_1768227022
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b0530846d3so5511575eec.0
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 06:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768227022; x=1768831822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEDSAcwpDXxiPTJcGNUppV3D5e/oOuqEeU6hMlgnPQ4=;
 b=AnXehaSHSAzQcHUBX0i/1RUYiyevvNzF2QtoWZIODo93cNimPI6xvwhD5nhCSv4J0L
 38PvKEhVOS0H5nuCL493QGjWnZGOlFKC8wud0BdlUBqMS2J05PFeHVEOFE52Dgn5Jfyt
 97BsIoTirp3xqlCs6L6Svx7exTV7anlLPqhsTB0k9ERa5pIz+nAoGwiL5vV4yKJbb0tb
 I+ElzPyRy1WT5IX8jDZGa+jGLvhWeDdpG60FHO2m/tkgbkK5+W9EDQGC7/fyrO/iXIQD
 rBbaS5+K0emXVCdZ0sdwwBx4r562eJGWkoPwLr0DH4gQjwdNTrdkrBDCBQfZ46gzfygD
 /Okw==
X-Gm-Message-State: AOJu0Yw44JKP2eFLG8uL4ufM4firBmrDq3eAjnHLCtdjw9NV8g89zvDJ
 NrEFjUS5mRPhRHX2MNoJk4hEAvKmGJzV/BEFKnr0jEiL0xCuO8EwdemR+4q06BEsLdQYBqnC052
 Fk9MhhsEiMIF72tSRlx6JEDqzMx06GBQwX7UZDNOrE4I9miQ6hBAOwAsScfxKa7idrTRyMd7FQq
 7rJW1hSD8IQ4EpGHVdltjdWoaXZVw=
X-Gm-Gg: AY/fxX6cl98xMWD3RnqWd11yZhoCt60Nd1JQT3UnyLkEG+wCSL1cE+FT9cqqyGe3ZVm
 Wunoyd+SydvTeBCLHLwSJPpk2ZfpLsVy5F7TshjDkWoeM68h6Iio+IevcdJ6/N46ZEIdmWZDQVc
 tX6bBX5RtD59N69GYAp9hELVP/jfvaeVd7CGIgj2DWqmwpar61wo0OgEPmMCrq8FUXPkk=
X-Received: by 2002:a05:7301:6505:b0:2ae:5d5e:9b1c with SMTP id
 5a478bee46e88-2b17d1fb255mr17310937eec.2.1768227022328; 
 Mon, 12 Jan 2026 06:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrsBE7P2Rm2kgsAam0rF2yZv3hpuGpv9bNVryOttoQSCezMzNrWj3v8om4l2fX5RXsMedfVAt8ytEENGpL9oQ=
X-Received: by 2002:a05:7301:6505:b0:2ae:5d5e:9b1c with SMTP id
 5a478bee46e88-2b17d1fb255mr17310915eec.2.1768227021867; Mon, 12 Jan 2026
 06:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
In-Reply-To: <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
Date: Mon, 12 Jan 2026 22:10:08 +0800
X-Gm-Features: AZwV_Qhlbh6rd6yju5cRwcHoWxePipbdOk-QpGxFyzLgVuUE89G63Gf1dhP_9dE
Message-ID: <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C2ts_O3dXUKqRowJ5_2aQzI573twntpnpUid0ui357o_1768227022
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLCBBbGwsCgpPbiBNb24sIEphbiAxMiwgMjAyNiBhdCA4OjU54oCvUE0gQW5kcmVh
IENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4Kd3JvdGU6Cgo+IEhpIQo+Cj4g
SSBnZW5lcmFsbHkgYWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLCBidXQgSSBoYXZlIHRoZSBmZWVs
aW5nIHdlIGFyZQo+IG1peGluZyBuYW1pbmcgYSBiaXQgaGVyZS4gRm9yIGluc3RhbmNlLCB3ZSBo
YXZlIGhlYWRlcnMgbGlrZSBpcGNtc2cuaAo+IHRoYXQgaGFzIG5vIGZ1bmN0aW9ucyBzdGFydGlu
ZyB3aXRoIHRzdF8qLCB3aGlsZSB0c3RfbnVtYS5oIGRvZXMuIEFsc28sCj4gdGhlIHRzdF8qIHBy
ZWZpeCBmb3IgZmlsZXMgaGFzIHRoZSBjbGVhciBnb2FsIHRvIHN0YXRlIHdlIGFyZSBpbXBvcnRp
bmcKPiBzb21lIExUUCBmdW5jdGlvbmFsaXRpZXMgaW5zaWRlIHRoZSB0ZXN0cyBjb2RlLgo+Cj4g
U2FpZCBzbywgSSB3b3VsZCByYXRoZXIgcmVuYW1lIGFsbCBMVFAgbGlicmFyaWVzIGFzIHRzdF8q
LmggYW5kIHRvCj4gcmVuYW1lIGZ1bmN0aW9ucyBpbnNpZGUgdGhlbSB3aXRoIHRzdF8qIHByZWZp
eC4gSW4gdGhpcyB3YXksIHdlIGtub3cKPiBhdCB0aGUgdmVyeSBmaXJzdCBsb29rLCB3aGVuIGEg
bGlicmFyeSBpcyBpbXBvcnRlZCBmcm9tIExUUCBhbmQgbm90Cj4gZnJvbSBvdGhlciBzb3VyY2Vz
Lgo+CgpJIGluZGVlZCB0aG91Z2h0IGFib3V0IGFsbCB1c2UgdHN0XyogZm9yIHRob3NlIGdsb2Jh
bCBoZWFkZXIgZmlsZXMuCkJ1dCB0byBkaXN0aW5ndWlzaCBsaWIvIHdpdGggbGlicy8gSSBmaW5h
bGx5IGZlZWwgdGhhdCBsaWJzLyBpcyBub3QgdGhlCmNvcmUgTFRQIEFQSQphbmQgc29tZXRpbWVz
IGJ1aWx0IG9ubHkgd2hlbiB0aGV5IGFyZSBuZWVkZWQsIGlmIHdlIHJlbmFtZSBhbGwgdGhlc2UK
aGVhZGVyIGZpbGUgd2l0aCB0c3RfKiB0aGF0IHdpbGwgbWlzbGVhZCBwZW9wbGUgdG8gZmluZCB0
aGUgKi5jIGZpbGUgaW4KbGliLywgd2hpY2gKaXMgbm90IHRoZSByaWdodCBwbGFjZS4KClNvIGlu
IG15IHBhdGNoLCBrZWVwIGRlZmluZSB0c3RfKiBvbmx5IGZvciB0aGUgY29yZSBMVFAgQVBJLCBh
bmQgbGliKiBwcmVmaXgKcmVzZXJ2ZSBmb3IgbGlicy8gdGhhdCB3aWxsIGJlIGNsZWFyIGF0IGEg
Z2xhbmNlLgoKT3IsIGlmIGdvIHdpdGggdHN0XyouaCBmb3IgYWxsIChhbmQgcmVuYW1lIGZ1bmN0
aW9ucyB3aXRoIHRzdF8qKSwgSSB0aGluawp0aGUgbGlicy8gc2hvdWxkIGJlIG1lcmdlZCBpbnRv
IGxpYi8uCgpAQ3lyaWwsIFBldHIsIGFueSBjb21tZW50cz8KCgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
