Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387BC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714127544; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=PuA3L0ePqqCzotpLQGb+PB6kcGAQvPfSuX6HpwKgOmQ=;
 b=FTNGejEoTv8vJIF3rn3RULwq2CMQDRITi7Wlm9ejBMGRNkzZFeCGzfL92qk32gWlRX5Tz
 u3jpNLOXCAbOLm9na9TvN4ioJDcydCFfVtVqvn5dqWq+Euh6vT2HMQtZaOAIrTf4v7aldjL
 N6Mls9REDHYsRGkzdSxwgA8+LcBEGVI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE6A43CFFD4
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 12:32:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F9F73CE531
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 12:32:02 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C2606013F8
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 12:32:02 +0200 (CEST)
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo263872866b.0
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714127521; x=1714732321; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5W/9THyK14gS1KcZK0ZfZp5OSJ3hohh6fvRCtZMAqg=;
 b=AJxe/GJUxHE9QJIjSfvTZ+fDowiwk+loTebGJhTpyqwE5A2odHAK9ZvCaLdD8Hyvut
 SGRhNj2r7MX4cPr/gkjMTNR+Ut+Gbo98VfUzhCklHjajiTVE6a86QQES4fQt/3INvxTz
 yTeyJQ7LC/3LNYZ6Cu7VCJ+nwJKj8NqagsPX3QrvBRFEifpqdgONpUYN4GJXaPQGs8tw
 4M1GLN9UsNc7dw7P1YE0SUBeycokHqWJSfXFgGcSa/4HCgPHOJOy9TFB3G/3k8d24bLu
 6RCbzbiSunnWcxU5GffEZS0Dmz9JMb2m9eYZlfGKvbY0HTbxw2cQBRYjWs2EA0VhwMa9
 0CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714127521; x=1714732321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5W/9THyK14gS1KcZK0ZfZp5OSJ3hohh6fvRCtZMAqg=;
 b=e/eVguFlowoctKh5HE4ht6ruVLS7/ytDBHpDiKai6Jr56s+OD63J7TDpl+CAm9s2GJ
 BpqRp/fPZ0hogGPlHFutulXOAYlXx71IcgmlEPVIzaf4z99zbSekCI3DW0aRW+fwc4v7
 WDnF8cjLq3vueBWRxCjAmgkL6E1bDi84is47TQDitk4BxgZbDzFqOeALKQyc8J5pEWLg
 2u13jS2QeViKZ5ixmu2UXToZsKTqsO1gLlbWb0foXd675LG6mDxt8052VArYHwW7XtZK
 CbJKxTHgsdXMty+FTn6TP0aOIg+mwftCtZNY2envMxWzAMKxAgH5BMGYvIlWf8h8X2y5
 VvUA==
X-Gm-Message-State: AOJu0YwiXMBZJi1Mrr+A13nx05toWpIZ2T/vf3EmKspDrjA0kdnwPwKn
 KHdKF2oFrRgvh4PZfC5O8vfpuwkZ7jYvIj+elWJgfTHY72i9LmWEqVPEE8QhxyB/IvtLduoP6bv
 54zQ20g==
X-Google-Smtp-Source: AGHT+IH+NSXOVHSjuSK/iCff5uO7YA3RACDrZ1hg98EW4o1LEO3W1slQyAPr0wcX7DBWwGSmZ9u17A==
X-Received: by 2002:a17:906:69cf:b0:a55:9dec:355f with SMTP id
 g15-20020a17090669cf00b00a559dec355fmr1459987ejs.70.1714127521467; 
 Fri, 26 Apr 2024 03:32:01 -0700 (PDT)
Received: from [10.232.133.119] ([88.128.88.8])
 by smtp.gmail.com with ESMTPSA id
 cb6-20020a170906a44600b00a58864c88aesm3641286ejb.225.2024.04.26.03.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 03:32:01 -0700 (PDT)
Message-ID: <360baa94-cf5b-4ee5-9b3f-29afb0129c18@suse.com>
Date: Fri, 26 Apr 2024 12:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240423082119.16117-1-andrea.cervesato@suse.de>
 <20240425213749.GA304030@pevik>
 <6b2dd151-c7cf-48b5-87f5-3c3efb425811@suse.com>
