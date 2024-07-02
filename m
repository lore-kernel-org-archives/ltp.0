Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1DAC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:35:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95023D3ED0
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:35:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2513D0F6E
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:34:53 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EED9C1002899
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719927290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AgIOt9e4pU2aGBUF2lquh2+7wB3oHV4MVKRPxokQbA=;
 b=C6LJ4jjBtgwwOv84+nquTDuZSXjAYnUsUb8xv8jzU83pXgzULkL4vwYWUCAFEGa8VLyQ3+
 6bF7/8F+PrlXOoTgsu+AbeDIx4/Z+vru7eC/iR7m73p1yrdvf8oVyTTD8j+JZWE7vWkgy4
 N8PJPsgWLHNuYNydJ+R/WYVimcFsHxQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-gjCNvSiqMn-G1DB6-ohmxQ-1; Tue, 02 Jul 2024 09:34:47 -0400
X-MC-Unique: gjCNvSiqMn-G1DB6-ohmxQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c7a6c639bfso3806601a91.3
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 06:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927286; x=1720532086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9AgIOt9e4pU2aGBUF2lquh2+7wB3oHV4MVKRPxokQbA=;
 b=jGICJsq3JAZWNABcEtFposTlvklrXpe5Y1+omtYEoQJW9b+aUA9WFM9sSV4FHeIlKz
 g/SI8a2q19fCqhXbXWZ2AcunkNsbbr0eVHcLUcjmwDYZTZoujJMuEFBvtk2lLrh085MJ
 NKAmvHZVPRXzr0kg3V8LsysV/1farZGN/1Fd+YEeT+9IEDRNue6bBLH4/Yx9yfXjCTWs
 TJ/mLdwp3cpluVpVIq0mUsmDnsAn4wF49w43m+jg78qX8ZGn0y3Pt2IzbL/SEtSdssxB
 NOOon3Jt8zWpY+Y0lP5xY19Qztg8BNdLYC1cFVTa0g4FZ0695UOA04DKe3YE2e6aZpp3
 ledw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAPPjBuElAMwTwpLDk3ZcAn7OfT2wy5E7f+h+zLMRY8HeS/wVrJTQPSbQKssRqY8vB+0kIzrDGpF/ASxCXiJC8a0k=
X-Gm-Message-State: AOJu0YzGPM8aTkF4YR0JB5Z61oAVgy6Hdm02mb5nAmTZigQOJM1dT0uA
 mwvSwnAW1Oi4A7oi46dD08HDojpG3lEoeyHSAsJ5yAS2AAVq5EGT4sbKt8OxzrX9/8dNDzRQ+k0
 0F6pCe6gv/mC3twH5YjQNaeGwG0G8y2oKjQSZoBZ0+Gkv/L0qjdn5kk68UjSQeo3Dr8Ba/DJot2
 0cYDbjJRKjpO6fbvJR4otns4Eu+ckbpHCJ27qi
X-Received: by 2002:a17:90a:d70b:b0:2c2:d8d7:bf65 with SMTP id
 98e67ed59e1d1-2c93d6d72famr6510926a91.7.1719927286099; 
 Tue, 02 Jul 2024 06:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE57kkImqJhABQiCNVUceeN9van85iQBIjHFQ0g9sJu09gB/CL74gejkBb1oKihqXg8Ogtk5/SvjsQQtMIocSs=
X-Received: by 2002:a17:90a:d70b:b0:2c2:d8d7:bf65 with SMTP id
 98e67ed59e1d1-2c93d6d72famr6510912a91.7.1719927285735; Tue, 02 Jul 2024
 06:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240702094745.96521-1-liwang@redhat.com>
 <20240702.Auya5Chaipho@digikod.net>
In-Reply-To: <20240702.Auya5Chaipho@digikod.net>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 21:34:33 +0800
Message-ID: <CAEemH2foX0KqS7OemqGbt0xj5iSbtzpcnTxvBAaJzr9JPKx71g@mail.gmail.com>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
 Andrea Cervesato <acervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] landlock: fix minimal required size for
 landlock_ruleset_attr copying
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it,
 paul@paul-moore.com, gnoack@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgMiwgMjAyNCBhdCA5OjAw4oCvUE0gTWlja2HDq2wgU2FsYcO8biA8bWljQGRp
