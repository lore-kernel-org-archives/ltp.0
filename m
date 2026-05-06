Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7605CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778075553; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0tC9ZC2YrfPfGJ0GtmBDMcpS7FTvMn/JDaN4/VGy81A=;
 b=LTGV1GuIHsGut0JMAptXlMWfpgn+91fki2W01x8zBIZwjL+C053oLlk1X53tDHyQBqa4B
 HvyVxQBb7+ZhurWzeeuqkV4bVsDVisp9oE26bP74+TCISR3WOM6oSTIVUHVTFREYX5G+Zr+
 F/d7r2kPb0oumDCbvQP+1ztHhvxN1lM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E303A3E6166
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:52:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC7853E2C53
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:52:10 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A5BF60057C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:52:10 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso3595182f8f.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778075529; x=1778680329; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V2vjXOfPnrMM7DPki2X+K5TWBF97F/1LnZcKypziBiY=;
 b=HRVSVr1iRqloaw9GsRd57EBz/nLZVoHzPghDig6d7uzAl2Up94SfzSQQFKwFja+5pt
 hM8vGi4Kp+YmRw/d8UMxshIrzE6AKd3Ui/WRfEEtbDFCxE0+T0B+qd5bhNHnhg+Cfiki
 wV6WipPBcVZ2QiF3Pp01xy2yM8OURDYR12jyTcm/BENOmpTzcswIyhVMLBxtM5EVVfq6
 lk5S1yrFJCP+IcL6yC04k8AyOOj8YEAhPXy0oR++H1AB7fL2sCi/vZCScWqKHuzjwEpd
 o+3mDb2ypgj7EtJPVK8K/uQqPv3K9nPbWuUP4wa09X+DuvVx9Isd1LlwGE5yoe21lLjk
 +xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075529; x=1778680329;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2vjXOfPnrMM7DPki2X+K5TWBF97F/1LnZcKypziBiY=;
 b=s9hcZ1SA1lXpy8FJa/evLm62GqnOTttxuI0+Qj/jmqbfmFo6dVF77XiejNExHz21X3
 iFTVKLXW4V84BIxu5acFGKEa1o9iMQCCgKDLKmEJkpKI/c+qS8iEzpp/opDKsnFmn7MT
 veI+dvKdTB3w52EG7kVkhvDMWnAWYjRkasj8uhfDPLFjgBdXWVgTW2a0zEFRXSHzhYhi
 ZmmQEQAriLnNgBp4MaMw7wncX2tqzNEijo47ihXCYCNJQay7vR+5oEDSaMrvzj4MQEMN
 dKSba04EQzlLBWzMBWeBhLiy7K0vP4G9yAhw7jrQ2kdjG9UyKwK3o5lAL6hGCkFrQKXH
 toaw==
X-Gm-Message-State: AOJu0YzWJOr9gn6Hw02qgtERQk6m2Ib1QsUQrrYQ32A2Gij7PdqNulAk
 g8y1TUnixaEpQjRupM//ItAqxaHkWLfyjvjynJ6TVkG7Z0Os7KYGEZxb4K5i57KO+YPJ6S+DKo5
 MyXQcAWWA3g==
