Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AFBCD8CA8
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781008901; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/CXd11X5ENKEmpMggflmb8mEsED9ZT6rdSFORrIJMiw=;
 b=hIwf/P6PTIk1SQVILTEEHmxP1r4ptLjWlKzJ1//d+Nx2H4Qf5386xNdhTW/H6QcPLEYqb
 CMcvpPfm/3Sf0Yj8lE+jWVtPsQMPGlZ81YO58p0O90luoFi6xdJSC5GZTum6VLuhdQ4DxEZ
 EZfsoKcLxxAQAz5CLXfuaf6tj08IhC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D53E43E4E71
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:41:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CCF33C1C6B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:41:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD772600941
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781008878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBQ4DCFYI4EiR9KYTiOPM+C9DEMadGJZYYJrNklQDBw=;
 b=bMPD5wNZu2uhJu1hK7cQLkbY9Z3/9RlGkTaXCHjIacokki9C4i2EuMciw+kLcqYtP9i7Gq
 Nj1eOcIxbbGLgn9NT/T//eJXQ4qm9jGo1+pzK6K7x0UhPJTjGFBhngydLwskfI4d89nEg+
 DLWxzgvfkBQxjRfdbdnDWI7G+i8iC3A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-WbQxcAauPNWUEUlJhwVToA-1; Tue, 09 Jun 2026 08:41:16 -0400
X-MC-Unique: WbQxcAauPNWUEUlJhwVToA-1
X-Mimecast-MFC-AGG-ID: WbQxcAauPNWUEUlJhwVToA_1781008875
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so3230197f8f.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 05:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008875; x=1781613675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tBQ4DCFYI4EiR9KYTiOPM+C9DEMadGJZYYJrNklQDBw=;
 b=NNZ89Op3AP055ULFDxOZ8Wqd4/tGn4Qgo17nlqfBnyEgfXztwtm9JKmOYIJpqD46Jv
 WVAgmgq9JLc2WuYT2IGB/pzhxd27ntBmyhGPbuGaFKtTQxGOsjIU/MMuRmTULiAu1F/W
 tD58iEagehzRTpqKFK1DZ0aDnnxyGG6eZZU55vYAkXYGPoNw4pnUs8vRwG6+xCSD+CoT
 VfVc9nwpEehuB85gmnRu0JtOhzx11grYi0kbZAVPhBIkxDgYZvpD85KW3SLTFNkwNFKW
 sho9O+idfWkNAiVyAm+7qErXkGgw02sqbJvuoviissduK76lPkwYCZweD7npsqkz32TI
 YE0w==
X-Gm-Message-State: AOJu0YzMLCB0YG5LWIhaG1vuxm77L3/bVd5+Yw2Zux3+d5F7IoirAbKf
 x6X/9ROsQuLtJUfw8z/tYQEijlKHQF4PIk+nLBVo56FFzuPZ/itiPFjZJ2f6Ujxw3ziCpzeU2mQ
 ayTdf9h7283abgNfGgSeSn2VBTA21perZZIsI9GsipKmechwSNu1xPMNNnBALfUK0sSN1Zv2z81
 qyiecVRBnNIZ4LqL3foFNV6Gln/sc=
X-Gm-Gg: Acq92OELhb3jYqHscFipmlHRqQSZxhXjGg7TlGsUzab1yjouu38Aw0H7SE5YfOKm6xg
 O3FSjtEURk/dvFa0FJWl6EUlcePs0JMNJhGKCfBQ5xvV+TZVpsSAOfQjgdEuS8+UJcAcRAe5l20
 QU/qk3AR6eY//YCY1AwHm5LpoEiSx3yHZiVfrY7/RobjqaY7v+a+loAxh8qUYi/Df4T+FSGj5/b
 GL4GkIxeG1HnNw=
X-Received: by 2002:a05:6000:2888:b0:460:3233:beec with SMTP id
 ffacd0b85a97d-460566db54fmr3529236f8f.40.1781008875324; 
 Tue, 09 Jun 2026 05:41:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:460:3233:beec with SMTP id
 ffacd0b85a97d-460566db54fmr3529199f8f.40.1781008874901; Tue, 09 Jun 2026
 05:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
In-Reply-To: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
Date: Tue, 9 Jun 2026 14:40:58 +0200
X-Gm-Features: AVVi8CeH-PVuK2yT9wR8upiZJuzzZDTZj2avq2wHGKHiAs2nxdg04KXWMP_O9G4
Message-ID: <CAASaF6x20BQuu3mhTRgQ=rQqQaWosPqbCCfJf5OCTUK+rh-q_w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rCkAfdMy7YavzpGTlqIdU6qPNy9wuootBFDU5haGirg_1781008875
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: remove needs_checkpoints leftover
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gOSwgMjAyNiBhdCAxMTo1OeKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cj4KPiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxh
bmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KCkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8
anN0YW5jZWtAcmVkaGF0LmNvbT4KCj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
Y2xvbmUvY2xvbmUxMC5jIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTEwLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMTAuYwo+IGluZGV4IDk2ZGU4
MTFhZDA3OWFhZDA1ZDIwMTRkOWJjNWFmYzVjMjJjYTcwNzcuLmQxZTNhZTExYzVlMjkzOWJkMWFj
MmVlN2Y2OTY3NDM2M2ZiMDdkZDIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9jbG9uZS9jbG9uZTEwLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Ns
b25lL2Nsb25lMTAuYwo+IEBAIC04OCw3ICs4OCw2IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnNldHVwID0g
c2V0dXAsCj4gICAgICAgICAuY2xlYW51cCA9IGNsZWFudXAsCj4gLSAgICAgICAubmVlZHNfY2hl
Y2twb2ludHMgPSAxLAo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3RscywKPiAgICAgICAg
IC5zdXBwb3J0ZWRfYXJjaHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsKPiAgICAgICAgICAg
ICAgICAgIng4Nl82NCIsCj4KPiAtLS0KPiBiYXNlLWNvbW1pdDogMWVmYjRiYjhlYjRhODU4MjI4
NGE5MGE3MGNhMmFkYzIyYzRlNDdiMAo+IGNoYW5nZS1pZDogMjAyNjA2MDktY2xvbmUxMF9yZW1v
dmVfY2hlY2twb2ludF9sZWZ0b3Zlci1kYTIwNGM5Y2FkY2MKPgo+IEJlc3QgcmVnYXJkcywKPiAt
LQo+IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
