Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0A4C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751646945; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vODNRA0KR3h6+GjT7mJfHnN6w4mdotltxtb8qIJmfmg=;
 b=QdF6IONC6WgasC5uH03Tmut2MYh8jj9GZ4EjM5WihthGo0fyu6RRU7EHo3iqQxyYOaxvW
 qcxiFNKPqib8VZah/kmVPnJf1bT2uXBVkJGQ7QJf0NRIxm66ToTJVXXuh4/XTYWeDwsyktK
 +WC4LwMz90dtvyYXQKjsUW3k0Lxqjzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 340343C9DD8
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 18:35:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCC3E3C4DF6
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 18:35:23 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7FC9600656
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 18:35:22 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso628986f8f.2
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751646922; x=1752251722; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KhGVGPaJCY9D0Nile7gVmYbBCCcj+oIY8ahAAcEC+U=;
 b=aZoFlzkJ/uRPU6dPs3zHrtalrfonkFxsTDebBkeO7doOikBTQn967UG9+XHVW2qTig
 8xsQmXHENtWZwn42PyZ9x2bjyhgAMjadvEAnU3cyuQCHnTAeVnEaUgoWCRP7xKj+n8tA
 8TcEVcDLkHuoD2qpm9NZRBM7dzJHwWJHpH8xaR73k8FbOlaXRCuK/kxHRRMYyOMW1oMO
 8bq6z9HBHTGod7LW+SdQAMXfV4OlWoex9QGs4Cbk3ZiCVVS9KJW/NGmHfNmW8Gd9OE/n
 iP2QTfDudAY2o/9lWLvXQ2ckkDNrIdwOs/Cga4RkzPl/wRbrbTcyL11IRGu6t3ea5Ot4
 YUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646922; x=1752251722;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KhGVGPaJCY9D0Nile7gVmYbBCCcj+oIY8ahAAcEC+U=;
 b=HxNIT/qDRLASAERh0s6l5tc+xhiXLBqg8kKW27YFWm5yx8ZwXUxoETl8JXVeqdFPxU
 ueWsPxcPV0NN3eBJ0FjvnWMpsqU4IYb5egakmMHVva06Ht1omdc1vkYGRipmwZk7NGEv
 ck2brEwj720jOUGGGvWZ+h+1fePEYgmOBYSLtNmUc18QS/3bLsEJgprHT2TI+LG2AOiK
 lKzcNPowZytx21ro02I0V2cX6fzbziMhtBIfrb3R74I//J5/sPdTbREj19BJwBJY/ZHL
 s4LDbo9dUmdbZJYAqIwq7yVpP6eEAHTjpH69h9eanMqJmTWAUjhl4XmMfHCxNo1+eBo/
 dfhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWBWQn1zXLxokJE7U+zVlbUo/7ZjBghiBVt6DrJKMHS0/+EODw6B4P4gl6TmDmx1zsIM=@lists.linux.it
X-Gm-Message-State: AOJu0YyRyffBDfxpiQfZCvNnx5+wr9d8/bw0HijwVB/5NyZ4VPTJ5BFN
 9ItWBJaRgwUjL5ZEoQ6ZhnMVwLlg9ZqAmtZD40usGdK4GaNlaULXSYcqyRvncHsv+60dtJlG4aX
 4K5Tk
X-Gm-Gg: ASbGncuryBMTHVDzCPfd7wMV+I1ChvAq8up9s2gpQ2DqjDtUjciHEb6EWBzzY9rZyGd
 ldV5EKrxTOQDQURz2JZ10jhhgqVAGFRBX/knW+5CN8w4R+/oTBUQd77f3OxRs5BlZF/gy0vo87m
 NS1bpBAIVY6/kO6pOzeI8gPDIuFXen7BqtHUZ8o91VybLq1Ts6NTJeL3VjxCerH7Vd4f33z/1Gt
 f36Ks6pbhUUWfwJQa6JwTpx5iZVrxKk9ywOzWb58ITZ7hLct8Zy9z2ocSwGumCtsPoQFxYoazWE
 jOEFAqs5KdZegMzKez3r58ornac/iEitwGvTwaJqL9K7y0IMIg==