X-Gm-Gg: AeBDietBipvsFZzRdsMsXglLlflVxV4q956stAOFT4Xipw2PY2BgPB1uKkSKP+BgifE
 oBmMLlDrBD/74+2SKsspTxz+Sw/uMlgZLKh5QfXQTMw3FS3huK9HdubGgMdZAR4XCN6piGiLRuT
 bR2+ZG0yHGTOr6DEF6lTC3DZ+rjxaQ0l2+X9jdAHab8piCs2Qx/hYsVWQkGn3lyo1ybMDBF2aA0
 RoRiHuQ9Uapf39OCBhzQ7Qf81d+1cdVFhLw5n/wRMHY8yhatKp3FfEY0v4CnBSvv4ssk6QCjUTf
 GJSHTCADCLPglMMT2swxxrrGC920lxntiU3HFqqkvOjl/Z/ZyMb4M7na5ln8NwT4i/4h7VzUhw3
 Xf2s/Choc3lxnuKWw1oyPYOXua5EUz/4Q18EdjATebIa9iM+fVvUSyfr8lfKB2qqCeDtFYf454I
 iRj6TsKfpJ1t4yL3wY1SghyFbuabGYmPsHQg2xoXAXlExxVjxAAQhS5yLMNupng6rzkAstOH70Z
 61GYas8zJVb21+2qerk9BWnT/OLHInIWKw937gWa/DeJE8k3wxDIC2i/L3WpniP1YpubeuSAcY2
 CBIHu9H0Gdsw
X-Received: by 2002:a05:6000:4305:b0:44a:ef8c:de18 with SMTP id
 ffacd0b85a97d-4515cf125c6mr6221878f8f.25.1778075529433; 
 Wed, 06 May 2026 06:52:09 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524834eesm12262133f8f.4.2026.05.06.06.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:52:09 -0700 (PDT)
Message-ID: <69fb4789.5d0a0220.2b948b.6eaf@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260409103041.8253-1-chrubis@suse.cz>
Date: Wed, 06 May 2026 13:52:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Fix proc parsing in newuname01
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWdlbnQgZGlkbid0IHNlbmQgdGhlIGZvbGxvd2luZyBlbWFpbDoKCi0tLSBSZXBseSB0byBbUEFU
Q0ggMS8yXSAtLS0KCk9uIFRodSwgOSBBcHIgMjAyNiwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IGxp
Yjogc2FmZV9maWxlX29wczogQWRkIFNBRkVfRklMRV9SRUFEX1NUUigpCgpIaSBDeXJpbCwKCj4g
KwlmID0gZm9wZW4ocGF0aCwgInIiKTsKPiArCWlmICghZikgewo+ICsJCXRzdF9icmttXyhmaWxl
LCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBOVUxMLAo+ICsJCSAgICAgICAgICAiRmFpbGVkIHRv
IG9wZW4gRklMRSAnJXMnIGZvciByZWFkaW5nIiwgcGF0aCk7Cj4gKwl9Cj4gKwo+ICsJaWYgKCFm
Z2V0cyhidWYsIGJ1Zl9zaXplLCBmKSkKCk1pc3NpbmcgcmV0dXJuOyBhZnRlciB0c3RfYnJrbV8o
KSDigJQgZiBpcyBOVUxMIGlmIGZvcGVuIGZhaWxlZCwgc28gZmdldHMoKQpkZXJlZmVyZW5jZXMg
TlVMTC4gRXZlcnkgb3RoZXIgZXJyb3IgcGF0aCBpbiB0aGlzIGZpbGUgaGFzIHJldHVybjsgYWZ0
ZXIKdHN0X2Jya21fKCkuCgpTYW1lIGlzc3VlIGluIHRoZSBmY2xvc2UoKSBlcnJvciBwYXRoIGJl
bG93LgoKPiArCXNpemVfdCBsZW4gPSBzdHJsZW4oYnVmKTsKClZhcmlhYmxlIGRlY2xhcmF0aW9u
IGFmdGVyIGEgc3RhdGVtZW50LiBNb3ZlIGxlbiB0byB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbgp3
aXRoIEZJTEUgKmYuCgo+ICsgKiBJdCdzIHJlY29tZW5kZWQgdG8gdXNlIHRoaXMgZm9yIHZhcmlv
dXMgc3lzZnMgb3IgcHJvY2ZzIGZpbGVzIHRoYXQgbWF5IGJlCgpzL3JlY29tZW5kZWQvcmVjb21t
ZW5kZWQvCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tCkFuZHJlYSBDZXJ2ZXNhdG8KU1VT
RSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4CmFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