Z2lrb2QubmV0PiB3cm90ZToKCj4gT24gVHVlLCBKdWwgMDIsIDIwMjQgYXQgMDU6NDc6NDVQTSAr
MDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+IEFzIGtlcm5lbCBjb21taXQgZmZmNjlmYjAzZGRlICgi
bGFuZGxvY2s6IFN1cHBvcnQgbmV0d29yayBydWxlcyB3aXRoIFRDUAo+IGJpbmQgYW5kIGNvbm5l
Y3QiKQo+ID4gaW50cm9kdWNpbmcgYSBuZXcgZmllbGQgJ2hhbmRsZWRfYWNjZXNzX25ldCcgaW4g
dGhlIHN0cnVjdHVyZQo+IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciwKPiA+IGJ1dCBpbiB0aGUgbGFu
ZGxvY2tfY3JlYXRlX3J1bGVzZXQoKSBpdCBzdGlsbCB1c2VzIHRoZSBmaXJzdCBmaWVsZAo+ICdo
YW5kbGVkX2FjY2Vzc19mcycKPiA+IHRvIGNhbGN1bGF0ZSBtaW5pbWFsIHNpemUsIHNvIHRoYXQg
bWFkZSBkZWNyZWFzZSAxIGlzIHVzZWxlc3MgaW4gTFRQCj4gbGFuZGxvY2swMS5jIHRvCj4gPiB0
ZXN0IHRoZSB0b28tc21hbGwtc2l6ZS4KPiA+Cj4gPiBUZXN0IGNvZGU6Cj4gPiAgICBydWxlX3Nt
YWxsX3NpemUgPSBzaXplb2Yoc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cikgLSAxOwo+ID4g
ICAgdHN0X3N5c2NhbGwoX19OUl9sYW5kbG9ja19jcmVhdGVfcnVsZXNldCwgLi4uLCBydWxlX3Nt
YWxsX3NpemUsIDApCj4gPgo+ID4gUmVzdWx0Ogo+ID4gICBsYW5kbG9jazAxLmM6NDk6IFRGQUlM
OiBTaXplIGlzIHRvbyBzbWFsbCBleHBlY3RlZCBFSU5WQUw6IEVOT01TRyAoNDIpCj4KPiBJbnRl
cmVzdGluZywgdGhpcyBsb29rcyBsaWtlIGEgYnVnIGluIHRoZXNlIExUUCB0ZXN0cy4KPgoKWWVz
LCBBbmRyZWEgZHJhZnRlZCBhIHNlcmllcyBvZiBsYW5kbG9jayB0ZXN0cyBmb3IgTFRQLgoKRllJ
IC0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9zZXJpZXM9
JnN1Ym1pdHRlcj0mc3RhdGU9JnE9bGFuZGxvY2smYXJjaGl2ZT0mZGVsZWdhdGU9CgoKCj4KPiA+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IENjOiBN
aWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+Cj4gPiBDYzogS29uc3RhbnRpbiBNZXNr
aGlkemUgPGtvbnN0YW50aW4ubWVza2hpZHplQGh1YXdlaS5jb20+Cj4gPiBDYzogUGF1bCBNb29y
ZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KPiA+IC0tLQo+ID4KPiA+IE5vdGVzOgo+ID4gICAgIEhp
IE1pY2thZWwsCj4gPiAgICAgICAgSSdtIG5vdCBxdWl0ZSBzdXJlIGlmIHRoYXQgaXMgb24gcHVy
cG9zZSB0byB1c2UgdGhlIGZpcnN0IGZpZWxkCj4gb3Iga2VybmVsCj4gPiAgICAgICAgYnVnLCBj
YW4geW91IHRha2UgYSBsb29rPwo+Cj4gSGkgTGksCj4KPiBZZXMgdGhpcyBpcyBvbiBwdXJwb3Nl
LiAgVGhlIGhhbmRsZWRfYWNjZXNzX2ZzIG1pbmltYWwgc2l6ZSBjaGVjayBzaG91bGQKPiBuZXZl
ciBjaGFuZ2UgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgcmVhc29uLiAgVXNlciBzcGFjZSBi
dWlsdCB3aXRoCj4gb2xkIGhlYWRlcnMgbXVzdCBzdGlsbCB3b3JrIHdpdGggbmV3IGtlcm5lbHMu
ICBUaGlzIGlzIHRlc3RlZCB3aXRoIHRoZQo+ICJpbmNvbnNpc3RlbnRfYXR0ciIgdGVzdCBpbiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9iYXNlX3Rlc3QuYwo+CgpUaGFua3MgZm9y
IHRoZSBjb25maXJtYXRpb24sIHZlcnkgaGVscGZ1bC4KCkBBbmRyZWEgQ2VydmVzYXRvIDxhY2Vy
dmVzYXRvQHN1c2UuZGU+LCBzZWVtcyB3ZSBoYXZlIHRvIGFkanVzdCB0aGUgdGVzdCB0bwp1c2Ug
YSByZWFsIHNtYWxsCnJ1bGUgc2l6ZSB3aGljaCBpcyBhdCBsZWFzdCBzbWFsbCB0aGFuIHNpemVv
ZihfX3U2NCkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
