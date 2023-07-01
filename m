Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C20EB64DC
	for <ltp@archiver.kernel.org>; Sat,  1 Jul 2023 14:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B7CA3CCEFF
	for <ltp@archiver.kernel.org>; Sat,  1 Jul 2023 16:16:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5833CC245
 for <ltp@lists.linux.it>; Sat,  1 Jul 2023 16:16:36 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1734460008D
 for <ltp@lists.linux.it>; Sat,  1 Jul 2023 16:16:36 +0200 (CEST)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-440afc96271so1027146137.3
 for <ltp@lists.linux.it>; Sat, 01 Jul 2023 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688220995; x=1690812995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84bPYaK31aMN2ZwSfdkcMICU9d0HioO0KREQUvtk3sQ=;
 b=c1W6a/s+u10sVJxI3ml6FHbExbWLnW+HxRXwj8sFH2PSDGpR3ythAmfGVBZE2aFWlh
 mnz0IpbM60JllCwDxdChOcUBtdE403muwWphd/gOawC7wfj3aAU/isEo8980/p04s9hI
 saOlmuPMMQ++0I2H+mtM0Z8fGa4VLUF/v/IiQfwDcbWIPoIL8Fs7C25mfImzEU5IkU1H
 itOp6PFxL485XG+awxz4j2xYWTucv7yG36v3kxexXx+hjFurn1xG/yM/cFrUS9uhayNs
 Qmo6xItHb6PKHmkprkok/6ByY1K1gSH/FM3NUVzCZDn3T5L802sTY+JNV+nxqEAObySr
 0Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688220995; x=1690812995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84bPYaK31aMN2ZwSfdkcMICU9d0HioO0KREQUvtk3sQ=;
 b=g4HwcYyh5I4RlGv1aoeQYVp+FW11D/EoRMeesfbAmXQI8/ZlL6VmPelBh9GrW3RDuO
 8kCtHCDCVF21sk+J/GnlDbeT5xMWcshMK8Scr280DCp5ClGtB4CnQgijVfY3g+kaSi4s
 6i49Nq0lWT1ymXYv+5p3hn47MvhoZpCScBDmMKJxWX1ZobgJD/JUVnkIr/RDsNnXV/VA
 26a4DRxS29zkL1zvQcNDmzxiDA47FLLgivZjG3m6E4msQmVqaiE9l8QZycBAhIE3HLbU
 eo7fasgmeGvn5eBWGr/gs+AIwFSOlIOBh9mfxFWQy3OLzSm9aP77X7vO8a7toefIY53H
 fBwg==
X-Gm-Message-State: ABy/qLZkqLTrJXdAIr51Tp69KEQdpk58U3kXVoT7gDflYmYJOLQ/kCh3
 nJakMDbBJJ7SQkXLnPP1d3NkxmNbH/IzdY520qM=
X-Google-Smtp-Source: APBJJlHMGBF8gDboajlNqsCa9/zJ3uAFMrnTHOGrojE6YROMuDZlCmPHQvU1n+mQxoQvNHVnP0O90NyFWEmm6nDdRO4=
X-Received: by 2002:a67:ea88:0:b0:443:8f10:7f72 with SMTP id
 f8-20020a67ea88000000b004438f107f72mr3560603vso.14.1688220994392; Sat, 01 Jul
 2023 07:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230630193742.310416-1-pvorel@suse.cz>
In-Reply-To: <20230630193742.310416-1-pvorel@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Jul 2023 17:16:23 +0300
Message-ID: <CAOQ4uxjG0GrKRZE5btcbptjAaKRLj+OFMJRynPwPx4_BP4=e9g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] runtest: Move fanotify23 from
 staging to syscalls
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMTA6MzjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBmYW5vdGlmeTIzIGlzIGEgdGVzdCBmb3IgRkFOX01BUktfRVZJQ1RB
QkxFLCBwcmVwYXJlZCBmb3IgdjUuMTktcmMxLgo+IFdlIGZvcmdldCB0byBtb3ZlIGl0IGFmdGVy
IHY1LjE5IGJlaW5nIHJlbGVhc2VkLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+Cj4gLS0tCj4gT2J2aW91c2x5IHdlIGZvcmdldCB0byBjaGVjayB0aGUgZmls
ZSBhZnRlciBzZXZlcmFsIGtlcm5lbCByZWxlYXNlcyA6KC4KPiBJJ20gc29ycnkuCgpPaCwgbWlz
c2VkIHlvdXIgbm90ZSBvbiBjb21taXQ6ClsgcHZvcmVsOiBtb3ZlIHRlc3QgaW50byBzdGFnaW5n
IF0KCklmIEknZCBrbm93biwgSSBtaWdodCBoYXZlIHJlbWVtYmVyZWQgdG8gcmVtaW5kIHlvdSA7
LSkKCmZhbm90aWZ5MjMgYW5kIGZhbm90aWZ5MTAgYm90aCBhZGRlZCB0ZXN0cyBmb3IKRkFOX01B
UktfRVZJQ1RBQkxFIGF0IHRoZSBzYW1lIHRpbWUuCgpCdXQgc2luY2UgdGhlbiB0aGVyZSB3ZXJl
IHR3byBhdHRlbXB0cyB0byBpbXByb3ZlIHRoZSByZWxpYWJpbGl0eQpvZiBmYW5vdGlmeTEwOgoK
NDhjZmQ3YTk5IHN5c2NhbGxzL2Zhbm90aWZ5MTA6IE1ha2UgZXZpY3RhYmxlIG1hcmtzIHRlc3Qg
bW9yZSByZWxpYWJsZQo0ZmVmZGYzNDAgZmFub3RpZnkxMDogTWFrZSBldmljdGFibGUgbWFya3Mg
dGVzdHMgbW9yZSByZWxpYWJsZQoKSSB3b25kZXIgaWYgZmFub3RpZnkyMydzIHJlbGlhYmlsaXR5
IGRpZCBub3QgY29tZSB1cCBzbyBmYXIgYmVjYXVzZQoxLiBJdCB3YXMgaW4gc3RhZ2luZyBsaXN0
CjIuIEl0IGhhcyB0aGlzIGhhY2s6CiAgICAgICAvKiBTaHJpbmtlcnMgb24gb3RoZXIgZnMgZG8g
bm90IHdvcmsgcmVsaWFibHkgZW5vdWdoIHRvCmd1YXJhbnRlZSBtYXJrIGV2aWN0aW9uIG9uIGRy
b3BfY2FjaGVzICovCiAgICAgICAuZGV2X2ZzX3R5cGUgPSAiZXh0MiIsCgpJIGd1ZXNzIHdlIHdp
bGwga25vdyBzb29uIC4uLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
