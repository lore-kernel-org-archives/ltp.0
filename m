Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703AFC4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 09:06:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D57753CC936
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 10:06:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6436A3C0349
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 10:06:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE9C21400F4C
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 10:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705568765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xzdzh/IqfRzkB1iEhHMYUQHP7osXzqz0O6DO3Vjn51E=;
 b=Bwb15MQN19kf4AqcxiC1aQFwXGZt+37H9DmAUv7iY8YSvi8ZetRBSz/BBtnpPYxsQ2c0Qk
 7Y1GRyaPIY+4MkCPglLtMfAlTK7DRaOXtwNNAG2aHbh0ZqG+IiQCEb5Gck+b33bmIbpTmW
 8cM3iqL2IiYtCrxNdpuhTr5FvjamEBA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-fBGeji-JNxqLIWgtwuxuLw-1; Thu, 18 Jan 2024 04:06:01 -0500
X-MC-Unique: fBGeji-JNxqLIWgtwuxuLw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c66a69ec8eso11165629a12.3
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705568760; x=1706173560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xzdzh/IqfRzkB1iEhHMYUQHP7osXzqz0O6DO3Vjn51E=;
 b=v2vO+IU9KOB/hchqvpB8zrdwBRyc3mqvBQ11WaTWJfwOWcqfndwZT/d2iQA0S9Q0pL
 XRKLocPvmmdfjy8XuSh6FrXapcw6OykNIqDnVzMCkQW8gjPKDNNhRf1vY+wGwUBPEzGC
 Y9bqqmGJ5dL/y6BkLjjnBJSUCHJMspoPqSFvbWEr4J/HXea713qw2r1u7YwBRLWABtMd
 BAq7C4/X2PFReOLjF8OX7zxC1hoikaC8rxmln8iNUxNaDETiflDO3up0WC6hA+Hg6gll
 Ymzv51WVUkGH1//RAQRaNmnwauB2jO2LP5mdGbwWrPcmkmXOnpBfmgslm6A01wnB8fgW
 2iug==
X-Gm-Message-State: AOJu0YxaxWTlrqyw5plN7F3RNumywYK6RISyxjh6lxQc9EsYlHj3M0go
 W40S1NSMjjvIejXU5sox29YPy0XSqGBdV8+nCx++qGk3/MFnM8yuk+yLQq+0cIdxuAP47xKNJjj
 YuyGGVYShzpeu+9En+2wrs0Hhkk8Ir2u+M8tdMzW5P6xdPiFGUQPQMl8wTnWQC8s3D4JMxSdMZh
 5ogUVIKqdXKWIEOSAQUy57oGY=
X-Received: by 2002:a05:6a20:6e18:b0:19a:2733:58d3 with SMTP id
 go24-20020a056a206e1800b0019a273358d3mr383508pzb.85.1705568760221; 
 Thu, 18 Jan 2024 01:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG7oBrqitJCfi097HTzsEQxAF+BJd3al6DwXFK7lKy7DQOJAtvaFq81/el1Minf4v/o44tHqVOyGi1MtTjv3U=
X-Received: by 2002:a05:6a20:6e18:b0:19a:2733:58d3 with SMTP id
 go24-20020a056a206e1800b0019a273358d3mr383495pzb.85.1705568759887; Thu, 18
 Jan 2024 01:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20240118090004.2748107-1-pvorel@suse.cz>
