Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AECC5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 10:07:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7C8A3CED41
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 11:07:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B51423CED00
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:07:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 022D8616F78
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709287639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RUf3YJQ7Q8ABBdA5sBoxW8CJb3Q94Oqwdx67uNPYPiY=;
 b=cJ/E8tosxOAbnnKMNk+ahkdjXk00zhMhB7EZAtJXCRLtS9N3tWZ3VYFanBjwKTzuDXt5Ke
 +uHFHbcIlxVCcjtHkof57MzfifcXiqfqhbrsFuwluIHK4nN0fnrabK40Gj0JdLpjjF689Y
 znTNkErQ3x8tdAymayvg8Ao9LWXZcPU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-9lJLCx0JPp-HCERU6NaXYw-1; Fri, 01 Mar 2024 05:07:17 -0500
X-MC-Unique: 9lJLCx0JPp-HCERU6NaXYw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29905ac5c21so1635863a91.0
 for <ltp@lists.linux.it>; Fri, 01 Mar 2024 02:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709287636; x=1709892436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUf3YJQ7Q8ABBdA5sBoxW8CJb3Q94Oqwdx67uNPYPiY=;
 b=rESQpCeGjfWhOWpzG65NBWXCPEOsOAnPtLVdP6NmpG6Oh07WO4zl99rQIg4PWNMSap
 y2FDEwF0eYsa95ytd+bU3HVQ4iAinDJVEfDBJauGKg2i5kYRYJxcjxbnFyAeP9agLGed
 cXDftCQ/R727P/o2zyqXQr44iOWuQ1e7zFOA+qwPEM12YOK69OZzQsVdaSMt3ue5tSqb
 YjfVSaeh1jXFri0pCiOobJK3FGpdRmdQQKQwzuO8AI8ggcqs+hCREtDvpm6sBGIQCLxD
 k22VQXuYE5gpFCJkhMx0uIcKU0UN96amLq1Opro+W1FqGtEpl43GSR51vhfuYL1RqcSL
 tAxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX00lPrB4tD4YThSt43arpVvnw7YzDBg2KR+81KPGMXYoCT7SZDbNgnT/z48VvcS0P88/yzYoCZS9zNc/wVL0D0QHM=
X-Gm-Message-State: AOJu0YyzgRWq4YdBC83CwtakDfy9r2in0mGr9bkYVp/rbjXyfX9Tm4EJ
 my0/xhDGZxIrGoXPQIRIBuioGlwOKnh9hvLfattTHr/No881jBwmbXgDkpUFs9fOmwCqe4DKpah
 Rp/HS+1DrmRpeJ3nFeQB8j4o1Bez+aWFHWdsuFeCrD7ocF7e2Jt3XhgyRO+eQF+UL36Qb30zeKZ
 NyObV1yFfoSb2Jg83sQr0Rf+w=
X-Received: by 2002:a17:90b:3557:b0:29a:f766:7eb1 with SMTP id
 lt23-20020a17090b355700b0029af7667eb1mr1144327pjb.23.1709287636436; 
 Fri, 01 Mar 2024 02:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExD3Yh7AfHPkMQHiW2k4QWROOvCq4M4PczXJsxln2xRbWH3DgdnceRBGJE5nO1bknMLmssZUs+6QTyLmclq3U=
X-Received: by 2002:a17:90b:3557:b0:29a:f766:7eb1 with SMTP id
 lt23-20020a17090b355700b0029af7667eb1mr1144306pjb.23.1709287635738; Fri, 01
 Mar 2024 02:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
 <20240222031018.12281-2-wegao@suse.com>
 <CAEemH2cXOi0DpE1p36H-hUxuH2o8WwhD8DUPndBDMoKBbJJnCQ@mail.gmail.com>
 <20240301084311.GA1660278@pevik>
In-Reply-To: <20240301084311.GA1660278@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2024 18:07:03 +0800
Message-ID: <CAEemH2dcyC3UPXPycgu6g5iZ97gx-T9gifusD7nhoaUNxhKLXw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 1/2] cgroup_core01.c: Set system default umaks
 to 0
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

T24gRnJpLCBNYXIgMSwgMjAyNCBhdCA0OjQz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+ID4gSGkgV2VpLCBQZXRyLAo+Cj4gPiBTZWVtcyB0aGUg
cHJvYmxlbSBXZWkgbWV0IGlzIHRoZSBkZWZhdWx0IHVtYXNrIG9mIDAwNzcsCj4gPiBhbnkgbmV3
IGZpbGVzIG9yIGRpcmVjdG9yaWVzIHRoYXQgYXJlIGNyZWF0ZWQgd2lsbCBoYXZlIHRoZWlyCj4g
PiBwZXJtaXNzaW9uIGJpdHMgbW9kaWZpZWQgYnkgdGhpcyB1bWFzay4KPgo+ID4gQWZ0ZXIgbG9v
a2luZyB0aG91Z2ggd2hhdCB5b3UgYm90aCBkaXNjdXNzZWQsIEkgdGhpbmsgbWF5YmUKPiA+IGFu
b3RoZXIgYmV0dGVyIGNob2ljZSBpcyB0byBzZXQgdGhlIHVtYXNrIHRvICcwMDAwJyB0ZW1wb3Jh
cmlseQo+ID4gYmVmb3JlIGNyZWF0aW5nIHRoZSBkaXJlY3RvcnksIGFuZCB0aGVuIHJlc3Rvcmlu
ZyB0aGUgcHJldmlvdXMKPiA+IHVtYXNrIHJpZ2h0IGFmdGVyLgo+Cj4gPiBBbGwgdGhlc2Ugb3Bl
cmF0aW9ucyBhcmUganVzdCBwdXQgaW50byBjZ3JvdXBfZGlyX21rIGZ1bmN0aW9uLgo+Cj4gTEdU
TSB0aGlzIGFwcHJvYWNoLCBwbGVhc2Ugc2VuZCBhIHBhdGNoLgo+CgpPaywgc3VyZS4KCgo+ID4g
KyAgICAgICBtb2RlX3Qgb2xkX3VtYXNrID0gdW1hc2soMDAwMCk7Cj4gbml0OiB1bWFzaygwKSBp
cyB0aGUgc2FtZSByaWdodD8KPgoKZXhhY3RseS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
