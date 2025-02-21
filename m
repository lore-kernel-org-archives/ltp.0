Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B65C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740132091; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=v1P6gA6ijHwpkcK8koLAiWoqbJBFJROVzJLa/KoOrVg=;
 b=gCoDhm3tw3poVEpQ1/+rjQY/fvK0NuR4knMMAvcsLnaPlnD2A3W/hK1UYKXgTplWBUhYm
 E2yNnXIMCsojXbUoORoOh5qmfLqmUACOVe5OVSidtQXO0cH48YHdIs6UKDY2cb6SNoIPtu0
 1ZYFbpwnH7rzmlItlkSWd+QOiUFvE8A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B6AD3C8139
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:01:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E31E3C06D0
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:01:07 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3DB9142CBAC
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:01:06 +0100 (CET)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30613802a04so20341421fa.2
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 02:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740132066; x=1740736866; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kg+2z6dzRNhRdLXWFL3jIHq8bkImwJVsPxBpmjZaJaY=;
 b=UNcTPJXBy/68+Y5czJ4QCuYmz/DAK2aPvNYaGIsA232J+bEQVTcr2rJ0VN9U93Q0Px
 PX/p2o1F3jZleOqClqijITAxeTUENofypVUQyxf2HWviFj7Bd6vWMlm4IuhwRl3fmkp0
 QvKZccS40H1QiWvN2WNp2XXqsBixzNAVSWeuMZC3U5GE3FaOT3mKafwMsfKwOO1+2ZgD
 EGqClarW3G5xTPSSIZHlZ1/Dm0nLSs8m4TRVtaDJ2LLLF4SL0L0SHTJiQxGRBngx7b5z
 iqzxvzJmh7+5mIr1goBkC6dKKZ4bYOPosn759Guyfl2xq+nafJ41M4rF/n2ROaQ5CEnz
 N0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132066; x=1740736866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kg+2z6dzRNhRdLXWFL3jIHq8bkImwJVsPxBpmjZaJaY=;
 b=rCEIL8trnX+lBpydxdw+wFkIWtFRbVsIDIbkwZ0CAid3A04nIkagESA2h5nWWu4ONH
 u9CzCRCvm9+dloGt2Nskfbcwe43AzF84YD4Tt8SKubWjN7EJWBKhRL0K25hlS52s92zg
 BQlrjkKJ5vIigUS4FQbqeImgZq6U7DmeYGZh86Ar1uLqXnY8UWOhs4Hy05iSyogr5ECM
 42R8RQUV6L97h1f0/kOeVZuYwkIVtI0yvsXmqZ+nsGzbKw0GFAES1525WsSjh54sS2xx
 E3Rn9kAqpguw1tPfA/TyGqYO4T2pw36wwUnWgXDyadY4g9vFOIrNZ4UG6AefoS6TGFLa
 zDuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE/jFi8jSE6HrJwWbAGgQh7C3RM6km1MhnG7sKseLJ3DrSt9oJnzryV7IF2cTUVZkfoiQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzEQsM8Q1vFHLbDFs/3nNGviXLVqJrdzGPmyMEdwPSpMpSUnrf5
 L3EFbYLfxzc4trVTWn2xC0Z43l51RvmJJsv7ptSY2cSDO1xGgYw0FOXNWwP2pS8hK5K06MBYXKO
 M2co=
X-Gm-Gg: ASbGncuVtPrpHBkfHJ8YpHAz3COwbu/W+z22uLTxv2nAaRKpnZA/T1N2RN0pA5eZo6s
 GzPgrO8ZJIfhNb+S7oMnvFYRYUVDCNIpzps2rugpfG9j0peN3er3DSIHSG5MLap6xdzyXYoK0Hm
 mojUQmPbJSL3Fk9YNMIbid3+pMg8LeA7XLPhjXqFqzW8yPSrm1wgvhVM5ln1D6y/5NtjRqQuNR2
 wKMRKmVUw1b8ffuI2PRabC9EM84/BfAMW/8/Fn4GrFabc+rSIG+kU/fpYHpVnb/KKb1g8fygCwr
 HVBMK7h96JJ05E4i/tl0xYSkRZyDInkqyp1qWckdNUqXAq4nODXOMEziL0eUQ+6szeScvaaiPXS
 5MxiuUWgO
