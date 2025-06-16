Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AADC71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750071742; h=date :
 message-id : to : mime-version : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/UPtCOsP299MixxPoPOegf2iBcExwifzfl1Bba+3HqQ=;
 b=Lj+dAYBldKVqR6k0kAknlU9+1PLqnQCcfoIReis4bkiBb6ZvFewlK+HlC956nPtg+um3m
 0yc/I/uta0thQ7L29QMQzbKt9SXjBV06h34p20brXgUNGVxjrd1hKXeTe1cqZzdsFbmFy87
 dC/DyZSKn7fguNgRkbynJTEga0HiH7w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC04D3CBFBB
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 13:02:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1191E3CAF07
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 13:02:01 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2B4132001AF
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 13:02:01 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so3123610f8f.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 04:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750071720; x=1750676520; darn=lists.linux.it;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to:cc
 :subject:message-id:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g1mm5p/ENNm2rAENHqec2Td1+f/4jZ+nB5Antkl9EM4=;
 b=cb5mTX9Ft5pfA7YcWcztGQcCyBap25eseaDHgRqjfooLifaks9pWO4utpInBPN5t3B
 ALsQ4+PJ+KPi9MsctJbiiwWuEzgoXKy4hbJFr2jr5rSp22t61eq85WEv2QRbXmXKQAU8
 5kLav4x2DGvjyAraCgvOYB7+E7NI8od3byGKrYExxnac+JefpEyyY+xTidqgxlh/q2nR
 oIemgQajhduKcZl2BWv4Js+gPl9WZUdvM9Bc9r9e9WT0qaIpSTPst7fWuedaBFeZa9fu
 RDx1rZ32MQBSTrEggRPhK9/m0koYBlnUNn8zs85jjh1bhEInM4aKZB+IeDiK3eK9tmVz
 U0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750071720; x=1750676520;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to:cc
 :subject:message-id:date:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g1mm5p/ENNm2rAENHqec2Td1+f/4jZ+nB5Antkl9EM4=;
 b=g+hMvW6IAm8EHH+XlVMVzdEDXr98ZsQotisYlwE4HIdkM5ecI45tXDsl4Xa2xgHxvY
 JUH1WpHENKDKtuPyzGjo5u4S5IhOEYHVS6cOpR4A07TLdtNa2x79kcJJkCKEI5WXtQlO
 aguFvh5bPK0zJuiQ/lNREBTIj0fTlG1Fr03zRFGcf6NhASPTcYqI1hJji+BTMhLUlIuw
 CU8XFQFaApZa9djFns/37FS5OEzNCsTg//ps3lyEeZ029V5RypfGaj6m+xb4o6uv1Tkp
 0MVTPGKDG5nmODzrYMMO9E3wlJfYquJWQl/AgdC4Iwr8UmOWVi0OEAEO0rv3mnkrwSGx
 LtAw==
X-Gm-Message-State: AOJu0YzQnF8kVCyD28GZy57PFLJP0DHFVxf79b0U3WFRtuH0J5ugAzuY
 V+0ZOeN6isiLNkEHxp0neuvJ1MNeywTPpaKHbG/utSEWDtCGZwTQlfs/yx6Uh+AZMY3z6WcnRH0
 q9DeJ
X-Gm-Gg: ASbGncvruMmuBgcSTMph5wdgqFwL2Ck6w4ZM17Gg7yZuw6MOGYc1wzKLh4yOUh60xLp
 ZYWvL6MGVQJRVh9jsyIsVM1kNuXFCjGmZyX6I/ayOSGVqvFOqj4YWe2PC0aQkUV1UrvNhpqRHPG
 60B+aIVPQVNlZ7BJ095/oNWh/13XtO5aNe9Tuno2pZzEkBJqbGFYBtMmg3p6JrllmL8uWaSzguK
 wu8SztZI+pOxkhh5ubCukV0fFEOAq859H7VY6umUbehKJFWuvrEjf/cv8vPZHlDVzusjOgKEU+0
 wl5IH/tfFfchxIVfTDZ4zpydvu3sQ0p709EEX+bln3fv6Jdh
X-Google-Smtp-Source: AGHT+IEWPE30Pck4NA7I/jglCG8RRaiANV52NnpIGKalc4nhHA7yxvquoYJDEOZ9qkaQPqVkDE+4OQ==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id
 ffacd0b85a97d-3a57c5a8d11mr3677141f8f.11.1750071720372; 
 Mon, 16 Jun 2025 04:02:00 -0700 (PDT)
Received: from localhost ([189.99.236.25]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2365de78204sm58516025ad.101.2025.06.16.04.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 04:01:59 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:01:54 -0300
Message-Id: <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
To: "Li Wang" <liwang@redhat.com>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
Mime-Version: 1.0
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
In-Reply-To: <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIEp1biAxMSwgMjAyNSBhdCAxMDo1MiBQTSAtMDMsIExpIFdhbmcgd3JvdGU6Cj4gUmlj
YXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+
IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+Cj4+IFRoZSB0ZXN0
IGNhc2UgZGVzY3JpcHRpb24gcmVhZHM6Cj4+Cj4+ICJUZXN0IGNhc2UgdG8gY2hlY2sgdGhhdCBT
SUdLSUxMIGNhbiBub3QgYmUgY2F1Z2h0LiIKPj4KPj4gSXQgbWFrZXMgdXNlIG9mIHNpZ2FjdGlv
bigpIHRvIHNldCB1cCBhIGhhbmRsZXIgZm9yIFNJR0tJTEwsIGJ1dAo+PiBhY2NvcmRpbmcgdG8g
aXRzIG1hbnVhbCBwYWdlOgo+Pgo+PiAiRUlOVkFMIEFuIGludmFsaWQgc2lnbmFsIHdhcyBzcGVj
aWZpZWQuICBUaGlzIHdpbGwgYWxzbyBiZSBnZW5lcmF0ZWQgaWYgYW4KPj4gYXR0ZW1wdCBpcyBt
YWRlIHRvIGNoYW5nZSB0aGUgYWN0aW9uIGZvciBTSUdLSUxMIG9yIFNJR1NUT1AsIHdoaWNoIGNh
bm5vdAo+PiBiZSBjYXVnaHQgb3IgaWdub3JlZC4iCj4+Cj4KPiBPciBjb3VsZCB3ZSByZWZhY3Rv
ciBraWxsMDcgdG8gdmFsaWRhdGUgdGhlIEVJTlZBTCB3aGVuIGNoYW5naW5nIGFjdGlvbiBvbgo+
IFNJR0tJTEwvU0lHU1RPUD8KCkJ1dCB0aGVuIHdlIHdvdWxkIGJlIHRlc3Rpbmcgc2lnYWN0aW9u
KCkuIENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlPwoKVGhhbmtzLAotCVJpY2FyZG8uCgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
