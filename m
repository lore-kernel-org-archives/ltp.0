Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22BEEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:30:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3B73CE0F0
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:30:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F58A3CAC32
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:30:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C60A600834
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687249824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y82kGUg/wI1058dMabL01BJmAJbPWm5UPwhpSbi6maE=;
 b=RFoaTkKOVeAvkIarcfbiXOasfjEeHuuWEkxnmuDE27iNS6DwxW6j+r8dtUgA47xlYCQpVQ
 5kyzTNDvcjVwn4dF7QAbSSdF01iK//H9sPkCbxMyx2k7BI8q9AN0O0EO1wG9Mnk2MZ18CF
 e+/nHv85uyc7sWpIDpAOlw+DQYaQd58=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-foVL1qw0N6CaLOz7JgWS2g-1; Tue, 20 Jun 2023 04:30:22 -0400
X-MC-Unique: foVL1qw0N6CaLOz7JgWS2g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b46d3eb01fso20458121fa.2
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249819; x=1689841819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y82kGUg/wI1058dMabL01BJmAJbPWm5UPwhpSbi6maE=;
 b=bxyXO+MG8if4IdLLCGO2nEaV7Pdn7P4ipIAe63f5Zi7nlmzK7gmIpox28hJn37XrBi
 CuhaXARFTdwujvzeF0xaSEu6BAgBHLh0ffpu1CdMCtmm5mcQ1pMjre68jwjxGs5G2kui
 N3zRpUnPTSeKzeklcjEzyH/XroUfj8RnzFYMVLprJdN7OPKrhK7rgYI38AXIIzTt2cmQ
 on/gAyB7xiGW4/li7X6W2XCzQI5/iiFRuJK9sl47pJ0e48ESnnEhcKohigUt26MfRRCa
 K+hiSZey81DnlfkFe7XAODAVwnnMS1MMcjtb5tId8bH/puCULpc47BslZEOgfdA/n/mR
 jwsw==
X-Gm-Message-State: AC+VfDxoakFBiw57JFQVAWuXMoumKFkyhi1SfhWppQUlH26or208V4ph
 1X7MQntIPOu9o2neoYQ3Q+ldSD9EvmT3UF0bMb1ZF3yA4A3SqaXWuluW0Xpk5NGtYNQK6ZUBiwD
 qGEbYkSBMQ17ZBQBknuPbbYMA8Kb2T1J7w4QZBdPk
X-Received: by 2002:a2e:8503:0:b0:2b2:10e2:af1d with SMTP id
 j3-20020a2e8503000000b002b210e2af1dmr6677578lji.10.1687249819699; 
 Tue, 20 Jun 2023 01:30:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZSQg5cdz1UdQMOQfR2WMr5/wcXJFfXbEQPIEjfcXHxfGROwuy2rPGyBJ+ef7whGKYMRpRR8Z6C8HoGop7yCM=
X-Received: by 2002:a2e:8503:0:b0:2b2:10e2:af1d with SMTP id
 j3-20020a2e8503000000b002b210e2af1dmr6677563lji.10.1687249819366; Tue, 20 Jun
 2023 01:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
In-Reply-To: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Jun 2023 16:30:07 +0800
Message-ID: <CAEemH2cyEdy0QVZQTuH9hHhkPtgBfV+Aswp6QRCX0hBEUOZfQw@mail.gmail.com>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/2] testcases/kernel: Add CVE tag to some
 existing tests.
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

