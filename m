Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD4FC77B7A
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 00:49:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18983CFC85
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 02:49:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B32E23CF442
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 02:49:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCF746000BE
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 02:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685666958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ywl1g+sEudUzkOR7bHGxodSm7QKfKQOEah9d7t/UfSM=;
 b=Df5mERBM3TfXLQaZXumUkYpknQYZA6b0MAK0yqdeLy2PUEXw/BWBIedUc5lTCv0FWJP7Oz
 Z7mw9N/+EZm6HwMZ8tYSZMXhlFaeu9CYfsDfCEYSrf0HmulMIuQF7bDRMdyc6Xu3nh39bJ
 vNMiLat9jDci/l1R/x9gyut1HOmpT1M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-M6p10PqjPoCRIa5W9NRqxQ-1; Thu, 01 Jun 2023 20:49:16 -0400
X-MC-Unique: M6p10PqjPoCRIa5W9NRqxQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af570dc8daso12429421fa.2
 for <ltp@lists.linux.it>; Thu, 01 Jun 2023 17:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685666955; x=1688258955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ywl1g+sEudUzkOR7bHGxodSm7QKfKQOEah9d7t/UfSM=;
 b=HrMp/cXwMybuc5noaQ0AU62aD76RfbqKz+5WZpmouffvky1GddfU3+dLRdV+coljOh
 FXrKUp5n1IkGSmdWnO4lbQVTFTxEISJqOsqELjC9+O8bzUEjLwEqeyON+UrRXhJkI1cj
 7QqCLdoESj6LtyjWXDF8sVNvhavXkIr4Y728FKiZxAbnyIu+51MOSFU0pde9Mtw0Z2Zz
 HGNGQkVHpLMFUeTh4CPGcjPDghKPkyyEemq6rHkSdovyf9OjRr1nRb4shrfK8WlNb7Wi
 hDee+WfKL1wfXwgOTUwgdtTNp/rlmiB0kOdTth+PQNmY+CA/mj/mrdy9+p0OFLKOKtzX
 d6dQ==
X-Gm-Message-State: AC+VfDznoF5JVjU9Ol5YwlcHHeH1oYL5fRusfQvot06w/4cJmXcrmEtc
 lkwN333fbGyNng+I2B5Mv2LIaQHiBsSlRHKgiBhOqywwh88441fCaowdTVGUQx+YIJU46CONqxl
 VIpJblYa1wFlAIDwwMN00oo1+6CA=
X-Received: by 2002:a2e:98ca:0:b0:2b0:6fca:ad16 with SMTP id
 s10-20020a2e98ca000000b002b06fcaad16mr594668ljj.51.1685666955021; 
 Thu, 01 Jun 2023 17:49:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qVAuXdjAF2GyaROkSYCol0Y5xjneuxygbJo4XLzwepzsp2yvtW8cVapyVxroZy0skMNW/VY4RYMjoYQikX94=
X-Received: by 2002:a2e:98ca:0:b0:2b0:6fca:ad16 with SMTP id
 s10-20020a2e98ca000000b002b06fcaad16mr594666ljj.51.1685666954711; Thu, 01 Jun
 2023 17:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
 <20230601091614.53228-1-liwang@redhat.com>
 <3482c8d1-4113-eac2-6eda-cc1bcc59b367@suse.cz>
