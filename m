Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E9C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707398758; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sXTCVYxg5zEA05mGWw+Nj5XLwGwHlqlcDBEOLplizm8=;
 b=bY9IsB9bJOmxCw35eAX42QU2r7/QAXxFJRssxwBYkeOgI3ErZpLf0KxxYbgwT4HqMrzpf
 i+g045DxLpryR/ExukfqhHL9GRAE1FudREr9rSzJqnARUXA1ELuLcMatAbvXF4XVfs/K3zz
 0Hbvw4jIiVvmlAjZEknf5AwJwyySuI8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66C533CF547
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 14:25:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F77F3CF54E
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 14:25:24 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 89C151000A00
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 14:25:23 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso548406f8f.0
 for <ltp@lists.linux.it>; Thu, 08 Feb 2024 05:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707398722; x=1708003522; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BiKG0EV6f2zpn3CQPFRDE1La2WlZyS2REPlvCgxH9yY=;
 b=AVw5blLz75u01Ymja2saLmMh2yk17hJgEK22hCgo9iwe2WrWb2tFncaK9YKrGK+far
 N8kRHZHjivKeAP9F+hUjAuR5jXmrvVe9qTYFM4XmjofmbQi4/X/0VhZyWo5wVZbcrsO6
 SVXSJMVYpzO7Sxew5sjB94gsxV4ka8WuBI8+c3g4ABLH/RZFhbfE1771ShIi8fEOIAuy
 eK+Ptdzyw6mDHA3HkgX/R8JfYg96/E899z5Tf3AN4wnt5jHd9Ir4d/GFVRZUV2a448CW
 r9iA2fu64m8A2D72dlqesJhUqPygTPILlNEpIE0vxmTBoqUm91vO55bz1JmPWulAqefO
 bKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707398722; x=1708003522;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BiKG0EV6f2zpn3CQPFRDE1La2WlZyS2REPlvCgxH9yY=;
 b=ag2fvJ4JmDe9GZYssTWm1oSNGPzshZsU+RoNr+MzoQF9erNv6+pGAWQQ/MviFfmzI/
 eFVhlx8GfK+rB+1tTGedVJL36b7Culyj2LOrJoqUfChlu+zFhzcylX1yZTw0Oqfca1mr
 1RMfzx3m6Zr4mQOci3R5kMN5hsDRYZ1K/1ZfaBVX6FeG5XHUFRXR2KFzmDtVlpjrDbc6
 RLC80on7UDlOVxRPFfz1vtASoqZOoauoImb0AYWxGzu1J+EMNWflxOqsXO5/hBAM8kB7
 JmKrI4dhhM07RF1Xu9icH973nq+nzvoOOr1N4ISwHMCVG2CljTdY27fvH+1Uo1kF5NHB
 nx7A==
X-Gm-Message-State: AOJu0YwA4zs/1viwNrfAoPWlq+f13LaAwy+Z+T/IF6+AOgILkYCcrEDR
 3weitG+ujyFcwyEFdaP2E1ZfZbacPLXb2zAVbJxPg+QyVLCfcyBq6LvD8dnf/tAS07y+hWtC890
 04Cs=
X-Google-Smtp-Source: AGHT+IG/g3PvyIYxTWvwerYLJ64aEArwc2rUVM2XOhI/rmwQnsCpvOw1qX4ExoCZUVK+aNQS1dOrrw==
X-Received: by 2002:a05:6000:14b:b0:33b:4c26:85df with SMTP id
 r11-20020a056000014b00b0033b4c2685dfmr1961957wrx.35.1707398722167; 
 Thu, 08 Feb 2024 05:25:22 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a056000181400b0033b43a5f53csm3576796wrh.103.2024.02.08.05.25.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 05:25:21 -0800 (PST)
Message-ID: <0cfbe8ce-f705-4cb1-bf74-a43376fda51e@suse.com>
Date: Thu, 8 Feb 2024 14:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231108074935.1409644-1-pvorel@suse.cz>
 <20231108074935.1409644-2-pvorel@suse.cz>
