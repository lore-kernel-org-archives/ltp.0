Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDF5C54E41
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8F7C3CE9E8
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:55:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BEA33C196B
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:55:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 036DD616F5A
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709722519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWgNwCRQ+1AwDerWpUHxRKeblirCv0FxaXN6VOjYo3Q=;
 b=Lo8tkSArFp8n/3k1i1Uhl5WhXCUyIp4lIwBQiPApq7/OK6sdEHyAOtCofzH6vlrTtLyqH+
 iDs3pG9Eaqntc3e59bw9bg4TSClOw7exjfP3GhwdaCVmfdMCBC970O2bG74hLTjSYimS2P
 mtZB8tRcnorWR39qIg11WL9gTPP8cAk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Fgw1nXu0PgKvtm8VWeGMiQ-1; Wed, 06 Mar 2024 05:55:18 -0500
X-MC-Unique: Fgw1nXu0PgKvtm8VWeGMiQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-299783294a6so644803a91.3
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 02:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709722212; x=1710327012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWgNwCRQ+1AwDerWpUHxRKeblirCv0FxaXN6VOjYo3Q=;
 b=fUEPCCZmQyqGIRCutihNYUaPvbGWsEAn+dhm3jJD8io42iCqmsCdnmnoUYke9EwaFD
 uaQE6I1lRhsyA3xQ6yp4KEed6Y9MKmIYMICokrsiIc4TWVw8928YhTxnkHlf9YNmUpin
 WOpG3EA51cGEU097Y6hnaq4nR4W8vKK3MJP0wesMeRAn1iuVW/g1O4p9BeVWP8WJNsXZ
 VcA58W3Ondh9Ofk2RWf0FG+ixz4NsFo0t6z/gBw5LjzbBSgJ+QTV0upLH4Ti5XKGFfwD
 JJuK5k+YMBv2Ib+hMT5QQkmZlQqOa9bCvDhZvx0vkgbwfgKi4Ue3vRxDd3NbwXEq2qyZ
 nebw==
X-Gm-Message-State: AOJu0YzBv1if5jjTmomF10MVEKBH6vLcV42rVW0aD7qjdilkWBt8NHjV
 Ndx5m1gvbyLxdDxf74rTOw8weP0WAJnbTE9NefdRrEmYA+7aoFnNTZy7467h9MLqVrN588qPBj4
 u1CBEjcEINRuHHoOOmbOgrgrwuZUjD5W6t4i7cQ8GChJ77hUpk165bZF1ctslDtB7AIEOob9+VP
 +0kiRknhUN/txoxyZspF5sb0Q=
X-Received: by 2002:a17:90a:a516:b0:29a:68ad:b77e with SMTP id
 a22-20020a17090aa51600b0029a68adb77emr11528681pjq.19.1709722212172; 
 Wed, 06 Mar 2024 02:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4OHxF2llgtOiO5/mS539iUlUTIXeZ1emFjRBk17eqeUM54md8wBeOOe76Utg5Eh55VE6EpJ4LXEb2W3RJ2jo=
X-Received: by 2002:a17:90a:a516:b0:29a:68ad:b77e with SMTP id
 a22-20020a17090aa51600b0029a68adb77emr11528670pjq.19.1709722211780; Wed, 06
 Mar 2024 02:50:11 -0800 (PST)