In-Reply-To: <3482c8d1-4113-eac2-6eda-cc1bcc59b367@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Jun 2023 08:49:03 +0800
Message-ID: <CAEemH2dFgks7biRyZR9b-GOWa9Mm0ckAiZjcHuo3oM-1GTJAog@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] shmget02: reduce the shmmax test value in
 compat mode
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Manfred Spraul <manfred@colorfullife.com>, Arnd Bergmann <arnd@arndb.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCAxMDo1MeKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpLAo+IHRoaXMgbG9va3MgZ29vZCwganVzdCBvbmUgbWlub3Ig
bm90ZSBhdCB0aGUgZW5kLgo+Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4KPgo+IE9uIDAxLiAwNi4gMjMgMTE6MTYsIExpIFdhbmcgd3JvdGU6Cj4gPiBBcyBB
cm5kIEJlcmdtYW5uIHBvaW50ZWQgb3V0IHRoYXQgU0hNTUFYIGJlaW5nIGRlZmluZWQgYXMKPiA+
IChVTE9OR19NQVggLSAoMVVMIDw8IDI0KSksIHNvIHRoZSBrZXJuZWwgd291bGQgbGlrZWx5IHVz
ZQo+ID4gYSBsYXJnZSA2NC1iaXQgdmFsdWUsIHdoaWxlIHRoZSAzMi1iaXQgdXNlciBzcGFjZSB1
c2VzIGEKPiA+IG11Y2ggc21hbGxlciBsaW1pdC4KPiA+Cj4gPiBJdCBmaW5hbGx5IHJlc3VsdHMg
aW4gRU5PTUVNIGZhaWx1cmU6Cj4gPiAgICBzaG1nZXQwMi5jOjk1OiBURkFJTDogc2htZ2V0KDE2
NDQxOTk4MjYsIDQyNzgxOTAwODAsIDE1MzYpCj4gPiAgICAgICAgICAgICAgICAgICBleHBlY3Rl
ZCBFSU5WQUw6IEVOT01FTSAoMTIpCj4gPgo+ID4gV2l0aCBzdWdnZXN0IGJ5IE1hbmZyZWQgU3By
YXVsIHdlIGNvdWxkIHJlZHVjZSB0aGUgdmFsdWUKPiA+IG9mICcvcHJvYy9zeXMva2VybmVsL3No
bW1heCcgaW4gY29tcGF0IG1vZGUgYW5kIG9ubHkgdGVzdAo+ID4gdGhlIG92ZXJmbG93IGJlaGF2
aW9yIHdpdGggZGVmYXVsdCsxLgo+ID4KPiA+IFJlcG9ydGVkLWJ5OiBMaW51eCBLZXJuZWwgRnVu
Y3Rpb25hbCBUZXN0aW5nIDxsa2Z0QGxpbmFyby5vcmc+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IENjOiBOYXJlc2ggS2FtYm9qdSA8bmFyZXNoLmth
bWJvanVAbGluYXJvLm9yZz4KPiA+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+
ID4gQ2M6IE1hbmZyZWQgU3ByYXVsIDxtYW5mcmVkQGNvbG9yZnVsbGlmZS5jb20+Cj4gPiAtLS0K
PiA+Cj4gPiBOb3RlczoKPiA+ICAgICAgdjEgLS0+IHYyCj4gPiAgICAgICAqIHJlbW92ZSB0aGUg
Y29uZGl0aW9uYWwgY29tcGlsYXRpb24gZm9yIDMyYml0Cj4gPgo+ID4gICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lwYy9zaG1nZXQvc2htZ2V0MDIuYyB8IDYgKysrKystCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htZ2V0L3NobWdldDAyLmMKPiBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwMi5jCj4gPiBpbmRl
eCA3OTg5ZWYzM2UuLmUwNTNiOThkMiAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwMi5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lwYy9zaG1nZXQvc2htZ2V0MDIuYwo+ID4gQEAgLTU2LDcgKzU2LDcgQEAgc3Rh
dGljIHN0cnVjdCB0Y2FzZSB7Cj4gPiAgICAgICB7JnNobWtleTEsIFNITV9TSVpFLCBJUENfRVhD
TCwgMCwgMCwgRU5PRU5UfSwKPiA+ICAgICAgIHsmc2hta2V5LCBTSE1fU0laRSwgSVBDX0NSRUFU
IHwgSVBDX0VYQ0wsIDAsIDAsIEVFWElTVH0sCj4gPiAgICAgICB7JnNobWtleTEsIFNITU1JTiAt
IDEsIElQQ19DUkVBVCB8IElQQ19FWENMLCAwLCAwLCBFSU5WQUx9LAo+ID4gLSAgICAgeyZzaG1r
ZXkxLCBTSE1NQVggKyAxLCBJUENfQ1JFQVQgfCBJUENfRVhDTCwgMCwgMCwgRUlOVkFMfSwKPiA+
ICsgICAgIHsmc2hta2V5MSwgODE5MiArIDEsIElQQ19DUkVBVCB8IElQQ19FWENMLCAwLCAwLCBF
SU5WQUx9LAo+ID4gICAgICAgeyZzaG1rZXksIFNITV9TSVpFICogMiwgSVBDX0VYQ0wsIDAsIDAs
IEVJTlZBTH0sCj4gPiAgICAgICB7JnNobWtleSwgU0hNX1NJWkUsIFNITV9SRCwgMSwgMCwgRUFD
Q0VTfSwKPiA+ICAgICAgIHsmc2hta2V5MSwgU0hNX1NJWkUsIElQQ19DUkVBVCB8IFNITV9IVUdF
VExCLCAwLCAxLCBFUEVSTX0sCj4gPiBAQCAtMTQ5LDQgKzE0OSw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
dHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgIC50ZXN0ID0gZG9fdGVzdCwKPiA+ICAgICAgIC50
Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+ID4gICAgICAgLmh1Z2VwYWdlcyA9IHtUU1RfTk9f
SFVHRVBBR0VTfSwKPiA+ICsgICAgIC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9w
YXRoX3ZhbFtdKSB7Cj4gPiArICAgICAgICAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgi
LCAiODE5MiIsIFRTVF9TUl9UQlJPS30sCj4gPiArICAgICAgICAgICAgIHt9Cj4gPiArICAgICB9
LAo+ID4gICB9Owo+Cj4gL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXggY2FuIGJlIGRpc2FibGVkIGJ5
IENPTkZJR19TWVNWSVBDX1NZU0NUTCwKPiBhbHRob3VnaCB0aGF0IHdvdWxkIGJlIHJhcmUuIEkg
dGhpbmsgdGhlIHNhdmVfcmVzdG9yZSBmbGFncyBzaG91bGQgYmUKPiBUU1RfU1JfVENPTkZfTUlT
U0lORyB8IFRTVF9TUl9UQlJPS19STy4gVGhpcyBjYW4gYmUgY2hhbmdlZCBkdXJpbmcgbWVyZ2Uu
Cj4KCkdvb2QgcG9pbnQsIHBhdGNoIHdhcyBhcHBsaWVkIHdpdGggdGhhdCBjaGFuZ2VzLgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
