Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA983C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 17:00:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BBAB3D0AAA
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 19:00:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BBC33C132A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 19:00:38 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 04CFA1000947
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 19:00:37 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42166eb31b2so8193385e9.0
 for <ltp@lists.linux.it>; Fri, 07 Jun 2024 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1717779637; x=1718384437;
 darn=lists.linux.it; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aMFYMOXae04AdG1QaZc9piBJyrLj/WWyAckHK59PSP8=;
 b=NNSaPK7W8KkghI+wWPFJyYwkPuQutV2r7wz197DhT9wQtDe7fqzyUoaQCcqfwZWIjw
 yNFepy3ubjVOHMKD4IZWF9bal3+PpinC3J2IF5GFm+fWHlGut2eOtjfeNypEynhKBMb2
 ciR0cKRlwCRh8pbBrsbT25f+G4NLBayjQzKbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779637; x=1718384437;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMFYMOXae04AdG1QaZc9piBJyrLj/WWyAckHK59PSP8=;
 b=uX6XNUg3V4HJ5lXAGMMzRABOeZxi2eP1/GYGRiAP3+VIcbD/MviKRj8/r1Rupxj9e6
 4FYK/h4K0+Ss0p1WahKU58K78C63NF/y6sPALWzxWlCGJPc2cSLI7yBtWLwnl1OhcLIT
 36BH0W48BACkCzwygLMG1A/dOIfZU2rzepU2xLjKRbTnRsoBBf8oDZ3KnNewbRmjsiLD
 tZ6PFk2Dr6utkN+VUBtmtPaZwC7vW4XcleawsOHqrCp9QR1dATcqK08jrU+KlZTL6aSO
 smqxr8cgWjUoNbY+N/zYzxx5Ks7dXPOpCqIOlqUjzUBqOCVwe9AuDL0lIXHG9J/dDA/V
 xR5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUezOpFchy6N+weSlO4b3ig5sAhUuYLPAT488IM8xfogrrsJYv3IWESxAehdURIaB+CRl3KBWVfj7PP7IpeRIlU8tw=
X-Gm-Message-State: AOJu0YyRBXvxjATB1oxfgsFfQMS5t2DpXOji9INuEldzSK4+n5YkGtHk
 2WCi0i8TaY4eSNEB56Du4sI1cPeR+0DKN0ZahvFcno0LlbXfunsFTGmeoY0l2xY=