MIME-Version: 1.0
References: <7509ec18-035e-4cdd-824f-5d8eac4bf3ff@suse.com>
In-Reply-To: <7509ec18-035e-4cdd-824f-5d8eac4bf3ff@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Mar 2024 18:49:59 +0800
Message-ID: <CAEemH2e1CscAMbrt6N7TJi=HCJtewhzLB9muwam=0yt9xqb05w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] March meeting summary
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKTmljZSBzdW1tYXJ5LgoKSSBndWVzcyBpdCB3b3VsZCBiZSBnb29kIHRvIGNv
cHkgaXQgaW50byB0aGUgbWVldGluZyBwYWQsIGFuZCB0aGVuCndlIGNhbiBlYXNpbHkgcmVjYXAg
dGhlIGhpc3RvcnkgcmVjb3JkaW5nIHdoZW4gbmVjZXNzYXJ5LgoKaHR0cHM6Ly9kb2NzLmdvb2ds
ZS5jb20vZG9jdW1lbnQvZC8xS2p3QXlSVjhYZTBqZFExYVdDcFFsV1Q0YktLTWJ1bVEyQ0hRVkVa
SHNBay9lZGl0CgpPbiBXZWQsIE1hciA2LCAyMDI0IGF0IDY6MznigK9QTSBBbmRyZWEgQ2VydmVz
YXRvIHZpYSBsdHAKPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBIaSEKPgo+IFRoYW5r
cyB0byBhbGwgcGFydGljaXBhbnRzIG9mIG91ciBtb250aGx5IExUUCBtZWV0aW5nLiBBIHNob3J0
IHN1bW1hcnkKPiBvbiB3aGF0IHdlIHRhbGtlZCBhYm91dDoKPgo+IC0gd2UgaGF2ZSB+MzAwIHRl
c3RzIHRvIHJlZmFjdG9yIGludG8gdGhlIG5ldyBMVFAgQVBJLCB3aGljaCAyLzMgb2YgdGhlbQo+
IGFyZSByZWFsbHkgbG93IHRvIHNsaWdodGx5IG1pZCBjb21wbGV4aXR5Cj4KPiAtIGluIG9yZGVy
IHRvIGF0dHJhY3QgbW9yZSBkZXZlbG9wZXJzIGFuZCByZXZpZXdlcnMsIHdlIG5lZWQgdG8gcHJv
dmlkZQo+IG1vcmUgZG9jdW1lbnRhdGlvbiBhYm91dCB0aGUgTFRQIHByb2plY3QuIFRoaXMgY2Fu
IGJlIGFjaGlldmVkIGJ5Cj4gc2hhcmluZyB3b3Jrc2hvcHMsIGJsb2dzIGFuZCBkb2N1bWVudGF0
aW9uIHRoYXQgY2FuIGhlbHAganVuaW9yCj4gZGV2ZWxvcGVycyB0byBzdGFydCB3b3JraW5nIG9u
IHNtYWxsIExUUCB0ZXN0cy4gSW4gc2hvcnQsIHRvIHNpbXBsaWZ5Cj4gZG9jdW1lbnRhdGlvbiBy
ZWFjaGFiaWxpdHkKPgo+IC0gdG8gaW1wcm92ZSBvdXIgZG9jdW1lbnRhdGlvbiB3ZSBjYW4gdHJ5
ICJyZWFkdGhlZG9jcy5pbyIgdGhhdCBpcwo+IHNpbWlsYXIgdG8gd2hhdCBrZXJuZWwgZGV2cyBh
cmUgdXNpbmcgKGNoZWNrCj4gaHR0cHM6Ly9rb3JnLmRvY3Mua2VybmVsLm9yZy9kb2NzLmh0bWwp
LiBJbiB0aGlzIHdheSB3ZSBjYW4gYWxzbyBwcm92aWRlCj4gYSBtb3JlIHJlYWRhYmxlIExUUCB3
ZWJzaXRlCj4KPiAtIHRvIGludHJvZHVjZSBhIHNwZWNpYWwgZmxhZyB0byBjb21tdW5pY2F0ZSB3
aXRoIHRlc3RzIHJ1bm5lciAoa2lyaykKPiB3aGVuIHdlIG5lZWQgdG8gcmVib290IHRoZSBtYWNo
aW5lIGR1cmluZyB0ZXN0cwo+Cj4gLSB3ZSBkaXNjdXNzZWQgYWJvdXQgc29tZSB0b29saW5nLCBB
SSwgcmV2aWV3aW5nIHRvb2xzLCBib3RzCj4KPgo+IFRoYW5rcyBmb3IgYWxsIHRoZSBzdWdnZXN0
aW9ucyBhbmQgaW1wcm92ZW1lbnRzLgo+IEhhdmUgYSBnb29kIGRheSBhbmQgc2VlIHlvdSB0aGUg
bmV4dCBtb250aCEKPgo+IEJlc3QgcmVnYXJkcywKPiBBbmRyZWEgQ2VydmVzYXRvCj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
