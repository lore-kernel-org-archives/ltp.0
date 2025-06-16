Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C342BC71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750082996; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AKqRvhKFzANfqwJfA6nOEwsk8qJAER9OSOumSaQB+OM=;
 b=D7IFIM3keWE3jTbiYNvZC9j5029hlLOd+fdeqtuZzxIc+3dPpm4YWK0NurwMdrDGr7Swa
 MYRWQlZ3sD5T8W6tYhLoD2rO20OMPdqUOVEqh4fztxbGM5hXlnyLEYPPTgbe4gPRpAsB0/Z
 nGYOMaxWvc8C3HOhJo9OLky5bNrVI2k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 428493CC099
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:09:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DADE3CBF43
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:09:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 402BE600837
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:09:34 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2669772f8f.0
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750082973; x=1750687773; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdtlb8/DQ/04SBMpDsVYAK1iUv/gHzkg3s7lnE8qB4c=;
 b=eBTwjeRntc82T9FAUQGvvzNo5nM6SnHGg3VWRVSJpoSfuxvyeCpYO1UdNM8DwMJSuI
 PylWZE05KqD73XZqlJUTq/Z6Ih3O2GuK3143XixGBnjkZVHVKzsO5Dc6n4T5NV3Pelu7
 Ud3bj85cF5S9W2lyqFpWjTtQrBGH3PIMHTpDi2nZ89Alo8OOzvnUYECcjPUPJdKggtxR
 M94QXZwuPPfAkougcB10PNC+mBRa2u3KrCN9WEOaTkNldDqxBrHeq+iV5obq1CsKZN5p
 Rt9LHvMs7uhin+TxpsKXGFbqZr8PyBPwBtt9PlPpVhRSygpVd3EYRnArVh0N08OjHlvC
 tqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082973; x=1750687773;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bdtlb8/DQ/04SBMpDsVYAK1iUv/gHzkg3s7lnE8qB4c=;
 b=Y6uZ/Nn6DGMmcg82GGxTqOVy6X4cn3niT/I203TdUdy4G2cyGkbqS4rucN0N4Kle8w
 yfnQXDL/TyXJmJEv6wHatA8TzPReDmMpcQnbDzH8RreIqcHp604ecq2ENicblz2iYFSN
 q1HIL578PhkUacGHK5YgF3NhulR0Gz+b/9gcDwT38Ok8SEFpICeSKfldXnm3FzgAceNt
 GZMAOQUFAXAPOliHlVxNO0hjjpKqBDAVsqvGMy8L0L+xB3K5sq/pevtnQraQaXNMQQer
 DN/z/BAl9cgiLT/uZQui28mYDKls3sWyNvui/lRoS4h8BPJSZSYZl66dnnFnU4q1IUG9
 MtMA==
X-Gm-Message-State: AOJu0Yxwm3C9CBbcBxZmVglnTNMeORssGyWRgTOmQL1NxkL1Jb9vw3pU
 ETL4O5o9C6fPiVLNHmEjh/WSQBxeIve7wbUpWt8MlKyxCt1cVRDDSCsWdhldoyfbz8E=
X-Gm-Gg: ASbGnctFHcm57gvGhvloJOZGi0W3n78BGZ3SmVZbJFbMOcPvsoEbmLvSkQ4rEtot7H4
 AqM3QJbx65F03c7xnq3cgm7B8IqufxJsoxWYgkBCoEMPo6FkQc4UqwSQcKoh19I4llZi0/DmKhq
 w4tKvTC/el7HaPKm1XOkycm4GzgwjrF54ju3iNKwvOXXl87ErGgvwBZoBR3XsTyPWOHEY4qlrtL
 eNkYaGiGgU/jUQheJfmrIvNndczOzFmEgSwttavU5JTSHcQiPaoLIKsYyoQ0d3luafkCfNJ2oBI
 4IlmrlDHRYO7WFi1nu6h6Wg5++qtpWUTFNH0QNzH/6yS6KMu
X-Google-Smtp-Source: AGHT+IEiokkmmhV8y1T+FsKzY92CvQ2PKEb+WtD46E1jC7jkl09SirSkFRcxqXGQtyNE8kzjO2wJyQ==
X-Received: by 2002:a05:6000:2f84:b0:3a3:63d3:369a with SMTP id
 ffacd0b85a97d-3a57237c5bamr7874052f8f.25.1750082973517; 
 Mon, 16 Jun 2025 07:09:33 -0700 (PDT)