X-Google-Smtp-Source: AGHT+IH+B4SZ+2f8QVyrQyqUPjYnlI5ri0FKPx7MpzpAG8YqnMlEUf2uhjeLz0obB76drIEf9M83pg==
X-Received: by 2002:a05:600c:4f8e:b0:41b:f022:8e69 with SMTP id
 5b1f17b1804b1-42164a03160mr27456565e9.19.1717779637334; 
 Fri, 07 Jun 2024 10:00:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:910f:5798:f456:d86d?
 ([2001:8b0:aba:5f3c:910f:5798:f456:d86d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c6bedsm58339125e9.30.2024.06.07.10.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 10:00:36 -0700 (PDT)
Message-ID: <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 07 Jun 2024 18:00:36 +0100
In-Reply-To: <ZmM25L0EmJufsS-f@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDE4OjM1ICswMjAwLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4g
SGkhCj4gPiA+ID4gVGhpcyBkb2VzIHRoZXJlZm9yZSB3b3JyeSBtZSBhIGxpdHRsZSBiaXQsIHRo
ZXJlIGFwcGVhcnMgdG8gYmUgYSBsb3QKPiA+ID4gPiBvZiBjb21wbGV4aXR5IGluIGtpcmsgd2Ug
ZG9uJ3QgbmVlZC4KPiA+ID4gCj4gPiA+IEkgd291bGQgc2F5IHRoYXQgdGhlcmUgaXMgYSBjb21w
bGV4aXR5IHRoYXQgeW91IGRvIG5vdCB0aGluayB0aGF0IHlvdQo+ID4gPiBuZWVkIGJ1dCBpbiBy
ZWFsaXR5IHlvdSBkby4gRmlyc3Qgb2YgYWxsIHRoZSBhc3N1bXB0aW9uIHRoYXQgeW91IGNhbgo+
ID4gPiBoYXZlIHRoZSB0ZXN0IHJ1bm5lciB0aGF0IGtlZXBzIHRoZSByZXN1bHRzIGFuZCBvdmVy
YWxsIHN0YXRlIG9uIHRoZQo+ID4gPiBzYW1lIG1hY2hpbmUgdGhhdCBydW5zIHRoZSB0ZXN0cyBp
cyB0aGUgbW9zdCBmbGF3ZWQgb2YgdGhlbSBhbGwuIFNvCj4gPiA+IHJ1bm5pbmcgdGhlIHRlc3Rz
IG92ZXIgc29tZSBraW5kIG9mIGNvbm5lY3Rpb24gaXMgdGhlIGJhc2lzIGRlc2lnbgo+ID4gPiBw
cmluY2lwbGUgb2Yga2lyay4gVGhhdCBhbGxvd3MgdXMgdG8gZWFzaWx5IGFuZCBzYWZlbHkgZGV0
ZWN0IHdoZW4gd2UKPiA+ID4gY3Jhc2gga2VybmVscyB3aXRoIG91ciB0ZXN0cywgd2hpY2ggdGVu
ZCB0byBoYXBwZW4gbW9yZSBvZnRlbiB0aGFuIG1vc3QKPiA+ID4gcGVvcGxlIHRoaW5rLiBBbmQg
SSBjYW4gZ28gYWJvdXQgYWxsIHRoZSB0aGluZ3MgdGhhdCBhcmUgdGhlcmUgYmVjYXVzZQo+ID4g
PiBvZiBhIGdvb2QgcmVhc29ucyBmb3IgaG91cnMuCj4gPiAKPiA+IEkgdGhpbmsgeW91IG1pc3Vu
ZGVyc3RhbmQgbXkgcG9pbnQuIFlvY3RvIHByb2plY3QgYWxyZWFkeSBoYXMgY29kZSB0bwo+ID4g
aGFuZGxlIHNldHRpbmcgdXAgcWVtdSBpbnN0YW5jZXMsIGNvbm5lY3RpbmcgdG8gdGhlbSwgY29s
bGVjdGluZyBkYXRhCj4gPiBmcm9tIHRoZW0gZXRjLiBhbmQgd2UgdXNlIHRoYXQgd2l0aCBsdHAg
aW4gdGhlIHNhbWUgd2F5IHdlIHVzZSBpdCBmb3IKPiA+IGxvdHMgb2Ygb3RoZXIgdGVzdHMuIFNv
IHllcywgSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IHlvdSBuZWVkIGEKPiA+IGNvbm5lY3Rpb24gYnV0
IHdlIGFscmVhZHkgaGF2ZSBhIHNvbHV0aW9uIGZvciB0aGF0LsKgCj4gPiAKPiA+IFdlIHByb2Jh
Ymx5IGRvbid0IHdhbnQgc29tZSB0ZXN0cyBkb2luZyB0aGlzIHdpdGgga2lyayBhbmQgZXZlcnl0
aGluZwo+ID4gZWxzZSBkb2luZyBpdCBkaWZmZXJlbnRseS4gSSBzdXNwZWN0IHdlIHdvdWxkbid0
IHdhbnQgdG8gc3dpdGNoCj4gPiBldmVyeXRoaW5nIHdlJ3JlIGRvaW5nIG92ZXIgdG8ga2lyayBl
aXRoZXIgYXMgdGhhdCB3b3VsZG4ndCB3b3JrIGZvciB1cwo+ID4gb3IgdGhlIGtpcmsgbWFpbnRh
aW5lcnMgZHVlIHRvIGRpZmZlcmluZyBuZWVkcyBhbmQgZXhwZWN0YXRpb25zLgo+IAo+IFRoaXMg
bWF5IGFjdHVhbGx5IHdvcmssIHNpbmNlIHdlIGFyZSB0cnlpbmcgdG8gbWFrZSBraXJrIGZsZXhp
YmxlIGVub3VnaAo+IHRvIHJ1biBvdGhlciB0ZXN0c3VpdGVzLCBJIHRoaW5rIHRoYXQgd2UgYWxy
ZWFkeSBydW4gc3Vic2V0IG9mIHNlbGZ0ZXN0Cj4gd2l0aCBraXJrIGluIG91ciBlbnZpcm9ubWVu
dC4KCkknbSBub3QgY29udmluY2VkIHRoYXQgd291bGQgYmUgYSBncmVhdCBmaXQgZm9yIGVpdGhl
ciBwcm9qZWN0IHRvIGJlCmhvbmVzdC4gUmVhZGluZyBtb3JlIGJlbG93LCB5b3UgaGF2ZSBhIHZl
cnkgc3BlY2lmaWMgaWRlYSBvZiBob3cKY29tbXVuaWNhdGlvbiBzaG91bGQgaGFwcGVuIGFuZCBt
YW55IG9mIG91ciB0ZXN0IHdvcmtmbG93IG5lZWRzIGFyZQpnb2luZyB0byBiZSBvdXRzaWRlIG9m
IHNjb3BlIG9mIGEgc2luZ2xlIGJpbmFyeSBjb21tdW5pY2F0aW5nIG92ZXIKdmlydGlvLiBJdCBt
YWtlcyBzZW5zZSBmb3Iga2VybmVsIHRlc3RpbmcgYnV0IHdlIGhhdmUgb3RoZXIgbmVlZHMuCgo+
ID4gPiBUaGF0IGJlaW5nIHNhaWQsIHRoZSBjdXJyZW50IGtpcmsgaW1wbGVtZW50YXRpb24gZW5k
ZWQgdXAgbW9yZSBjb21wbGV4Cj4gPiA+IHRoYW4gSSB3b3VsZCBsaWtlIGl0LCBhbmQgdGhhdCBp
cyBzb21ldGhpbmcgdG8gaW1wcm92ZSBvdmVyIHRoZQo+ID4gPiBkZXByZWNhdGlvbiBwZXJpb2Qu
IFRoZSBnZW5lcmFsIGlkZWEgaXMgdG8gYWxsb3cgdXNlcnMgdG8gZXhwZXJpbWVudAo+ID4gPiB3
aXRoIGtpcmssIGV2ZW4gd2hlbiBpdCdzIG5vdCBwZXJmZWN0IHRvIGdldCBmZWVkYmFjayBhbmQg
aWRlYWxseSBtYWtlCj4gPiA+IGl0IHVzYWJsZSBmb3IgbW9zdCB1c2VjYXNlcyBiZWZvcmUgd2Ug
Z2V0IHJpZCBvZiBydW5sdHAgZm9yIGdvb2QuCj4gPiAKPiA+IEl0IHNvdW5kcyBsaWtlIHdlIG5l
ZWQgdG8gc3dpdGNoIHRvIGtpcmsgYW5kIHVzZSBpdCBzaW1wbHkgYXMgYSBkaXJlY3QKPiA+IHJ1
biBob3N0IGRyaXZlciwgYnV0IHdlIGFyZSBnb2luZyB0byBoYXZlIGEgbG90IG9mIGNvbXBsZXhp
dHkgaW4gdGhlcmUKPiA+IHdlIGFyZW4ndCBpbiBuZWVkIG9mLgo+IAo+IEknbSBhZnJhaWQgdGhh
dCdzIG5vdCBhIGdvb2Qgc29sdXRpb24gZWl0aGVyLiBUaGUgZW5kIGdvYWwgZm9yIGtpcmsgaXMK
PiB0byBoYXZlIGEgc21hbGwgYmluYXJ5IGxvY2tlZCBpbiBSQU0gYW5kIHdpdGggcmVhbHRpbWUg
cHJpb3JpdHkgdG8KPiBleGVjdXRlIHRlc3RzIGFuZCBzZW5kIGJhY2sgbG9ncywgaW4gY2FzZSBv
ZiBxZW11IG92ZXIgdmlydGlvLCB0byB0aGUKPiBraXJrLiBUaGF0IGlzIHRvIG1ha2Ugc3VyZSB0
aGF0IGxvZ3MgYXJlIGNvbGxlY3RlZCBwcm9wZXJseSBldmVuIHdoZW4KPiBrZXJuZWwgaXMgb3V0
IG9mIG1lbW9yeSBhbmQgaW4gYSBzaW1pbGFyIHNpdHVhdGlvbnMuCj4gCj4gSWYgeW91IHJ1biBr
aXJrIG9uIHRoZSBWTSwgcmVwb3J0aW5nIGlzIG5vdCBnb2luZyB0byBiZSByZWxpYWJsZS4KClRo
aXMgbWVhbnMgeW91J3JlIGVmZmVjdGl2ZWx5IG1hbmRhdGluZyBob3cgbHRwIGJlIHJ1biBhbmQg
dGhlIG9ubHkKdmFyaWFibGUgd291bGQgYmUgdGhlIGtlcm5lbCBiaW5hcnkuIFdoaWxzdCBJIGNh
biB1bmRlcnN0YW5kIHRoYXQsIEknbQpub3Qgc3VyZSBob3cgdXNlZnVsIHVzIHRlc3Rpbmcgd2l0
aCB0aGlzIHdvdWxkIGJlLgoKPiBNeSBpbml0aWFsIGlkZWEgd2FzIHRvIGJ1aWxkIHRoZSBuZXcg
Z2VuZXJhdGlvbiB0ZXN0cnVubmVyIGFzIGEgc2V0IG9mCj4gYnVpbGRpbmcgYmxvY2tzLCB0aGF0
IGNvdWxkIGJlIHJldXNlZCBzZXBhcmF0ZWx5LCBidXQgdGhlIGN1cnJlbnQgZGVzaW5nCj4gZG9l
cyBub3QgbWFrZSBpdCBlYXN5Lgo+IAo+IFdlIGRvIGhhdmUgdGhlIGx0eCBiaW5hcnksIHdoaWNo
IGlzIHRoZSBzbWFsbCBkaXNwYXRjaGVyIHN1cHBvc2VkIHRvIHJ1bgo+IG9uIHRoZSBWTS4gQW5k
IGluIGFuIGlkZWFsIHdvcmxkIHdlIHdvdWxkIGhhdmUgYSBweXRob24gbGlicmFyeSB0aGF0Cj4g
dGFsa3MgdG8gaXQgb24gdGhlIG90aGVyIGVuZCwgYXMgYSBwYXJ0IG9mIGtpcmssIHRoYXQgY291
bGQgYmUgcmV1c2VkCj4gc2VwYXJhdGVseS4gQW5kIHRoZSBzYW1lIGZvciBidWlsZGluZyBsaXN0
cyBvZiB0ZXN0IHRvIGV4ZWN1dGUsIGlkZWFsbHkKPiB3ZSB3b3VsZCBoYXZlIGEgcHl0aG9uIGxp
YnJhcnkgdGhhdCB3b3VsZCBleHBvcnQgYSBzaW1wbGUgaW50ZXJmYWNlIHNvCj4gdGhhdCBldmVy
eW9uZSBjb3VsZCBpbnRlZ3JhdGUgdGhlIGJsb2NrcyB0aGF0IHRoZXkgcmVhbGx5IG5lZWQgaW50
bwo+IHRoZWlyIHNvbHV0aW9uLgoKQXV0b21hdGVkIHRlc3RpbmcgaXMgYSBoYXJkIHByb2JsZW0g
dG8gc29sdmUgZ2VuZXJpY2FsbHkgYW5kIGV2ZW4gaWYKeW91IGRvIG1hbmFnZSB0aGF0LCB0aGlz
IGFsbCBsb29rcyBsaWtlIGEgbG90IG9mIHdvcmsgZXZlbiBqdXN0IHRvCnJlcHJvZHVjZSB3aGF0
IHdvcmtzIHRvZGF5IDovLgoKSSBkbyB1bmRlcnN0YW5kIHRoZSBpZGVhIGJ1dCBpbiBwcmFjdGlz
ZSwgSSBkb24ndCBoYXZlIHRoZSB0aW1lIG9yIGtub3cKYW55b25lIHdpdGggdGhlIHRpbWUgdG8g
cHV0IGludG8gc29tZXRoaW5nIGxpa2UgdGhpcy4gSSBjYW4gYmFyZWx5IGtlZXAKdGhlIHRlc3Rz
L2luZnJhIHdlIGhhdmUgcnVubmluZy4KCkNoZWVycywKClJpY2hhcmQKCgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
