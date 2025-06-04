Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA3C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749044560; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=E/R6xcuBbVmAxJZd1fl+ygTHOLAD+LH+SJFewoScOjk=;
 b=LErxeVf99A2HOV0rLddNAivCniAPKsUi1bdrWQB2/DSxLalpEXWF/KD5ChpYt/5KMHzjX
 cx2MgRiu9Kw8d9AD7XlP7Zutr9UvohkGgcjwYkzU71QBolUtZvDP9xvUv7wBRe65AN2GHCZ
 HcpYwz5kDfLyL26SqGW0pq8xFfcsDUQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F39353CA147
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 15:42:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88E013C9349
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:42:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C77E2600BB8
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749044535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34mJ5ARI1QWrQKdbrirV9gpStd0YGj+se79AKJj+ajY=;
 b=aE63u6k+KrSYGAQJ/TnJc+eiqwoxuTKW9Mt/kpxfe2JvFMnCAa+tsIjrtBtnUXx+e1VyUh
 j/7RR2lvhOoljlhmWiKFU1cjlNGQhYLfkZWCS2BzpC2QnIsaoHUvkHidXtLwj1qrYI0P0M
 IOg5h38f7wG1SjqXOJjUpyL+qrmLlgI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Qd3322yZOgWJZO5XQ850Hw-1; Wed, 04 Jun 2025 09:42:14 -0400
X-MC-Unique: Qd3322yZOgWJZO5XQ850Hw-1
X-Mimecast-MFC-AGG-ID: Qd3322yZOgWJZO5XQ850Hw_1749044533
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso2738373f8f.1
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 06:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749044533; x=1749649333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34mJ5ARI1QWrQKdbrirV9gpStd0YGj+se79AKJj+ajY=;
 b=ZUnMNoIHYgpHMTcuZHqd4SZkUqmQHL5bO81L7EEyLeyBY/0aDjRtu8l0neaSPohCqy
 fRO/W8L9FnNJ2y2ZArUw/05RiAERA4QpFd8ZX/i5uigSzlrcekqVeU+fdHE08SzN7SkW
 1R1Sx48/ef4OgI4Ct6EmVDF18eDnDseXc8Z+lBXGBHwg2QrEnjHETRqKO+BpZHldhGMh
 Rs5HrM4JjOa2qQwbCKB23N4xiggr4JL6spM4+lmw4N5xhQtnPIYLtxa6m3dRkHT8wMfg
 3pF/d6TOO0XHyvJrdRVgfZ1JvO0mJb4G5Nt1duQTmxWnbgpqM2/Ote3KKNPGfHC835S7
 SpOw==
X-Gm-Message-State: AOJu0YyNZgqSHAGRS2BJf9s3PcfL9uhH3Bqflxl0MNtB6zguOWAxFHDZ
 nflOCdWNQ1hBzMfwhxnEfgaltE37Sy2Ih29wwzuhhbTnOAchbMZOKqqBzAZf1JULhlo3ra+C7IL
 TAMw1/huTTZzr6uW4Ki5wCnloU4umDrCYoyJAcIRmAgZ9OZHcj2849zPgt0ifz4N3XWVgB0vqck
 mkeC8GAAUXECjHPUUkpYC/ocR5gucZrwNTgJW3DLUU
X-Gm-Gg: ASbGncsWapPhmphkdBrXCdbFxhgjVgE8jbGa3FPK5wBReI6gBF3jp4gSHCAvbYH9mqO
 bTD5bxGvH9rce6ROo567SjQViAnln1n1xU68F6rHOC18emrelHdFScN70BAx9EtEKFKR6
X-Received: by 2002:a05:6000:288f:b0:3a4:e6c6:b8b1 with SMTP id
 ffacd0b85a97d-3a51dbcc40bmr2583982f8f.17.1749044532944; 
 Wed, 04 Jun 2025 06:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhX9Rbu2VrB80PuMc5Qg2DlMACmnNctYKbOW2iHxSQwJfNYJnjZksKr3RnB4BfsC25ChdsjDxnC10dixAmkVg=
X-Received: by 2002:a05:6000:288f:b0:3a4:e6c6:b8b1 with SMTP id
 ffacd0b85a97d-3a51dbcc40bmr2583945f8f.17.1749044532427; Wed, 04 Jun 2025
 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250602013756.136453-1-gaoshanliukou@163.com>
