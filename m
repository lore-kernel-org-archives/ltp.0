Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F58C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847CC3CE1D1
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:18:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C26053C8964
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:17:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB4AD1417C2C
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706177875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VrD5ZEo3Pj3modr0yC4+1jFvFsbY64O9D8ARkCxb/cM=;
 b=F38IA1s64x3mPc6eEHsj7gH1pr9qn9HUsaMRsxL8CVHvX2RicicBOjdcFoKU/qVAFTLJfH
 d106W/uZ64xDh8SNU451L34h1CuFpzAnTJGbNKuFeFr2Q2sRR1Sxj4Ig0dESglPzQ0h+3r
 ty1GerviR+Bsr2SeEOtpLszcLLMlqVo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-FfIP6YhVPs2ZZtXozmDSdA-1; Thu, 25 Jan 2024 05:17:52 -0500
X-MC-Unique: FfIP6YhVPs2ZZtXozmDSdA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d6fb108807so73243a12.0
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 02:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706177870; x=1706782670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTXxxRuOu/KoVNMGidjT3AiYtPH9SBlmG42iEVTaai8=;
 b=gvddeG1pMHFie8HaOi66OKNfnTRj5aZ+Gf+fdXHRNeLEL/eXrmBJ9Wk1jShmTEvja4
 RC5XUC1p0GMesWfs8b0quiGB74LdDabaE8HxfiH8+0W+bsYRAgTHmT24a2Oa9sBsg7Yy
 XAExaYuqCDTWwMZg1o1GvKqrnDKc8F8I0z2vNJDWHLkUXd0MUs87VyYDU7gUn+hn1Q/Y
 cxGABw2I+ftc/ifOEfi6GsfxTYMmBr1ASnFTKkrqwrnuy2+NpuikIlqmU1YRKtUvQZ08
 P2wENMAOJxP2O29Wbcc4bCaDbDcsO9XC3bJWRvscxS8P5qhXPTfIWZykiC6nFwtHFAt+
 eXmg==
X-Gm-Message-State: AOJu0YzYwTIzd20OJdsJnnCDWCkU1WXMOD5OmVHA9WGjQTq98MtxJt0n
 MoAKXAAUo9z1TJbddOhKpxOIvZlGHDmdRVcOPkcOG18AyKJ+VY1OmBdb/p7LzFtb+CLS91FGktw
 nAjbVq5zQZ42CtV6vtJi46/QKnQ6zdPz39/7QLfGWvuUWAFX01oenP51MTlJcN17Lx5ufxGmgk5
 bM9OMXuLfn1u3Vv8OcLdGbMIVxmAs03rHM4U9N
X-Received: by 2002:a05:6a20:3d28:b0:19c:638a:e7f5 with SMTP id
 y40-20020a056a203d2800b0019c638ae7f5mr967073pzi.41.1706177869961; 
 Thu, 25 Jan 2024 02:17:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIAELR4CJc/7VKlVou6bbx9Ao35Bf9IJxD0rwHMsNcD0pLd43D7Q+n3rpokN0+DcM78dnP/E9ohXPduiCM/As=
X-Received: by 2002:a05:6a20:3d28:b0:19c:638a:e7f5 with SMTP id
 y40-20020a056a203d2800b0019c638ae7f5mr967064pzi.41.1706177869651; Thu, 25 Jan
 2024 02:17:49 -0800 (PST)
