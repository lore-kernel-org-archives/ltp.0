Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4792C98321
	for <ltp@archiver.kernel.org>; Sat, 17 Jan 2026 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768655787; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IdJRq5mp+OGiekCsccgRgYg9J8nRpMf+E0ZYjK2EzZ4=;
 b=Bi4jNXdeYZP6w655h+hoKXCGNB0ik+IBn2ok9cvh9A/G3usf6sg3je/PPnpUkZJW0EyAE
 MizxCFRQUsJjxBP5j9xjkVV81IenaHSfk0ju2OhmMnTvD6gv23QkNETD1ltAUGIp/6b0AGf
 sjgjUqBjCwszb9KLaLROBjHwg1VnLdg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47E3C3CAFF7
	for <ltp@archiver.kernel.org>; Sat, 17 Jan 2026 14:16:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 948AF3CAEAC
 for <ltp@lists.linux.it>; Sat, 17 Jan 2026 14:16:04 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7551600872
 for <ltp@lists.linux.it>; Sat, 17 Jan 2026 14:16:03 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so2423871f8f.1
 for <ltp@lists.linux.it>; Sat, 17 Jan 2026 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768655763; x=1769260563; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VqL1rhAmP0gW+SjnILHLyDY0BxVRpDGiRGqFqoPYWAM=;
 b=AQ+KiObmW05hWA44kq2eTu7YsKGBJHn2kcm6ZmPMlN+fUy8OFrRk5EfK5qR7KvrwjH
 85qV4lFp/MuZL0DkXusK2u9VJDOfC/C9c8eYaMxiam6e9eHB7lN+brpN/7gaN6p0R59Y
 JIGL+fqxCIAqY1tr1SBjZaSO+Wa2a1+rI3jbRTuMEOlgMD4dFqizlaVZ8AlBZaMW1slq
 aAq2/qIrvoR3P+aPvrNGfB774CgkhDYEwE2Twr2nrbg3mA6562+4NCIKW9YXXeovi1GF
 v7xzbhzVPW4bfG68Hq4uBCzoHC5mNMjNDxpPZFu0KQbtaSmCntjiU4Rqf+WBO/ZdhxLc
 pkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768655763; x=1769260563;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqL1rhAmP0gW+SjnILHLyDY0BxVRpDGiRGqFqoPYWAM=;
 b=OFUhg57q3/LY7saRMF3e8nPj+LJC2MWIHR0djr81FRn8dHBPqu955BUTQs6n+8g0Rb
 9+RhU5mRNfN1Ly3AC8Pzlddhn4/p1UeNFfRzKO/7UAvsxYvr3MuSEpKck2J5TLJhwT0Y
 mkouffxjxq8Xcba6FVavDvCVpfW0f3UmyNW0xZFfLyhEiCMtZaFgmjuWuS7LJlwKAEmm
 vhAnfqoJOxafS0Of7nwSqLwYsSgNJqAXrd29ySTXTxbmRBD5XxuduNnUxaytXxLVEJcH
 5oezYmRyb7wUQA1B1r8N7NcpYUHSx1IspHKExlug/be6bryzhnY/NkfpfvSGhnf6ErVd
 9J1w==
X-Gm-Message-State: AOJu0Yx9MjwECHplLusJnfzubnALlmPI6qHVQ5m3Fer/yl5lyWbqzERl
 7xVuLjc31BbuYfSWlIwPf4oKeU43shuPmeoZAtuVKdLorYY21y0t0pb2KShYZSbkCw==
X-Gm-Gg: AY/fxX7uFZf2NKR44Rp/DDAEdu9Rl/Hry1R/AQmOHxHtpyDWHC7IQBzyfsibe7vermQ
 Bawpt8wzTfgaDierwZpplxDQJRr1WbFAXSUcfXcsjZMEAmEZ3DbsAJ89K1mjhH7PG1fhLoYf9U0
 ezEQk0Zrdyf0nZFHw5Xx0iUf6Mu7KWnDslhN8QL8arpJSmVdTBDKqpds+QzPQq8FqVvDsIITda0
 SzCidOs9TkYelgaQtcfV5NtqX8ycno/neBgD/wvdLR1IL+/zPeHvVKmJYcrn9bmpfZoFGbE1rpy
 yOwj6SmIYkfPwQQ6JKiZ/A+18jy5B5oz/iImFk4trcMjdvpYX9e7FFnvYnTJoM1rHvYyfWyBv1p
 /LmqJqY2GgJ5tx5B77aQ845cYz+LWFuZxwT5NiGLb5WlVYOmszubJ7zZotJ1MAm3ptJ63LFlOLt
 EF4gWY/+YM4+qXou1f4OgA9CFHKyep
X-Received: by 2002:a05:6000:144b:b0:431:8f8:7f2f with SMTP id
 ffacd0b85a97d-4356a07743emr5870620f8f.34.1768655763013; 
 Sat, 17 Jan 2026 05:16:03 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dadbsm11145447f8f.21.2026.01.17.05.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 05:16:02 -0800 (PST)
Date: Sat, 17 Jan 2026 13:16:01 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aWuLke3rmststr0n@autotest-wegao.qe.prg2.suse.org>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-4-wegao@suse.com>
 <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMTYsIDIwMjYgYXQgMDk6MjU6MDVQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiA+ICAgICAgICAgVFNUX0FTU0VSVF9JTlQocGFydHNjYW5fcGF0aCwgMCk7Cj4gPiAgICAgICAg
