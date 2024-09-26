Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970C8CCF9E9
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727338767; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=xMzs3BnON8Ul9SeDVoulWCYXJ0WfzSN6T0NGg4tkqAI=;
 b=ZqMgOVUyszdqJvqhhvNXx+QmnVRq6sqM8bAaYZ5ftBwyIoHadXpiWTArA/PUvfJPPsoCU
 Muwitoc3wfkKgVR3KFZneEAXNOhLguafwkgi3hdc+6f2W3Tx7MZ9XVU2RDc4LoNaatygvTu
 1F9YUL0f8Jijd+Y2bMTVzpWPt9TrGy4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A4D3C4E74
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 10:19:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E79F3C29CA
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 10:19:06 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2358664870F
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 10:19:05 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so649648a12.0
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727338744; x=1727943544; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPmGm82Tq/+2ldtjps5HdiErQf0tsdEEFrm5ak30Qu0=;
 b=ZZ9NRpwizgtp5rrIq1fHffKeN4t86XLfZ4jm5rqCj6AyRJm6OeYeX5FLXfINb/5R8s
 23JnsIm3HDuH0Ack/0qMRWRKGRGHVmHkVNlKNZs8ABvTLEncowqSucgrPSjV9B2OZGTz
 4dj54lRJljqpcORrGxY4XxU7TzhCzRuabdo9iQOG9a4UZBxJa0Q/ZXMLmkKs5E/JmZB6
 SgJroljuaoP9GYQIbZ9eQ4SDb1hRZZ1v2B83V+vVpHrgNPUQMDC2cZwrq9T1k0z3u4QK
 HxcrlFEdlPJqZm3wx4+n9b2RWFwGem02LNZ7jik76VRPLJ6zoefk2tbDnCCePsapglWb
 ORIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727338744; x=1727943544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPmGm82Tq/+2ldtjps5HdiErQf0tsdEEFrm5ak30Qu0=;
 b=V5+s+acrS1kby6lw5FffvHAV98ynQn+wzBds7XNas+UaQqLyxjDMcZuHbvuv2gkzhp
 /gh5ZpUhNiu3G80A/CaFl5hugw32auH84pF0rdwujIfuCfTylDkS0MHKiijzMzQpBLln
 Dypvwl6pYIN64ZkwY8H/JY16olvMe5JOtjCbbJqcw4yPWuAakiY5rJL5m+j1Lz2JNr03
 lms03QKT2U6K9fIENmhMknhg0Mc5q8/jhcCHHeCFUHK5gsJaKOtjZkzVVLaW+U2yhNNd
 r8yyhDMSdZEvU7bcWnyH8jbbXqeGis2NGKxhcqqp02Quroxw0NiDzDyw/SMnV2DL5VmJ
 9/6A==
X-Gm-Message-State: AOJu0Yxbc06Fsehk8Wd73+l08CCtBwMF9lkoVpffPQVZR+XDLjfmr2Kp
 sk7QJhBE5nwY9bYMAjTidyyIP3RSezNPlDXwcbLSJygnKVrHWEmGQH/27nIVj+h+9a3LE3NFv+3
 S
X-Google-Smtp-Source: AGHT+IEhlBuqmpNkjN9mmfAHHm+WSBoMlH15yXMEN9ZgLwo+/EU/uitQMZDcDQEfYZC3//ZVgH8cgA==
X-Received: by 2002:a05:6402:5cd:b0:5c7:2295:f238 with SMTP id
 4fb4d7f45d1cf-5c72295f3a0mr3097003a12.30.1727338744469; 
 Thu, 26 Sep 2024 01:19:04 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.112.18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf48c10esm2831811a12.13.2024.09.26.01.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 01:19:04 -0700 (PDT)
Message-ID: <21b8462a-a9ad-4660-a36f-4fd90255c96b@suse.com>
Date: Thu, 26 Sep 2024 10:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
 <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
 <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
 <CAASaF6wYYSfjxgg2byVBDhqCpQs9-8ngJZv8LrrJiytPR2=+ag@mail.gmail.com>
 <5e157a19-8832-4531-b1b5-617f2a1044d5@suse.com>
 <CAASaF6zHWu3CwTGNyu+gGNeqE_58gCA1XeysO0hPBbr14DpCtQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAASaF6zHWu3CwTGNyu+gGNeqE_58gCA1XeysO0hPBbr14DpCtQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

