Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A47109190B
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773946564; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+oz/kgTWkfh5+FU0X74C9FSEa8IXbQkWS/ksyy4AbSc=;
 b=NuEYRmL0yD70pcYN3OO4WFG4Z6NMuJd1yGFegij333zgq5txDJ+yw86jzhxcqdC/7hohq
 c6SanDIRGkadWpoO9SFZVpsmlhov3ghwzRUvCORHQR4cbqFBYny03p7vqWkAOQI5cLQTyyp
 304rpJh84X6FjJawfheM/inMcKbnkCY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF9E3E30C2
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 19:56:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 739483E1CEA
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 19:55:40 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5D141401211
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 19:55:39 +0100 (CET)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-38704f70ea3so11627561fa.2
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 11:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773946539; cv=none;
 d=google.com; s=arc-20240605;
 b=C8SonsaaaNEy510fPNQuhQWs5DzvUDloYeUYHf9HP7Mp5YJBwq6YZ+7RpOhf1jZ4wI
 EdEcgdzGAwxuTbyrM2OPASAvB0SjQON48YfG3zNE2z9qKLqj5kJaU1ama8DYCJ55jNud
 CIZWI1n7andk3lS8zBr2opoIybTqcc0ndRE19yIzZTaa8xjFkFJPEhNGZ+teBsEZPBa2
 JUWfYEfb45KTbvpXWkCO1S9pexnaGFNqJgjF3WikzIP6ws1E1to66tACeOYk+6NDIoIG
 D+r+ID+TZxqI2/EoKH22I9rraqLPc5aKObzBcP2nq6i/+ltyeTq/ULHbQVzxaTZ5YW+H
 w78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3rk0RJmJkK3rjcoG+WLX7OlLwh07j/T+iQvU0OP2cI=;
 fh=bHAnNs0lV0TgPev7b1M0YDomSbZSyPHUPmBZH4cVpe8=;
 b=QQz/cWqTCE6H/axQ+thXPsnGHmnWYDoYby2r5btoXmH9m8vrvah+5XzMfUNjG95B9S
 JJTZEqkv21QhvL+YqIFRWWlspBuZ5IoiocDg1Fp5N1BroCr7xeJU3A392UhBYHC4EElZ
 akgtpcCGKX4hjExMTwkPEmTe0SUREqecyNDjLXOlq2l3jUg0pFVLvh8F6G9U3Bvk5ENv
 omf4uI0TiEG2+rAkFyiwHAIQbLqZtRuhVtC2NqCSmQKqb4ZkCV4o6Df386z36UueOAEw
 p2OYJTnCnZaLzyw8XWaw4Gpz3HCQu+l8yUebslGKvY6ZEQa9h+ofAhjCICYQ4qRK3sn0
 G+SA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773946539; x=1774551339; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K3rk0RJmJkK3rjcoG+WLX7OlLwh07j/T+iQvU0OP2cI=;
 b=eNlBPcxPRThYjND8ntavj05743KTUDWankSCZPiZyQQpus7Tk42Fh8wFlF+AidqLEZ
 W/+EfXr2ofqqTlR/UOZJMngTFC8E4DZ7PiBrsCb9F/V2w7tZcToUx/57Ll354NedxYYJ
 s3VZfyKV6HqMbWfVd/hERZ+n2NxTrmn+RXUlAVLIiVvWauu8uIfFHFlvlkVmyAvuYKj3
 GH1LLqaySJApD92fOAsvjvk5laeS3Ne0Qsak91H8D2t2Z5AiBCQQaPP1e9p7LgNd9Geg
 Zv6UKxlOfqBFCDqiUlCiAOq4mmvKEPkBhcDatC8m2UvULdxCRgGT0IxUkS5N4zAPOmw1
 O6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946539; x=1774551339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3rk0RJmJkK3rjcoG+WLX7OlLwh07j/T+iQvU0OP2cI=;
 b=sGPZ9VhB4I8I/3NINhZfItxejdVY4S4JvXsjDX90qrDcpD3DzC5kI0XB9j7juPCFf7
 k3Wawzt2pJG9IG5dycQ7GTuAv5pjCvVqM+FV3IhiDDa8ixLCKp+Nxh1yaDCOlM9mS106
 +rnJ76xcI/vZSMBiEQ5yzvgPQ4zTLJSWC92gOGEHqnwmXTQ9f3xvaO0htjmZL/b9oryD
 97q1A/n52fh2iEdynetrjb7IBDca5/aqJwClD5ss+Xm5J2Fie+dbQ/ttDkgY7VY215xr
 NX7XR+0kGy+qGDhuOsdWl9Re401rIFru3b9VXnZcUn6Sn5dyEhdXRoWIHYq3kB32yNJQ
 MGYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOHjwPK/oDa1JUe0sElbT47m5nq11OiAuAS8L230j9UeyBNMiufOulRkzWcT8K59FfNrs=@lists.linux.it