Received: from localhost ([189.99.236.25]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-748900062cesm7026316b3a.57.2025.06.16.07.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:09:33 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 16 Jun 2025 11:09:27 -0300
Message-Id: <DAO0MWF8LETA.1PY8DUWS4A6W7@suse.com>
To: "Li Wang" <liwang@redhat.com>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
 <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
 <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
In-Reply-To: <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1biAxNiwgMjAyNSBhdCAxMTowOCBBTSAtMDMsIExpIFdhbmcgd3JvdGU6Cj4gT24g
TW9uLCBKdW4gMTYsIDIwMjUgYXQgNzowMuKAr1BNIFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1A
c3VzZS5jb20+IHdyb3RlOgo+Cj4+IE9uIFdlZCBKdW4gMTEsIDIwMjUgYXQgMTA6NTIgUE0gLTAz
LCBMaSBXYW5nIHdyb3RlOgo+PiA+IFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cj4+ID4KPj4gPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgo+PiA+Pgo+PiA+PiBUaGUgdGVzdCBjYXNlIGRlc2NyaXB0aW9uIHJl
YWRzOgo+PiA+Pgo+PiA+PiAiVGVzdCBjYXNlIHRvIGNoZWNrIHRoYXQgU0lHS0lMTCBjYW4gbm90
IGJlIGNhdWdodC4iCj4+ID4+Cj4+ID4+IEl0IG1ha2VzIHVzZSBvZiBzaWdhY3Rpb24oKSB0byBz
ZXQgdXAgYSBoYW5kbGVyIGZvciBTSUdLSUxMLCBidXQKPj4gPj4gYWNjb3JkaW5nIHRvIGl0cyBt
YW51YWwgcGFnZToKPj4gPj4KPj4gPj4gIkVJTlZBTCBBbiBpbnZhbGlkIHNpZ25hbCB3YXMgc3Bl
Y2lmaWVkLiAgVGhpcyB3aWxsIGFsc28gYmUgZ2VuZXJhdGVkCj4+IGlmIGFuCj4+ID4+IGF0dGVt
cHQgaXMgbWFkZSB0byBjaGFuZ2UgdGhlIGFjdGlvbiBmb3IgU0lHS0lMTCBvciBTSUdTVE9QLCB3
aGljaAo+PiBjYW5ub3QKPj4gPj4gYmUgY2F1Z2h0IG9yIGlnbm9yZWQuIgo+PiA+Pgo+PiA+Cj4+
ID4gT3IgY291bGQgd2UgcmVmYWN0b3Iga2lsbDA3IHRvIHZhbGlkYXRlIHRoZSBFSU5WQUwgd2hl
biBjaGFuZ2luZyBhY3Rpb24KPj4gb24KPj4gPiBTSUdLSUxML1NJR1NUT1A/Cj4+Cj4+IEJ1dCB0
aGVuIHdlIHdvdWxkIGJlIHRlc3Rpbmcgc2lnYWN0aW9uKCkuIENvdWxkIHlvdSBwbGVhc2UgZWxh
Ym9yYXRlPwo+Pgo+Cj4gWW91J3JlIHJpZ2h0LCBpZiB3ZSB0ZXN0IHNpZ2FjdGlvbigpLCB0aGVu
IHRoZSBjb2RlIHNob3VsZCBiZSBwdXQgaW50bwo+IGtlcm5lbC9zeXNjYWxscy9zaWdhY3Rpb24v
c2lnYWN0aW9uMDMuYy4KPgo+IE1heWJlIHdlIGNhbiB0cnk6CgpTdXJlISBCdXQgaW4gYW55IGNh
c2Uga2lsbDA3IHNob3VsZCBzdGlsbCBiZSByZW1vdmVkIElNSE8uCgo+Cj4gc3RhdGljIHZvaWQg
cnVuKHZvaWQpCj4gewo+ICAgICBzdHJ1Y3Qgc2lnYWN0aW9uIGFjdCA9IHsKPiAgICAgICAgIC5z
YV9oYW5kbGVyID0gU0lHX0lHTiwKPiAgICAgfTsKPgo+ICAgICBpbnQgcmV0Owo+Cj4gICAgIHJl
dCA9IHNpZ2FjdGlvbihTSUdLSUxMLCAmYWN0LCBOVUxMKTsKPiAgICAgaWYgKHJldCA9PSAtMSAm
JiBlcnJubyA9PSBFSU5WQUwpIHsKPiAgICAgICAgIHRzdF9yZXMoVFBBU1MsICJzaWdhY3Rpb24o
U0lHS0lMTCkgZmFpbGVkIGFzIGV4cGVjdGVkIHdpdGggRUlOVkFMIik7Cj4gICAgIH0gZWxzZSB7
Cj4gICAgICAgICB0c3RfcmVzKFRGQUlMLCAuLi4pOwo+ICAgICB9Cj4KPiAgICAgcmV0ID0gc2ln
YWN0aW9uKFNJR1NUT1AsICZhY3QsIE5VTEwpOwo+ICAgICBJZiAocmV0ID09IC0xICYmIGVycm5v
ID09IEVJTlZBTCkgewo+ICAgICAgICAgdHN0X3JlcyhUUEFTUywgInNpZ2FjdGlvbihTSUdTVE9Q
KSBmYWlsZWQgYXMgZXhwZWN0ZWQgd2l0aCBFSU5WQUwiKTsKPiAgICAgfSBlbHNlIHsKPiAgICAg
ICAgIHRzdF9yZXMoVEZBSUwsIC4uLik7Cj4gICAgIH0KPiB9CgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
