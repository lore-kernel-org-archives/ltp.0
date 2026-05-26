Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE67CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779832200; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=tJ0UTafQlN3He7r9+uNJGbjKvooajkRB1MPh2SkieCE=;
 b=iBVuZm//mQUc+jPtoQpRc2V8aT9K0zHMFl8HdffC+eLVBcNKgcIZQ0mdLBkOGIupsiBYt
 FcvPhHMa4N+YT22NNrhcMd6GMCIdWvOpC3Db2Z3vov5X+C1dBb+N/LlxvEHRATH7NBpjwH8
 802J+dVI7GgFTy6nBRTW21cPTH1nNVU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AC003C5AE0
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 23:50:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 600333C5AE0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C59031400BF1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779832172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5wYaq1L1xdMlQmH/s8EEsY/6Q/7a8y3lr0+Q8L8gfOw=;
 b=h6qs8QpvtZJ9HX+qX+y/wrhs/vQQu0L5dGfu6oFJPycS+Ueg1WNZGB01Xr3zLi8bfZln1a
 hfd5uB9zCAeiKw0JlSuPDPexYdQa47aerHUE4p5ZtK4LvTgLEIbzWmbEM4taUGEfnIfWIt
 vYgxi2imde109j97ZE7zG0D4MvXIa1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-onYJLPVvNrCSZTZ_Rcd6Fg-1; Tue, 26 May 2026 17:49:31 -0400
X-MC-Unique: onYJLPVvNrCSZTZ_Rcd6Fg-1
X-Mimecast-MFC-AGG-ID: onYJLPVvNrCSZTZ_Rcd6Fg_1779832170
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so6915128f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 14:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832170; x=1780436970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wYaq1L1xdMlQmH/s8EEsY/6Q/7a8y3lr0+Q8L8gfOw=;
 b=sYKloTrpoKPjgyi6PfM0X9w7VQKlNTnPdWRlv9VLZvTkmJp8we9R+FP6icM/LEic4q
 4Y62RFPGQiABmuaHjlMywYWOXEtIMr2A1zItExAs7/ZWHXuW5Y0LpSdhv+zxONRQiW/e
 fwNmksmx75QFyq3odhfGAiG5IRLO+RgZKYlMyqQRr95P3NNh2yiNWqS5/MG6byLVQ13X
 YKrprog4UzORAVxFj5NQvGQIK46NNbquL4CHfGhx4mhh0y3KC68hB6cXJwDbPFtF/4AT
 PK24AMPtiBJbH98vkK1yDKH2NdGFdfnYIpbqtPOaBs9U1AECpNb0kwuC9yQGnA6qnH8Z
 Ytdg==
X-Gm-Message-State: AOJu0YxOSYGv2IluUnYMrO8Pkf07h94k8p0y/LGyHGWQb860N0yJmH6+
 ubWstmvqi+XnRrhIrpCDN2V6DMArMGR+UxcrAIcWq60EHZwp3wGTRpt7DdK09MZzrtkP7pPjaq0
 muZQfMthhsrzbW9zJwUOw/EV2v65KxYfCLNjhXnIyl6+M95ppf5kqRF7Ho7EGfjHBSD+YqrwXKC
 4b2KZw4xooHWdYFv864p8JJ4HgLJILnfVjpk+U
X-Gm-Gg: Acq92OE3wf44VpIma/X5x4HnyM8B3JSYqi3gH8KHK3rea0utIKRhGPQxy5iYjzwv1PO
 LENqEMN9s8wC2qIkDgkZCxNUfNm1QZ4c1Bvo5NYzdLTBIHGtDLk0m2OW+4jIhwpB0zNUH1bZZar
 Oq4W3sA/fCsZ3j4v0Xr1g0FjpeoGcXJt6uJvZyWIqfI24Qi7AKNB15WCyLmRo3XIruSFLhrGAXt
 eStQJD7PaaKPlK/4JfwPMZSHWiEbvEhgfMs0XdU0aE4AcytUm4Bdhrp0AQyMqwL3SqACl24aWGH
 WIb4M3QimAmbzF7Abcw8HMv8Y95CY6By2i5cjNrqtyFXYZqRMLfKeOFf68SFiw3zRLaG4sWnS0h
 y2bfFuvU6yOi34GqoHWL/2RYyG8CqzVHpMbw7SDqDodmuM9Fcap25Jk58S505lw==
X-Received: by 2002:a05:6000:420d:b0:45e:93ec:2deb with SMTP id
 ffacd0b85a97d-45eb3697d3cmr38247264f8f.16.1779832169943; 
 Tue, 26 May 2026 14:49:29 -0700 (PDT)
