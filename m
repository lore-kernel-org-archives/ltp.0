Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AC6C5475B
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 06:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0C1F3CE84D
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 07:41:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC1E93C8121
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 07:40:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8AF9E2348BD
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 07:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710398456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMqwpZm7+akrIkVdhna7vl03WxfaqcY79IGhs7tICxI=;
 b=CY44pnk2YmVxCRUxAoOfq5/cCGKoKY2t3IboQXr0KfVz6TXd8RPQJjGIXjvJtqOB0jss26
 2AuCQrZlchwEzaCLCSZfvyH50BR+UZQzNTlWj9a4Dcw5wQJc8wy1NPwy9l/i/bZM1v3TKW
 DOyDqtI3xagwo9o7fdEWQlOQcpJfGYo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-zhRP0ThdMPmRiuLR8xoaXQ-1; Thu, 14 Mar 2024 02:40:54 -0400
X-MC-Unique: zhRP0ThdMPmRiuLR8xoaXQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29c64cfcb8aso576056a91.3
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 23:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710398453; x=1711003253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMqwpZm7+akrIkVdhna7vl03WxfaqcY79IGhs7tICxI=;
 b=BarPv6uXVhJ2wdbTNud3+B0hMfHCDlFgrwMxjL9+YLOLYzRsLiDE6veuxXXIiY2+4y
 fqvqh2Ydu7AvNOCK43U9EMJCxSUWkjOSN+bbfn7DlGJ7tcNJR84z8+yy9s/+dQyNr6P6
 zBg/gIrz8IMjklqZ7rPHBKFdeQ3/EXK02WREO4NsfW3PGZG2rcK9ykITvV7x9URls2hB
 bEh4ik8luE2K7Si+xjpEpeWBSOpMkkzwvkBUe8ZuVYdx5NrLb5K8PNcRvdFAk1opffMV
 BxVlKsLKNXKBsjRLnpOdCoYwtIKg6BaIKxlbU0+bNdMDoyNttgYjQp/eEiG5+UqWqnWV
 +44g==
X-Gm-Message-State: AOJu0YxVVEeeFkBaX1LdFoeZcuwFl7BdJTjOGBqXmcHIjV5G3s2iQFHN
 0HcgcJSONK4TmXDkUIcoque0oO2lPx2tq4S4zfl8tECl38pfhU761UEaVtt+0TTKq2Zf/Vaip74
 i5dTgQ5zGIkvqCMZewPanfd+cXGVTolwe2izBXAJWZ/YdPcAv2MfOyHVPRW/R+owJB5Cr6qZzfe
 1uB5mjedkSO8WA6+EXxxh37t4=
X-Received: by 2002:a17:90b:23cf:b0:29b:ce33:492d with SMTP id
 md15-20020a17090b23cf00b0029bce33492dmr823384pjb.22.1710398453321; 
 Wed, 13 Mar 2024 23:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHPUISK6kDcEQB2ekPIyVNElUwdZ9OjZMwb/3//f+Cun3wgD7szeil8NgBx2643LJaKU6P6kkftAiTqAgQ4eg=
X-Received: by 2002:a17:90b:23cf:b0:29b:ce33:492d with SMTP id
 md15-20020a17090b23cf00b0029bce33492dmr823374pjb.22.1710398452983; Wed, 13
 Mar 2024 23:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240314013320.5536-1-wegao@suse.com>
In-Reply-To: <20240314013320.5536-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Mar 2024 14:40:40 +0800
Message-ID: <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

SGkgV2VpLAoKT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgOTozM+KAr0FNIFdlaSBHYW8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gRHVyaW5nIG91ciB0ZXN0IGkgZmluZCBh
IG9vbSBlcnJvciBkdXJpbmcgdGVzdCB3aGljaCB0cmlnZ2VyZWQgYnkKPiB0c3RfcG9sbHV0ZV9t
ZW1vcnkuCj4KPiBrZXJuZWw6Cj4gb29tLWtpbGw6Y29uc3RyYWludD1DT05TVFJBSU5UX01FTUNH
LG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2FsbG93ZWQ9MC0xLG9vbV9tZW1jZz0vbHRw
L3Rlc3QtOTU1Mix0YXNrX21lbWNnPS9sdHAvdGVzdC05NTUyMAo+IGtlcm5lbDogTWVtb3J5IGNn
cm91cCBvdXQgb2YgbWVtb3J5OiBLaWxsZWQgcHJvY2VzcyA5NTc1IChzd2Fwb24wMSkKPiB0b3Rh
bC12bToxMDUxNDg0a0IsIGFub24tcnNzOjEwNDY1NzJrQiwgZmlsZS1yc3M6MTI4MGtCLCBzaG1l
bS1yc3M6MGswCj4KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiAt
LS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYyB8IDQgKysr
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+IGluZGV4IGQ0
MDZlNGJkOS4uMzU3OTkyNTI1IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc3dhcG9uL3N3YXBvbjAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3
YXBvbi9zd2Fwb24wMS5jCj4gQEAgLTQxLDcgKzQxLDkgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9p
ZCkKPiAgICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMCwgMCk7Cj4KPiAgICAgICAg
IFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNncm91cC5wcm9jcyIsICIlZCIsIGdldHBpZCgpKTsK
PiAtICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVT
VE1FTSk7Cj4gKwo+ICsgICAgICAgLyogQXBwbHkgYSBtYXJnaW4gdG8gYXZvaWQgb29tIGR1cmlu
ZyB0c3RfcG9sbHV0ZV9tZW1vcnkgKi8KPiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywg
Im1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSArIFRFU1RNRU0vMTAwKTsKPgoKRXZlbiB3aXRo
IGEgYml0IG9mIG1hcmdpbiBhZGRlZCB0aGVyZSBpcyBzdGlsbCBub3QgZ3VhcmFudGVlIHRvIGF2
b2lkIE9PTQpjb21wbGV0ZWx5LgoKQXMgdGhlIENncm91cCBWMSBhbmQgVjIgdHJhY2sgbWVtb3J5
IGFuZCBzd2FwIGluIHR3byB3YXlzLCBpZiB0aGUgbWFyZ2luIGlzCnRvbyBsYXJnZSB0aGF0IG1p
Z2h0IG5vdCBtYWtlIHRoZSBzd2FwIGhhcHBlbiB3aGljaCBpcyBub3Qgb3VyIGV4cGVjdGF0aW9u
LgoKU28gb3RoZXIgbWV0aG9kIEkgY2FuIHRoaW5rIG9mIGlzIHRvIGRpc2FibGUgdGhlIE9PTSBp
biBDZ291cCwKICAgIGVjaG8gMSA+IG1lbW9yeS5vb21fY29udHJvbApvciwgc2V0IGBvdmVyY29t
bWl0X21lbW9yeWAgdG8gMiB0byBwcmV2ZW50IHRoZSBPT00gZnJvbSBvY2N1cnJpbmcuCiAgICBl
Y2hvIDIgPiAvcHJvYy9zeXMvdm0vb3ZlcmNvbW1pdF9tZW1vcnkKCgoKCj4gIH0KPgo+ICBzdGF0
aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gLS0KPiAyLjM1LjMKPgo+Cj4gLS0KPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+Cgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
