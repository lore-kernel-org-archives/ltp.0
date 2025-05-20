Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB2EC3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747740725; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8CJtBDrmEFX0hRbcmLT3y9h8MOnOypYfC1ivf1LNv/A=;
 b=F6FWJOEZ2eVoNcRGGQOJS2RCYE5Gb+30wKOnjELm3lbgV+SaChgkhP7dRHnlzhUwRnF+p
 eoDZyCmjV9FKo6QNgRq9885jxb8EcMF7K6MSvbIDknF9XPi2AhgQxqKQurkMlUZ7IlmdhgE
 9SiBxcNYyicMy7hk+sC7V2JsJ1SPFBc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EB933CC761
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 13:32:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310553CC6F9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:31:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4EC3E10009D8
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:31:42 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso1276981f8f.0
 for <ltp@lists.linux.it>; Tue, 20 May 2025 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747740702; x=1748345502; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMQy/Hn2k6mAjROlO7PLrNUk+v9te0rMACpLO2A0F6w=;
 b=Wylcx4SYcX4uqIZudC9co6pcskpD0cA/VJbmOx8VfYrPu0cfRNqZrEVac295L/qpL4
 tZNhrQ6LfCsg3COq3ckUDskdGAiPV277RwATzLj+n/Mrm7fBPJ+Ffnkqm7Rg+x49wopx
 3hXnJ5HvjgUPyRqpNNOpC9A1XcsP+qy5DrPO9qfaYiZHNoakA5W5cIXEV0wXoht7bBLC
 xGgoAu+OY/LLsywjYao4qeeLLNRoLFcLPSmvjhl9u/K72yAigM6Md01pC+b4yi9kFs9H
 kB/oTCr1Vqj1kCj4ucxQQufsd/JSCtRdVQD4WzQT5/RLikqoBNBZEv74zCD2Opaz+pJK
 ze8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747740702; x=1748345502;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMQy/Hn2k6mAjROlO7PLrNUk+v9te0rMACpLO2A0F6w=;
 b=uN5d2kzjT0c1953wmpoz3rHgQYdJv6vVzVU+nwN0AXCULi+vaIoG6FH5LzzIWRkgml
 I/KBMfHy+YMVZ4bxeXrOrEppos17d2JeytxNobqmgiUQG0IYcfyEV9dwzPoiqtWaAdP9
 HIrFSFnnw8CpUVQSY0jqK717azjXKBux4r75LUNmybL1I41m5L1uJcAzxUh2ADeebaOC
 F9XuzF3CsyvhHULcN/8Dgwa++7B8f0WU/prmxHCSLtBTYK4jN2LZWOmhQb0W6qIqb+1O
 BtKSP+QsXFCX0ErdRSnL47B6Y3Wdtn0/1yOE2meSc4QNBdEWSGrlgyHrUht6brCypwjh
 co5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjTewxCBLQ/8dXoGcAO5kD8z5/dShFCnyPvVtCDSzjaUUaEcIr9hr/+ApcPClqMO/MtRU=@lists.linux.it
X-Gm-Message-State: AOJu0YxMF5CESngQgs6AQ0vpMFS42KqoXoorUuY7w248x4u7oMBwZsCA
 PkS6aK0I/LjkI5MhC4LibY9Tml4wIS8xjVrxpGKJ0lUncAkUU+MVoNQi13majOewkqkBIJDxgw1
 yj056
X-Gm-Gg: ASbGncs/4mDtyjufp3aIpjEhHYgAsdmzjUAH/ZVmMB5id/ghTdEWE9bDsq4NJjMjQT6
 6eYXH3bS454+yJok2Pf3+zdRoNaVy4xtVhc360OtVqcXRYE90BZGrc8HFGIf6zVjNoH02KwvtD2
 B2ASekTFNWVFkoeTLmIlLH48AQSOpV8H9NqlH8i3AwgxO0VscXH7SMIK9cATmmVB8kXE2U+pqqC
 hFC1SwnU8BosTiGDI83d3wu3stVh97GmJsRFc1PCXIuOJw8/zvk/DEy3fLSq/elgPZ68h5Xveyy
 EbWKwRxK7AsL7WLunA87QrbHgkaG+Ie6B1rWqM+ZDDj7Z+Opew==
X-Google-Smtp-Source: AGHT+IHf7j2ol9ZXspCkLFWSs8/QLzXQ2HP21pzbrgVXh23Mc/TzAST/peTQ7Ce6ZTH8dmtoDRMFZw==
X-Received: by 2002:a05:6000:2304:b0:39c:1429:fa57 with SMTP id
 ffacd0b85a97d-3a35fe5c560mr11819438f8f.3.1747740701744; 
 Tue, 20 May 2025 04:31:41 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dfa64aa8f5sm8131642137.0.2025.05.20.04.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:31:41 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 20 May 2025 08:31:35 -0300
Message-Id: <DA0YDBI0SQUN.2TLZFDRK8N1YD@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
In-Reply-To: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIE1heSAyMCwgMjAyNSBhdCA4OjI5IEFNIC0wMywgUmljYXJkbyBCLiBNYXJsacOocmUg
d3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFRo
ZSBjb21taXQgYmUwYWFjYTJmNzQyICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0
LmgiKSBsZWZ0IGJlaGluZAo+IGFuIGltcG9ydGFudCBmYWN0b3Igb2YgbW9kaWZ5X2xkdCgpOiB0
aGUga2VybmVsIGludGVudGlvbmFsbHkgY2FzdHMgdGhlCj4gcmV0dXJuIHZhbHVlIHRvIHVuc2ln
bmVkIGludC4gVGhpcyB3YXMgaGFuZGxlZCBpbgo+IHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5
MC5jIGJ1dCB3YXMgcmVtb3ZlZC4gQWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50Cj4gZmlsZS4K
Pgo+IFJlcG9ydGVkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4gUmV2aWV3
ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBS
aWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IC0tLQo+IENoYW5nZXMgaW4gdjM6
Cj4gLSBFRElUTUU6IGRlc2NyaWJlIHdoYXQgaXMgbmV3IGluIHRoaXMgc2VyaWVzIHJldmlzaW9u
Lgo+IC0gRURJVE1FOiB1c2UgYnVsbGV0cG9pbnRzIGFuZCB0ZXJzZSBkZXNjcmlwdGlvbnMuCj4g
LSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNTEyLWZpeGVzLW1v
ZGlmeV9sZHQtdjItMS1lYWVmNTU3N2U0NGVAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjM6Ci0gTW92
ZWQgdGhlIGAocnZhbCA9PSAtMSAmJiBlcnJubyA9PSBFSU5WQUwpYCBjaGVjayBpbnRvIHNhZmVf
bW9kaWZ5X2xkdC4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