X-Received: by 2002:a05:6000:420d:b0:45e:93ec:2deb with SMTP id
 ffacd0b85a97d-45eb3697d3cmr38247242f8f.16.1779832169595; 
 Tue, 26 May 2026 14:49:29 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a6cdsm1211123f8f.2.2026.05.26.14.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:49:29 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 00:49:23 +0300
Message-ID: <20260526214927.150812-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vMNJJmDKTJc8zZHYidmj0cClaI7QscOsUqRrKvvvFd8_1779832170
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SW1wcm92ZSBlcnJvciBoYW5kbGluZyBjb3ZlcmFnZSBmb3IgZnV0ZXggc3lzY2FsbHMgYnkgYWRk
aW5nIHRlc3RzCmZvciBtaXNzaW5nIGVycm9yIGNvbmRpdGlvbnMgdGhhdCB3ZXJlIHByZXZpb3Vz
bHkgdW50ZXN0ZWQuCgpmdXRleF93YWl0MDYgdmVyaWZpZXMgRUZBVUxUIGlzIHJldHVybmVkIHdo
ZW4gdWFkZHIgb3IgdGltZW91dApwb2ludHMgdG8gdW5tYXBwZWQgbWVtb3J5LgoKZnV0ZXhfd2Fp
dDA3IHZlcmlmaWVzIEVJTlRSIGlzIHJldHVybmVkIHdoZW4gZnV0ZXhfd2FpdCgpIGlzCmludGVy
cnVwdGVkIGJ5IGEgc2lnbmFsLgoKZnV0ZXhfd2FrZTA1IHZlcmlmaWVzIEVGQVVMVCBpcyByZXR1
cm5lZCB3aGVuIHVhZGRyIHBvaW50cyB0bwp1bm1hcHBlZCBvciBQUk9UX05PTkUgbWVtb3J5LgoK
ZnV0ZXhfY21wX3JlcXVldWUwMyB2ZXJpZmllcyBFRkFVTFQgaXMgcmV0dXJuZWQgd2hlbiB1YWRk
ciBvcgp1YWRkcjIgcG9pbnRzIHRvIHVubWFwcGVkIG9yIGluYWNjZXNzaWJsZSAoUFJPVF9OT05F
KSBtZW1vcnkuCgp2MTM6CiAtIEVhY2ggcnVudGVzdC9zeXNjYWxscyBlbnRyeSBpcyBub3cgaW4g
aXRzIG93biBwYXRjaCwgbm90IGFsbCBpbgogICBwYXRjaCAxLzQsIHNvIGVhY2ggcGF0Y2ggaXMg
c2VsZi1jb250YWluZWQgYW5kIGJpc2VjdC1zYWZlCiAtIGZ1dGV4X3dha2UwNTogYWRkIG1pc3Np
bmcgYmxhbmsgbGluZSBiZXR3ZWVuIHN5c3RlbSBhbmQgbG9jYWwgaW5jbHVkZXMKIC0gZnV0ZXhf
Y21wX3JlcXVldWUwMzogZml4IGNvbW1lbnQg4oCUIGdldF9mdXRleF9rZXkoKSB2YWxpZGF0ZXMg
Ym90aAogICBhZGRyZXNzZXMgYmVmb3JlIHRoZSAqdWFkZHIgPT0gdmFsIGNoZWNrLCBub3QgYWZ0
ZXIKCk1pY2hhZWwgTWVuYXNoZXJvdiAoNCk6CiAgZnV0ZXhfd2FpdDA2OiBBZGQgRUZBVUxUIGVy
cm9yIGNvdmVyYWdlIHRlc3QKICBmdXRleF93YWl0MDc6IEFkZCBFSU5UUiBlcnJvciBjb3ZlcmFn
ZSB0ZXN0CiAgZnV0ZXhfd2FrZTA1OiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdlIHRlc3QKICBm
dXRleF9jbXBfcmVxdWV1ZTAzOiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdlIHRlc3QKCiBydW50
ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4Ly5naXRpZ25vcmUgICAgfCAgNCArCiAuLi4vc3lzY2Fs
bHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUwMy5jICAgICAgfCA5OSArKysrKysrKysrKysrKysr
KysrCiAuLi4va2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dhaXQwNi5jICAgICAgfCA3NSAr
KysrKysrKysrKysrKwogLi4uL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWl0MDcuYyAg
ICAgIHwgODkgKysrKysrKysrKysrKysrKysKIC4uLi9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0
ZXhfd2FrZTA1LmMgICAgICB8IDg5ICsrKysrKysrKysrKysrKysrCiA2IGZpbGVzIGNoYW5nZWQs
IDM2MCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mdXRleC9mdXRleF9jbXBfcmVxdWV1ZTAzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dhaXQwNi5jCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWl0MDcuYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhf
d2FrZTA1LmMKCi0tIAoyLjU0LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