In-Reply-To: <20231108074935.1409644-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] link05: Use constant for number of links
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpMR1RNCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KClJlZ2FyZHMsCkFuZHJlYQoKT24gMTEvOC8yMyAwODo0OSwgUGV0ciBWb3Jl
bCB3cm90ZToKPiBObyBuZWVkIHRvIGNyZWF0ZSB2YXJpYWJsZSwgd2hlbiBudW1iZXIgb2YgbGlu
a3MgaXMgbm90IGNoYW5nZWQuCj4KPiBGaXhlczogZDkwOGZkODcwICgibGluay9saW5rMDU6IENv
bnZlcnQgdG8gbmV3IEFQSSIpCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+Cj4gLS0tCj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saW5rL2xpbmswNS5jIHwg
MTMgKysrKysrLS0tLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saW5r
L2xpbmswNS5jIAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saW5rL2xpbmswNS5jCj4g
aW5kZXggMWQ3MDhjNmY2Li5hMTg4ZGExOGQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9saW5rL2xpbmswNS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9saW5rL2xpbmswNS5jCj4gQEAgLTE1LDE4ICsxNSwxNyBAQAo+ICNpbmNsdWRlICJ0c3RfdGVz
dC5oIgo+Cj4gI2RlZmluZSBCQVNFTkFNRcKgwqDCoCAibGtmaWxlIgo+ICsjZGVmaW5lIE5MSU5L
U8KgwqDCoCAxMDAwCj4KPiBzdGF0aWMgY2hhciBmbmFtZVsyNTVdOwo+Cj4gLXN0YXRpYyBpbnQg
bmxpbmtzID0gMTAwMDsKPiAtCj4gc3RhdGljIHZvaWQgdmVyaWZ5X2xpbmsodm9pZCkKPiB7Cj4g
wqDCoMKgwqBpbnQgY250ID0gMCwgY3JlYXRlZDsKPiDCoMKgwqDCoGNoYXIgbG5hbWVbMTAyNF07
Cj4gwqDCoMKgwqBzdHJ1Y3Qgc3RhdCBmYnVmLCBsYnVmOwo+Cj4gLcKgwqDCoCBmb3IgKGNyZWF0
ZWQgPSAxOyBjcmVhdGVkIDwgbmxpbmtzOyBjcmVhdGVkKyspIHsKPiArwqDCoMKgIGZvciAoY3Jl
YXRlZCA9IDE7IGNyZWF0ZWQgPCBOTElOS1M7IGNyZWF0ZWQrKykgewo+IMKgwqDCoMKgwqDCoMKg
IHNwcmludGYobG5hbWUsICIlc18lZCIsIGZuYW1lLCBjcmVhdGVkKTsKPiDCoMKgwqDCoMKgwqDC
oCBUU1RfRVhQX1BBU1NfU0lMRU5UKGxpbmsoZm5hbWUsIGxuYW1lKSwgIiVkOiBsaW5rKCVzLCAl
cykiLCAKPiBjcmVhdGVkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmbmFtZSwgbG5hbWUpOwo+IEBAIC0zNiw3ICszNSw3IEBAIHN0YXRp
YyB2b2lkIHZlcmlmeV9saW5rKHZvaWQpCj4KPiDCoMKgwqDCoFNBRkVfU1RBVChmbmFtZSwgJmZi
dWYpOwo+Cj4gLcKgwqDCoCBmb3IgKGNudCA9IDE7IGNudCA8IG5saW5rczsgY250KyspIHsKPiAr
wqDCoMKgIGZvciAoY250ID0gMTsgY250IDwgTkxJTktTOyBjbnQrKykgewo+IMKgwqDCoMKgwqDC
oMKgIHNwcmludGYobG5hbWUsICIlc18lZCIsIGZuYW1lLCBjbnQpOwo+Cj4gwqDCoMKgwqDCoMKg
wqAgU0FGRV9TVEFUKGxuYW1lLCAmbGJ1Zik7Cj4gQEAgLTQ1LDE2ICs0NCwxNiBAQCBzdGF0aWMg
dm9pZCB2ZXJpZnlfbGluayh2b2lkKQo+Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVz
KFRGQUlMLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJsaW5rKCVzLCAlc1sx
LSVkXSkgcmV0ICVsZCBmb3IgJWQgZmlsZXMsIHN0YXQgdmFsdWVzIAo+IGRvIG5vdCBtYXRjaCAl
ZCAlZCIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZuYW1lLCBmbmFtZSwg
bmxpbmtzLCBUU1RfUkVULCBubGlua3MsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZuYW1lLCBmbmFtZSwgTkxJTktTLCBUU1RfUkVULCBOTElOS1MsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKGludClmYnVmLnN0X25saW5rLCAoaW50KWxidWYuc3Rfbmxp
bmspOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+
IMKgwqDCoMKgfQo+Cj4gLcKgwqDCoCBpZiAoY250ID09IG5saW5rcykgewo+ICvCoMKgwqAgaWYg
KGNudCA9PSBOTElOS1MpIHsKPiDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRQQVNTLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAibGluayglcywgJXNbMS0lZF0pIHJldCAlbGQgZm9yICVkIGZp
bGVzLCBzdGF0IGxpbmtjb3VudHMgCj4gbWF0Y2ggJWQiLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZm5hbWUsIGZuYW1lLCBubGlua3MsIFRTVF9SRVQsIG5saW5rcywgKGludClmYnVmLnN0
X25saW5rKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZuYW1lLCBmbmFtZSwgTkxJTktT
LCBUU1RfUkVULCBOTElOS1MsIChpbnQpZmJ1Zi5zdF9ubGluayk7Cj4gwqDCoMKgwqB9Cj4KPiBj
bGVhbnVwOgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
