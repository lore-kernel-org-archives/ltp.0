Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54E7C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721811703; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TPfBzlqSEd3qT9inUVOt5NypX/wbf2zQ+wjGAEsxbb8=;
 b=X6YLGQwFEkNZ/g+Sc6CicTLXMi+T0Q65jLq2dDVbL+vuTr4nid7Km77hG+BERybzU3ToM
 LF94J4bhm2u1gZAa0Z0j47fVESYq+DyPJevlyNl9lKnjq8qc8SBy762yYWBBAd05pE8v87m
 cFX6qobGOT7JYCmb/svSS5TlwSp/FsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6073D1C24
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:01:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2DC3D0895
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:01:21 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5B681B60EC9
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:01:20 +0200 (CEST)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52efabf5d7bso4376220e87.1
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721811680; x=1722416480; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=qkzkGIALak+xEaXTqrkApNKogpmBhCu8VObrJy1D9wQ=;
 b=caVTeW/KpLmeZLrVQFjWWP//vXKYFHOorLNWFgXxWIxx3Rzsb4h0QOGDBWtUeA4Lro
 GyE8UEjkI6f8tIgVEkAcmO8PxuIPioDAuZbfjgA/0ooW3tUwtywXrblsh7ZygNlwt1vg
 XFTiKaLZ2xIiagm5hQjVhvC+2NO9ssSpEv72y26/9jLgQoIqd3IGc2t+PBXf/zPAp6DZ
 GRVi/CtM2c9gbo9DkmtzS+5uNEi5gdmMi3RVs3mqdr4djkkSvQmMkp5LedJE9VqoV6Ux
 rqU1uPUJhds5Tk/s9UZ8w4H0E5W/lE1TcD73VVeUwDdWxTXOfK8+LDKJ7LKuL65B1EBl
 rYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721811680; x=1722416480;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkzkGIALak+xEaXTqrkApNKogpmBhCu8VObrJy1D9wQ=;
 b=Ia1Ll2Ldr82kgExszqGm37JS+DLs9MsqIEH+8poxDg06infdTUh6a7Tkv5fL9ZlmgA
 Hsl99WMGcpiLcN/JKlOYY/yGkchFGyNwJBgPBTJa6mkg6QjR0MhU7L4rHfSJFL9K5Zke
 Qu4sFEYLZSKeQJsN+3SxKDIGfX8nnlskdRqn61bREIuxJdawuV7wf4Ls/+ddbRnVF+5c
 5GW9vkZY1NaEsHeEjFG0pEX6Kb0y3lep5Mp5ciD+YuFky5LVjzRnQ6WysY808U72IXdM
 dw1hW3Oha3V/AJg8xXVFUacT/vssLi0Mb9KfHPIrdv3hM74lB27sK5ZzrIuHNCdWRQgP
 d2IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ve3GwmyWS0bRZttlJR3CQJhFfX4gr9oN9jbX4+73AJYRWmcSV/gzfdYg9WX3nxTO09VKYltyzqCFIgdYAjgk/A8=
X-Gm-Message-State: AOJu0YwsvaKAKoZIdaT96JQYf1jQh2hcwyFVEjCgVhHi/rVijKJNsStg
 1iImVM4tawTKaps+lOM6Yne0dz6K1QJkkZYz4cN8vLF32Z9hARgRtMfaWiNNTK5Q/7jIZvOEnW3
 A/wE=
X-Google-Smtp-Source: AGHT+IGmb8z+tTtu67jQgwuIfed7S+vFs9UYVljNZuic94mw5L7q4jb0xXhNOlkaPXLfP4waBp0FwA==
X-Received: by 2002:a05:6512:a84:b0:52f:6f49:3593 with SMTP id
 2adb3069b0e04-52fceffd580mr956150e87.34.1721811679100; 
 Wed, 24 Jul 2024 02:01:19 -0700 (PDT)
