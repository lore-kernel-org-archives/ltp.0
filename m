Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DAAC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721835321; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AERAah7Gn/iqESl0lE2MzQtoMRshhPxDyh1mWJV9hDo=;
 b=NmGqHx55QIhXWgleo5w/CayhVgZ1t3Hvv1vad+eMvYDGWjWYvlFbvPtGXiBlNyBREFN1W
 0e/ZCvrKxptL7j7Vpa3cYVAcdOCM9SLKBdga9cglFYLuLvcd6mH0czcTrSllaTg6he0mpW1
 Etb78axR9wpcu05SVHz0Q3ZtDZ6VYKE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081A53D1C44
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 17:35:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 643B13D1C2E
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:34:58 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A492B100092F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:34:57 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so122513866b.1
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721835297; x=1722440097; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=Hk44b5XzMZPyqrcM52fpefxZ5G6rQ+Iy7h4/NXfFsH0=;
 b=g9psTE+8CWJPfxfdQLfHfKE7ZAZgbxn3fv4BaxvZLtdiH3st6WH0aKX3h8k8WtLMRo
 Msh5uCKxgijzhnxsacEh5ZHFhL1v83DJuyQ4rIlhB8GVaaz34oyq3+kO+MjTbsTVjV+3
 /zKJjxVZJSAMP5IQeVX+XgM6vlXAcWSQvwLpm6/p7OfaIc58yLZGJEgM2izWjV7tKJiM
 sCNx/hJQXytJJVQD5W5Is7oS0sVj00fukf9VAjEiPsLKus2SeXatGdr79+qNOFi5HS3/
 o2isfHzrYC8b5ZmAMGIQ+I3QUl8uAkyANDtOwit62OsppuIPlfwR/6gs9M/0Mc1LixKq
 oKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721835297; x=1722440097;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk44b5XzMZPyqrcM52fpefxZ5G6rQ+Iy7h4/NXfFsH0=;
 b=Awe+g/nLD1flBjM7kwdWThKGUIy2MA0BfjAGZjWVrqxgdseD2R+tvqmhyXQVCjT2Zw
 y4P3V+v8jq5zJuluYcHkrkdqSRMIUApwRZj3Q9ViulPt7Ct6dwzcH3fvLqdFReiXGvYy
 i+TqN9bCRFWzsD9dHSfibkLJKBBMLyt7Q5kIODn1RHWc8OAUARlX4/PllyKIxguK7ssz
 YosGNYI3G7A4BaL80QFqFMsZbODLXlmrfdQIcL5j/pVYL9YDKrJsCpJgsGptOY/PKiaB
 vLL2Cp6PDSfvMebq8WPmaEaTAkFYxdQyXE+4DrOK+62R3PpWiZuQdO1uqCTSRLvLqq1F
 tvOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9xmFgautx3FOh+XmbqEU6ZvQherIS8mZBFDC5JQMZYy1YHCDw7Ia0Cl17wW43AroUz9Wf23AqJq637hUwaxaZSkE=
X-Gm-Message-State: AOJu0YzyqN3GPOfIl2jkojxnBdPKIRUnRHR5MSzknhTxSFJ9vhmVujpO
 gJQdO9pAZqD6VNPlZv6i6xV7Xwo8+tp24SL2pvVv6p0+MUV61JrOFLYlhDubYRU=
X-Google-Smtp-Source: AGHT+IG6/XKAJ/fG6hz1TeIbHfeKAUb1CkW5vvTpA+9e6evMIH/3J1tQmc4INSQTd0AeU19eUC9+5Q==
X-Received: by 2002:a17:906:7955:b0:a77:f5fc:cb61 with SMTP id
 a640c23a62f3a-a7ab27f0f74mr257318166b.0.1721835296704; 
 Wed, 24 Jul 2024 08:34:56 -0700 (PDT)
Received: from smtpclient.apple ([37.162.70.207])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7ab11613e9sm78388466b.23.2024.07.24.08.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 08:34:56 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Date: Wed, 24 Jul 2024 17:34:44 +0200
Message-Id: <7F3E1D80-0F31-4017-9512-A83CA87B4AE1@suse.com>
References: <ZqEWnS9zi84z2CL2@yuki>
In-Reply-To: <ZqEWnS9zi84z2CL2@yuki>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mailer: iPhone Mail (21F90)
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add mseal() syscall declaration
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U29ycnkgYnV0IEkgZG9u4oCZdCBnZXQgaXQuIFJlc29sdmluZyBjb25mbGljdHMgaXMgcmVhbGx5
IHNvbWV0aGluZyB1cCB0byBwZW9wbGUgd2hvIHB1c2ggdGhlIGNvZGUgb24gdGhlIG1haW5saW5l
ICg6CkFsc28gaXQgc2hvdWxkIGJlIHByZXR0eSBlYXN5IHNpbmNlIGl0IHJlcXVpcmVzIHRvIGFj
Y2VwdCBib3RoIGhlYWQgYW5kIGNvbWluZyBjaGFuZ2VzLgoKQW5kcmVhCgo+IE9uIDI0IEp1bCAy
MDI0LCBhdCAxNjo1OSwgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+IAo+
IO+7v0hpIQo+PiBJIGNhbiBzZW5kIHYzIGlmIG5lZWRlZC4KPiAKPiBCdXQgdGhhdCB3b3VsZCBz
b2x2ZSBvbmx5IG1zZWFsKCkgYW5kIHRoZSBmaGNtb2RhdDIoKSBoYXMgdGhlIHNhbWUKPiBjb2xs
aXNpb24gYW5kIHdvdWxkIG5lZWQgYSB2MyB0aGF0IHdvdWxkIGFwcGx5IG9uIHRoZSB0b3Agb2Yg
bXNlYWwoKS4KPiBUaGUgc3lzY2FsbCBpbiBmaWxlcyBhcmUgdW5mb3J0dW5hdGVsbHkgY29udGV0
aW9uIHBvaW50IHNvIEknbQo+IHN1Z2dlc3RpbmcgdG8gYWRkIGFsbCB0aGUgZGVmaW5pdGlvbnMg
eW91IGFyZSBnb2luZyB0byBuZWVkIGluIGEgc2luZ2xlCj4gcGF0Y2ggaW5zdGVhZC4KPiAKPiAt
LQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
