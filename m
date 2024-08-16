Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943CC3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 07:02:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DB1A3D21E8
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 09:02:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0D573D20B5
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 09:01:48 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A1F660045C
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 09:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723791705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PLgHVEh9tchfX8RTYKlVnAICzgDBDdxjhWQNw9sy+w=;
 b=OOEjIzdiAOPacXxEYFWeEGBwussaf7e1tU8s05v1kU6+kHuLrqksUP3xQ2H66FxS6/X3o+
 TgCVVJlqwHcskRe/uPPKjE5fFv9qKTJ2Hiliuby9ta4lF7rZaQUWioRYvHamsSOnmVKpNY
 wUIcAVhC1/Iz0Juzt+29KqvusxiUVMQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-MAFGTCRfNy-_c-zeA4Pwdg-1; Fri, 16 Aug 2024 03:01:43 -0400
X-MC-Unique: MAFGTCRfNy-_c-zeA4Pwdg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d1da888717so1696939a91.2
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 00:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723791701; x=1724396501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PLgHVEh9tchfX8RTYKlVnAICzgDBDdxjhWQNw9sy+w=;
 b=CzEywqBsqmm+0rcBSU5sS4MHSAOy0AkuDrfyTEeHKaSYCvJGRjIC5ulokji7c/ey+/
 PDxpb+t+Y5HriqkM2/4G26wOrr6tZnkTUdjFHNKfcVjwk9651le8/9a5VoEuDRmy5S0g
 A1IUOYXXq8qvpw98r/Hnp1cXj8CTJCoOXoCfbvtyb5W0tr3cjzJOT/FTvwJ43m9Hau7b
 CUF6TSqjYp7ASg/FqXJ2HlqQZQlvZEKTBT+fv1HdXAxwqugL9UNsRj7RhXbyDz9jJCrZ
 oNb71xChBaUfutD8k8vCT6HTiF6pr8YVjDISpmoBgNQ29in7mV0wNky5SRbNKkWsBLIg
 AS0w==
X-Gm-Message-State: AOJu0YxJ1ef7A+komwXen1erZkPBdftNMfFtZcHcrdUvGwSoGZVjFvMF
 LvTdJVFkQQcuB6/qJeMBoxHhXbo5dkXfjWjivdIWuV6jI56ajzpPG/hXsGc8AiXaNK4cOqEPbPw
 pHT4LBkdo9ocvw+fj2bqmXiWdZS7ufsWEu5+6iTVeU2ox4wuENtd8YgpEoPtZ/wtvp1IbRIcJuB
 B1NlQyKTUUK96sjwCkLhhZ6uKAXnLtp85Gv9hu
X-Received: by 2002:a17:90b:4f85:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d3e00f06e3mr2255572a91.31.1723791700895; 
 Fri, 16 Aug 2024 00:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDqGri+/u0iz37fnEpoLTVDamZjNoh/c2xNoZRa0zHq1EidcCNNX7KelENL/Cxgd+Bmmo3ssB+CPYtNfd6MsA=
X-Received: by 2002:a17:90b:4f85:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d3e00f06e3mr2255555a91.31.1723791700492; Fri, 16 Aug 2024
 00:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240816045342.185737-1-ice_yangxiao@163.com>
In-Reply-To: <20240816045342.185737-1-ice_yangxiao@163.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Aug 2024 15:01:28 +0800
Message-ID: <CAEemH2fg9-Su=nXY=_gyZ_gK9hDNx=0s-TD8JpoZWmT4LfQmcg@mail.gmail.com>
To: Xiao Yang <ice_yangxiao@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls/landlock05.c: Remove useless tags
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

T24gRnJpLCBBdWcgMTYsIDIwMjQgYXQgMTI6NTTigK9QTSBYaWFvIFlhbmcgPGljZV95YW5neGlh
b0AxNjMuY29tPiB3cm90ZToKCj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgZnJvbSBtZXRh
ZGF0YS9tZXRhcGFyc2U6Cj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5k
bG9jazA1LmM6IHVzZWxlc3MgdGFnOiBmb3JtYXRfZGV2aWNlCj4gdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1LmM6IHVzZWxlc3MgdGFnOiBuZWVkc190bXBkaXIK
Pgo+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8aWNlX3lhbmd4aWFvQDE2My5jb20+Cj4KClJl
dmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYyB8IDIgLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbGFuZGxvY2svbGFuZGxvY2swNS5jCj4gaW5kZXggNjg5OWRkMWYxLi43MDNmN2Q4MWMg
MTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9j
azA1LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2Nr
MDUuYwo+IEBAIC05MCw3ICs5MCw2IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHN0YXRp
YyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAgICAgIC50ZXN0X2FsbCA9IHJ1biwKPiAg
ICAgICAgIC5zZXR1cCA9IHNldHVwLAo+IC0gICAgICAgLm5lZWRzX3RtcGRpciA9IDEsCj4gICAg
ICAgICAubmVlZHNfcm9vdCA9IDEsCj4gICAgICAgICAuZm9ya3NfY2hpbGQgPSAxLAo+ICAgICAg
ICAgLmJ1ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtdKSB7Cj4gQEAgLTEwMiw3ICsxMDEsNiBA
QCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAgICAgICAgIFRTVF9D
QVAoVFNUX0NBUF9SRVEsIENBUF9TWVNfQURNSU4pLAo+ICAgICAgICAgICAgICAgICB7fQo+ICAg
ICAgICAgfSwKPiAtICAgICAgIC5mb3JtYXRfZGV2aWNlID0gMSwKPiAgICAgICAgIC5tb3VudF9k
ZXZpY2UgPSAxLAo+ICAgICAgICAgLm1udHBvaW50ID0gTU5UUE9JTlQsCj4gICAgICAgICAuYWxs
X2ZpbGVzeXN0ZW1zID0gMSwKPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
