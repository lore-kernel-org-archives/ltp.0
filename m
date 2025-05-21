Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A0C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747827264; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UYqSSouE76cKK4aYL57+OcUjVMJwWVgWxkBHSo1pK2Y=;
 b=RSCqeAG+ZIrS9JNHjaqMySVfirXhL7+QBc7xo0cIWqW3QZemsicq97ajhQSNBpcjupW1U
 TqTwkmwVSJHTqyzcgn1ZHQT0npv+Zl8KhnVGy7sTX4VvVKnNRlrLJweWEMLOQRhaCL+BNPr
 i/0J1DeXCEM3bcc0Qq3/isXJBPMZSb8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FC403CC7CE
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 13:34:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B72473CA55C
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:34:02 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D446201DC2
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:34:01 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a3681aedf8so3519093f8f.1
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747827241; x=1748432041; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wylGI0N/pFFk2Skj32IV6nTI9CgYqg5BiVPIuTDVfQo=;
 b=VPNyv+Nq4Fw3+wdQvvLCC8er1sCVsxGMW01bDYInXa9B26C3fqSIsooympEMgo7Q+O
 aw83TuzSTNqBCMvOc/YbNU+qw9nNcpANCLJV+/Bgm4WZURaQ/IONI23SlWVv9zGg636f
 zR3qlhkWpif5Xrrnrjyndgq34X6l6CPs5BXGuk8bt2WNrgnlgNXaI62XyWEXR1ZHWio6
 6au++WFg5HbyPP9cNVhsxXotl9Q2rTbPCpWnjI8STqXXLOb4JVUrebNOEzS6FnYjmhGR
 tm8XivCIz+LSG27wawivUHjIUvK6oFq4g7gEsvbFeUPT13ly+XnnYlgtcixypffxWy3m
 9UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747827241; x=1748432041;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wylGI0N/pFFk2Skj32IV6nTI9CgYqg5BiVPIuTDVfQo=;
 b=I6M5pdxFabiOrQlcehedD5h4uPqAHCrSY3ephfsAAUhJuVYsKGzTEM5/JRBekllbXQ
 N2PYz81I3//uKs9ZMpDZZLAy5xqv7aJQt7Occ+0E+F2ZiFZHPUYWu/zJEtoa7qe7qubG
 fvuGqzreFqkscg6UzfWRxAuGMwgHT7irzgBgaJm728JLRzSN4dN3LYjM82iV2s6qppnL
 wf3WYCUlvU8HTc3V+AFSHItmv2jd7ZsJ/5LJsyLsphq5sHDp8bkjMw2BO6veDqheIgjJ
 vx2ni/mxQfQ+thVJHFhoumMdFDZWzYhaAk67SGa32MtiiOd7UAg4hlqGbaWuClI5ifOl
 2ZEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFf3q8vbP4qwJIbaFZOzmG0Tpd7NujO3ijeyu1yx/8AeKVt6MO5uv+S/VqJQ+QZ6dbcws=@lists.linux.it
X-Gm-Message-State: AOJu0YxSBuLosHGPeAeAnCGN/8WO82sogPJMxF3fZ44dEgEH3fIygxVr
 lldCU4A+xWyT+LiaMdL6CT9YRE0+srx7uk48NSgFoFMx/WAYNuIgYtPuzEsqNRGM6gg=
X-Gm-Gg: ASbGnctoFpoTd5cMOxFNQqqjLSxLnKL21D8OGJFL5pY/0PZbzyubDA5QSajY2BiX0zu
 GwP7nD3P/cyq4l/xpUvCTKX8/DpPJqqc3UzFsVL0+pEVlTGagr5haq1BcLXP+Qis0ctFjtoHLG/
 8fihlqNYdhyo45WODw5SlJyJtWKIOCDeCEPlMaBq9pEtSvfiWcmGLh732UFWw/OWFoQVRK5oByd
 jkq4yNhkvmI3AU21bZyVdr13ObLcz3PocakXKLwNrOaApd70oivRTz+hz18pgBUeP6PpiAnBM/b
 sW9g5B03LVhZTaCrFA4AuKe4I4O0lXUoFgC8vQc=