X-Google-Smtp-Source: AGHT+IGOr0h1hmp942dyacbmgdGMafBpwv0bOOtw5bmA6s/+MOhHXawLG48OjA6ZbicdtpIscmRfFw==
X-Received: by 2002:a05:6000:4601:b0:3a5:8a68:b82d with SMTP id
 ffacd0b85a97d-3b4965ff5cbmr2513497f8f.43.1751646922309; 
 Fri, 04 Jul 2025 09:35:22 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a994aa77d4sm16361611cf.73.2025.07.04.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:35:21 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 04 Jul 2025 13:35:15 -0300
Message-Id: <DB3F0C75MAF0.3TBFSF17YH388@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250703-conversions-munmap-v1-0-30de82d59004@suse.com>
 <20250703-conversions-munmap-v1-3-30de82d59004@suse.com>
 <54c64003-9dbe-435c-a647-90ec20fc16f1@suse.com>
 <DB3DH6Q3K9NY.MNT7YCB2EZI9@suse.com>
 <3598e02d-bb1c-45cb-8f17-6a5e47b46e91@suse.com>
In-Reply-To: <3598e02d-bb1c-45cb-8f17-6a5e47b46e91@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] syscalls: munmap03: Convert to new API
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

T24gRnJpIEp1bCA0LCAyMDI1IGF0IDE6MjYgUE0gLTAzLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3Rl
Ogo+IE9uIDcvNC8yNSA1OjIzIFBNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPj4gTW9z
dCBvZiB0aG9zZSBhcmUgZm9yIG1tYXAuIFRoZSBvbmx5IG9uZSBsZWZ0IHNlZW1zIHRvIGJlIEVO
T01FTSwgd2hpY2gKPj4gSSBkb24ndCB0aGluayBpdCdzIHZpYWJsZSB0byB0ZXN0LiBXRFlUPwo+
IEkgZ3Vlc3MgeW91IG1lYW46Cj4KPiAgwqDCoMKgwqDCoMKgIEVOT01FTSBUaGXCoCBwcm9jZXNz
J3PCoCBtYXhpbXVtIG51bWJlciBvZiBtYXBwaW5ncyB3b3VsZCBoYXZlIGJlZW4KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZWVkZWQuwqAgVGhpcyBlcnJvciBjYW4gYWxzbyBvY2N1
csKgIGZvcsKgIG11bm1hcCgpLCB3aGVuCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
bWFwcGluZ8KgIGHCoCByZWdpb24gaW4gdGhlIG1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5n
LAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaW5jZSB0aGlzIHJlc3VsdHMgaW4gdHdv
IHNtYWxsZXIgbWFwcGluZ3Mgb24gZWl0aGVyIHNpZGUKPgo+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBvZiB0aGUgcmVnaW9uIGJlaW5nIHVubWFwcGVkLgo+Cj4gTHVja2lseSBpdCBpcyB0
ZXN0YWJsZSwgYnV0IHdlIG5lZWQgYSBuZXcgdGVzdCBmb3IgdGhhdC4gV2hhdCB3ZSBjYW4gZG8g
Cj4gaXMgdG8gcmVhZCAKPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9hZG1pbi1ndWlkZS9zeXNj
dGwvdm0uaHRtbCNtYXgtbWFwLWNvdW50IGFuZCB0byAKPiBtYXAgdGhlIG1heGltdW0gYW1vdW50
IG9mIG1lbW9yeSBtYXAgYXJlYXMuIFRoZW4gd2UgbXVubWFwKCkgaW4gdGhlIAo+IG1pZGRsZSBv
ZiBvbmUgb2YgdGhlbSwgcmVzdWx0aW5nIGluICsxIG1hcHBlZCBhcmVhcyBhbmQgb2J0YWluaW5n
IEVOT01FTSAKPiBmcm9tIHRoZSBzeXNjYWxsLiBGZWVsIGZyZWUgdG8gZXhwbG9yZSBpdC4KPgoK
VGhhbmtzIGZvciB0aGUgcG9pbnRlcnMsIEknbGwgZ2l2ZSBpdCBhIHNob3QgOC0pCgo+IC0gQW5k
cmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