In-Reply-To: <20240118090004.2748107-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jan 2024 17:05:47 +0800
Message-ID: <CAEemH2e_EEQ_EpqPCM2BOCAquZByEvzLNcmdwRAi1MYxoOJGHg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_supported_fs_types: Disable FUSE bcachefs
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
Cc: Brian Foster <bfoster@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTgsIDIwMjQgYXQgNTowMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gYmNhY2hlZnMgZ290IGludG8gdGhlIGtlcm5lbCBpbiA2LjcgdGhlcmVm
b3JlIGl0J3Mgbm90IG11Y2ggdXNlZnVsIGZvcgo+IHRlc3RpbmcgRlVTRSB2ZXJzaW9uLgo+Cj4g
Tk9URTogVGhlIG9yaWdpbmFsIHB1cnBvc2UgZm9yIHRoaXMgd2FzIGEgZmFpbHVyZSB3aXRoIGJj
YWNoZWZzLXRvb2xzIG9uCj4ga2VybmVsIHdpdGhvdXQgYmNhY2hlZnMgc3VwcG9ydCAoZS5nLiBr
ZXJuZWwgPCA2LjcpOgo+Cj4gICAgICMgTFRQX1NJTkdMRV9GU19UWVBFPWJjYWNoZWZzIC4vY2hk
aXIwMQo+ICAgICAuLi4KPiAgICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjU3OiBUSU5GTzog
bWtmcy5iY2FjaGVmcyBkb2VzIGV4aXN0Cj4gICAgIHRzdF90ZXN0LmM6MTY2OTogVElORk86ID09
PSBUZXN0aW5nIG9uIGJjYWNoZWZzID09PQo+ICAgICB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBG
b3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCBiY2FjaGVmcyBvcHRzPScnCj4gICAgIGV4dHJhIG9w
dHM9JycKPiAgICAgdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0
bwo+ICAgICAvdG1wL0xUUF9jaGR3cWhHdFovbW50cG9pbnQgZnN0eXA9YmNhY2hlZnMgZmxhZ3M9
MAo+ICAgICB0c3RfdGVzdC5jOjExMzE6IFRCUk9LOiBtb3VudCgvZGV2L2xvb3AwLCBtbnRwb2lu
dCwgYmNhY2hlZnMsIDAsIChuaWwpKQo+ICAgICBmYWlsZWQ6IEVOT0RFViAoMTkpCj4KPiBTdWdn
ZXN0ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgbGliL3RzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYyB8IDEw
ICsrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9saWIvdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jIGIvbGliL3RzdF9zdXBwb3J0ZWRf
ZnNfdHlwZXMuYwo+IGluZGV4IDM2OTgzNjcxNy4uYmJiYjhkZjE5IDEwMDY0NAo+IC0tLSBhL2xp
Yi90c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMKPiArKysgYi9saWIvdHN0X3N1cHBvcnRlZF9mc190
eXBlcy5jCj4gQEAgLTMzLDYgKzMzLDExIEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBmc190
eXBlX3doaXRlbGlzdFtdID0gewo+ICAgICAgICAgTlVMTAo+ICB9Owo+Cj4gK3N0YXRpYyBjb25z
dCBjaGFyICpjb25zdCBmc190eXBlX2Z1c2VfYmxhY2tsaXN0W10gPSB7Cj4gKyAgICAgICAiYmNh
Y2hlZnMiLAo+ICsgICAgICAgTlVMTCwKPiArfTsKPiArCj4gIHN0YXRpYyBjb25zdCBjaGFyICpm
c190eXBlc1tBUlJBWV9TSVpFKGZzX3R5cGVfd2hpdGVsaXN0KV07Cj4KPiAgc3RhdGljIGludCBo
YXNfbWtmcyhjb25zdCBjaGFyICpmc190eXBlKQo+IEBAIC05Niw2ICsxMDEsMTEgQEAgc3RhdGlj
IGVudW0gdHN0X2ZzX2ltcGwgaGFzX2tlcm5lbF9zdXBwb3J0KGNvbnN0IGNoYXIKPiAqZnNfdHlw
ZSkKPgo+ICAgICAgICAgU0FGRV9STURJUih0ZW1wbGF0ZSk7Cj4KPiArICAgICAgIGlmICh0c3Rf
ZnNfaW5fc2tpcGxpc3QoZnNfdHlwZSwgZnNfdHlwZV9mdXNlX2JsYWNrbGlzdCkpIHsKPiArICAg
ICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlNraXBwaW5nICVzIGJlY2F1c2Ugb2YgRlVTRSBi
bGFja2xpc3QiLAo+IGZzX3R5cGUpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gVFNUX0ZTX1VO
U1VQUE9SVEVEOwo+ICsgICAgICAgfQo+ICsKPiAgICAgICAgIC8qIElzIEZVU0Ugc3VwcG9ydGVk
IGJ5IGtlcm5lbD8gKi8KPiAgICAgICAgIGlmIChmdXNlX3N1cHBvcnRlZCA9PSAtMSkgewo+ICAg
ICAgICAgICAgICAgICByZXQgPSBvcGVuKCIvZGV2L2Z1c2UiLCBPX1JEV1IpOwo+IC0tCj4gMi40
My4wCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