X-Google-Smtp-Source: AGHT+IF+Pc2nRMUtE5oKaYUTisD4wq7QASt6miBEsH3imSIQBahW1Q+OTdbNZwHjjvundECXhl6JqQ==
X-Received: by 2002:a05:6000:40cf:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3a35c821ea1mr18863407f8f.6.1747827240850; 
 Wed, 21 May 2025 04:34:00 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dfa66f1981sm9383380137.16.2025.05.21.04.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 04:33:59 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 21 May 2025 08:33:53 -0300
Message-Id: <DA1T1M774MB6.1R9T71NMMTRC8@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
 <2b58e361-39f0-4d31-a285-c6908c4a8931@suse.cz>
In-Reply-To: <2b58e361-39f0-4d31-a285-c6908c4a8931@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ldt.h: Add workaround for x86_64
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

T24gV2VkIE1heSAyMSwgMjAyNSBhdCA4OjMxIEFNIC0wMywgTWFydGluIERvdWNoYSB3cm90ZToK
PiBIaSwKPiBpdCB0dXJucyBvdXQgdGhhdCB0aGVyZSdzIGEgbWlzdGFrZSBpbiB0aGlzIHBhdGNo
LiBTZWUgYmVsb3cuCj4KPiBPbiAxMi4gMDUuIDI1IDEyOjA1LCBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSB3cm90ZToKPj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4g
Cj4+IFRoZSBjb21taXQgYmUwYWFjYTJmNzQyICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxh
cGkvbGR0LmgiKSBsZWZ0IGJlaGluZAo+PiBhbiBpbXBvcnRhbnQgZmFjdG9yIG9mIG1vZGlmeV9s
ZHQoKTogdGhlIGtlcm5lbCBpbnRlbnRpb25hbGx5IGNhc3RzIHRoZQo+PiByZXR1cm4gdmFsdWUg
dG8gdW5zaWduZWQgaW50LiBUaGlzIHdhcyBoYW5kbGVkIGluCj4+IHRlc3RjYXNlcy9jdmUvY3Zl
LTIwMTUtMzI5MC5jIGJ1dCB3YXMgcmVtb3ZlZC4gQWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50
Cj4+IGZpbGUuCj4+IAo+PiBSZXBvcnRlZC1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNl
LmN6Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29t
Pgo+PiAtLS0KPj4gQ2hhbmdlcyBpbiB2MjoKPj4gLSBBZGRlZCBUQlJPSyBmb3IgYW55IHJldCAh
PSAwIGluIG1vZGlmeV9sZHQgY2FsbCBpbiBjdmUtMjAxNS0zMjkwLmMKPj4gLSBMaW5rIHRvIHYx
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNTA3LWZpeGVzLW1vZGlmeV9sZHQtdjEt
MS03MGEyNjk0Y2ZkZGNAc3VzZS5jb20KPj4gLS0tCj4+ICAgaW5jbHVkZS9sYXBpL2xkdC5oICAg
ICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCj4+ICAgdGVzdGNhc2VzL2N2ZS9j
dmUtMjAxNS0zMjkwLmMgfCAgOCArKysrKysrLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xh
cGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0LmgKPj4gaW5kZXggNmI1YTJkNTljYjQxYmZjMjRl
YjVhYzI2YzNkNDdkNDlmYjhmZjc4Zi4uMTczMzIxZGQ5YWMzNGJhODdlZmYwZWVlOTYwNjM1ZjMw
ZDg3ODk5MSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9sYXBpL2xkdC5oCj4+ICsrKyBiL2luY2x1
ZGUvbGFwaS9sZHQuaAo+PiBAQCAtMzEsNyArMzEsMjcgQEAgc3RydWN0IHVzZXJfZGVzYyB7Cj4+
ICAgc3RhdGljIGlubGluZSBpbnQgbW9kaWZ5X2xkdChpbnQgZnVuYywgY29uc3Qgc3RydWN0IHVz
ZXJfZGVzYyAqcHRyLAo+PiAgIAkJCSAgICAgdW5zaWduZWQgbG9uZyBieXRlY291bnQpCj4+ICAg
ewo+PiAtCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0
ZWNvdW50KTsKPj4gKwlsb25nIHJ2YWw7Cj4+ICsKPj4gKwllcnJubyA9IDA7Cj4+ICsJcnZhbCA9
IHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRyLCBieXRlY291bnQpOwo+PiAr
Cj4+ICsjaWZkZWYgX194ODZfNjRfXwo+PiArCS8qCj4+ICsJICogVGhlIGtlcm5lbCBpbnRlbnRp
b25hbGx5IGNhc3RzIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUKPj4gKwkgKiB0byB1bnNpZ25l
ZCBpbnQgdG8gcHJldmVudCBzaWduIGV4dGVuc2lvbiB0byA2NCBiaXRzLiBUaGlzIG1heQo+PiAr
CSAqIHJlc3VsdCBpbiBzeXNjYWxsKCkgcmV0dXJuaW5nIHRoZSB2YWx1ZSBhcyBpcyBpbnN0ZWFk
IG9mIHNldHRpbmcKPj4gKwkgKiBlcnJubyBhbmQgcmV0dXJuaW5nIC0xLgo+PiArCSAqLwo+PiAr
CWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7Cj4+ICsJCXRzdF9yZXMoVElORk8sCj4+
ICsJCQkiV0FSTklORzogTGliYyBtaXNoYW5kbGVkIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUi
KTsKPj4gKwkJZXJybm8gPSAtKGludCllcnJubzsKPgo+IEkndmUgY29tcGxldGVseSBtaXNzZWQg
dGhhdCB0aGlzIGxpbmUgaXMgc3VwcG9zZWQgdG8gYmU6Cj4gZXJybm8gPSAtKGludClydmFsOwoK
b29wcy4gSSdtIHZlcnkgc29ycnkgYWJvdXQgdGhhdC4gV2lsbCBzZW5kIGEgZml4IHJpZ2h0IG5v
dy4KCj4KPj4gKwkJcnZhbCA9IC0xOwo+PiArCX0KPj4gKyNlbmRpZiAvKiBfX3g4Nl82NF9fICov
Cj4+ICsKPj4gKwlyZXR1cm4gcnZhbDsKPj4gICB9Cj4+ICAgCj4+ICAgc3RhdGljIGlubGluZSBp
bnQgc2FmZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGlu
dCBmdW5jLAo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgYi90
ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+PiBpbmRleCA4ZWMxZDUzYmJiNWE5ZjNlNzc2
MWQzOTg1NWQzNGY1OTNlMTE4YTI4Li5lNzA3NDJhY2M4N2MzOTA4ODk1M2UwMmYxNjE0NmI3YjU4
YTc1ZmQxIDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+PiAr
KysgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+PiBAQCAtMTk3LDcgKzE5NywxMyBA
QCBzdGF0aWMgdm9pZCBzZXRfbGR0KHZvaWQpCj4+ICAgCQkudXNlYWJsZQkgPSAwCj4+ICAgCX07
Cj4+ICAgCj4+IC0JU0FGRV9NT0RJRllfTERUKDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRhX2Rl
c2MpKTsKPj4gKwlURVNUKG1vZGlmeV9sZHQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVz
YykpKTsKPj4gKwlpZiAoVFNUX1JFVCA9PSAtMSAmJiBUU1RfRVJSID09IEVJTlZBTCkgewo+PiAr
CQl0c3RfYnJrKFRDT05GIHwgVFRFUlJOTywKPj4gKwkJCSJtb2RpZnlfbGR0OiAxNi1iaXQgZGF0
YSBzZWdtZW50cyBhcmUgcHJvYmFibHkgZGlzYWJsZWQiKTsKPj4gKwl9IGVsc2UgaWYgKFRTVF9S
RVQgIT0gMCkgewo+PiArCQl0c3RfYnJrKFRCUk9LIHwgVFRFUlJOTywgIm1vZGlmeV9sZHQiKTsK
Pj4gKwl9Cj4+ICAgfQo+PiAgIAo+PiAgIHN0YXRpYyB2b2lkIHRyeV9jb3JydXB0X3N0YWNrKHVu
c2lnbmVkIHNob3J0ICpvcmlnX3NzKQo+PiAKPj4gLS0tCj4+IGJhc2UtY29tbWl0OiBiMDcwYTU2
OTJlMDM1ZWMxMmMzZDNjN2E3ZTllOTdjMjcwZmQ0ZDdkCj4+IGNoYW5nZS1pZDogMjAyNTA1MDct
Zml4ZXMtbW9kaWZ5X2xkdC1lYmNmZGQyYTdkMzAKPj4gCj4+IEJlc3QgcmVnYXJkcywKCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
