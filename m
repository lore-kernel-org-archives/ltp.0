Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4EC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 08:30:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A293CD8A8
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 09:30:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D9223CB7FD
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:29:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.145.221.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 15F24200BBC
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678350591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoMFDB/UuC+Rz4e/jt6DJju8j/eRxuSe3Rh3WajnoZ8=;
 b=HxJO1gyq/L89LD+CzT1ryxyzKYt26pXK7tho2sv2k7Yugh5fyRkNepabQNQgGJrSToZkJA
 Eb+4FebIg6h9rAeOcHVqiQV97xsKQaK89SAEhbUVcVQ81I9xxhppnV+tVR3jEOCeXe9A7Q
 QdjvJe/M7+HT3+3GTEGVFnNRgbyHxHI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BNDSR_piMk6QBZmRXoVElQ-1; Thu, 09 Mar 2023 03:29:49 -0500
X-MC-Unique: BNDSR_piMk6QBZmRXoVElQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 z6-20020a7bc7c6000000b003e0107732f4so390781wmk.1
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 00:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678350588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CoMFDB/UuC+Rz4e/jt6DJju8j/eRxuSe3Rh3WajnoZ8=;
 b=RYj69R7nBFPmVbbZ/xn/TM27oP/PF9R23ud2R0ZOVHG1+2PcZuAZ3odIrMucJhvD2y
 vS/G6RV8kuyoudvlBC3uv6DjfwVSrdAifqC193QOdIT2m8ZBPqNM5uz8qUUWZL7ty38I
 G6DmZNvB3uGhXW3ddMAq4AZjkHPu+/okTosGTAm10DL9oBBEJTH4Xc0AggmGRH6lxcje
 uzxPWF+XNkzc73p6T/55fnqJEUs+63qanGyIV/yLFukHtrjvzQoMkezxIUafeYTsbH/y
 s1lH97SL4zg9UtUnaB9XWnwroXxCBFNHZCBex/x1OWZTCPO0CqUYug0ARnO9R5KOS4Lc
 7HCQ==
X-Gm-Message-State: AO0yUKWI1MQxTbmfZ2Lx0hqzquHW4VNlK2ECBX4E94QeeMZ7giZvUqfc
 OOUPT5A16+vAKllUGA2lhsU8mbOjpRZiC7RPOJ5Q85oGMStMOU2DDqAb3iQ3ttQq47C+ynBYwLA
 hF0kPAiEdsuYb/UF4JofxWZIOHXQ=
X-Received: by 2002:a05:600c:54c4:b0:3e0:f40:f720 with SMTP id
 iw4-20020a05600c54c400b003e00f40f720mr4535570wmb.8.1678350588418; 
 Thu, 09 Mar 2023 00:29:48 -0800 (PST)
X-Google-Smtp-Source: AK7set8udBlQig1h62fOOLDgmtj4I9CB7/Keh3UUKUu6TeGv3WYhmcEHXkJWDTirYwcOH0UBoAM13JXtQx5CFkjJRT8=
X-Received: by 2002:a05:600c:54c4:b0:3e0:f40:f720 with SMTP id
 iw4-20020a05600c54c400b003e00f40f720mr4535565wmb.8.1678350588171; Thu, 09 Mar
 2023 00:29:48 -0800 (PST)
MIME-Version: 1.0
References: <ZAha6JdEJSoKUkyQ@yuki>
In-Reply-To: <ZAha6JdEJSoKUkyQ@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Mar 2023 16:29:37 +0800
Message-ID: <CAEemH2dceLbx9Jr2CQawFeeWug2_zaYb8WGXX9fP_CKSELmvHQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] hugemmap24 failure on aarch64 with 512MB hugepages
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

W0NjJ2luZyBKYW4gU3RhbmNla10KCk9uIFdlZCwgTWFyIDgsIDIwMjMgYXQgNTo1MeKAr1BNIEN5
cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gTG9va3MgbGlrZSB0
aGUgaHVnZW1tYXAyNCB0ZXN0IGZhaWxzIG9uIGFhcmNoNjQgd2l0aCA1MTJNQiBodWdlcGFnZXMK
PiBzaW5jZSBpdCBhdHRlbXB0cyB0byBNQVBfRklYRUQgYXQgTlVMTCBhZGRyZXNzLCBhbnkgaWRl
YSB3aHkgYWFyY2g2NCBpcwo+IGxpbWl0ZWQgdG8gMHgxMDAwMDAwMCBhcyBzbGljZSBib3VuZGFy
eT8KPgoKSXQgbG9va3MgbGlrZSBhIGdlbmVyaWMvcmFuZG9tIHNsaWNlX2JvdW5kYXJ5IHRoYXQg
dHJpZXMgYXMgYQpiYXNpYyBnYXAgYmV0d2VlbiB0d28gYXZhaWxhYmxlIGZyZWUgbmVpZ2hib3Ig
c2xpY2VzLgoKaHR0cHM6Ly9naXRodWIuY29tL2xpYmh1Z2V0bGJmcy9saWJodWdldGxiZnMvY29t
bWl0LzhlZTI0NjJmM2Y2ZWVhNzIwNjc2NDFhMTk3MjE0NjEwNDQzNTc2YjgKaHR0cHM6Ly9naXRo
dWIuY29tL2xpYmh1Z2V0bGJmcy9saWJodWdldGxiZnMvY29tbWl0LzM5OWNkYTU3ODU2NGJjZDUy
NTUzYWI4ODgyN2E4MjQ4MWI0MDM0ZDEKCkkgZ3Vlc3MgaXQgZG9lc24ndCBtYXR0ZXIganVzdCB0
byBpbmNyZWFzZSB0aGUgc2l6ZSBvZiB0aGUgYm91bmRhcnkuCm9yLCB3ZSBjYW4gc2tpcCB0ZXN0
aW5nIG9uIGEgYmlnIHBhZ2Utc2l6ZSBzeXN0ZW0gbGlrZSBhYXJjaDY0KHdpdGggNTEyTUIpCmlm
IHVuYWJsZSB0byBmaW5kIHRoZSBmcmVlIHNsaWNlcy4KClRlc3QgcGFzc2VkIGZyb20gbXkgc2lk
ZSB3aXRoIHBhdGNoOgoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDI0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDI0LmMKQEAgLTM3LDcgKzM3LDcgQEAgc3RhdGljIGludCBpbml0X3NsaWNlX2Jv
dW5kYXJ5KGludCBmZCkKICNlbHNlCiAgICAgICAgLyogcG93ZXJwYzogMjU2TUIgc2xpY2VzIHVw
IHRvIDRHQiAqLwogICAgICAgIHNsaWNlX2JvdW5kYXJ5ID0gMHgwMDAwMDAwMDsKLSAgICAgICBz
bGljZV9zaXplID0gMHgxMDAwMDAwMDsKKyAgICAgICBzbGljZV9zaXplID0gMHgxMDAwMDAwMDA7
CiAjZW5kaWYKCiAgICAgICAgLyogZHVtbXkgbWFsbG9jIHNvIHdlIGtub3cgd2hlcmUgaXMgaGVh
cCAqLwoKCgo+Cj4gU2VlOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0
cC9pc3N1ZXMvMTAyMgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgo+
IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
