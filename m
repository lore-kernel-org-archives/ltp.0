Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE3CCE7AA6
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 03:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60B513C265D
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 05:18:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F873C25E0
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 05:18:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E939B1000DBA
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 05:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725592712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKEGP1Aza4RnmuKBUYuz597A6kLtsCaOIhlAGuX0yWo=;
 b=IHHss8UFKiSb7W4L/8bm92C34dapvfHgJoHNr+LWKw8lAb/HTIyG7XpSrLgfVLRQ/zlGSo
 TU6zU23wLkG5CeCKQp6i4XIyG8KIDtB6LD7Z1yJXWz+EzrdGqfPg+SUvFaXSPl5KH3mWif
 0ww3hXI8hMpXbFxWH4usMWsurshR8OA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-pSF0RCZ6PYm30vIyFlJiyA-1; Thu, 05 Sep 2024 23:18:30 -0400
X-MC-Unique: pSF0RCZ6PYm30vIyFlJiyA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7143ae1b4fbso2062701b3a.0
 for <ltp@lists.linux.it>; Thu, 05 Sep 2024 20:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725592709; x=1726197509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rKEGP1Aza4RnmuKBUYuz597A6kLtsCaOIhlAGuX0yWo=;
 b=MlkUGSK3BqmJiB/EsRdU0qm4oTHHc9XZJBTJAqbLvJJb1K7V+jXzt377pJPuQVLMtm
 hMkIuktOOi9j9cQJ+saMDLUky/A57JQ+z2OGLMtKKMi3QCAXZfvVcconjxx91FStn74T
 w0gdvn6JcxWSk3GyTj27CIKdQccvL6YZpn79B0sqHqc5BONh9LgGpMnxnVQY7TFLACet
 cPLysRTj/m6pHqE8itTU+anqDAlnczGozpcGEc84VpxvIVIMscgH7z3TSc+fVmrcc/Yk
 SONzkK1Ox6ERD6MSYFVd11gnnejlT7REDn4uZBxTKfWcLNhqgMmAJ5U5l4+1x5nFSxPk
 6xww==
X-Gm-Message-State: AOJu0YyJNwLIhIewjYUlG/x/IJE32Pf+xu7DzfEiVmufIKKd746kzo6O
 GB1Fz2QQH7Dj+v1Fe1b/+MUXQFjucS+zamMcekvb1Vs2zH8aSZKC+aJdfXPfj7q2KJqFW6dSIF7
 vwehvWtNbzlWaKVd1mAsKYVPGWZq6QiDrhEeM2U3sbNyK475dp/NrcIxV4m13ygVjvHfDRHEmrk
 PWbQCsMbm3mbwJgsNL4K1P+80=
X-Received: by 2002:a05:6a00:139f:b0:717:8b4e:a17f with SMTP id
 d2e1a72fcca58-718d531e249mr1966456b3a.4.1725592709153; 
 Thu, 05 Sep 2024 20:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1XY7KfhQKB/WGblpOebCPuATkckZyCnn9gjyC3O0t1YH2Il4blIul/YRFy3hHsxO23IKBrWGCXUnB10pdBuI=
X-Received: by 2002:a05:6a00:139f:b0:717:8b4e:a17f with SMTP id
 d2e1a72fcca58-718d531e249mr1966422b3a.4.1725592708625; Thu, 05 Sep 2024
 20:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240905134502.33759-1-mdoucha@suse.cz>
 <20240905134502.33759-2-mdoucha@suse.cz>
In-Reply-To: <20240905134502.33759-2-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 11:18:16 +0800
Message-ID: <CAEemH2fyNf7dgyo-_FOuxq8qUFSUBC+T3YjFXEndqdAB+0QQVw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] fallocate05: Deallocate whole file on bcachefs
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

T24gVGh1LCBTZXAgNSwgMjAyNCBhdCA5OjQ14oCvUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6PiB3cm90ZToKCj4gVGhlIGRlZmF1bHQgZGVhbGxvY2F0aW9uIHNpemUgaXMgbGlrZWx5
IHRvbyBzbWFsbCBmb3IgYmNhY2hlZnMKPiB0byBhY3R1YWxseSByZWxlYXNlIHRoZSBibG9ja3Mu
IFNpbmNlIGl0IGlzIGFsc28gYSBjb3B5LW9uLXdyaXRlCj4gZmlsZXN5c3RlbSwgZGVhbGxvY2F0
ZWQgdGhlIHdob2xlIGZpbGUgbGlrZSBvbiBCdHJmcy4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcnRp
biBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KCi0tLQo+Cj4gQUZBSUNUIEJjYWNoZWZzIHVzZXMg
NTEyIGJ5dGUgZGF0YSBibG9ja3MgYnkgZGVmYXVsdCBidXQgMjU2S0IgaW5vZGUKPiBibG9ja3Mu
IFRoZSB3aG9sZSBmaWxlIHdpbGwgYmUgMTI4S0IgYW5kIDMyS0IgZ2V0cyBkZWFsbG9jYXRlZCB3
aGljaCBtYXkKPiBiZSB0b28gc21hbGwuIEhvd2V2ZXIsIEknbSBub3QgZW50aXJlbHkgc3VyZSB3
aGV0aGVyIHRoaXMgaXMgdGhlIGJlc3QKPiBzb2x1dGlvbi4KPgoKSSB0aGluayB0aGlzIHNvbHV0
aW9uIGlzIGNvcnJlY3QuCgpFdmVuIGRlYWxsb2NhdGluZyBhIGhvbGUgc2l6ZSAoMzJLQikgdGhh
dCBpcyBsYXJnZXIgdGhhbiBhIGJsb2NrIHNpemUKNTEyYnl0ZXMsCmJ1dCB0aGF0IGRvZXMgbm90
IG1lYW4gdGhlIEJjYWNoZWZzIGNhbiBzYXRpc2Z5IGVub3VnaCBzaXplIGZvciBmb2xsb3dpbmcK
d3JpdHRlbgpiZWhhdmlvciwgYmVjYXVzZSB0aGUgYWxsb2NhdGlvbiBvZiBuZXcgZGF0YSBibG9j
a3MgKGhvbGUpIG1pZ2h0IGludm9sdmUKbW9kaWZ5aW5nCm1ldGFkYXRhIHN0cnVjdHVyZXMgdGhh
dCBuZWVkIG1vcmUgc3BhY2UoZXh0ZW5kcyBtb3JlIGlub2RlIGJsb2NrcyAyNTZLQikuCgpJZiB0
aGUgZmlsZXN5c3RlbSBjYW5ub3QgYWNjb21tb2RhdGUgdGhlc2UgY2hhbmdlcywgaXQgY291bGQg
bGVhZCB0byBhbgpFTk9TUEMgZXJyb3IuCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