In-Reply-To: <20250602013756.136453-1-gaoshanliukou@163.com>
Date: Wed, 4 Jun 2025 15:41:54 +0200
X-Gm-Features: AX0GCFu54RJicJsZwHHD12B7nyiov24fdp8jkvYZKq1Lm_fT2tQwn7H4lqHq4Zw
Message-ID: <CAASaF6waa4CsDMxSCF=LOqKMDg4_T511eZn2wu+cAf1VjVjrgw@mail.gmail.com>
To: "yang.zhang" <gaoshanliukou@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2PeaYLij9Fvh0TGfMTeShA4GKDsRSRSg3OEum2c-a7k_1749044533
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH LTP] open_posix: fix send_rev_2.c testcase
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: "yang.zhang" <zhangyang01@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMiwgMjAyNSBhdCA1OjIy4oCvUE0geWFuZy56aGFuZyA8Z2Fvc2hhbmxpdWtv
dUAxNjMuY29tPiB3cm90ZToKPgo+IEZyb206ICJ5YW5nLnpoYW5nIiA8emhhbmd5YW5nMDFAa3ls
aW5vcy5jbj4KPgo+IDEuIEFmdGVyIGZvcmssIHVzaW5nIGNvcnJlY3Qgc3dpdGNoIGJyYW5jaCBm
b3IgcGFyZW50IGFuZCBjaGlsZC4KPiAyLiBGaXggYXJyYXkgb3V0LW9mLWJvdW5kcyBpc3N1ZSB3
aGVuIGNhbGxpbmcgbXFfc2VuZC4KPgo+IFNpZ25lZC1vZmYtYnk6IHlhbmcuemhhbmcgPHpoYW5n
eWFuZzAxQGt5bGlub3MuY24+CgpTdWJqZWN0IHNheXMgInNlbmRfcmV2XzIuYyIsIGJ1dCBwYXRj
aCBpcyBmb3Igc2VuZF9yZXZfMS5jLApzbyB0aGF0J3Mgc29tZXRoaW5nIHRvIGZpeCBkdXJpbmcg
Y29tbWl0LgoKUmV2aWV3ZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoK
Cj4gLS0tCj4gIC4uLi9mdW5jdGlvbmFsL21xdWV1ZXMvc2VuZF9yZXZfMS5jICAgICAgICAgICB8
IDM1ICsrKysrKysrKy0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDE4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZS9mdW5jdGlvbmFsL21xdWV1ZXMvc2VuZF9yZXZfMS5jIGIvdGVzdGNhc2VzL29w
ZW5fcG9zaXhfdGVzdHN1aXRlL2Z1bmN0aW9uYWwvbXF1ZXVlcy9zZW5kX3Jldl8xLmMKPiBpbmRl
eCA0NmVlZjgzN2EuLjdjN2QyZjc2MSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvZnVuY3Rpb25hbC9tcXVldWVzL3NlbmRfcmV2XzEuYwo+ICsrKyBiL3Rlc3Rj
YXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9mdW5jdGlvbmFsL21xdWV1ZXMvc2VuZF9yZXZfMS5j
Cj4gQEAgLTU3LDIzICs1Nyw2IEBAIGludCBtYWluKHZvaWQpCj4gICAgICAgICAgICAgICAgIHJl
dF9jb2RlID0gUFRTX1VOUkVTT0xWRUQ7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAg
ICAgY2FzZSAwOgo+IC0gICAgICAgICAgICAgICBtcV9nZXRhdHRyKG1xLCAmYXR0cik7Cj4gLSAg
ICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBNQVhfTVNHICYmIHJldF9jb2RlID09IFBUU19Q
QVNTOyBpKyspIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIlslZF0gc19tc2df
cHRyIGlzICclcycgXG4iLCBpICsgMSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c19tc2dfcHRyW2ldKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIlByZXBhcmUg
dG8gc2VuZCBtZXNzYWdlLi4uXG4iKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoLTEg
PT0gbXFfc2VuZChtcSwgc19tc2dfcHRyW2ldLCBhdHRyLm1xX21zZ3NpemUsIDEpKSB7Cj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwZXJyb3IoIm1xX3NlbmQgZG9lc24ndCByZXR1
cm4gc3VjY2VzcyBcbiIpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0X2Nv
ZGUgPSBQVFNfVU5SRVNPTFZFRDsKPiAtICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRmKCJQcm9jZXNzICVsZCBzZW5k
IG1lc3NhZ2UgJyVzJyB0byAiCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgInByb2Nlc3MgJWxkIFxuIiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAobG9uZylnZXRwaWQoKSwgc19tc2dfcHRyW2ldLCAobG9uZylwaWQpOwo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIH0KPiAtICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICAo
dm9pZCl3YWl0KE5VTEwpOwo+IC0gICAgICAgICAgICAgICBicmVhazsKPiAtICAgICAgIGRlZmF1
bHQ6Cj4gICAgICAgICAgICAgICAgIHByaW50ZigiRW50ZXIgaW50byBjaGlsZCBwcm9jZXNzLi4u
XG4iKTsKPiAgICAgICAgICAgICAgICAgbXFfZ2V0YXR0cihtcSwgJmF0dHIpOwo+ICAgICAgICAg
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgTUFYX01TRyAmJiByZXRfY29kZSA9PSBQVFNfUEFTUzsg
aSsrKSB7Cj4gQEAgLTkxLDcgKzc0LDIzIEBAIGludCBtYWluKHZvaWQpCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAgIGV4aXQo
cmV0X2NvZGUpOwo+IC0KPiArICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICBkZWZhdWx0
Ogo+ICsgICAgICAgICAgICAgICBtcV9nZXRhdHRyKG1xLCAmYXR0cik7Cj4gKyAgICAgICAgICAg
ICAgIGZvciAoaSA9IDA7IGkgPCBNQVhfTVNHICYmIHJldF9jb2RlID09IFBUU19QQVNTOyBpKysp
IHsKPiArICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIlslZF0gc19tc2dfcHRyIGlzICcl
cycgXG4iLCBpICsgMSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc19tc2dfcHRy
W2ldKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIlByZXBhcmUgdG8gc2VuZCBt
ZXNzYWdlLi4uXG4iKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoLTEgPT0gbXFfc2Vu
ZChtcSwgc19tc2dfcHRyW2ldLCBzdHJsZW4oc19tc2dfcHRyW2ldKSArIDEsIDEpKSB7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwZXJyb3IoIm1xX3NlbmQgZG9lc24ndCByZXR1
cm4gc3VjY2VzcyBcbiIpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0X2Nv
ZGUgPSBQVFNfVU5SRVNPTFZFRDsKPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRmKCJQcm9jZXNzICVsZCBzZW5k
IG1lc3NhZ2UgJyVzJyB0byAiCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgInByb2Nlc3MgJWxkIFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAobG9uZylnZXRwaWQoKSwgc19tc2dfcHRyW2ldLCAobG9uZylwaWQpOwo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICAo
dm9pZCl3YWl0KE5VTEwpOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPgo+
IC0tCj4gMi4zNC4xCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
