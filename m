Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF02CC7EE2C
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 08:27:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0CEE3CD29C
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 10:27:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B4253C04A5
 for <ltp@lists.linux.it>; Tue, 23 May 2023 17:09:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D23F720093E
 for <ltp@lists.linux.it>; Tue, 23 May 2023 17:09:54 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6094cb26eso11497505e9.2
 for <ltp@lists.linux.it>; Tue, 23 May 2023 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tessares.net; s=google; t=1684854594; x=1687446594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E8b9MpzTCglN7HI+qZ7EYTlHwVoKr0imEe2dKuGSUUc=;
 b=oedF/OpaSzR0ty3V7END7dGpEbKtM9xZFqWV75o4kqKtimqL14VCIbfzEeX2RK4svX
 vxTe8PsCutukTy7lfsL2C1C8OdHQyQqAqIO+2v6etis6aieDlewgAvQqdy7iKuxlj/ze
 kJSKUdJlLYTMdPLGgElYQ2/WJGcCBsw6Zm9GKGycBR9BZs7CKmHF3darLzJ4fUWT8Kwm
 lXO6X85FLpXKuoYLk07ZsOJCr/3NiJqFywVt+zDzED0lLsFJ+vPYkvCeA4sZDPv+roE+
 XUZfldjTcau4V7yYACc2RTLfe1c4FXOeA7qaJjwDEVo28mmoB2g0YCB/G3MW2i6gG6l+
 Dgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684854594; x=1687446594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8b9MpzTCglN7HI+qZ7EYTlHwVoKr0imEe2dKuGSUUc=;
 b=Kw6VkagFPCs+Q87rHweKfEFQvscVdyYfvTI0r5/BOgX7OBerYu9ghWZ9hWZN07zjvQ
 HaR7OYyFSNY5bb2G9e6i/1xHYCE1qObkqiBQQnnCNev4kKWcfJqCUT2YBq4rlnK8V7Zb
 WLMfB2ODLvw5o1uN1m+WZx9A0ziKkXwkp+BbV+v+NRYzjWQWhhuWUV3lqSNp7YGnCnv3
 eZock7WuB/+z9jrD0r0b/MLmgp8nqaE+E5whaWpezZfDkpFwz8DBppbKAm76A+7Ccps/
 qKR/Zv+x5Q/36fuSxChYZXxY+goFXMlLhFY3ksTUhSUtoNLcKPRnVNTaLfUtkugebFME
 jyAw==
X-Gm-Message-State: AC+VfDxORwYzpJgoJy/q6rkEwkEUWIe8hV4i+iWJ37TcSM8afAwpwAGh
 Lh96m+ZpLeQS8/maKxjEMwzakQ==
X-Google-Smtp-Source: ACHHUZ53ALZt8ITA9PYkpa+ddvkzqMUvuxLGadsY4TgcTyLDpTXlK3mlv8nuCJzmyUKUbpLaMhQxSw==
X-Received: by 2002:a1c:7716:0:b0:3f6:f56:5e82 with SMTP id
 t22-20020a1c7716000000b003f60f565e82mr717086wmi.3.1684854594086; 
 Tue, 23 May 2023 08:09:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d?
 ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003f42d8dd7ffsm11930110wmi.19.2023.05.23.08.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:09:53 -0700 (PDT)
Message-ID: <457ea968-b2dd-1a9b-7eab-0b0ec825304d@tessares.net>
Date: Tue, 23 May 2023 17:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
 <CA+G9fYs4zoTUQUnkvncEpPWvfGD6sDSXi94KXji+udMrvfm5Rg@mail.gmail.com>
In-Reply-To: <CA+G9fYs4zoTUQUnkvncEpPWvfGD6sDSXi94KXji+udMrvfm5Rg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 May 2023 10:27:44 +0200
Subject: Re: [LTP] [PATCH 6.1 000/292] 6.1.30-rc1 review
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
From: Matthieu Baerts via ltp <ltp@lists.linux.it>
Reply-To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: f.fainelli@gmail.com, rwarsow@gmx.de, pavel@denx.de, shuah@kernel.org,
 LTP List <ltp@lists.linux.it>, patches@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
 srw@sladewatkins.net, patches@kernelci.org,
 MPTCP Upstream <mptcp@lists.linux.dev>, akpm@linux-foundation.org,
 jonathanh@nvidia.com, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTmFyZXNoLAoKT24gMjMvMDUvMjAyMyAxNjo1MiwgTmFyZXNoIEthbWJvanUgd3JvdGU6Cj4g
