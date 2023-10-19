Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B305CDB482
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 05:42:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550413C84F2
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 07:42:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E383C84F2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 07:42:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C383600D2F
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 07:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697694139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMAmMrzPZvq60GB1LOdBxUZ4GXfS9IfBEjTW+Rzik5A=;
 b=D48mrcnEnofed+6a+RMStF1U6krTBDn/DS8pytypW0JlVGqMPedGS6UYTOZSNHVBYz4cfw
 oO0nkdEOSxm3//81opt2zkUa/VlSdhhLn5RaWS2bb7TPLnMlOMfkdfVS30ipvatPxVeSf/
 DYiwvVEoc3C8UzW7Q4mp/WBYFq47MrM=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-cUkMUCAFOUu3aPFvAEhTpA-1; Thu, 19 Oct 2023 01:42:18 -0400
X-MC-Unique: cUkMUCAFOUu3aPFvAEhTpA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-457c9dc1ae6so427946137.0
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 22:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697694137; x=1698298937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMAmMrzPZvq60GB1LOdBxUZ4GXfS9IfBEjTW+Rzik5A=;
 b=BJl7+0iZz5SEyhlErvWdN2FLQdtRpp5D3r+79hyRsRYXbF3kP5jUDyxs4fUzQGC5ku
 +e3p1EvM3ZFq5rAfG0O8VyhzuL/go/AvhxB0DjKLK79ImrdE41zYPDVK1TOGz7gaE7jX
 jELffEdWr4+LrRQ5m3CDb6qhcYbMMEc4OAnrUNOewXfaZBA6XdLaEn1G4HdTAsCspZ+p
 vC/445Pyv0/OX+e/4jmJlAWAOsbcHwRZaClT3r2MPZ4mqBFdgTOrbc2a/bQ5H3Ql6kBH
 egPFbkEBdxtAS71wK914DfdzrQteSDrEl3xqq5XqYcAHrWh4qwQPohWTKqW/EF/DkQY0
 oWAQ==
X-Gm-Message-State: AOJu0YwxvwBE7F3+XoNiDJNScPVWiBW/0aDlyzYjobkRe29e5b1P/ydj
 2QsElv6jcGkczRYuTXNj/zzR1t1IRjh82XiWPAQonBAkoXDTlOav7q3FbKojbGVwNkTN+F8wJlx
 iMEErCdWQOnIz1ZOlDNECcWRGay8=
X-Received: by 2002:a67:e7c5:0:b0:44e:837a:25e with SMTP id
 hy5-20020a67e7c5000000b0044e837a025emr325658vsb.11.1697694137628; 
 Wed, 18 Oct 2023 22:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWHBooU7JSswlzxeupooyK5m67HmiA6gTGHVn8OID7Egbn+sWgGnNkbuScqoEnYNMPqFztTmHcTOte4PiNxP4=
X-Received: by 2002:a67:e7c5:0:b0:44e:837a:25e with SMTP id
 hy5-20020a67e7c5000000b0044e837a025emr325654vsb.11.1697694137363; Wed, 18 Oct
 2023 22:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230904125424.4011-1-andrea.cervesato@suse.de>
In-Reply-To: <20230904125424.4011-1-andrea.cervesato@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 Oct 2023 07:42:51 +0200
Message-ID: <CAASaF6zuwMYGZApTd_YCfuQ049e9uor3ONDdfJ9URHqKkP_2=Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Check swap availability in process_madvise01
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

T24gTW9uLCBTZXAgNCwgMjAyMyBhdCAyOjU04oCvUE0gQW5kcmVhIENlcnZlc2F0bwo8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmRlPiB3cm90ZToKPgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICAuLi4va2VybmVsL3N5c2Nh
bGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2UwMS5jICAgICAgfCA1ICsrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2UwMS5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNl
MDEuYwo+IGluZGV4IDIwN2RjMDI4ZS4uMzIyYjRjZjYwIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21h
ZHZpc2UwMS5jCj4gQEAgLTEyMyw0ICsxMjMsOSBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRl
c3QgPSB7Cj4gICAgICAgICAubWluX2t2ZXIgPSAiNS4xMCIsCj4gICAgICAgICAubmVlZHNfY2hl
Y2twb2ludHMgPSAxLAo+ICAgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ICsgICAgICAgLm1pbl9z
d2FwX2F2YWlsID0gTUVNX0NISUxEIC8gVFNUX0tCLAoKU2hvdWxkIHRoaXMgYmUgTUVNX0NISUxE
IC8gVFNUX01CID8gVGhlIGNvbW1lbnQgaW4gaW5jbHVkZS90c3RfdGVzdC5oCnNheXMgIk1pbmlt
dW0gc2l6ZShNQikgb2YgU3dhcEZyZWUiCgo+ICsgICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNv
bnN0IGNoYXIgKltdKSB7Cj4gKyAgICAgICAgICAgICAgICJDT05GSUdfU1dBUD15IiwKPiArICAg
ICAgICAgICAgICAgTlVMTAo+ICsgICAgICAgfSwKPiAgfTsKPiAtLQo+IDIuMzUuMwo+Cj4KPiAt
LQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
