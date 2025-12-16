Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487DAD609C2
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765907456; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C0gP7F+Qyxc8Saf9d/6UQi6rgn1kQLSjp3fQ++8SS/U=;
 b=LeJ0kALIisewZkQYHYBDgm7L2OtF/fxlVjNe06elvX9jPjEY2KEc5Ubykz6gJAV0Uqm13
 GgPQ9xsQeuSlk370DxWGvPVzub7TehzB8e2Nm1N0U+Dvy6qyC1qLVsKCOoRK90qamXL33gw
 jjZU1P9/vxVQXVydC0qv+yoNiTECFg0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FE763D0378
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 18:50:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AAC53CECFD
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:50:34 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53CD020035F
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:50:27 +0100 (CET)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-595825c8eb3so5700255e87.0
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765907426; x=1766512226; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ11ATpsUuH5Ax24csRcEnxUZjhPU016CrL4HZ/SBMg=;
 b=zw0a/dPD48eEWRm365iuAiTbjstYaB2qUAVvbUjW0ewfXmIO6hKcCFEraP0PkrWuhD
 yKg7G5iF9DAIurKRmbK1TquyT72B2dZ1paQIutX+y1UsFjdqg2paWUWbvMqMWLAbNYd3
 /Jt2UJRKjdIZCTacusiWc/m9iAMRoqoo64DURS+HYiGyivJuOqC2c3zvG39MAaYY/8Yk
 Gb28F/udepdUWssK+FQ2AUC2keKuMi5aSXCyUhPuDtcrZukQXZh4gIJL/RtPTbR7hQmt
 vVm+7+kKEZY7qOzk4QlF1GJuyaZ29v8QFiWVVi8w4zf6lxv3ayr+7dxlhPoYbn7HDHkZ
 FvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765907426; x=1766512226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZ11ATpsUuH5Ax24csRcEnxUZjhPU016CrL4HZ/SBMg=;
 b=vlBWFIFOU+t8DEYcaBelnCMJ1kDfHSjwQ10NyQ4NIgHxg1icD4M+y9Zp/6dECpjxCk
 QshNuGtd8GxJ0ORU+ImKeAolSM+AtHX5tL2Zmzhq5HvJtOOcGuLEJpFpsUNZYag6blAj
 TWyJON5QvRxeCG7xSifK737bmwh1XxFehYg4nvyvwrnxowPxFMEo4MrdIKbdhz54zVVx
 uMGqokP+K5nW33NQBL3KDShYtiBjcGF96R3xFjZ6/LvM7yS+5wPdNFZCoSl01GPYiyJR
 xQaE69gkEJToNtHdBWImyX6D/ZcJkjh1eTM3XJIPbksxQI3NMn1tghrfQYNCUAanibb5
 JUmA==
X-Gm-Message-State: AOJu0YxrZaTwGROA/+d9gLa2UHMm+wOlekL1J/q+P3oLSOk5AwmEGFBe
 ei6V5e3JKKTM5Bc7fRfQjQ1+pkxIZDxRfS6ScXqiPT8a+VaDU7/69ysycsxCe9iWsf/2QSuV0Cy
 UK+cmapczE9nJWx5vSQIUIK8q2GdK/SDXtRtjhkRf
X-Gm-Gg: AY/fxX7WibCW4MxbqwK4PLCFX+GdFb3OIJl0nNdhMrpsFXKNdByIIlu3vztIdTiZsck
 KzEY9GRlehjc591TYExjGBO8R5PLgB2ksDsZ4VIJ7CmRRDIjNkC32gfVuwtwnSGDLuQAg9RquyX
 qaQLvYIHwgE6vzw7WhLCGGMa5iJzQ9A8Ti+8Ee0hesSxT5kUMCz8JfaUvvYF6Qcy82ViNOHToaL
 Xo5MUggzO+3Cciony7vo+J2iYgPhxSZWvX2601ifFnnt/tBqdIgzO18Lq94oBFymHC9Rw==
X-Google-Smtp-Source: AGHT+IHCPG1StADKDMHOLJSYDUEG9lcL5Mzdg8LMR9MI95mh2u+Zu+WhZAxe1pVEkkMePddu1/tiqMkKJhDnvOqqsAo=
X-Received: by 2002:a05:6512:ad0:b0:598:eecd:ab31 with SMTP id
 2adb3069b0e04-598faa98367mr5258477e87.50.1765907426042; Tue, 16 Dec 2025
 09:50:26 -0800 (PST)
MIME-Version: 1.0
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
 <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
In-Reply-To: <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
Date: Tue, 16 Dec 2025 09:50:13 -0800
X-Gm-Features: AQt7F2qAYf1aas_lMriqLbs3HmPWVfcVFTdIVsYeSphbyL9ZZ5OmuSgFULgzGqQ
Message-ID: <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Chris Wailes via ltp <ltp@lists.linux.it>
Reply-To: Chris Wailes <chriswailes@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QW5kcmVhLAoKVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIGNoYW5nZS4gIFdlJ3JlIGN1cnJlbnRs
eSBhZGRpbmcgYSBgY2xvbmUzYCB3cmFwcGVyCnRvIEFuZHJvaWQncyBCSU9OSUMgbGliYyBpbXBs
ZW1lbnRhdGlvbi4gIEFkZGl0aW9uYWxseSwgdGhpcyBpcyB0aGUKc2lnbmF0dXJlIHVzZWQgZm9y
IGBnbGliY2AncyBgX19jbG9uZTNgCjxodHRwczovL2dpdGh1Yi5jb20vYm1pbm9yL2dsaWJjL2Js
b2IvZGVkOWMxZTUyNWYyZDY5YTgxZTYxYzM0YzI5MDc3ZmVkN2RmNjU4Yy9pbmNsdWRlL2Nsb25l
X2ludGVybmFsLmg+Ci4KCi0gQ2hyaXMKCk9uIFR1ZSwgRGVjIDE2LCAyMDI1IGF0IDQ6NDDigK9B
TSBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgp3cm90ZToKCj4g
SGkgQ2hyaXMsCj4KPiBGaXJzdCBvZiBhbGwsIHNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4gVW5m
b3J0dW5hdGVseSwgSSBjb3VsZG4ndAo+IGZpbmQgYW55IEMgbGliIGNvZGUgcmVmZXJlbmNlIHRo
YXQgaXMganVzdGlmeWluZyB0aGUgY2xvbmUzKCkgd3JhcHBlcgo+IGluc2lkZSB0aGlzIHBhdGNo
Lgo+Cj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVy
IExpbnV4Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQo+Cj4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