T24gVHVlLCAyMyBNYXkgMjAyMyBhdCAwMDo1MywgR3JlZyBLcm9haC1IYXJ0bWFuCj4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPj4KPj4gVGhpcyBpcyB0aGUgc3RhcnQgb2Yg
dGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA2LjEuMzAgcmVsZWFzZS4KPj4gVGhlcmUg
YXJlIDI5MiBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBhbGwgd2lsbCBiZSBwb3N0ZWQgYXMgYSBy
ZXNwb25zZQo+PiB0byB0aGlzIG9uZS4gIElmIGFueW9uZSBoYXMgYW55IGlzc3VlcyB3aXRoIHRo
ZXNlIGJlaW5nIGFwcGxpZWQsIHBsZWFzZQo+PiBsZXQgbWUga25vdy4KPj4KPj4gUmVzcG9uc2Vz
IHNob3VsZCBiZSBtYWRlIGJ5IFdlZCwgMjQgTWF5IDIwMjMgMTk6MDM6MjUgKzAwMDAuCj4+IEFu
eXRoaW5nIHJlY2VpdmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4KPj4KPj4g
VGhlIHdob2xlIHBhdGNoIHNlcmllcyBjYW4gYmUgZm91bmQgaW4gb25lIHBhdGNoIGF0Ogo+PiAg
ICAgICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L3N0YWJs
ZS1yZXZpZXcvcGF0Y2gtNi4xLjMwLXJjMS5nego+PiBvciBpbiB0aGUgZ2l0IHRyZWUgYW5kIGJy
YW5jaCBhdDoKPj4gICAgICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvc3RhYmxlL2xpbnV4LXN0YWJsZS1yYy5naXQgbGludXgtNi4xLnkKPj4gYW5kIHRo
ZSBkaWZmc3RhdCBjYW4gYmUgZm91bmQgYmVsb3cuCj4+Cj4+IHRoYW5rcywKPj4KPj4gZ3JlZyBr
LWgKPiAKPiAKPiBSZXN1bHRzIGZyb20gTGluYXJv4oCZcyB0ZXN0IGZhcm0uCj4gTm8gcmVncmVz
c2lvbnMgb24gYXJtNjQsIGFybSwgeDg2XzY0LCBhbmQgaTM4Ni4KPiAKPiBUZXN0ZWQtYnk6IExp
bnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KCiguLi4pCgo+
IHNlbGZ0ZXN0czogbmV0L21wdGNwOiBkaWFnLnNoIHN0YXJ0ZWQgZmFpbGluZyBvbiA2LjEuMzAt
cmMxIGJ1dAo+IHBhc3NlZCBvbiA2LjMuNC1yYzEuIFRoaXMgaXMgZHVlIHRvIGNoYW5nZXMgaW4g
bGF0ZXN0IGtzZWxmdGVzdAo+ICg2LjMpIHJ1bm5pbmcgb24gNi4xLgo+IAo+IHRlc3QgbG9nczoK
PiA9PT09PT09Cj4gIyBzZWxmdGVzdHM6IG5ldC9tcHRjcDogZGlhZy5zaAo+ICMgbm8gbXNrIG9u
IG5ldG5zIGNyZWF0aW9uICAgICAgICAgICAgICAgICAgICAgICAgICBbICBvayAgXQo+ICMgbGlz
dGVuIG1hdGNoIGZvciBkcG9ydCAxMDAwMCAgICAgICAgICAgICAgICAgICAgICBbICBvayAgXQo+
ICMgbGlzdGVuIG1hdGNoIGZvciBzcG9ydCAxMDAwMCAgICAgICAgICAgICAgICAgICAgICBbICBv
ayAgXQo+ICMgbGlzdGVuIG1hdGNoIGZvciBzYWRkciBhbmQgc3BvcnQgICAgICAgICAgICAgICAg
ICBbICBvayAgXQo+ICMgYWxsIGxpc3RlbiBzb2NrZXRzICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBbICBvayAgXQo+ICMgYWZ0ZXIgTVBDIGhhbmRzaGFrZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbICBvayAgXQo+ICMgLi4uLmNoayByZW1vdGVfa2V5ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbICBvayAgXQo+ICMgLi4uLmNoayBubyBmYWxsYmFjayAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbICBvayAgXQo+ICMgLi4uLmNoayAyIG1zayBpbiB1
c2UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbIGZhaWwgXSBleHBlY3RlZCAyIGZvdW5k
IDAKPiAjIC4uLi5jaGsgMCBtc2sgaW4gdXNlIGFmdGVyIGZsdXNoICAgICAgICAgICAgICAgICAg
WyAgb2sgIF0KPiAjIGNoZWNrIGZhbGxiYWNrICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWyAgb2sgIF0KPiAjIC4uLi5jaGsgMSBtc2sgaW4gdXNlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgWyBmYWlsIF0gZXhwZWN0ZWQgMSBmb3VuZCAwCj4gIyAuLi4uY2hrIDAgbXNr
IGluIHVzZSBhZnRlciBmbHVzaCAgICAgICAgICAgICAgICAgIFsgIG9rICBdCj4gIyBtYW55IG1z
ayBzb2NrZXQgcHJlc2VudCAgICAgICAgICAgICAgICAgICAgICAgICAgIFsgIG9rICBdCj4gIyAu
Li4uY2hrIG1hbnkgbXNrIGluIHVzZSAgICAgICAgICAgICAgICAgICAgICAgICAgIFsgZmFpbCBd
IGV4cGVjdGVkCj4gMjU0IGZvdW5kIDAKPiAjIC4uLi5jaGsgMCBtc2sgaW4gdXNlIGFmdGVyIGZs
dXNoICAgICAgICAgICAgICAgICAgWyAgb2sgIF0KPiBub3Qgb2sgNCBzZWxmdGVzdHM6IG5ldC9t
cHRjcDogZGlhZy5zaCAjIGV4aXQ9MTEKPiAKPiBsb2dzOgo+ICAtIGh0dHBzOi8vcWEtcmVwb3J0
cy5saW5hcm8ub3JnL2xrZnQvbGludXgtc3RhYmxlLXJjLWxpbnV4LTYuMS55L2J1aWxkL3Y2LjEu
MjktMjkzLWdlMDBhM2Q5NmY3NTYvdGVzdHJ1bi8xNzE2Mzk3Ny9zdWl0ZS9rc2VsZnRlc3QtbmV0
LW1wdGNwL3Rlc3QvbmV0X21wdGNwX2RpYWdfc2gvaGlzdG9yeS8KPiAgLSBodHRwczovL3FhLXJl
cG9ydHMubGluYXJvLm9yZy9sa2Z0L2xpbnV4LXN0YWJsZS1yYy1saW51eC02LjEueS9idWlsZC92
Ni4xLjI5LTI5My1nZTAwYTNkOTZmNzU2L3Rlc3RydW4vMTcxNjM5Nzcvc3VpdGUva3NlbGZ0ZXN0
LW5ldC1tcHRjcC90ZXN0L25ldF9tcHRjcF9kaWFnX3NoL2RldGFpbHMvCgpUaGFuayB5b3UgZm9y
IGxvb2tpbmcgYXQgdGhlc2UgTVBUQ1Agc2VsZnRlc3RzIGFuZCBmb3IgaGF2aW5nIHJlcG9ydGVk
CnRoZXNlIGlzc3Vlcy4KCldlIGFyZSBsb29raW5nIGF0IGhhdmluZyBNUFRDUCBzZWxmdGVzdHMg
c3VwcG9ydGluZyBwcmV2aW91cyBrZXJuZWwKdmVyc2lvbnMgYnV0IHRoYXQncyBub3QgZWFzeSBi
ZWNhdXNlIG91ciBzZWxmdGVzdHMgYXJlIHZlcmlmeWluZyBzb21lCmludGVybmFsIGJlaGF2aW91
cnMsIG5vdCBqdXN0IHdoYXQgaXMgZXhwb3NlZCB0byB0aGUgdUFQSSwgZS5nLiB3aGF0Cm5ldHdv
cmsgcGFja2V0cyBhcmUgYmVpbmcgc2VudCwgZXRjLi4gQWxzbywgc29tZSBzb2NrZXQgb3B0aW9u
cyBhbmQKY291bnRlcnMgLS0gbGlrZSB3aGF0IHlvdSByZXBvcnRlZCBoZXJlIGFib3ZlIHdpdGgg
ZGlhZy5zaCAtLSB3ZXJlCnJldHVybmluZyAwIGJlZm9yZSBiZWluZyBpbXBsZW1lbnRlZCBpbiBN
UFRDUDogc28gd2UgbmVlZCB0byBhY2NlcHQgdGhhdAp0aGVzZSBjb3VudGVycyBtaWdodCBub3Qg
d29yaywgdGhhdCdzIG5vdCBpZGVhbCBmb3IgYSB0ZXN0IHRoYXQgd2FudHMgdG8KY2hlY2sgaWYg
dGhleSB3b3JrIDopCgpBbnl3YXksIGZvciB0aG9zZSB3aG8gd2FudHMgdG8gZm9sbG93IHRoZSBl
dm9sdXRpb24sIHBhdGNoZXMgaGF2ZSBiZWVuCnNoYXJlZCBvbiBvdXIgbWFpbGluZyBsaXN0OgoK
ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbXB0Y3AvbGlzdC8/c2VyaWVz
PTc0OTg2OCZzdGF0ZT0qCiAgaHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3Bf
bmV0LW5leHQvY29tbWl0cy83MjIwYzRjMjJiODgKICBodHRwczovL2dpdGh1Yi5jb20vbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dC9pc3N1ZXMvMzY4CgpDaGVlcnMsCk1hdHQKLS0gClRlc3Nh
cmVzIHwgQmVsZ2l1bSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25zCnd3dy50ZXNzYXJlcy5uZXQK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
