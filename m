Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6774C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:08:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27A183D0A9A
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 18:08:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E583D0767
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:08:12 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39D6A20116C
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:08:12 +0200 (CEST)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eadaac1d28so16802431fa.3
 for <ltp@lists.linux.it>; Fri, 07 Jun 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1717776491; x=1718381291;
 darn=lists.linux.it; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RoMoDV0/+Q+VcTi0PL5heOpoHjv8KadcTn5A/FhwjCc=;
 b=ZoY8ohShF+dZfp4mwPfwDXwWSv0L8ft2/GdludLE6t8U5UGtnnsamthueH2ps8Tngj
 j7LeKm/86QFjC93tHLNPF7v8abIdcrnF2/G96THFgOFlyqJw/TbHavk97LUFLeP9OtvY
 6lMFmDjG1b13M6z0fY7KMHUTcEiHJ/Z0PtQ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717776491; x=1718381291;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RoMoDV0/+Q+VcTi0PL5heOpoHjv8KadcTn5A/FhwjCc=;
 b=F9zQH8F2gIQI8M//Sr1b6yL/pO1bXOCXBaty55iC5d7hEt23avFTtUt8g03rkQO3wx
 XOMU8YaGt/8bqPkdkcNgE8IQNVp+MMjsYCUS3/rK7lHDaXdi1r64pFdbM+x+Kd/kEpiY
 qwzWsxtCUDmdMozvxIEbdx9tpx6DeW/cuR1bX3QusW+cMwCDLo4LRjIGHWfGCfHCAmIM
 rvBkMzbzTWi7Qpd+0IeXC9QgwV1UnYhR68ol6F94/XN5tNvSZdRY6CXUx0nv74/pW5zt
 rv25mv3Shlacac4s/4SqmVYMRr5Jw6Xhc96QiYL+vTE4ILBAP7fqfN4PvpAoYaItxRE1
 mlLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJc0rJMOhD8EXm3wjbGNjFe4/7RIUen0xwSXXiO48MxBGkvXmDEloSWpA1C+uG5eYQieAkMursT2umO9sThBlmsXg=
X-Gm-Message-State: AOJu0Yw4LwEGWCYtjjIWRexS8vNdH/Y1j9U0wbXnsFjQv/rBnq1K6K/R
 oMjNcL6azq5xZ0/y9oczVRzDPNSsSr/+ZUICezzh6U+UbOW+Jm/NYfewXTzAJ+s=