Received: from smtpclient.apple ([37.162.110.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa2c93sm8627250a12.25.2024.07.24.02.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 02:01:18 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Date: Wed, 24 Jul 2024 11:01:07 +0200
Message-Id: <5C233D16-A52A-47E0-AFD0-3D5E88B9F00B@suse.com>
References: <ZqC-69CoVPMRsJLv@yuki>
In-Reply-To: <ZqC-69CoVPMRsJLv@yuki>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mailer: iPhone Mail (21F90)
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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

WWVhaCB0aGlzIGlzIHRoZSBjYXNlLgpUaGUgcHJvYmxlbSBjb21lcyB3aGVuIHRzdF90bXBkaXJf
cGF0aCgpIGlzIHVzZWQgd2l0aG91dCBnaXZpbmcgLm5lZWRzX3RtcGRpciBhbmQgdGhlIHBvaW50
ZXIgdG8gdG1wZGlyIGlzIG5vdCBpbml0aWFsaXNlZC4KCj4gT24gMjQgSnVsIDIwMjQsIGF0IDEw
OjQ1LCBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cj4gCj4g77u/SGkhCj4+
PiBJIGhhZCBhIHN0cmFuZ2UgU0VHRkFVTFQgd2hlbiAubmVlZHNfdG1wZGlyIGlzIG5vdCBkZWZp
bmVkLiBBcmUgeW91IHN1cmUgdGhlCj4+PiBmZWF0dXJlIGlzIGNvcnJlY3RseSB3b3JraW5nIGlu
IHRoYXQgY2FzZT8gVENPTkYgc2hvdWxkIGJlIGV4cGVjdGVkIGluIHRoYXQKPj4+IGNhc2UuCj4+
IAo+PiBDb3VsZCB5b3UgYmUgbW9yZSBzcGVjaWZpYyB3aGF0IGlzIHdyb25nPyAoZmFpbGluZyB0
ZXN0LCB3aGF0IGJhY2t0cmFjZSBmcm9tIGdkYgo+PiBvdXRwdXRzLiBNYXliZSBydW4gaXQgYm90
aCAqd2l0aCogYW5kICp3aXRob3V0KiBzZXQgZm9sbG93LWZvcmstbW9kZSBjaGlsZCwgbm90Cj4+
IHN1cmUgaWYgdGhlIGluZm8gd2lsbCBiZSBpbiB0aGUgbGlicmFyeSBydW4gb3IgaW4gdGhlIHRl
c3QgZm9yayBydW4pLgo+PiAKPj4gSSB0ZXN0ZWQgYmluZDAyLmMsIHdoaWNoIGlzICp3aXRob3V0
KiAubmVlZHNfdG1wZGlyIGFuZCBpdCB3b3Jrcy4gYmluZDAxLmMgaXMKPj4gKndpdGgqIC5uZWVk
c190bXBkaXIgYW5kIGl0IGFsc28gd29ya3MuICBUaGVzZSBhcmUgbm90IG1vZGlmaWVkIGJ5IHRo
ZSBtZXJnZWQKPj4gY2hhbmdlIChjNWQ5NWI2ZDMpLCB0aHVzIEkgYWxzbyB0ZXN0ZWQgY2hyb290
MDEuYyAoKndpdGhvdXQqIC5uZWVkc190bXBkaXIpIGFuZAo+PiBpdCBhbHNvIHdvcmtzLgo+PiAK
Pj4gQmVzaWRlcywgb3BlblNVU0UgTFRQIHRlc3Rpbmcgb2YgTFRQIHN5c2NhbGxzIHdpdGggYzVk
OTViNmQzIFsxXSBkb2VzIG5vdCBoYXZlCj4+IGFueSBuZXcgZmFpbHVyZXMuCj4gCj4gSSBzdXBw
b3NlIHRoYXQgd2UgbmVlZCB0aGlzLCB0byBoYXZlIGEgVEJST0sgbWVzc2FnZSBpbnN0ZWFkIG9m
IFNlZ0ZhdWx0Cj4gaWYgdXNlcnMgY2FsbCB0aGluZ3Mgb3V0IG9mIG9yZGVyOgo+IAo+IGRpZmYg
LS1naXQgYS9saWIvdHN0X3RtcGRpci5jIGIvbGliL3RzdF90bXBkaXIuYwo+IGluZGV4IDFmYjFi
ZDY5OC4uYmJiNDVkZmE5IDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfdG1wZGlyLmMKPiArKysgYi9s
aWIvdHN0X3RtcGRpci5jCj4gQEAgLTM1OCw2ICszNTgsOSBAQCBjaGFyICp0c3RfdG1wZGlyX3Bh
dGgodm9pZCkKPiB7Cj4gICAgICAgIHN0YXRpYyBjaGFyICp0bXBkaXI7Cj4gCj4gKyAgICAgICBp
ZiAoIVRFU1RESVIpCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICIubmVlZHNfdG1w
ZGlyIG11c3QgYmUgc2V0ISIpOwo+ICsKPiAgICAgICAgaWYgKHRtcGRpcikKPiAgICAgICAgICAg
ICAgICByZXR1cm4gdG1wZGlyOwo+IAo+IEBAIC0zNjgsMTEgKzM3MSwxNiBAQCBjaGFyICp0c3Rf
dG1wZGlyX3BhdGgodm9pZCkKPiAKPiBjaGFyICp0c3RfdG1wZGlyX21rcGF0aChjb25zdCBjaGFy
ICpmbXQsIC4uLikKPiB7Cj4gLSAgICAgICBzaXplX3QgdGVzdGRpcl9sZW4gPSBzdHJsZW4oVEVT
VERJUik7Cj4gLSAgICAgICBzaXplX3QgcGF0aF9sZW4gPSB0ZXN0ZGlyX2xlbjsKPiArICAgICAg
IHNpemVfdCB0ZXN0ZGlyX2xlbiwgcGF0aF9sZW47Cj4gICAgICAgIHZhX2xpc3QgdmEsIHZhYzsK
PiAgICAgICAgY2hhciAqcmV0Owo+IAo+ICsgICAgICAgaWYgKCFURVNURElSKQo+ICsgICAgICAg
ICAgICAgICB0c3RfYnJrKFRCUk9LLCAiLm5lZWRzX3RtcGRpciBtdXN0IGJlIHNldCEiKTsKPiAr
Cj4gKyAgICAgICB0ZXN0ZGlyX2xlbiA9IHN0cmxlbihURVNURElSKTsKPiArICAgICAgIHBhdGhf
bGVuID0gdGVzdGRpcl9sZW47Cj4gKwo+ICAgICAgICB2YV9zdGFydCh2YSwgZm10KTsKPiAgICAg
ICAgdmFfY29weSh2YWMsIHZhKTsKPiAgICAgICAgcGF0aF9sZW4gKz0gdnNucHJpbnRmKE5VTEws
IDAsIGZtdCwgdmEpICsgMjsKPiAKPiAKPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3Vz
ZS5jegoKQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