T24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgNDoxN+KAr1BNIFNvdXRhIEthd2FoYXJhIDwKc291dGEu
a2F3YWhhcmFAbWlyYWNsZWxpbnV4LmNvbT4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IFNvdXRh
IEthd2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGludXguY29tPgo+CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVs
L21lbS9rc20va3NtMDUuYyAgICAgICAgICAgICAgICAgICAgfCA0ICsrKysKPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9pcGMvc2htYXQvc2htYXQwMy5jICAgICAgIHwgMSArCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDAyLmMgICAgICAgICB8IDEgKwo+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHNvY2tvcHQvc2V0c29ja29wdDAyLmMgfCA0ICsr
KysKPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmFtZS91bmFtZTA0LmMgICAgICAgICAg
IHwgNCArKysrCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wNS5jCj4gYi90ZXN0Y2FzZXMva2Vy
bmVsL21lbS9rc20va3NtMDUuYwo+IGluZGV4IDI1ZjM0MzViMi4uMWY1OGM4MzI1IDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wNS5jCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0va3NtL2tzbTA1LmMKPiBAQCAtOTUsNiArOTUsMTAgQEAgc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgICAgICAgICAiQ09ORklHX0tTTT15IiwKPiAg
ICAgICAgICAgICAgICAgTlVMTAo+ICAgICAgICAgfSwKPiArICAgICAgIC50YWdzID0gKGNvbnN0
IHN0cnVjdCB0c3RfdGFnW10pIHsKPiArICAgICAgICAgICAgICAgeyJDVkUiLCAiMjAxMS0yMTgz
In0sCj4gKyAgICAgICAgICAgICAgIHt9Cj4gKyAgICAgICB9Cj4gIH07Cj4KPiAgI2Vsc2UKPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htYXQvc2htYXQwMy5j
Cj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1hdC9zaG1hdDAzLmMKPiBpbmRl
eCBkZmE0MjdhNTYuLjE2YmYwMTAwOSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2lwYy9zaG1hdC9zaG1hdDAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2lwYy9zaG1hdC9zaG1hdDAzLmMKPiBAQCAtMTA0LDYgKzEwNCw3IEBAIHN0YXRpYyBzdHJ1
Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiOTVl
OTFiODMxZjg3In0sCj4gICAgICAgICAgICAgICAgIHsibGludXgtZ2l0IiwgImE3M2FiMjQ0ZjBk
YSJ9LAo+ICAgICAgICAgICAgICAgICB7ImxpbnV4LWdpdCIsICI4Zjg5YzAwN2I2ZGUifSwKPiAr
ICAgICAgICAgICAgICAgeyJDVkUiLCAiMjAxNy01NjY5In0sCj4gICAgICAgICAgICAgICAgIHt9
Cj4gICAgICAgICB9Cj4gIH07Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMva2V5Y3RsL2tleWN0bDAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3Rs
L2tleWN0bDAyLmMKPiBpbmRleCA1NzJmMzRiMTYuLjM1Y2MyODM4ZCAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwwMi5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMDIuYwo+IEBAIC0xNDQsNiArMTQ0LDcg
QEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnRlc3RfYWxsID0g
ZG9fdGVzdCwKPiAgICAgICAgIC50YWdzID0gKGNvbnN0IHN0cnVjdCB0c3RfdGFnW10pIHsKPiAg
ICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiYjRhMWI0ZjUwNDdlIn0sCj4gKyAgICAgICAg
ICAgICAgIHsiQ1ZFIiwgIjIwMTUtNzU1MCJ9LAo+ICAgICAgICAgICAgICAgICB7fQo+ICAgICAg
ICAgfQo+ICB9Owo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHNv
Y2tvcHQvc2V0c29ja29wdDAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0c29j
a29wdC9zZXRzb2Nrb3B0MDIuYwo+IGluZGV4IGU3NjIxNTM4Yi4uMzM0OWM5OTcwIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0c29ja29wdC9zZXRzb2Nrb3B0MDIu
Ywo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0c29ja29wdC9zZXRzb2Nrb3B0
MDIuYwo+IEBAIC05Niw0ICs5Niw4IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsK
PiAgICAgICAgIC5uZWVkc19yb290ID0gMSwKPiAgICAgICAgIC5zZXR1cCA9IHNldHVwLAo+ICAg
ICAgICAgLmNsZWFudXAgPSBjbGVhbnVwLAo+ICsgICAgICAgLnRhZ3MgPSAoY29uc3Qgc3RydWN0
IHRzdF90YWdbXSkgewo+ICsgICAgICAgICAgICAgICB7IkNWRSIsICIyMDE3LTczMDgifSwKPiAr
ICAgICAgICAgICAgICAge30KPiArICAgICAgIH0KPiAgfTsKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91bmFtZS91bmFtZTA0LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvdW5hbWUvdW5hbWUwNC5jCj4gaW5kZXggMmQwODUxYzhiLi44ODUzNjhjMjQgMTAw
NjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmFtZS91bmFtZTA0LmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VuYW1lL3VuYW1lMDQuYwo+IEBAIC03OSw0
ICs3OSw4IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgdGVzdF9ucikKPiAgc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnRlc3QgPSBydW4sCj4gICAgICAg
ICAudGNudCA9IDIsCj4gKyAgICAgICAudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3RhZ1tdKSB7
Cj4gKyAgICAgICAgICAgICAgIHsiQ1ZFIiwgIjIwMTItMDk1NyJ9LAo+ICsgICAgICAgICAgICAg
ICB7fQo+ICsgICAgICAgfQo+ICB9Owo+IC0tCj4gMi4zMS4xCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