X-Google-Smtp-Source: AGHT+IHjKbAFmigRz3fxEVP51pSHlyVinGPWwsiVuhGnAChvE5451xoxPtEScJ6TwOlG0SOe3Yp9tg==
X-Received: by 2002:a05:6512:1309:b0:545:aa5:d455 with SMTP id
 2adb3069b0e04-5483913f943mr887377e87.15.1740132065824; 
 Fri, 21 Feb 2025 02:01:05 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5452ee87c55sm2144277e87.186.2025.02.21.02.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:01:05 -0800 (PST)
Message-ID: <4d291716-8e19-44d3-98aa-a18a29a860d6@suse.com>
Date: Fri, 21 Feb 2025 11:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20231227130555.29035-1-wegao@suse.com>
 <20240603125514.683-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20240603125514.683-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] open15: allow restricted O_CREAT of FIFOs and
 regular files
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKSWYgd2Ugd2FudCB0byBtZXJnZSB0aGlzIHBhdGNoLCB3ZSBuZWVkIHRvIGRvIGEg
Y291cGxlIG9mIHRoaW5ncyBtb3JlLgpUaGUgb3BlbjE1IGlzIG5vdyB0YWtlbiBieSBhbiBhbm90
aGVyIHRlc3QsIHNvIHdlIG5lZWQgdG8gbW92ZSBpdCB0byBvcGVuMTYuCkFsc28gd2UgZG9uJ3Qg
aGF2ZSBhIG5pY2UgZ2l0IGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJpbmcgd2hhdCdzIHRoZSAKcHVy
cG9zZSBvZiB0aGUgdGVzdC4KCk9uIDYvMy8yNCAxNDo1NSwgV2VpIEdhbyB2aWEgbHRwIHdyb3Rl
Ogo+IEZpeDogIzU3NAo+Cj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
Cj4gLS0tCj4gICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vLmdpdGlnbm9yZSB8ICAgMSAr
Cj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMgICB8IDEyNSArKysr
KysrKysrKysrKysrKysrKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCsp
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuL29w
ZW4xNS5jCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2Fs
bHMKPiBpbmRleCA0ZjFlZTFmMzQuLjQxNTJlMWU1ZiAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5
c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC05MzUsNiArOTM1LDcgQEAgb3Bl
bjExIG9wZW4xMQo+ICAgb3BlbjEyIG9wZW4xMgo+ICAgb3BlbjEzIG9wZW4xMwo+ICAgb3BlbjE0
IG9wZW4xNAo+ICtvcGVuMTUgb3BlbjE1Cj4gICAKPiAgIG9wZW5hdDAxIG9wZW5hdDAxCj4gICBv
cGVuYXQwMiBvcGVuYXQwMgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L29wZW4vLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdu
b3JlCj4gaW5kZXggMDAxZDg3NGQ2Li5hZjU5OTc1NzIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9vcGVuLy5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL29wZW4vLmdpdGlnbm9yZQo+IEBAIC0xMiwzICsxMiw0IEBACj4gICAvb3BlbjEy
X2NoaWxkCj4gICAvb3BlbjEzCj4gICAvb3BlbjE0Cj4gKy9vcGVuMTUKPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuL29wZW4xNS5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9vcGVuL29wZW4xNS5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAw
MDAwMDAwMDAuLmRlNTMyNWUwMQo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPiBAQCAtMCwwICsxLDEyNSBAQAo+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmln
aHQgKGMpIDIwMjMgV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gKyAqLwo+ICsKPiArLypcCj4g
KyAqIFtEZXNjcmlwdGlvbl0KTm90IG5lZWRlZCBhbnltb3JlLgo+ICsgKgo+ICsgKiBWZXJpZnkg
ZGlzYWxsb3dzIG9wZW4gb2YgRklGT3Mgb3IgcmVndWxhciBmaWxlcyBub3Qgb3duZWQgYnkgdGhl
IHVzZXIgaW4gd29ybGQKPiArICogd3JpdGFibGUgc3RpY2t5IGRpcmVjdG9yaWVzCj4gKyAqCj4g
KyAqIGNvbW1pdCAzMGFiYTY2NTZmNjFlZDQ0Y2JhNDQ1YTNjMGQzOGIyOTZmYTllOGY1Cj4gKyAq
IEF1dGhvcjogU2FsdmF0b3JlIE1lc29yYWNhIDxzLm1lc29yYWNhMTZAZ21haWwuY29tPgo+ICsg
KiBEYXRlOiAgIFRodSBBdWcgMjMgMTc6MDA6MzUgMjAxOCAtMDcwMAo+ICsgKiAgICAgbmFtZWk6
IGFsbG93IHJlc3RyaWN0ZWQgT19DUkVBVCBvZiBGSUZPcyBhbmQgcmVndWxhciBmaWxlcwp3ZSBz
aG91bGQgdXBkYXRlIC50YWdzIGluc3RlYWQgb2YgY29weWluZyBjb21taXQgbWVzc2FnZSBoZXJl
Lgo+ICsgKi8KPiArCj4gKyNpbmNsdWRlIDxwd2QuaD4KPiArI2luY2x1ZGUgPHN0ZGxpYi5oPgo+
ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArI2luY2x1ZGUgInRzdF9zYWZlX2ZpbGVfYXQuaCIK
PiArCj4gKyNkZWZpbmUgIEZJTEVOQU1FICAic2V0dWlkMDRfdGVzdGZpbGUiCj4gKyNkZWZpbmUg
IERJUiAibHRwX3RtcF9jaGVjazEiCj4gKyNkZWZpbmUgIFRFU1RfRklMRSAidGVzdF9maWxlXzEi
Cj4gKyNkZWZpbmUgIFRFU1RfRklGTyAidGVzdF9maWZvXzEiCj4gKyNkZWZpbmUgIExUUF9VU1Jf
VUlEMSAxMDAwCj4gKyNkZWZpbmUgIExUUF9VU1JfVUlEMiAxMDAxCj4gKyNkZWZpbmUgIENPTkNB
VChkaXIsIGZpbGVuYW1lKSBkaXIgIi8iIGZpbGVuYW1lCj4gKyNkZWZpbmUgIFBST1RFQ1RFRF9S
RUdVTEFSICIvcHJvYy9zeXMvZnMvcHJvdGVjdGVkX3JlZ3VsYXIiCj4gKyNkZWZpbmUgIFBST1RF
Q1RFRF9GSUZPUyAiL3Byb2Mvc3lzL2ZzL3Byb3RlY3RlZF9maWZvcyIKPiArCj4gK3N0YXRpYyBp
bnQgZGlyX2ZkOwo+ICsKPiArc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gK3sKPiArCWludCBwaWQ7
Cj4gKwo+ICsJU0FGRV9DSE1PRChESVIsIDA3NzcgfCBTX0lTVlRYKTsKPiArCVNBRkVfRklMRV9Q
UklOVEYoUFJPVEVDVEVEX1JFR1VMQVIsICIlZCIsIDApOwo+ICsJU0FGRV9GSUxFX1BSSU5URihQ
Uk9URUNURURfRklGT1MsICIlZCIsIDApOwo+ICsKPiArCWlmICghU0FGRV9GT1JLKCkpIHsKPiAr
CQlTQUZFX1NFVFVJRChMVFBfVVNSX1VJRDEpOwo+ICsKPiArCQlpbnQgZmQgPSBUU1RfRVhQX0ZE
KG9wZW5hdChkaXJfZmQsIFRFU1RfRklMRSwgT19DUkVBVCB8IE9fUkRXUiwgMDc3NykpOwo+ICsK
PiArCQlTQUZFX0NMT1NFKGZkKTsKPiArCj4gKwkJU0FGRV9NS0ZJRk8oQ09OQ0FUKERJUiwgVEVT
VF9GSUZPKSwgMDc3Nyk7Cj4gKwo+ICsJCWV4aXQoMCk7Cj4gKwl9Cj4gKwo+ICsJdHN0X3JlYXBf
Y2hpbGRyZW4oKTsKPiArCj4gKwlpZiAoIVNBRkVfRk9SSygpKSB7Cj4gKwkJU0FGRV9TRVRVSUQo
TFRQX1VTUl9VSUQyKTsKPiArCj4gKwkJaW50IGZkID0gVFNUX0VYUF9GRChvcGVuYXQoZGlyX2Zk
LCBURVNUX0ZJTEUsIE9fQ1JFQVQgfCBPX1JEV1IsIDA3NzcpKTsKPiArCj4gKwkJU0FGRV9DTE9T
RShmZCk7Cj4gKwo+ICsJCWZkID0gVFNUX0VYUF9GRChvcGVuKENPTkNBVChESVIsIFRFU1RfRklG
TyksIE9fUkRXUiB8IE9fQ1JFQVQsIDA3NzcpKTsKPiArCQlTQUZFX0NMT1NFKGZkKTsKPiArCj4g
KwkJZXhpdCgwKTsKPiArCX0KPiArCj4gKwl0c3RfcmVhcF9jaGlsZHJlbigpOwo+ICsKPiArCVNB
RkVfRklMRV9QUklOVEYoUFJPVEVDVEVEX1JFR1VMQVIsICIlZCIsIDEpOwo+ICsJU0FGRV9GSUxF
X1BSSU5URihQUk9URUNURURfRklGT1MsICIlZCIsIDEpOwo+ICsKPiArCWlmICghU0FGRV9GT1JL
KCkpIHsKPiArCQlTQUZFX1NFVFVJRChMVFBfVVNSX1VJRDIpOwo+ICsJCVRTVF9FWFBfRkFJTChv
cGVuYXQoZGlyX2ZkLCBURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQ1JFQVQsIDA3NzcpLCBFQUNDRVMp
Owo+ICsJCVRTVF9FWFBfRkFJTChvcGVuKENPTkNBVChESVIsIFRFU1RfRklGTyksIE9fUkRXUiB8
IE9fQ1JFQVQsIDA3NzcpLCBFQUNDRVMpOwo+ICsKPiArCQlleGl0KDApOwo+ICsJfQo+ICsKPiAr
CXRzdF9yZWFwX2NoaWxkcmVuKCk7Cj4gKwo+ICsJU0FGRV9GSUxFX1BSSU5URihQUk9URUNURURf
UkVHVUxBUiwgIiVkIiwgMik7Cj4gKwlTQUZFX0ZJTEVfUFJJTlRGKFBST1RFQ1RFRF9GSUZPUywg
IiVkIiwgMik7Cj4gKwlTQUZFX0NITU9EKERJUiwgMDAyMCB8IFNfSVNWVFgpOwo+ICsKPiArCWlm
ICghU0FGRV9GT1JLKCkpIHsKPiArCQlTQUZFX1NFVFVJRChMVFBfVVNSX1VJRDIpOwo+ICsJCVRT
VF9FWFBfRkFJTChvcGVuYXQoZGlyX2ZkLCBURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQ1JFQVQsIDA3
NzcpLCBFQUNDRVMpOwo+ICsJCVRTVF9FWFBfRkFJTChvcGVuKENPTkNBVChESVIsIFRFU1RfRklG
TyksIE9fUkRXUiB8IE9fQ1JFQVQsIDA3NzcpLCBFQUNDRVMpOwo+ICsKPiArCQlleGl0KDApOwo+
ICsJfQo+ICsKPiArCXRzdF9yZWFwX2NoaWxkcmVuKCk7Cj4gKwl1bmxpbmsoQ09OQ0FUKERJUiwg
VEVTVF9GSUZPKSk7ClNBRkVfVU5MSU5LKCkKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKPiArewo+ICsJdW1hc2soMCk7Cj4gKwlTQUZFX01LRElSKERJUiwgMDc3NyB8IFNfSVNW
VFgpOwo+ICsJZGlyX2ZkID0gU0FGRV9PUEVOKERJUiwgT19ESVJFQ1RPUlkpOwo+ICt9Cj4gKwo+
ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gK3sKPiArCVNBRkVfQ0xPU0UoZGlyX2ZkKTsK
CmlmIChkaXJfZmQgIT0gLTEpCiDCoMKgwqAgU0FGRV9DTE9TRShkaXJfZmQpOwoKPiArfQo+ICsK
PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLnNldHVwID0gc2V0dXAsCj4g
KwkuY2xlYW51cCA9IGNsZWFudXAsCj4gKwkubmVlZHNfcm9vdCA9IDEsCj4gKwkudGVzdF9hbGwg
PSBydW4sCj4gKwkubmVlZHNfdG1wZGlyID0gMSwKPiArCS5mb3Jrc19jaGlsZCA9IDEsCj4gKwku
c2F2ZV9yZXN0b3JlID0gKGNvbnN0IHN0cnVjdCB0c3RfcGF0aF92YWxbXSkgewo+ICsJCXtQUk9U
RUNURURfUkVHVUxBUiwgTlVMTCwgVFNUX1NSX1RDT05GfSwKPiArCQl7UFJPVEVDVEVEX0ZJRk9T
LCBOVUxMLCBUU1RfU1JfVENPTkZ9LAo+ICsJCXt9Cj4gKwl9LAoudGFncyBpcyBtaXNzaW5nLgo+
ICt9OwpBbmRyZWEKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
