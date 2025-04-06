Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B843C36010
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743908155; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=umnVlm1vz8UcAV6LzSUlo7eQUXHIF2l/3V0HbqaPSzo=;
 b=QiXrififdYsn2EJ/u8lfFTon42HqBX5f7za/fwY0XlPp+sIRBLHL26j6DKAG52wI3KpQk
 xo8QcgGdACkItRUycqY5U2XjeTRrqfpABrqpGP6KrBIyEZuadOzUjXFjnQNzmVchaFwCOO7
 AMH6A9t/M3j4Btx0vJlFOjFFxo/3Gw4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1523CB2CC
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 04:55:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A20A13C32FE
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:55:33 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2827A200398
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743908131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3IwSPoXqUjPJUNCVmvYJPuSdd18o2cDBH1SikZ7qwg=;
 b=AzAK7EDJDI8lFxnK5588fsjCSFZiOtOgmpTXTwU2SJqKKTC1b9ARZHdDzmWkkq1lBbtZ5W
 7KnfHwr93J2aiVt3vjQ4b8ehrpqferntIYfsD4mJd8xkikbGDHsmG2Wkcefv8s1U3EbQq3
 sM03FWOi2b6VCG9U3TELGnO/EVWUxTk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-a53uLOU0OkSqB0HeFLXfMQ-1; Sat, 05 Apr 2025 22:55:29 -0400
X-MC-Unique: a53uLOU0OkSqB0HeFLXfMQ-1
X-Mimecast-MFC-AGG-ID: a53uLOU0OkSqB0HeFLXfMQ_1743908129
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so446533966b.2
 for <ltp@lists.linux.it>; Sat, 05 Apr 2025 19:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743908128; x=1744512928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3IwSPoXqUjPJUNCVmvYJPuSdd18o2cDBH1SikZ7qwg=;
 b=e0b/T0pPJ7xfQy1PO8Tlxg8/RCpsXnNMzo3kD38bmBRha/8gjaGunDjv0xbYNxil0r
 LVBGb8ytI8rHZnZf/v9HkGFjhF89WkUiOvPu2FyxaJMaIl3/RI97bUZ8qf1h+KkeXABE
 r9LVZOILszoDVR/3gaFFNl7r2VSFJjEdQ0N/iogSbtCAXfIzxYUxYyik6RZ+Oxp1Wqn0
 p58vDL/7MPV6AcxrQW62Cr34o9jmdPNjU4cKpiC7TViz1nJrAOXSjl0oMYVC5N0Pn+yS
 kpEMzwASPfEZRkqAhtWH/LqG9jJgHhc2Sg6NPbNXjS9HkKMTsk7144/1XdAYiaz4e0xt
 g0wQ==
X-Gm-Message-State: AOJu0YzuCzuDsDq8MQqqn1GdfhNJSvdJdoOOyGk8N/i+vYalmfT5JuC4
 1KipdK+/5AWC8+sXvec0sr5VpTYF/dbh/XjWgvTalSbjIOZhLWIwYgF8WAoNkeP1Iq25MoKCHiR
 Lolm5ZHF0Kt+ReH+Q1P260CWJn8GxMtvrVUU66re9swXVg5UUMAxNNCEAYVE9U0s08wG7CyUKPi
 Xtgxfz7EjIwYrQOGuzvHw7LXs=
X-Gm-Gg: ASbGnctT37TXr9fYtVgl77jZucPdSj4Guhy73sOS3HOkn6d4iwpANjsrxIQEcJd+h+5
 3+QE+eDlARGZZJoEBaIjONrChad77QJyZjITzl1F4QLsQ5yuy6CjGWdiPqCiZ/A3jSV02Pyef5w
 ==
X-Received: by 2002:a17:907:7e98:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ac7d1c64effmr755673666b.49.1743908128585; 
 Sat, 05 Apr 2025 19:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9kIKH3d7QR3M/3nmHf3cbWDAitxAKYQk+QBQMDQVQudSXu0kmYiXCMn1cRJ4oeG96p6xxz04bh2SvjnO7WFI=
X-Received: by 2002:a17:907:7e98:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ac7d1c64effmr755672566b.49.1743908128224; Sat, 05 Apr 2025
 19:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250403101912.459507-1-pvorel@suse.cz>
 <20250403101912.459507-2-pvorel@suse.cz>
In-Reply-To: <20250403101912.459507-2-pvorel@suse.cz>
Date: Sun, 6 Apr 2025 10:55:15 +0800
X-Gm-Features: ATxdqUGDIkV6eNC3pKuonstzr_O3AZsX9rSQ8lWKXWDn79w1X60YKO8aajXUtdQ
Message-ID: <CAEemH2eeXdsXe61phvVDvYbHSndO2ryPpzvg_xmJQ6e4wS1c_A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dIWvMtqDEEYh5Syq9rTqYUjXBIeyZLLHdHV0fvSHOGs_1743908129
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC][PATCH 1/2] runtest/ipc: Enable named pipes on
 non-blocking IO
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

