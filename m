Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E47FC36013
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743104297; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=asAYPbvStjStSDACHB/5gn2cQ8kG2NEkwrlW6xf/wso=;
 b=AOhCvWuv75TwakX6d+lwmSUP0qe85x0DsZpEkNvhNVuXQEuDSgvWWYVU1hYV9FDhN07dS
 PzxeeM0WXoM8gW1c07rhZiP6F+jnimg24XgsS9rzQLGeEoTu7Oef6znSo9f141+a5E/5k57
 QB17wmcagMv4NMFawXgdpd5K3mQaM4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD4DD3CA0FB
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 20:38:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C35393C9FC8
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 20:37:55 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FABB14000F9
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 20:37:55 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d5f10e1aaso15305e9.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1743104275; x=1743709075; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J76/FaAmmn90GTWCbYbh47FcXzg5/pfV06E8JfZK/l8=;
 b=S60PNxfPqkLB5nMPt4iLcNHoBSsdzQYeHE2eSMGYFLAFqFcgFdzUNJAA+t0YizCyGc
 xOMlgtLQNYJIQKOgXF2l5okpBSIu0YQAKo5s5fb2m4V5SbJsuoNjfgMwR+lCjVRg7Sxp
 23YWu+5j5vjEVWyQ8X/0K6NWSAngvC6apfZ7YEz5mtqgZ0fr7rnIpYbKxVAa9Tpi0tIc
 sLZdjEStd1v2aDk9UAzNhkZRR7uIdM2aFdkwOaks2HENNvaHERmkVzV4lKRvzeOX6Lur
 3G4u6VMvrikAz3UDldY/8u5D/XRFUp1yyNmEMiNWrN/r2VqSKWFITy3mFuOUPtX7ZCdJ
 UZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743104275; x=1743709075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J76/FaAmmn90GTWCbYbh47FcXzg5/pfV06E8JfZK/l8=;
 b=FCryT8Y+zO7Tpq8hdf7+imVyuEqcD02Ttg+A7+v7L89bw0d7HfwTBDvWuEs2CPaXDc
 s3kSvMKzXTPSNfK1xKqsKKiPSqUZ4tu5pdOrL/SN+frXZYWcayLxFazifKXmtl0hLbe9
 jRTXqOorPQzv5IDy38IjDLvTXqjtBRxhc3EkE/QYKfqEWA2EPmOS1920UtLXWc4cS7yp
 +NiXRYcFIaNTGnpowB/7RG51hB+kQwY2tzFs/ua8AAfCkeiigJAAT10txPbKmEzTD7ZT
 ol8aSfS/jmkQBMJ6VFMM8lWdzud539ekl0jOAAz59b54u5SfixTdR4Yv58mSRqvYQx1u
 jAcA==
X-Gm-Message-State: AOJu0Yyx7eIWdbJt50k6L89xOnnQBAeil06XD+/22m28qiokRlW52lN8
 3aK1oU3Dsv1n5AA0x0iEjc5tFgFRgYHQkc6Z6NTxgNFF36FCQQ7Ldb5P4PSfS1uThSG3k4arKe2
 NALJ+VoNKvKu8tKAqdtqP76qN4IHDK27smSkJ9AJEto8um4IkrbmI
X-Gm-Gg: ASbGncsCrYKM535FCqeUtlmU0tc/N7OxIXT4o5KSh1wHSt2q8vgC+rXS4CwXllf2VuV
 pOrusCO6dkgmiWmzTFhgS4JCbwknSTCVS4zJi4357BllckEIQ9Ai97E+oXuIGpKB4rYXZnVvapJ
 IaxFa2BaNv/PcMVF7oof4QKu+AMvNdB0YOcVQifVNgjZHxKrZn3dQRA2uq
X-Google-Smtp-Source: AGHT+IE+4eJ5i/Vfz7UxGmNY55i5/6Sxwlc8P5crSvg0HIuEtaTQawDngjIQc6KfB63vuc3kw1IEeAwWgIhmqOX4SSE=
X-Received: by 2002:a05:600c:511c:b0:439:8d84:32ff with SMTP id
 5b1f17b1804b1-43d908df676mr203355e9.3.1743104274542; Thu, 27 Mar 2025
 12:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250326223532.3411149-1-tjmercier@google.com>
 <lo4sjpn6uvhyhgi7welsp4dsvi6jxrl4h5gwacuvqmgfvfqcq7@ayoafjktxzyc>