IFRTVF9BU1NFUlRfSU5UKGF1dG9jbGVhcl9wYXRoLCAwKTsKPiA+ICAgICAgICAgVFNUX0FTU0VS
VF9TVFIoYmFja2luZ19wYXRoLCBiYWNraW5nX2ZpbGVfcGF0aCk7Cj4gPiBAQCAtMTE0LDEwICs5
NywyMyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfaW9jdGxfbG9vcCh2b2lkKQo+ID4KPiA+ICBzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+ICsgICAgICAgcGFydGVkX3N1cCA9IHRzdF9j
bWRfcHJlc2VudCgicGFydGVkIik7Cj4gCj4gCj4gSW4gdGhlIGxvZ2ljIG9mIHRzdF90ZXN0LmMs
IHRoZXJlIGFscmVhZHkgZGlkIGNoZWNrIGFuZCBzdG9yZSB0aGUKPiB2YWx1ZSBpbiB0c3RfdGVz
dC0+bmVlZHNfY21kcy5wcmVzZW50LCBzbyB3aHkgaGVyZSBkbyB0aGUgY2hlY2sKPiBzZXBlcmF0
ZWx5IGFnYWluPwo+IAo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgdHN0X2NtZCAqcGNtZCA9IHRz
dF90ZXN0LT5uZWVkc19jbWRzOwo+ICsgICAgICAgICAgICAgICB3aGlsZSAocGNtZC0+Y21kKSB7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcGNtZC0+cHJlc2VudCA9IHRzdF9jaGVja19jbWQo
cGNtZC0+Y21kLAo+ICFwY21kLT5vcHRpb25hbCkgPyAxIDogMDsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBwY21kKys7Cj4gKyAgICAgICAgICAgICAgIH0KPiAKTGV0IG1lIGNsYXJpZnksIGFu
ZCBwbGVhc2UgY29ycmVjdCBtZSBpZiBJ4oCZbSBtaXN0YWtlbiA6KQp0c3RfY21kX3ByZXNlbnQg
bm90IGRvIHRzdF9jaGVja19jbWQgYWdhaW4gYnV0IGp1c3QgZ28gdGhyb3VnaCBsaXN0IGZpbmQK
c3BlY2lmaWMgY21kIHN1Y2ggYXMgInBhcnRlZCIgcHJlc2VudCBzdGF0dXMuCj4gCj4gPiArICAg
ICAgIGNvbnN0IGNoYXIgKmNvbnN0IGNtZF9wYXJ0ZWRbXSA9IHsicGFydGVkIiwgIi1zIiwgZGV2
X3BhdGgsICJta2xhYmVsIiwgIm1zZG9zIiwgIm1rcGFydCIsCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAicHJpbWFyeSIsICJleHQ0IiwgIjFNIiwgIjEwTSIs
IE5VTEx9Owo+ID4gKwo+ID4gICAgICAgICBkZXZfbnVtID0gdHN0X2ZpbmRfZnJlZV9sb29wZGV2
KGRldl9wYXRoLCBzaXplb2YoZGV2X3BhdGgpKTsKPiA+ICAgICAgICAgaWYgKGRldl9udW0gPCAw
KQo+ID4gICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJGYWlsZWQgdG8gZmluZCBmcmVl
IGxvb3AgZGV2aWNlIik7Cj4gPgo+ID4gKyAgICAgICB0c3RfZmlsbF9maWxlKCJ0ZXN0LmltZyIs
IDAsIDEwMjQgKiAxMDI0LCAxMCk7Cj4gPiArCj4gPiArICAgICAgIHRzdF9hdHRhY2hfZGV2aWNl
KGRldl9wYXRoLCAidGVzdC5pbWciKTsKPiA+ICsgICAgICAgYXR0YWNoX2ZsYWcgPSAxOwo+ID4g
Kwo+ID4gKyAgICAgICBpZiAocGFydGVkX3N1cCkKPiAKPiBDYW4gd2UganVzdCByZXVzZSB0aGUg
J3RzdF90ZXN0LT5uZWVkc19jbWRzLnByZXNlbnQnIHJlc3VsdD8KPiAKWW91IGNhbm5vdCBhY2Nl
c3MgdHN0X3Rlc3QtPm5lZWRzX2NtZHMucHJlc2VudCBkaXJlY3RseSBhcyBpZiBpdCB3ZXJlIGEg
c2luZ2xlIHZhcmlhYmxlLCAKYmVjYXVzZSBuZWVkc19jbWRzIGlzIGFuIGFycmF5IChhIGxpc3Qp
IG9mIHN0cnVjdHVyZXMuIFRvIGdldCB0aGUgc3RhdHVzIG9mIGEgc3BlY2lmaWMgY29tbWFuZCAK
bGlrZSAicGFydGVkIiwgeW91IG11c3QgaXRlcmF0ZSB0aHJvdWdoIHRoYXQgbGlzdCB0byBmaW5k
IHRoZSBlbnRyeSBtYXRjaGluZyB0aGF0IG5hbWUuCj4gPiArICAgICAgICAgICAgICAgU0FGRV9D
TUQoY21kX3BhcnRlZCwgTlVMTCwgTlVMTCk7Cj4gCj4gCj4gLS0gCj4gUmVnYXJkcywKPiBMaSBX
YW5nCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