MIME-Version: 1.0
References: <ZZQHPkwg-W2R1ejJ@yuki> <Zak5QdHCUyUmJ5x4@yuki>
In-Reply-To: <Zak5QdHCUyUmJ5x4@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Jan 2024 18:17:37 +0800
Message-ID: <CAEemH2dZrhc_1G+PY5s89tQMhQ-F-mVbjBz+_CdbjBYm9CG_Ow@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxsLAoKT24gVGh1LCBKYW4gMTgsIDIwMjQgYXQgMTA6NDTigK9QTSBDeXJpbCBIcnViaXMg
PGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+IEFzIHdlIGFyZSBuZWFyaW5nIHRoZSBl
bmQgb2YgdGhlIG1vbnRoIEkgd291bGQgbGlrZSB0byBnZXQgdG8gYSBnaXQKPiBmcmVlemUgYW5k
IHN0YXJ0IHdpdGggYSBwcmUtcmVsZWFzZSB0ZXNpbmcuIElkZWFsbHkgSSB3b3VsZCBsaWtlIHRv
Cj4gZnJlZXplIHRoZSBnaXQgdGhpcyBGcmlkYXkgMTkuCj4KPiBJZiB0aGVyZSBpcyBhbnl0aGlu
ZyBJIHNob3VsZCBoYXZlIGEgbG9vayBhdCBiZWZvcmUgdGhlIGZyZWV6ZSBvciB0aGF0IEkKPiBo
YXZlIG1pc3NlZCBwbGVhc2UgcG9pbnQgaXQgb3V0IHNvIHRoYXQgSSBjYW4gaGF2ZSBhIGxvb2su
Cj4KClRlc3QgYmFzZWQgb24gdGhlIGxhdGVzdCBMVFAgKG1haW4tYnJhbmNoICsgbGlic3dhcC1w
YXRjaHNldCkgcmVzdWx0cyBhczoKCnNwbGljZTA3OiByaGVsOS4zICsga2VybmVsLTYuNy4wLCBh
bGwtYXJjaGVzCgogICAgODYJc3BsaWNlMDcuYzo2MjogVElORk86IC9kZXYvemVybyAtPiAuLi4K
ICAgIDg3CXNwbGljZTA3LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBvbiAvZGV2L3plcm8gLT4gZmls
ZSA6IEVJTlZBTCAoMjIpCiAgICA4OAlzcGxpY2UwNy5jOjU0OiBUUEFTUzogc3BsaWNlKCkgb24g
L2Rldi96ZXJvIC0+IE9fUEFUSCBmaWxlIDogRUJBREYgKDkpCiAgICA4OQlzcGxpY2UwNy5jOjU0
OiBUUEFTUzogc3BsaWNlKCkgb24gL2Rldi96ZXJvIC0+IGRpcmVjdG9yeSA6IEVCQURGICg5KQog
ICAgOTAJc3BsaWNlMDcuYzo1NDogVFBBU1M6IHNwbGljZSgpIG9uIC9kZXYvemVybyAtPiAvZGV2
L3plcm8gOiBFQkFERiAoOSkKICAgIDkxCXNwbGljZTA3LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBv
biAvZGV2L3plcm8gLT4gL3Byb2Mvc2VsZi9tYXBzCjogRUJBREYgKDkpCiAgICA5MglzcGxpY2Uw
Ny5jOjU0OiBUUEFTUzogc3BsaWNlKCkgb24gL2Rldi96ZXJvIC0+IHBpcGUgcmVhZCBlbmQgOiBF
QkFERiAoOSkKICAgIDkzCXNwbGljZTA3LmM6NTQ6IFRGQUlMOiBzcGxpY2UoKSBvbiAvZGV2L3pl
cm8gLT4gcGlwZSB3cml0ZSBlbmQgc3VjY2VlZGVkCiAgICA5NAlzcGxpY2UwNy5jOjU0OiBUUEFT
Uzogc3BsaWNlKCkgb24gL2Rldi96ZXJvIC0+IHVuaXggc29ja2V0IDogRUlOVkFMICgyMikKICAg
IDk1CXNwbGljZTA3LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBvbiAvZGV2L3plcm8gLT4gaW5ldCBz
b2NrZXQgOiBFSU5WQUwgKDIyKQoKCnByb2Nfc2NoZWRfcnQwMTogcmhlbC05LjMoNS4xNC4wLTM2
Mi44LjEuZWw5XzMpLCBhbGwtYXJjaGVzCgogICAgMTAJcHJvY19zY2hlZF9ydDAxLmM6NDU6IFRG
QUlMOiBFeHBlY3Q6IHRpbWVzbGljZV9tcyA+IDAgYWZ0ZXIKcmVzZXQgdG8gZGVmYXVsdAogICAg
MTEJcHJvY19zY2hlZF9ydDAxLmM6NTE6IFRQQVNTOiBlY2hvIDAgPgovcHJvYy9zeXMva2VybmVs
L3NjaGVkX3J0X3BlcmlvZF91cyA6IEVJTlZBTCAoMjIpCiAgICAxMglwcm9jX3NjaGVkX3J0MDEu
Yzo1MzogVEZBSUw6IGVjaG8gLTEgPgovcHJvYy9zeXMva2VybmVsL3NjaGVkX3J0X3BlcmlvZF91
cyBpbnZhbGlkIHJldHZhbCAyOiBTVUNDRVNTICgwKQogICAgMTMJcHJvY19zY2hlZF9ydDAxLmM6
NTk6IFRQQVNTOiBlY2hvIC0yID4KL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ydF9ydW50aW1lX3Vz
IDogRUlOVkFMICgyMikKICAgIDE0CXByb2Nfc2NoZWRfcnQwMS5jOjcyOiBURkFJTDogZWNobyBy
dF9wZXJpb2RfdXMrMSA+Ci9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfcnRfcnVudGltZV91cyBpbnZh
bGlkIHJldHZhbCAxOiBTVUNDRVNTICgwKQoKCnNjaGVkX3JyX2dldF9pbnRlcnZhbDAxOiByaGVs
LTkuMyg1LjE0LjAtMzYyLjguMS5lbDlfMyksIGFsbC1hcmNoZXMKCiAgICAgOQlzY2hlZF9ycl9n
ZXRfaW50ZXJ2YWwwMS5jOjQ0OiBUSU5GTzogVGVzdGluZyB2YXJpYW50OiB2RFNPIG9yCnN5c2Nh
bGwgd2l0aCBsaWJjIHNwZWMKICAgIDEwCXNjaGVkX3JyX2dldF9pbnRlcnZhbDAxLmM6NjE6IFRQ
QVNTOiBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwoKSBwYXNzZWQKICAgIDExCXNjaGVkX3JyX2dldF9p
bnRlcnZhbDAxLmM6Njg6IFRQQVNTOiBUaW1lIHF1YW50dW0gMHMgMTAwMDAwMDAwbnMKICAgIDEy
CXNjaGVkX3JyX2dldF9pbnRlcnZhbDAxLmM6NzY6IFRGQUlMOgovcHJvYy9zeXMva2VybmVsL3Nj
aGVkX3JyX3RpbWVzbGljZV9tcyAhPSAxMDAgZ290IC0xCiAgICAxMwlzY2hlZF9ycl9nZXRfaW50
ZXJ2YWwwMS5jOjQ0OiBUSU5GTzogVGVzdGluZyB2YXJpYW50OiBzeXNjYWxsCndpdGggb2xkIGtl
cm5lbCBzcGVjCiAgICAxNAlzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMS5jOjYxOiBUUEFTUzogc2No
ZWRfcnJfZ2V0X2ludGVydmFsKCkgcGFzc2VkCiAgICAxNQlzY2hlZF9ycl9nZXRfaW50ZXJ2YWww
MS5jOjY4OiBUUEFTUzogVGltZSBxdWFudHVtIDBzIDEwMDAwMDAwMG5zCiAgICAxNglzY2hlZF9y
cl9nZXRfaW50ZXJ2YWwwMS5jOjc2OiBURkFJTDoKL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ycl90
aW1lc2xpY2VfbXMgIT0gMTAwIGdvdCAtMQoKCnNjaGVkX2dldGF0dHIwMTogcmhlbC05LjMoNS4x
NC4wLTM2Mi44LjEuZWw5XzMpLCBhbGwtYXJjaGVzCgogICAgIDcJc2NoZWRfZ2V0YXR0cjAxICAg
IDEgIFRGQUlMICA6ICBzY2hlZF9nZXRhdHRyMDEuYzo1NzoKc2NoZWRfc2V0YXR0cigpIGZhaWxl
ZDogZXJybm89RVBFUk0oMSk6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkCgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
