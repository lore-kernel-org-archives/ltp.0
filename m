Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1E1C71141
	for <ltp@archiver.kernel.org>; Sat, 14 Jun 2025 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749897420; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sFc4Do6ZcWAY2Goz/5iCEMysv7dYqNnJestUCZ6bePQ=;
 b=VDYsS4VMvyKilU4jnfyMx+2tEvnDwQ4G3AQrH3LUHFHmFpy6KUfeknutPZvjRjC7oFRAM
 TzL20uRRDBpFVE7RXUnQf9Cyiv4NdgHkUilkMj825moCNUDfm/NLgvTn+ixnn/KKL5B9nqT
 pDfmkySBtVa0WKN5BmQNFuW8RN4chKg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858FE3CB87B
	for <ltp@archiver.kernel.org>; Sat, 14 Jun 2025 12:37:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385063C064E
 for <ltp@lists.linux.it>; Sat, 14 Jun 2025 12:36:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9119D600096
 for <ltp@lists.linux.it>; Sat, 14 Jun 2025 12:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749897395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+bbbiozFeONyBok7jOR5NcJTlsKafYrq5d6hjwShLcs=;
 b=hdAajGgW1OfHb1c9LFBXC0i5siFVLbCc8JgHAJSjFQWrPz9y+D5N3NXX9+eJqKApEscC53
 ND4N2YNH7IYDTlkQoMF99Sdy4A/xn9ybfXusGjcpSVN24Vu4RnkbfdqTzuVDN9SPxBbD2Z
 B+1J6ATI5V1p4Rcv5r3wlHhAv+1FQ7s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-fHAIpxqZNlmyV4dW18ZGbA-1; Sat, 14 Jun 2025 06:36:31 -0400
X-MC-Unique: fHAIpxqZNlmyV4dW18ZGbA-1
X-Mimecast-MFC-AGG-ID: fHAIpxqZNlmyV4dW18ZGbA_1749897389
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso186400a91.2
 for <ltp@lists.linux.it>; Sat, 14 Jun 2025 03:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749897389; x=1750502189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bbbiozFeONyBok7jOR5NcJTlsKafYrq5d6hjwShLcs=;
 b=fsz8RLJQY1GPkKw0PKNcnuoaIB1I4+Qpxp/iuTfLmspEQ7G6j7ZuhqgOF4wF3OlU0B
 Ta2DuC8pIg6XqH1L6JmP5HZADzPcFF0feTAN99JeIJOX93tsTswAlI/4M0p4Bzh3rw50
 uEV5HNoClwt/uRISqIbTdYeY/v5zEkCSTqulnUs5auRBg3dJZz7SRCwoqp3AzuGFZpTz
 vi1fiQy/0FzKSLpwh/euRcvoHNffGa0+LCZ3Zos8s1IK3uC5ACTeV6hd5ZB79NQm05R3
 AOTS8JNq0QnJcms2wUqVCYxS2Cenp4+lJ4KpO8f+y/dypSljSXqVk+qxzFplrcWFfVWw
 i6DA==
X-Gm-Message-State: AOJu0YzunoVYLY0m/kAnFN1pVm148ctELSPNwK1s//VSVmECQ6Ll08oi
 5L0ETi4y1mhNcT+uovr/DYmWHrb62PVtPCkDosCKLSVuoUd2PLL7a6tEgG4fd6uDqYDdyLIRTEf
 qGHu/QenbbJZmZFsqQHQd+pU6rIrG9bbkljvv2nHFWQVH9H4txCASI5xQ6UiFxdumUJWEWB7Oo2
 yIcatWaaokB9Nd+bA2rsfP4s1K4TQ=
X-Gm-Gg: ASbGncsEil/D4sMEfOvJwnHqp2eX5uKh0EyUqA69CMtu23y+T12iUvpNTxg0D/oBDkP
 QzzM62IV3lWRkH2HgDSnizEnSsSxkv2hGIyQuWwUc5+OtgUXKdvYY1cqYtdU88GPzt3O/qg/moV
 6ZGhID
X-Received: by 2002:a17:90b:2e44:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-313f1d5efe4mr3717374a91.19.1749897389243; 
 Sat, 14 Jun 2025 03:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTmGQ4qgx2JriwPVph5sO6PgIZxZgEumrUH2v4MfD4xb8IpAuuY+G8eEgAq8UaMPFMBwZFU8fvkqDOu/Mx0Zw=
X-Received: by 2002:a17:90b:2e44:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-313f1d5efe4mr3717354a91.19.1749897388886; Sat, 14 Jun 2025
 03:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250606110541.220472-1-liwang@redhat.com>
 <20250606110541.220472-3-liwang@redhat.com>
 <2804439.mvXUDI8C0e@thinkpad>
In-Reply-To: <2804439.mvXUDI8C0e@thinkpad>
Date: Sat, 14 Jun 2025 18:36:15 +0800
X-Gm-Features: AX0GCFu6yNUp3-iInsDYL1S6hZTo0XAr_KQ28s1mFtr4Q6INQjYgMU82PynKcBs
Message-ID: <CAEemH2csoQCWBheCOhCEWn9BPWS12cL3RFk8gqbwrbdFq66d9Q@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3e6ybFLmZ7zHnWM47xMqvyaBnf-BlZ09b2pz7XKPEWg_1749897389
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 3/3] lib: moves test infrastructure states into
 a shared context structure
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

SGkgQXZpbmVzaCwKClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMgZmFpbHVyZSwgYWZ0ZXIgYSBk
ZWVwIGxvb2sgSSB0aGluayBpdCdzIGJlY2F1c2UKc29tZSBwYXJlbnQgcHJvY2VzcyBpcyBtaXN1
c2luZyB0aGUgdHN0X3JlaW5pdCgpIGZ1bmN0aW9uLCBjYXVzaW5nIGl0CnRvIG5vdCBmaW5kIHRo
ZSBjb3JyZWN0IG1hZ2ljIG51bWJlciBhbmQgZXZlbnR1YWxseSBicmVhayBsaWtlIGJlbG93LgoK
V2UgY2FuIGNvcnJlY3QgdGhlIGJlaGF2aW9yIG9mIHRoZXNlIHRlc3RzIHRvIHVzZSB0c3RfY2hl
Y2twb2ludF9pbml0KCkKY29ycmVjdGx5IGJlZm9yZSBjYWxsaW5nIGFueSBDSEVDS1BPSU5UIG1h
Y3Jvcy4KCkkgd2lsbCBzZW5kIGEgcGF0Y2ggdG8gZml4IGFsbCBvZiB0aGF0LgoKCk9uIEZyaSwg
SnVuIDEzLCAyMDI1IGF0IDExOjAx4oCvUE0gQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+
IHdyb3RlOgoKPiBIaSBMaSwKPgo+IFRoaXMgc2VlbXMgdG8gYmUgY2F1c2luZyBhIHJlZ3Jlc3Np
b24gd2l0aCBjb25uZWN0b3JzL3BlYyB0ZXN0Ogo+Cj4gc3VzZXRlc3Q6fi9sdHAvdGVzdGNhc2Vz
L2tlcm5lbC9jb25uZWN0b3JzL3BlYyAjIC4vY25fcGVjLnNoCj4gY25fcGVjIDEgVElORk86IFJ1
bm5pbmc6IGNuX3BlYy5zaAo+IGNuX3BlYyAxIFRJTkZPOiBUZXN0ZWQga2VybmVsOiBMaW51eCBz
dXNldGVzdCA2LjE0LjYtMi1kZWZhdWx0ICMxIFNNUAo+IFBSRUVNUFRfRFlOQU1JQyBUdWUgTWF5
IDEzIDA5OjU2OjIyIFVUQyAyMDI1IChhZDY5MTczKSB4ODZfNjQgeDg2XzY0IHg4Nl82NAo+IEdO
VS9MaW51eAo+IGNuX3BlYyAxIFRJTkZPOiBVc2luZyAvdG1wL0xUUF9jbl9wZWMuZGp0c0MzWmNz
eiBhcyB0bXBkaXIgKHRtcGZzCj4gZmlsZXN5c3RlbSkKPiBjbl9wZWMgMSBUSU5GTzogdGltZW91
dCBwZXIgcnVuIGlzIDBoIDVtIDBzCj4gY25fcGVjIDEgVElORk86IFRlc3QgcHJvY2VzcyBldmVu
dHMgY29ubmVjdG9yCj4gY25fcGVjIDEgVElORk86IFRlc3RpbmcgZm9yayBldmVudCAobmV2ZW50
cz0xMCkKPiB0c3RfdGVzdC5jOjE5OTogVERFQlVHOiBtbWFwKChuaWwpLCA0MDk2LCBQUk9UX1JF
QUQgfCBQUk9UX1dSSVRFKDMpLCAxLCA0LAo+IDApCj4gdHN0X3Rlc3QuYzoyMDM6IFRCUk9LOiBJ
bnZhbGlkIHNoYXJlZCBtZW1vcnkgcmVnaW9uIChiYWQgbWFnaWMpCj4gdHN0X3Rlc3QuYzoxOTk6
IFRERUJVRzogbW1hcCgobmlsKSwgNDA5NiwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSgzKSwgMSwg
MywKPiAwKQo+IHRzdF90ZXN0LmM6MjAzOiBUQlJPSzogSW52YWxpZCBzaGFyZWQgbWVtb3J5IHJl
Z2lvbiAoYmFkIG1hZ2ljKQo+IHRzdF90ZXN0LmM6MTk5OiBUREVCVUc6IG1tYXAoKG5pbCksIDQw
OTYsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUoMyksIDEsIDMsCj4gMCkKPiB0c3RfdGVzdC5jOjIw
MzogVEJST0s6IEludmFsaWQgc2hhcmVkIG1lbW9yeSByZWdpb24gKGJhZCBtYWdpYykKPiBjbl9w
ZWMgMSBUQlJPSzogdHN0X2NoZWNrcG9pbnQgd2FpdCAxMDAwMCAwIGZhaWxlZAo+IGNuX3BlYyAx
IFRJTkZPOiBTRUxpbnV4IGVuYWJsZWQgaW4gZW5mb3JjaW5nIG1vZGUsIHRoaXMgbWF5IGFmZmVj
dCB0ZXN0Cj4gcmVzdWx0cwo+IGNuX3BlYyAxIFRJTkZPOiBpdCBjYW4gYmUgZGlzYWJsZWQgd2l0
aCBUU1RfRElTQUJMRV9TRUxJTlVYPTEgKHJlcXVpcmVzCj4gc3VwZXIvcm9vdCkKPiBjbl9wZWMg
MSBUSU5GTzogbG9hZGVkIFNFTGludXggcHJvZmlsZXM6IG5vbmUKPgo+IFN1bW1hcnk6Cj4gcGFz
c2VkICAgMAo+IGZhaWxlZCAgIDAKPiBicm9rZW4gICAxCj4gc2tpcHBlZCAgMAo+IHdhcm5pbmdz
IDAKPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