In-Reply-To: <lo4sjpn6uvhyhgi7welsp4dsvi6jxrl4h5gwacuvqmgfvfqcq7@ayoafjktxzyc>
Date: Thu, 27 Mar 2025 12:37:41 -0700
X-Gm-Features: AQ5f1JrW3ZlnnJ4Sx9_rP1DMopaWWIT9o9YXKAjvYBtw0W0vV-zUqQyY4jU28wg
Message-ID: <CABdmKX1JTkVGwRF-DB-q+=E6rqhxr-aN=kEGd1BEvHO25S9f9A@mail.gmail.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_control_test: Disable swapping in test
 cgroup
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
From: "T.J. Mercier via ltp" <ltp@lists.linux.it>
Reply-To: "T.J. Mercier" <tjmercier@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMjcsIDIwMjUgYXQgNjozNuKAr0FNIE1pY2hhbCBLb3V0bsO9IDxta291dG55
QHN1c2UuY29tPiB3cm90ZToKPgo+IEhlbGxvLgo+Cj4gT24gV2VkLCBNYXIgMjYsIDIwMjUgYXQg
MTA6MzU6MzJQTSArMDAwMCwgIlQuSi4gTWVyY2llciIgPHRqbWVyY2llckBnb29nbGUuY29tPiB3
cm90ZToKPiA+IG1lbWNnX2NvbnRyb2xfdGVzdF8xIHNldHMgYm90aCBhIG1lbW9yeSBsaW1pdCBh
bmQgYSBtZW1zdy9zd2FwIGxpbWl0IHRvCj4gPiBhIHNpbmdsZSBwYWdlLCBhbmQgdGhlbiBhc2tz
IG1lbV9wcm9jZXNzIHRvIGFsbG9jYXRlIDIgcGFnZXMgaW4gYW4KPiA+IGF0dGVtcHQgdG8gY2F1
c2UgYSBtZW1jZyBPT00ga2lsbC4gSG93ZXZlciwgaWYgc3dhcHBpbmcgaXMgZW5hYmxlZCB0aGUK
PiA+IGZpcnN0IHBhZ2UgY2FuIGJlIHN3YXBwZWQgYmVmb3JlIHRoZSBzZWNvbmQgaXMgYWxsb2Nh
dGVkIGNhdXNpbmcgbmVpdGhlcgo+ID4gbGltaXQgdG8gYmUgZXhjZWVkZWQsIGFuZCBubyBPT00g
a2lsbCB0byBvY2N1ciB3aGljaCByZXN1bHRzIGluIGEgdGVzdAo+ID4gZmFpbHVyZS4gRml4IHRo
aXMgYnkgZGlzYWJsaW5nIHN3YXAgaW4gdGhlIHRlc3QgY2dyb3VwIGlmIGl0IGlzIGVuYWJsZWQs
Cj4gPiBjYXVzaW5nIGJvdGggcGFnZXMgdG8gYWx3YXlzIGJlIGFjY291bnRlZCB1bmRlciB0aGUg
c2FtZSBjb3VudGVyIHN1Y2gKPiA+IHRoYXQgbWVtb3J5Lm1heCAodjIpIC8gbWVtb3J5LmxpbWl0
X2luX2J5dGVzICh2MSkgY2F1c2VzIGFuIE9PTSBraWxsLgo+Cj4gSSBzZWUgaG93IHRoaXMgZml4
ZXMgdGhlIHRlc3QgZm9yIHYyIGJ1dCBmb3IgdjEgdGhlIHdyaXRlIHdvdWxkIGZhaWwKPiB3aXRo
IC1FSU5WQUwgYmVjYXVzZSBtZW1vcnkubWVtc3cubGltaXRfaW5fYnl0ZXMgPCBtZW1vcnkubGlt
aXRfaW5fYnl0ZXMKPiBhbmQgc3dhcG91dCB3b3VsZCBzdGlsbCBiZSBwb3NzaWJsZSAod2hpY2gg
aXQgd2Fzbid0IF9vbiB2MV8gYmVmb3JlIHRoaXMKPiBwYXRjaCBJSVVDKS4KPgo+IElPVyB0aGUg
dGVzdGNhc2Ugc2hvdWxkIG5vdCB0cmVhdCBtZW1vcnkuc3dhcC5tYXggKHYyKSBhbmQKPiBtZW1v
cnkubWVtc3cubGltaXRfaW5fYnl0ZXMgKHYxKSBhcyBlcXVpdmFsZW50IHF1YW50aXRpZXMuCgpU
aGFua3MgTWljaGFsLiBJJ20gYWJvdXQgdG8gc2VuZCBhIHYyIHdoZXJlIHN3YXAgaXMgZGlzYWJs
ZWQgb25seSBpbgptZW1jZyB2MiBidXQgdGhlIG1lbXN3IGxpbWl0IGlzIHN0aWxsIGFwcGxpZWQg
aW4gbWVtY2cgdjEuIFRlc3RlZCBvbgpib3RoIHZlcnNpb25zIG9mIG1lbWNnIHRoaXMgdGltZS4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