X-Gm-Message-State: AOJu0YzyczgIi3yFEJ8jKDe+t2HyMsSdQ0kPjJu1yv93qh8bm1EqERx1
 gUPDddFCyoDu+HLlME1mtqnzv+pBdoo7VOBb67SdEgA+VNZV8NlDu8O9PENW0AaTI8dzbUb4SJg
 F+qCFPvL2LZ+WJHOAOiLY2aF8L6rEBCBk/BehJgfB
X-Gm-Gg: ATEYQzzf09rWkfgaHmoQfzLrpQSKE3MMWPjVBDr4wSsjdDYfeQFeKVuTnCzTwzBRWp1
 KTu4mlTBjOmBiKN3x84QQ2lnnPpdnKo/4bGusgNi+2YS+OfYCxAXeTTEUqjTBa5xnCPIZ6lpk2p
 cUkrfz2wzL4vGQPYkzgs6G/vLO+YiEAYEai2iA2Eo8G7Yb1gtg4yH7c2n7Zt1Uf9lHuzj0lhjX/
 v6q/plnlp0yiL/PyydPDjyR1aoQX6fpd5aJXjH7vdz/lKBT9IrXzUnpCp5yrY8oOTFXxtFsm7iu
 rlTONX1d6e+G8RjvfDwKhjzTx4TjHkwoqwFGyQ==
X-Received: by 2002:a05:651c:1b12:b0:38a:3374:f908 with SMTP id
 38308e7fff4ca-38bf9685a23mr1946021fa.16.1773946538451; Thu, 19 Mar 2026
 11:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
 <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
 <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
 <7d12c14f-4654-4248-b478-f57d721aba9a@suse.com>
 <CAEemH2fxanCLLMaMZRporvMXxdg0LKjO07_4suHgcFYxGQGCPQ@mail.gmail.com>
 <CAKfqHert2XNHQ12ai3r7joZYwTcV2DkbW7jFu7HqB07ZncQr+w@mail.gmail.com>
 <CAKfqHeonbt5n6d4GoWbmcqfAXpBdCsUNH0wbdzd1N65_+KHWiw@mail.gmail.com>
 <abtzeEghSKbrVf38@redhat.com>
In-Reply-To: <abtzeEghSKbrVf38@redhat.com>
Date: Thu, 19 Mar 2026 11:55:26 -0700
X-Gm-Features: AaiRm51fTmdd9AtgT5xoKEoKtMy_QgaKTzfA_Uw_qkn-uQqyQMGn5aGA931IelQ
Message-ID: <CAKfqHeo2wkL77_zfegJJ0sY8erROEfeOd01KKFWLiJtAiksv8g@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: chrubis@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RG9uZS4gIFRoYW5rcyBmb3IgdGhlIGd1aWRhbmNlLgoKLSBDaHJpcwoKT24gV2VkLCBNYXIgMTgs
IDIwMjYgYXQgODo1NOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKCj4g
PiBXb3VsZCBpdCBiZSBiZXR0ZXIvZWFzaWVyIGZvciBtZSB0byBzdWJtaXQgdGhpcyB0aHJvdWdo
IEdpdEh1Yj8KPgo+IFRoZSBwYXRjaCBnZW5lcmFsbHkgbG9va3MgZ29vZC4KPgo+IFdlIHByZWZl
ciB0byByZXZpZXcgcGF0Y2ggaW4gbWFpbGluZyBsaXN0LiBDb3VsZCB5b3UgdHJ5IHRvIHJlc2Vu
ZAo+IGl0IHZpYSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzPwo+Cj4gICMgc3VkbyBkbmYgaW5zdGFs
bCBnaXQtZW1haWwKPgo+ICAuLi4gZG8gc29tZSBsb2NhbCBjb25maWd1cmUgLi4uCj4KPiAgIyBn
aXQgZm9ybWF0LXBhdGNoIC0xCj4gICMgZ2l0IHNlbmQtZW1haWwgMDAwMS14eCAtLXRvIGx0cEBs
aXN0cy5saW51eC5pdAo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgo+CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