Ck9uIDkvMjYvMjQgMDk6NDcsIEphbiBTdGFuY2VrIHdyb3RlOgo+IE9uIFRodSwgU2VwIDI2LCAy
MDI0IGF0IDk6MDfigK9BTSBBbmRyZWEgQ2VydmVzYXRvCj4gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5jb20+IHdyb3RlOgo+Pgo+PiBPbiA5LzI1LzI0IDIyOjAxLCBKYW4gU3RhbmNlayB3cm90ZToK
Pj4+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDM6MjTigK9QTSBBbmRyZWEgQ2VydmVzYXRvCj4+
PiA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4+Pj4gT24gOS8yNC8yNCAxNTox
NiwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4+Pj4+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDEwOjQ2
4oCvQU0gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwCj4+Pj4+IDxsdHBAbGlzdHMubGludXguaXQ+
IHdyb3RlOgo+Pj4+Pj4gSGkhCj4+Pj4+Pgo+Pj4+Pj4gUGxlYXNlIGNvbnNpZGVyIHRoaXMgcGF0
Y2hzZXQgYXMgYSBkcmFmdCBvcGVuIGZvciBkaXNjdXNzaW9uLgo+Pj4+PiBIYXZlIHlvdSBjb21w
YXJlZCBvbGQgYW5kIG5ldyBkZWZpbmVzPyBBcmUgdGhlcmUgYW55IGRpZmZlcmVuY2VzCj4+Pj4+
IChvdGhlciB0aGFuIGFkZGl0aW9ucyk/Cj4+Pj4+Cj4+Pj4gT25seSBhZGRpdGlvbnMsIGJ1dCB0
aGlzIGlzIGEgZHJhZnQgd29yayBhbmQgSSdtIHNlYXJjaGluZyBmb3IKPj4+PiBhbHRlcm5hdGl2
ZSBpZGVhcyBhcyB3ZWxsLgo+Pj4+IEZvciBleGFtcGxlLCB0aGUgbGltaXRhdGlvbiBvZiB0aGlz
IGFwcHJvYWNoIGlzIHRoYXQgc3lzY2FsbHMuaCBoYXMgdG8KPj4+PiBiZSBnZW5lcmF0ZWQgYW55
d2F5Lgo+Pj4gSSBndWVzcyBpdCB3b3VsZG4ndCBiZSB0b28gZGlmZmljdWx0IHRvIGNoYW5nZSBz
Y3JpcHQgdG8gZ2VuZXJhdGUgLmluCj4+PiBmaWxlcyBpbnN0ZWFkLCByaWdodD8KPj4gSSdtIGFs
cmVhZHkgZG9pbmcgaXQgaW4gdGhlIGdlbmVyYXRlX3N5c2NhbGxzLnNoIHNjcmlwdCwgc28gaXQn
cyBxdWl0ZQo+PiBlYXN5LiBUaGUgcG9pbnQgaXMgaWYgd2Ugd2FudCB0byBtYWtlIHRoaXMgZXh0
cmEgc3RlcCwgYmVjYXVzZSBtYXliZSB3ZQo+PiBjYW4ganVzdCBkb3dubG9hZCB0aGUgdGFibGVz
IGFscmVhZHkgY3JlYXRlZCBieSB0aGUgc3lzY2FsbHMtdGFibGUKPj4gcHJvamVjdCBhbmQgd2Ug
aGF2ZSAuaW4gZmlsZXMgZm9yIGZyZWUuIEJ1dCB0aGF0IGFwcHJvYWNoIGhhcyBkb3duc2lkZXMK
Pj4gb2YgY291cnNlLgo+Pj4+IEF0IHRoZSBzYW1lIHRpbWUsIHdlIGhhdmUgcHJvamVjdHMgbGlr
ZQo+Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9ocncvc3lzY2FsbHMtdGFibGUgKHRoYXQgaW5zcGly
ZWQgbXkgc2NyaXB0KQo+Pj4+IHByb3ZpZGluZyBweXRob24gYmluZGluZ3MgYW5kICptYXliZSog
aXQgY291bGQgYmUgdXNlZCB0byBjcmVhdGUgYQo+Pj4+IHB5dGhvbiBzY3JpcHQgd2hpY2ggZ2Vu
ZXJhdGUgLmluIGZpbGVzIHdoZW4gdGhleSBuZWVkIHRvIGJlIHVwZGF0ZWQuCj4+PiBweXRob24g
ZmVlbHMgbGlrZSBhbiBleHRyYSBzdGVwLCBzaW5jZSB3ZSBjb3VsZCBkbyBpdCBpbiBleGlzdGlu
ZyBzaGVsbCBzY3JpcHQuCj4+PiBNYXliZSBzdG9yZSBhIGNvcHkgb2YgdXBkYXRlLXRhYmxlcy5z
aCBpbiBMVFAgcmVwbywgYW5kIGFkZCBzb21lIHdyYXBwZXIKPj4+IHRvIHByb3ZpZGUgY3JlYXRl
X3RhYmxlc19mb3JfTFRQKCkgZnVuY3Rpb24gYW5kIGEgY2hlY2sgdG8gcHJpbnQgd2FybmluZyBp
Zgo+Pj4gb3JpZ2luYWwgZ2l0aHViIHByb2plY3QgY2hhbmdlcyB1cGRhdGUtdGFibGVzLnNoLgo+
Pj4KPj4+IGNyZWF0ZV90YWJsZXNfZm9yX0xUUCgpIHdvdWxkIGdlbmVyYXRlIC5pbiBmaWxlcyBh
bmQgcmVzdCBjYW4gc3RheSBhcyBpdCBpcy4KPj4gSSB3YXMgYWxzbyB0aGlua2luZyB0aGF0IG1h
eWJlIGl0J3MgZW5vdWdoIHRvIGhhdmUgMiBzY3JpcHRzOiBvbmUgZm9yCj4+IHVwZGF0aW5nIHN5
c2NhbGxzIC5pbiBmaWxlcyB3aGVuIG5lZWRlZCBhbmQgb25lIGZvciBtZXJnaW5nIHRoZW0uCj4+
Cj4+IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaW4gdGhpcyBhcHByb2FjaCBpczogd2hlbiBkbyB3
ZSB3YW50IHRvIHVwZGF0ZQo+PiB0YWJsZXM/IEl0IHdvdWxkIGJlIG5pY2UgdG8gZG8gdGhhdCBl
dmVyeSAuL2NvbmZpZ3VyZSAsIGJ1dCB0aGF0IHdvdWxkCj4+IGJlIHRvbyBtdWNoIGJlY2F1c2Ug
b2YgZ2l0L2N1cmwgZGVwZW5kZW5jeS4KPiBMVFAgY2FuIHJ1biBpbiBsYWJzIHdpdGggbm8gZXh0
ZXJuYWwgbmV0d29yayBhY2Nlc3MsIHNvIEknZCBhdm9pZCBhbnkgZG93bmxvYWQKPiBhcyBwYXJ0
IG9mIGNvbmZpZ3VyZS4gQW5kIGluIHVubGlrZWx5IGNhc2UgZ2l0aHViIHByb2plY3QgZGlzYXBw
ZWFycwo+IHdlIHdvdWxkIGhhdmUKPiBMVFAgcmVsZWFzZXMgb3V0IHRoZXJlIHdpdGggYnJva2Vu
IGNvbmZpZ3VyZS4KPgo+IExvb2tpbmcgYXQgZ2l0IGxvZywgaW4gbGFzdCBjb3VwbGUgeWVhcnMg
d2UgdXBkYXRlZCBzeXNjYWxscyBtYXliZSAzLTQKPiB0aW1lcyBlYWNoIHllYXIuCj4gSSB0aGlu
ayBpdCdzIGVub3VnaCB0byBoYXZlIGl0IGFzIGFuIGV4dHJhIHN0ZXAgd2hlbiB3ZSBuZWVkIHRv
IHVwZGF0ZSBzeXNjYWxscy4KPiBJIHNlZSBpdCBhcyBhIGhlbHBlciBzY3JpcHQgeW91IHJ1biB0
byBwYXRjaCAuaW4gZmlsZXMuIEV2ZW4gaWYgdGhhdAo+IHVzZXMgcmVhZGlseSBhdmFpbGFibGUK
PiB0YWJsZXMgZnJvbSBnaXRodWIgcHJvamVjdCwgaXQgd291bGQgc3RpbGwgYmUgYSBwYXRjaCB0
aGF0IHBlb3BsZSBjYW4KPiByZXZpZXcgYW5kIHNwb3QKPiBwb3RlbnRpYWwgaXNzdWVzIChvcmln
aW5hdGluZyBmcm9tIHNjcmlwdCBvciB0YWJsZXMpLgoKWWVhaCwgdGhpcyBpcyBzb21ldGhpbmcg
aSB3YXMgdGhpbmtpbmcgYWJvdXQuIFdlIGNhbiBjcmVhdGUgYSBzY3JpcHQgZm9yIAptZXJnaW5n
IG5ldyBzeXNjYWxscyBpbnRvIHRoZSBjdXJyZW50IC5pbiBmaWxlcyBhbmQgc2NyaXB0IGNhbiBi
ZSAKdHJpZ2dlcmVkIG9ubHkgd2hlbiBuZWVkZWQuIEkgd2lsbCB0YWtlIGEgbG9vayBhdCBpdC4K
ClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrCgo+Pj4+IEV0Yy4uCj4+Pj4KPj4+Pj4+IEFuZHJlYQo+
Pj4+Pj4KPj4+Pj4+IE9uIDkvMjQvMjQgMTA6MDYsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4+
Pj4+Pj4gVGhlIHByb2JsZW0gd2UgaGF2ZSBhdCB0aGUgbW9tZW50IGlzIHRoYXQgYWxsIHN5c2Nh
bGxzIGlucHV0IGZpbGVzIG11c3QKPj4+Pj4+PiBiZSBjaGFuZ2VkIGJ5IGhhbmQgZWFjaCB0aW1l
IHdlIG5lZWQgdG8gdGVzdCBhIG5ldyBzeXNjYWxsLiBUaGUgaWRlYSBpcwo+Pj4+Pj4+IHRvIHNp
bXBsaWZ5IHRoaXMgcHJvY2VzcywgcHJvdmlkaW5nIGEgc2NyaXB0IHRoYXQgaXMgYWJsZSB0byBy
ZWFkIGZyb20KPj4+Pj4+PiBrZXJuZWwgc291cmNlcyBhbmQgdG8gZ2VuZXJhdGUgYWxsIHN5c2Nh
bGxzIGZpbGVzIHdlIG5lZWQuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIGlzIGRvbmUgYnkgdGhlIGdl
bmVyYXRlX3N5c2NhbGxzLnNoIHNjcmlwdCB0aGF0IGNhbiBiZSB1c2VkIGFzCj4+Pj4+Pj4gZm9s
bG93aW5nOgo+Pj4+Pj4+Cj4+Pj4+Pj4gLi9nZW5lcmF0ZV9zeXNjYWxscy5zaCBwYXRoL3RvL2tl
cm5lbC9zb3VyY2UgcGF0aC90by9zeXNjYWxscy5oCj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIGFwcHJv
YWNoIHJlcXVpcmVzIGEgY2VydGFpbiB0eXBlIG9mIGF0dGVudGlvbiwgZHVlIHRvIHRoZSBmYWN0
IHRoYXQKPj4+Pj4+PiB3ZSBuZWVkIHRvIGdlbmVyYXRlIHN5c2NhbGxzLmggYXQgZWFjaCBrZXJu
ZWwgdmVyc2lvbiwgb3Igd2hlbiBuZXcKPj4+Pj4+PiBzeXNjYWxscyBoYXZlIGJlZW4gYWRkZWQg
aW4gdGhlIGtlcm5lbC4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2
ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gQW5k
cmVhIENlcnZlc2F0byAoNCk6Cj4+Pj4+Pj4gICAgICAgICAgIFJlbmFtZSBzeXNjYWxscyBvcmRl
ciBmaWxlIHRvIHN1cHBvcnRlZC1hcmNoLnR4dAo+Pj4+Pj4+ICAgICAgICAgICBBZGQgc2NyaXB0
IHRvIGdlbmVyYXRlIHN5c2NhbGxzLmgKPj4+Pj4+PiAgICAgICAgICAgRGVwcmVjYXRlIG9sZCBz
eXNjYWxscyBpbnB1dCBmaWxlcwo+Pj4+Pj4+ICAgICAgICAgICBTYXZlIHN5c2NhbGxzLmggaW5z
aWRlIHJlcG8KPj4+Pj4+Pgo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpLy5naXRpZ25vcmUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgMSAtCj4+Pj4+Pj4gICAgICBpbmNsdWRlL2xh
cGkvc3lzY2FsbHMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDM0MjcyICsrKysrKysr
KysrKysrKysrKysKPj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hYXJjaDY0Lmlu
ICAgICAgICAgICAgICAgICAgIHwgICAzMDYgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5
c2NhbGxzL2FyYy5pbiAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMyNSAtCj4+Pj4+Pj4gICAg
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NDA0IC0KPj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9ibGFja2xpc3Qtc3lzY2Fs
bHMudHh0ICAgICAgIHwgICAgIDYgKwo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxz
L2dlbmVyYXRlX3N5c2NhbGxzLnNoICAgICAgICAgfCAgIDI5MiArCj4+Pj4+Pj4gICAgICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvaHBwYS5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgIDUyIC0K
Pj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9pMzg2LmluICAgICAgICAgICAgICAg
ICAgICAgIHwgICA0MzkgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQu
aW4gICAgICAgICAgICAgICAgICAgICAgfCAgIDk1NiArLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9s
YXBpL3N5c2NhbGxzL2xvb25nYXJjaC5pbiAgICAgICAgICAgICAgICAgfCAgIDMxMCAtCj4+Pj4+
Pj4gICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbWlwc19uMzIuaW4gICAgICAgICAgICAgICAg
ICB8ICAgMzc5IC0KPj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBzX242NC5p
biAgICAgICAgICAgICAgICAgIHwgICAzNTUgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5
c2NhbGxzL21pcHNfbzMyLmluICAgICAgICAgICAgICAgICAgfCAgIDQyNSAtCj4+Pj4+Pj4gICAg
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcG93ZXJwYy5pbiAgICAgICAgICAgICAgICAgICB8ICAg
NDMyIC0KPj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9wb3dlcnBjNjQuaW4gICAg
ICAgICAgICAgICAgIHwgICA0MzIgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxz
L3JlZ2VuLnNoICAgICAgICAgICAgICAgICAgICAgfCAgIDEyOSAtCj4+Pj4+Pj4gICAgICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvczM5MC5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgNDE5IC0K
Pj4+Pj4+PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zMzkweC5pbiAgICAgICAgICAgICAg
ICAgICAgIHwgICAzNjcgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3NoLmlu
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQxMyAtCj4+Pj4+Pj4gICAgICBpbmNsdWRlL2xh
cGkvc3lzY2FsbHMvc3BhcmMuaW4gICAgICAgICAgICAgICAgICAgICB8ICAgNDE4IC0KPj4+Pj4+
PiAgICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zcGFyYzY0LmluICAgICAgICAgICAgICAgICAg
IHwgICAzODMgLQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3N0cmlwX3N5c2Nh
bGwuYXdrICAgICAgICAgICAgfCAgICAxOSAtCj4+Pj4+Pj4gICAgICAuLi4vbGFwaS9zeXNjYWxs
cy97b3JkZXIgPT4gc3VwcG9ydGVkLWFyY2gudHh0fSAgICB8ICAgICAxIC0KPj4+Pj4+PiAgICAg
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy94ODZfNjQuaW4gICAgICAgICAgICAgICAgICAgIHwgICAz
OTYgLQo+Pj4+Pj4+ICAgICAgMjUgZmlsZXMgY2hhbmdlZCwgMzUxNzQgaW5zZXJ0aW9ucygrKSwg
Njc1NyBkZWxldGlvbnMoLSkKPj4+Pj4+PiAtLS0KPj4+Pj4+PiBiYXNlLWNvbW1pdDogOTY4ZTYy
NDVkOTNiYzkxNzIzZTcyMDg2YTcxZTZiYzUwZjQ5NWQwYgo+Pj4+Pj4+IGNoYW5nZS1pZDogMjAy
NDA5MjMtZ2VuZXJhdGVfc3lzY2FsbHMtNzgwZGMyMjI3YmRiCj4+Pj4+Pj4KPj4+Pj4+PiBCZXN0
IHJlZ2FyZHMsCj4+Pj4+PiAtLQo+Pj4+Pj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4+Pj4+PgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
