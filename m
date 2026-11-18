Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162E606A336
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=rjbJAte1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YSr0uypU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795018922; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hCLrsl11WOXOhtFaxIiALeTbfJp5CJgLHxRtYms09ug=;
 b=rjbJAte1mQVlrW9YfzZZBkqvbGJsvRPVjJwqWKV1fHS6fGVlzoyKQkwY3w9hUZsnNspVT
 NHXyWRekYcuzylY8Hzpa1eL4RoqV9QNnmdNSSPlehUS+Cgnhw6qe+ndGP56Swk9ZFdnmM8x
 slXXS0sUeWedzC/S11Bc7z3I37reGdM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABA0F3EB2C2
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 17:22:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FBC73E2D08
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 17:21:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A63131A00CBE
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 17:21:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795018899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdWpBp5dlmyYWFLvuIyR+OZWcgsql0Uyy/ZglHbre8I=;
 b=YSr0uypUJG+opqU4f23kUN439lmglXfot2snhb4BbRH6DfLqWly+y8ObNqAfIFB7q1kiNA
 8FqvblNM8eh56+piaH46LkjmyQhOfznj4X677cyPOtJDc0842eM9vzJsuYAbsA+JF6WkGx
 6Dfh02GkFqn01zJYHfzjKyUiceex8Cg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-uoQ5bgvfNbKvQf-qYeTjGg-1; Wed, 18 Nov 2026 11:21:37 -0500
X-MC-Unique: uoQ5bgvfNbKvQf-qYeTjGg-1
X-Mimecast-MFC-AGG-ID: uoQ5bgvfNbKvQf-qYeTjGg_1795018896
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b3b7d66416so15002867b3.3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 08:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018896; x=1795623696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZdWpBp5dlmyYWFLvuIyR+OZWcgsql0Uyy/ZglHbre8I=;
 b=Vraq+v9u8Qf7AKZwNqs7g5mbB/paZKjKzXGGr7MVVH19lqfIDyCjD2gq1d6InsYW+W
 SyMuS7rT7K6ErG6I+qFAOIynVPm4OXSlDKwhfr+vtqXOfpwHYXNeetxBdud+79ODxeO5
 IhjRX3Iglfd2EQdA5pdJI2x2nY2rg2nCHpQ39AXhl8JpMTWiz6XuGi/zMwEv89Udn3YM
 Q3p2dVGhejIAKJzfgo5/1BrZxAjvhDaEoy2QngU5dy2wMr4PnIa2zT+hLrmd3Ugy4yzQ
 +56rV/+3HDyQC7NDIKwX+2ZDOJaOR+3O0sQ/d84ms5cw76uSGBjo3fAevNZO2iZDsXo+
 CLaw==
X-Gm-Message-State: APuU4Z/SqW0OL4/IK1fcZlxuluPo77bpAnjioFT+KuoaQHKzadrkhEOr
 38Xdj/Lh9VmwJjOjCeriBwkxOFfQEF6X7mZT5sIO4FscAIBWpF8CcHs6NZHUXaR3Tp4sqmsG9yL
 eWEwS+JQlbk2WkemQDexEpW9+zQW5rPOnnFkqWxgoLiMwF0OdV2v7yTG/5tuW+CplTVlRfewJ2d
 i+uHirmFhsU91y+t7BZaG/fljudRUVGZxv8Dc=
X-Gm-Gg: AZFdTZcJQRrlXz7LIL7Z6TXGZ9b/8LIZzBKYIP2wDlRQErjLlg2nwPdgnbG1wabI5aA
 KNrgshkR8/cbDOs73PkqR8yCGEax9PF0+CtY931nnuOswRIY2xgzT3v8HTGhCKwH2gFcDi24kkN
 n5YzgmRIznjM9Bf94fKrjzmqx2siLfSaO0EPONOanx0VHX128GeUA3xIW0255zy9O6cXtM8E94E
 yWDlh6bFcMDn9WHrkxN5Yfkl3UMzwV5gNtNSR6QaTLeZUEF104=
X-Received: by 2002:a05:690e:1447:b0:67d:bff8:c405 with SMTP id
 956f58d0204a3-67dd3cf28a0mr1471355d50.5.1795018896267; 
 Wed, 18 Nov 2026 08:21:36 -0800 (PST)
X-Received: by 2002:a05:690e:1447:b0:67d:bff8:c405 with SMTP id
 956f58d0204a3-67dd3cf28a0mr1471344d50.5.1795018895671; Wed, 18 Nov 2026
 08:21:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105080245.2067876-1-afazekas@redhat.com>
 <20261105155415.3529-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20261105155415.3529-1-linuxtestproject.agent@gmail.com>
Date: Wed, 18 Nov 2026 17:21:23 +0100
X-Gm-Features: AclHuK9zmOEI8wkOv-kEF4HEU41pOq3aqHGvLq0OVTjLcQIzAXztvpNPS6_FiDo
Message-ID: <CAMTxPK20n7NjKbW3w-0+aHLk00RpazYT_WE-Rzkj9s4miT=F5g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iGHmn79OQ331UulW9hkOiJ9JN3zDw2xQPAzGRaVcedo_1795018896
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Attila Fazekas via ltp <ltp@lists.linux.it>
Reply-To: Attila Fazekas <afazekas@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpJIGFtIHdvbmRlcmluZyB3aGVuIHRoZSBtZXJnZSB0cmFpbiB3aWxsIGFycml2ZSBmb3Ig
dGhpcyBjaGFuZ2UgaWYgaXQgaXMKY29taW5nLgpEbyB5b3UgbmVlZCBhbnkgYWN0aW9uIGZyb20g
bWU/CgpCZXN0IFJlZ2FyZHMsCkF0dGlsYQoKCgpPbiBUaHUsIE5vdiA1LCAyMDI2IGF0IDQ6NTTi
gK9QTSA8bGludXh0ZXN0cHJvamVjdC5hZ2VudEBnbWFpbC5jb20+IHdyb3RlOgoKPiBIaSBBdHRp
bGEsCj4KPiBPbiBUaHUgTm92IDUgMDk6MDI6NDUgMjAyNiArMDEwMCwgQXR0aWxhIEZhemVrYXMg
PGFmYXpla2FzQHJlZGhhdC5jb20+Cj4gd3JvdGU6Cj4gPiBtbWFwMjI6IEJvdW5kIGNoaWxkIG1l
bW9yeSBhbGxvY2F0aW9uIHRvIGF2b2lkIE9PTQo+Cj4gVmVyZGljdCAtIFJldmlld2VkCj4KPiAt
LS0KPiBOb3RlOgo+Cj4gVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3Np
dGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCj4gZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBm
aW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQo+IGNvbW1lbnQgdGhpcyBlbWFpbCBv
ciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgo+Cj4gUmVnYXJkcywKPiBMVFAgQUkgUmV2aWV3ZXIK
Pgo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