Content-Language: en-US
In-Reply-To: <6b2dd151-c7cf-48b5-87f5-3c3efb425811@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: update syscalls statistics
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IHRoZXJlIGFyZSBzeXNjYWxscyBsaWtlICJjYWNoZWN0
bCIgd2hpY2ggYXJlIApNSVBTIHNwZWNpZmljLgpBdCB0aGUgc2FtZSB0aW1lLCAicmVzdGFydF9z
eXNjYWxsIiBpcyBzdXBwb3NlZCB0byBiZSB1c2VkIGZvciBpbnRlcm5hbCAKdXNhZ2Ugb25seS4K
CkkgbGVmdCB0aGVtIHRoZXJlLCBidXQgbWF5YmUgdGhleSBuZWVkIHRvIGJlIGJsYWNrbGlzdGVk
IGFzIHdlbGwuCgpPbiA0LzI2LzI0IDEyOjI5LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IEhp
IQo+Cj4gT24gNC8yNS8yNCAyMzozNywgUGV0ciBWb3JlbCB3cm90ZToKPj4gSGkgQW5kcmVhLAo+
Pgo+Pj4gVGhpcyBwYXRjaCBibGFjay1saXN0IGEgZmV3IHN5c2NhbGxzIHdoaWNoIGFyZSBub3Qg
aW1wbGVtZW50ZWQgaW4gdGhlCj4+PiBrZXJuZWwsIHVudGVzdGFibGUgb3IgZWl0aGVyIHJlYWxs
eSBvbGQgKD08IDIuNiBrZXJuZWwgdmVyc2lvbiksIGFzIAo+Pj4gd2VsbAo+Pj4gYXMgZGVmaW5p
bmcgYWxyZWFkeSB0ZXN0ZWQgc3lzY2FsbHMuCj4+PiBBbHNvIGZpeGVkIGFuIGluZGV4IGlzc3Vl
IHdpdGggdGFibGUgZ2VuZXJhdGlvbi4KPj4gVGhhbmtzIGEgbG90LCBvYnZpb3VzIGZpeCwgdGhl
cmVmb3JlIG1lcmdlZC4KPj4KPj4gSSB3b3VsZCBzdGlsbCBjb25zaWRlcjoKPj4KPj4gMSkgTGlz
dGluZyBhbHNvIG1xX2dldHNldGF0dHIoKS4KPiBGcm9tIG1hbnVhbDoKPgo+IERFU0NSSVBUSU9O
Cj4gwqDCoMKgwqDCoMKgIERvIG5vdCB1c2UgdGhpcyBzeXN0ZW0gY2FsbC4KPgo+IMKgwqDCoMKg
wqDCoCBUaGlzwqAgaXPCoCB0aGUgbG93LWxldmVsIHN5c3RlbSBjYWxsIHVzZWQgdG8gaW1wbGVt
ZW50IAo+IG1xX2dldGF0dHIoMykgYW5kIG1xX3NldGF0dHIoMykuwqAgRm9yIGFuIGV4cGxhbmF0
aW9uIG9mIGhvdyB0aGlzIAo+IHN5c3RlbSBjYWxsIG9wZXJhdGVzLCBzZWUgdGhlIGRlc2NyaXB0
aW9uCj4gwqDCoMKgwqDCoMKgIG9mIG1xX3NldGF0dHIoMykuCj4KPj4gMikgVHJ5aW5nIHRvIGxp
bmtzIHN5c2NhbGxzIG5hbWVzIHRvIHRoZSBzeXNjYWxscyBkaXJlY3RvcnkKPj4gKGUuZy4gcmVh
ZCA9PiByZWFkIGRpcmVjdG9yeSBpbiBMVFAgdHJlZVsxXSkgdGhhdCBzaG91bGQgbm90IGJlIHRo
YXQgCj4+IGhhcmQuCj4gSXQncyBhbHJlYWR5IGxpa2UgdGhpczogd2UgY2hlY2sgZm9yIHN5c2Nh
bGxzIHN1YmZvbGRlcnMgYW5kIGNvbXBhcmUgCj4gdGhlbSB3aXRoIHN5c2NhbGxzIGZpbGUuIElm
IHN1YmZvbGRlciBleGlzdHMsIHdlIHN1cHBvc2UgdG8gaGF2ZSB0ZXN0cyAKPiBmb3IgdGhlIHNw
ZWNpZmljIHN5c2NhbGwgKG9mIGNvdXJzZSwgdGhpcyBkb2Vzbid0IGluY2x1ZGUgY292ZXJhZ2Up
Lgo+PiAzKSBXcml0ZSBleHBsYW5hdGlvbiwgdGhhdCB0aGVzZSBzeXNjYWxscyBhcmUgdG8gInNv
bWUgZXh0ZW5kIHRlc3RlZCIuCj4+IElkZWFsbHksIEkgd291bGQgd2lzaCB3ZSB3b3VsZCB0cmFu
c2Zvcm0gbWV0YWRhdGEgb3V0cHV0IGdlbmVyYXRpb24gWzJdCj4+IHRvIHRoZSBkb2NzIGhlcmUg
YW5kIGVuYWJsZSBhbHNvIExUUCBsYXRlc3Qgc3RhYmxlIHZlcnNpb24gZG9jcy4KPiBQb3NzaWJs
ZSwgYnV0IGl0IG1pZ2h0IGJlIGEgYml0IGNoYWxsZW5naW5nCj4+Cj4+IEtpbmQgcmVnYXJkcywK
Pj4gUGV0cgo+Pgo+PiBbMV0gCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvbHRwL3RyZWUvbWFzdGVyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZAo+PiBbMl0g
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3JlbGVhc2VzL2Rv
d25sb2FkLzIwMjMwNTE2L21ldGFkYXRhLjIwMjMwNTE2Lmh0bWwKPgo+IEFuZHJlYQo+CgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