T24gVGh1LCBBcHIgMywgMjAyNSBhdCA2OjE54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBUZXN0cyB3ZXJlIGRpc2FibGVkIGZyb20gdGhlIHN0YXJ0IChlZGFiNjdi
M2EwIGluIDIwMDEpIGR1ZSBFQUdBSU4uCj4gVGVzdHMgYXJlIHdvcmtpbmcgbm93IGV2ZW4gb24g
dmVyeSBvbGQgU0xFMTItU1AzIGJhc2VkIDQuNCBrZXJuZWwsCj4gdGhlcmVmb3JlIGVuYWJsZSB0
aGVtLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KVGVz
dGVkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tLQo+ICBydW50ZXN0L2lwYyB8IDYgKystLS0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvcnVudGVzdC9pcGMgYi9ydW50ZXN0L2lwYwo+IGluZGV4IGRiN2Y3YmVkNTguLmY1Y2Rl
YTE5NzQgMTAwNjQ0Cj4gLS0tIGEvcnVudGVzdC9pcGMKPiArKysgYi9ydW50ZXN0L2lwYwo+IEBA
IC00LDEwICs0LDkgQEAKPiAgcGlwZWlvXzEgcGlwZWlvIC1UIHBpcGVpb18xIC1jIDUgLXMgNDA5
MCAtaSAxMDAgLWIgLWYgeDgwCj4gICMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAwIGNo
dW5rcyBvZiA0MDkwIGJ5dGVzIHRvIGEgbmFtZWQgcGlwZQo+ICAjIHVzaW5nIGJsb2NraW5nIEkv
Two+IC0jcGlwZWlvXzIgcGlwZWlvIC1UIHBpcGVpb18yIC1jIDUgLXMgNDA5MCAtaSAxMDAgLWYg
eDgwCj4gK3BpcGVpb18yIHBpcGVpbyAtVCBwaXBlaW9fMiAtYyA1IC1zIDQwOTAgLWkgMTAwIC1m
IHg4MAo+ICAjIHNwYXducyA1IGNoaWxkcmVuIHRvIHdyaXRlIDEwMCBjaHVua3Mgb2YgNDA5MCBi
eXRlcyB0byBhIG5hbWVkIHBpcGUKPiAgIyB1c2luZyBub24tYmxvY2tpbmcgSS9PCj4gLSMgVGhp
cyB0ZXN0IGhpdHMgRUFHQUlOLCB3aGljaCBwaXBlaW8gZG9lc24ndCBoYW5kbGUgYXQgdGhlIG1v
bWVudAo+ICBwaXBlaW9fMyBwaXBlaW8gLVQgcGlwZWlvXzMgLWMgNSAtcyA0MDkwIC1pIDEwMCAt
dSAtYiAtZiB4ODAKPiAgIyBzcGF3bnMgNSBjaGlsZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9m
IDQwOTAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gICMgdXNpbmcgYmxvY2tpbmcgSS9PCj4g
QEAgLTIwLDEwICsxOSw5IEBAIHBpcGVpb181IHBpcGVpbyAtVCBwaXBlaW9fNSAtYyA1IC1zIDUw
MDAgLWkgMTAgLWIgLWYgeDgwCj4gIHBpcGVpb182IHBpcGVpbyAtVCBwaXBlaW9fNiAtYyA1IC1z
IDUwMDAgLWkgMTAgLWIgLXUgLWYgeDgwCj4gICMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUg
MTAgY2h1bmtzIG9mIDUwMDAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gICMgdXNpbmcgYmxv
Y2tpbmcgSS9PCj4gLSNwaXBlaW9fNyBwaXBlaW8gLVQgcGlwZWlvXzcgLWMgNSAtcyA1MDAwIC1p
IDEwIC1mIHg4MAo+ICtwaXBlaW9fNyBwaXBlaW8gLVQgcGlwZWlvXzcgLWMgNSAtcyA1MDAwIC1p
IDEwIC1mIHg4MAo+ICAjIHNwYXducyA1IGNoaWxkcmVuIHRvIHdyaXRlIDEwIGNodW5rcyBvZiA1
MDAwIGJ5dGVzIHRvIGEgbmFtZWQgcGlwZQo+ICAjIHVzaW5nIG5vbi1ibG9ja2luZyBJL08KPiAt
IyBUaGlzIHRlc3QgaGl0cyBFQUdBSU4sIHdoaWNoIHBpcGVpbyBkb2Vzbid0IGhhbmRsZSBhdCB0
aGUgbW9tZW50Cj4gIHBpcGVpb184IHBpcGVpbyAtVCBwaXBlaW9fOCAtYyA1IC1zIDUwMDAgLWkg
MTAgLXUgLWYgeDgwCj4gICMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9m
IDUwMDAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gICMgdXNpbmcgbm9uLWJsb2NraW5nIEkv
Two+IC0tCj4gMi40OS4wCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