X-Google-Smtp-Source: AGHT+IEELN0VsQdoSgEYSUJ1Zo0S4fW2Wn3T+Mwb26VCc1jBVrPO0FtD7cp9avKZtznitcXmLVDd+g==
X-Received: by 2002:a2e:9d8b:0:b0:2ea:7e38:7968 with SMTP id
 38308e7fff4ca-2eadce8898bmr19046251fa.53.1717776491308; 
 Fri, 07 Jun 2024 09:08:11 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:910f:5798:f456:d86d?
 ([2001:8b0:aba:5f3c:910f:5798:f456:d86d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm56959405e9.25.2024.06.07.09.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 09:08:10 -0700 (PDT)
Message-ID: <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 07 Jun 2024 17:08:10 +0100
In-Reply-To: <ZmMrBnkIXKfrF8Xv@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDE3OjQ1ICswMjAwLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4g
SGkhCj4gPiA+IGtpcmsgaXMgbm90IHBlcmZlY3QgYnV0IGFscmVhZHkgbXVjaCBiZXR0ZXIgdGhh
biBvbGQgcnVubHRwIHNjcmlwdC4KPiA+ID4gTGV0J3MgZGVwcmVjYXRlIHJ1bmx0cCBhbmQgcHJv
cGFnYXRlIGtpcmsuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4KPiA+ID4gLS0tCj4gPiA+IMKgcnVubHRwIHwgMTMgKysrKysrKysrKysrKwo+
ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IEknZCBub3Rl
IHRoYXQgWW9jdG8gUHJvamVjdCdzIENJIGlzIHN0aWxsIHVzaW5nIHJ1bmx0cCBhbmQgd2UgaGF2
ZSBubwo+ID4gcmVjaXBlIGZvciBraXJrLCBvciBhbnkgZXhwZXJpZW5jZSBvZiB1c2luZyBpdC4K
PiAKPiBUaGF0J3Mgd2h5IHJ1bmx0cCBpc24ndCBnb2luZyB0byBkaXNhcHBlYXIgd2l0aG91dCBh
IGRlcHJlY2F0aW9uIHBlcmlvZCwKPiB0aGUgaWRlYSBpcyB0byBhZGQgdGhlIGRlcHJlY2F0aW9u
IGFuZCB3YWl0IGEgZmV3IHJlbGVhc2VzIGJlZm9yZSB0aGUKPiBmaW5hbCByZW1vdmFsLCB0aGF0
IGluIHByYWN0aWNhbCB0ZXJtcyBtZWFucyBhdCBsZWFzdCBhIHllYXIsIHBvc3NpYmx5Cj4gdHdv
IGZvciB1c2VycyB0byBleHBsb3JlIHRoZSByZXBsYWNlbWVudCBhbmQgZ2l2ZSB1cyBmZWVkYmFj
ay4KCkl0IGhlbHBzIHRvIGtub3cgdGhhdCwgaXQgd2Fzbid0IGNsZWFyIGhvdyBxdWlja2x5IHlv
dSBwbGFuZWQgdG8gcmVtb3ZlCnJ1bmx0cCEKCj4gPiBUaGlzIGRvZXMgdGhlcmVmb3JlIHdvcnJ5
IG1lIGEgbGl0dGxlIGJpdCwgdGhlcmUgYXBwZWFycyB0byBiZSBhIGxvdAo+ID4gb2YgY29tcGxl
eGl0eSBpbiBraXJrIHdlIGRvbid0IG5lZWQuCj4gCj4gSSB3b3VsZCBzYXkgdGhhdCB0aGVyZSBp
cyBhIGNvbXBsZXhpdHkgdGhhdCB5b3UgZG8gbm90IHRoaW5rIHRoYXQgeW91Cj4gbmVlZCBidXQg
aW4gcmVhbGl0eSB5b3UgZG8uIEZpcnN0IG9mIGFsbCB0aGUgYXNzdW1wdGlvbiB0aGF0IHlvdSBj
YW4KPiBoYXZlIHRoZSB0ZXN0IHJ1bm5lciB0aGF0IGtlZXBzIHRoZSByZXN1bHRzIGFuZCBvdmVy
YWxsIHN0YXRlIG9uIHRoZQo+IHNhbWUgbWFjaGluZSB0aGF0IHJ1bnMgdGhlIHRlc3RzIGlzIHRo
ZSBtb3N0IGZsYXdlZCBvZiB0aGVtIGFsbC4gU28KPiBydW5uaW5nIHRoZSB0ZXN0cyBvdmVyIHNv
bWUga2luZCBvZiBjb25uZWN0aW9uIGlzIHRoZSBiYXNpcyBkZXNpZ24KPiBwcmluY2lwbGUgb2Yg
a2lyay4gVGhhdCBhbGxvd3MgdXMgdG8gZWFzaWx5IGFuZCBzYWZlbHkgZGV0ZWN0IHdoZW4gd2UK
PiBjcmFzaCBrZXJuZWxzIHdpdGggb3VyIHRlc3RzLCB3aGljaCB0ZW5kIHRvIGhhcHBlbiBtb3Jl
IG9mdGVuIHRoYW4gbW9zdAo+IHBlb3BsZSB0aGluay4gQW5kIEkgY2FuIGdvIGFib3V0IGFsbCB0
aGUgdGhpbmdzIHRoYXQgYXJlIHRoZXJlIGJlY2F1c2UKPiBvZiBhIGdvb2QgcmVhc29ucyBmb3Ig
aG91cnMuCgpJIHRoaW5rIHlvdSBtaXN1bmRlcnN0YW5kIG15IHBvaW50LiBZb2N0byBwcm9qZWN0
IGFscmVhZHkgaGFzIGNvZGUgdG8KaGFuZGxlIHNldHRpbmcgdXAgcWVtdSBpbnN0YW5jZXMsIGNv
bm5lY3RpbmcgdG8gdGhlbSwgY29sbGVjdGluZyBkYXRhCmZyb20gdGhlbSBldGMuIGFuZCB3ZSB1
c2UgdGhhdCB3aXRoIGx0cCBpbiB0aGUgc2FtZSB3YXkgd2UgdXNlIGl0IGZvcgpsb3RzIG9mIG90
aGVyIHRlc3RzLiBTbyB5ZXMsIEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB5b3UgbmVlZCBhCmNvbm5l
Y3Rpb24gYnV0IHdlIGFscmVhZHkgaGF2ZSBhIHNvbHV0aW9uIGZvciB0aGF0LsKgCgpXZSBwcm9i
YWJseSBkb24ndCB3YW50IHNvbWUgdGVzdHMgZG9pbmcgdGhpcyB3aXRoIGtpcmsgYW5kIGV2ZXJ5
dGhpbmcKZWxzZSBkb2luZyBpdCBkaWZmZXJlbnRseS4gSSBzdXNwZWN0IHdlIHdvdWxkbid0IHdh
bnQgdG8gc3dpdGNoCmV2ZXJ5dGhpbmcgd2UncmUgZG9pbmcgb3ZlciB0byBraXJrIGVpdGhlciBh
cyB0aGF0IHdvdWxkbid0IHdvcmsgZm9yIHVzCm9yIHRoZSBraXJrIG1haW50YWluZXJzIGR1ZSB0
byBkaWZmZXJpbmcgbmVlZHMgYW5kIGV4cGVjdGF0aW9ucy4KCj4gVGhhdCBiZWluZyBzYWlkLCB0
aGUgY3VycmVudCBraXJrIGltcGxlbWVudGF0aW9uIGVuZGVkIHVwIG1vcmUgY29tcGxleAo+IHRo
YW4gSSB3b3VsZCBsaWtlIGl0LCBhbmQgdGhhdCBpcyBzb21ldGhpbmcgdG8gaW1wcm92ZSBvdmVy
IHRoZQo+IGRlcHJlY2F0aW9uIHBlcmlvZC4gVGhlIGdlbmVyYWwgaWRlYSBpcyB0byBhbGxvdyB1
c2VycyB0byBleHBlcmltZW50Cj4gd2l0aCBraXJrLCBldmVuIHdoZW4gaXQncyBub3QgcGVyZmVj
dCB0byBnZXQgZmVlZGJhY2sgYW5kIGlkZWFsbHkgbWFrZQo+IGl0IHVzYWJsZSBmb3IgbW9zdCB1
c2VjYXNlcyBiZWZvcmUgd2UgZ2V0IHJpZCBvZiBydW5sdHAgZm9yIGdvb2QuCgpJdCBzb3VuZHMg
bGlrZSB3ZSBuZWVkIHRvIHN3aXRjaCB0byBraXJrIGFuZCB1c2UgaXQgc2ltcGx5IGFzIGEgZGly
ZWN0CnJ1biBob3N0IGRyaXZlciwgYnV0IHdlIGFyZSBnb2luZyB0byBoYXZlIGEgbG90IG9mIGNv
bXBsZXhpdHkgaW4gdGhlcmUKd2UgYXJlbid0IGluIG5lZWQgb2YuCgpDaGVlcnMsCgpSaWNoYXJk
CgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
