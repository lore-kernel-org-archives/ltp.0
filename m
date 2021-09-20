Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F19C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 19:35:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7776961107
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 19:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7776961107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F793C8F90
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 21:34:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E00BA3C1B0A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 21:34:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D882914010EE
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 21:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1632166488;
 bh=hG1lHvpLT+jJ1CXWJznFP4IlBwrEh/E7rLfPl5kY8pQ=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=Bxe15/w0EL8MoAJX8qPQTPqveSdfXLkTCChPVSNBtFHZmbOOa5I2Clp8Dz8uHFxFF
 xJskE4sTFIj3cSrLkqhKUb4GRTRSrfCdbEllFBGg6qOc27CWo6ZEnetDkJTU/9E0/o
 5aFIRxaaVRSCINI9ocbuKOWPP1FZJpixtqDAaXxA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.13.82]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wrF-1mmIWc3KNF-00xoUv for
 <ltp@lists.linux.it>; Mon, 20 Sep 2021 21:34:47 +0200
Message-ID: <e417824f-e49f-561c-84bb-769c507552a4@web.de>
Date: Mon, 20 Sep 2021 21:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
To: ltp@lists.linux.it
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
X-Provags-ID: V03:K1:BBgzyPO2rDpUXOTpSutc5tPy9T74CoNfhU+pJxshy0kDFAihoDl
 R7OaCCPuZMIwXkvi558Vm2O/Pa/qoN9kTooZNJJbNkDK94uUnvoISfMfHtNzfry4hH2/BZm
 xRauCKqOKrCcVp24UTyDH+lm/MBWBaxXZ7urXjKCGBrv5fLDs3cCv7XyV/rRS41NveUsDcd
 rNjSvCUYb7IXdQIg9ubJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:daRyxpY0wl4=:7vKBEE7gKoEi60KSD5Gr3X
 hrPAGI1ergmDJQvJ1FgQGrVpxW5Y4+JNSO4Bjm6QzQ7fZlaE1T3DFMWd0/sTNywrZQeBcVEo+
 zX0FXbRSGKtpM3bvLRWxzUmUL1iHmovwgM7whuPg0A9o9Ni04N8EEJ8Q9o89NFFw9MMIyerH1
 7K0zPYk5envz3Nk0q9CxGCNSun3oTGVfyxxKe4BQcb58iplropSS8tkEDbGjwlpi2BPeQv5XF
 VSzGG+FcxvnsmmPMFC2JJfCk2gRBvfvm4jVRZIhozQKf1abGNK2cESyST7GZB5vv7GvKwTKGE
 j3sDYpYUhPs8uy3optgxr8xEpIX3e+D/CfaLbfyXB1h8hIlxq6sSLlnl/0yDF3nIQFTBzgEM0
 3HLEOSv63o7GHWRtwGGji7JDDYWp2aLPGbGVmgWP54GhENIBWjUWhgFPouEp8kds5k4c+MvjY
 YRgpYAXOk4W0uKzutL1CmCFww10OzHd1NZ1iBYPLf3z/hUhi1gr5Coiv8DDoNv2kvl77+rJyg
 9a4C2Lm+qH3jRo6IJGy+8jtYku9sEbyC983eG7zNmMDUJTH0rOkvvZdMVfzHHEz90yc+jYzts
 HvvJh4+gxsDYVwhxKH9rTLL9Y74GnUwvQuG2CS4piGaaQOcAgdu5L4Q1pUlEXsGorY6njwhmn
 r7Vvh87FyUDAwsz26S9JP1m2+3dx7nvNXnOdfl9l4hVFylrBLuYOFD/bIJUs5R1OT86DFpa24
 VzAz/LKCCtTQPARFmx9V9kUe/vNJ3TGC858+Sy+1HaLLrCWryv1ebwaAH7XVOi24CMcxByhrn
 7s8BcrK/EvFlQkGMrNkWikMrPhWwTSX74NWL3UQXjlsXU6r7zG/P/U7218VyVpZWO1xRsZySr
 knKo8qZcZsVA/XbJ9L+A0HBfF7mbpml3rucUytvxZG7Zj8LkazR9lUbh/QPUMzSGaARiSunD6
 R4y3rruVsIYzjdhjvHtFgpNCRA2w+CyrzGvZsK6wOX953Nqap4APmoj4Heq9lumNq8Q6DGJ9k
 S0KyhisehLkatmEhe4q8VeuSNtnO8iPUAGWovp5L134qNbJneJdqhUzioJ4VXmDw9r4cKJtBU
 ynEPPF46mj8EZk=
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Checking special execution durations for the determination of
 mountable file systems
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpJIGNhbWUgYWxvbmcgdGhlIG5lZWQgdG8gY2hlY2sgdW5leHBlY3RlZCBzb2Z0d2Fy
ZSBleGVjdXRpb24gZHVyYXRpb25zCmF0IGFub3RoZXIgcGxhY2UuCgoqIFF0CiAgIGh0dHBzOi8v
ZG9jLnF0LmlvL3F0LTUvcXN0b3JhZ2VpbmZvLmh0bWwjbW91bnRlZFZvbHVtZXMKCiogS1BNY29y
ZQogICBodHRwczovL2dpdGh1Yi5jb20vS0RFL2twbWNvcmUvYmxvYi9jZTM5ZTE0OTA0MGJjZTk3
ODJiOTFlNTMyZDA0MWNhMGM3NTQ4YTc3L3NyYy9mcy9maWxlc3lzdGVtLmNwcCNMMTQ1CgpFeGFt
cGxlOgpbTWFya3VzX0VsZnJpbmdAZmVkb3JhIG1vdW50ZWRWb2x1bWVzXSQgdGltZSAuL21vdW50
ZWRWb2x1bWVzCk51bWJlciBvZiBldmVudHVhbGx5IG1vdW50ZWQgZmlsZXN5c3RlbXM6IDQzCgpy
ZWFsICAgIDNtMyw1NjFzCnVzZXIgICAgMG0wLDAxNnMKc3lzICAgIDBtMCwwMjZzCgoKSSBpbmNy
ZWFzZWQgc29mdHdhcmUgYW5hbHlzaXMgZWZmb3J0cyBhY2NvcmRpbmdseS4KaHR0cHM6Ly9naXRo
dWIuY29tL25hbWh5dW5nL3VmdHJhY2UvCgpbTWFya3VzX0VsZnJpbmdAZmVkb3JhIG1vdW50ZWRW
b2x1bWVzXSQgdGltZSBzdWRvIHVmdHJhY2UgcmVjb3JkIC0tZGF0YT0vaG9tZS9NYXJrdXNfRWxm
cmluZy9UZXN0L21vdW50ZWRWb2x1bWVzL1Byb2JlLXVmdHJhY2UvIC0tbmVzdC1saWJjYWxsIC0t
a2VybmVsIC0tbnVtLXRocmVhZD00IC4vbW91bnRlZFZvbHVtZXMKTnVtYmVyIG9mIGV2ZW50dWFs
bHkgbW91bnRlZCBmaWxlc3lzdGVtczogNDIKCnJlYWwgICAgM200LDgzNXMKdXNlciAgICAwbTAs
MzQ2cwpzeXMgICAgMG0zLDU0OXMKCgpbTWFya3VzX0VsZnJpbmdAZmVkb3JhIH5dJCB1ZnRyYWNl
IC0tZGF0YT1UZXN0L21vdW50ZWRWb2x1bWVzL1Byb2JlLXVmdHJhY2UgcmVwb3J0IC0tZmlsdGVy
PVFTdG9yYWdlSW5mbzo6bW91bnRlZFZvbHVtZXMKICAgVG90YWwgdGltZSAgIFNlbGYgdGltZSAg
ICAgICBDYWxscyAgRnVuY3Rpb24KICAgPT09PT09PT09PSAgPT09PT09PT09PSAgPT09PT09PT09
PSAgPT09PT09PT09PT09PT09PT09PT0KICAgICAzLjAwMCAgbSAgNDc4LjQwMyB1cyAgICAgICAg
ICAgMSAgUVN0b3JhZ2VJbmZvOjptb3VudGVkVm9sdW1lcwogICAgIDMuMDAwICBtICAgMzguMjYx
IHVzICAgICAgICAgIDkwICBRU3RvcmFnZUluZm86OlFTdG9yYWdlSW5mbwogICAgIDMuMDAwICBt
ICAgMTAuMjQ0IG1zICAgICAgICAgIDQ4ICBRU3RvcmFnZUluZm86OnNldFBhdGgKICAgICAzLjAw
MCAgbSAgICAzLjAwMCAgbSAgICAgICAgICAyMyAgbGludXg6c2NoZWR1bGUKICAgICAzLjAwMCAg
bSAgICAxLjAzMCAgbSAgICAgICAgICA0OCAgc3RhdHZmczY0CiAgICAgMS4wMzAgIG0gICAgMS4z
MTUgbXMgICAgICAgICAgNDcgIF9feDY0X3N5c19zdGF0ZnMKICAgIDQ1Ljg4NyBtcyAgICA1Ljc0
NiBtcyAgICAgICAgIDk0NCAgUURpckl0ZXJhdG9yOjpuZXh0CiAgICAyOC43NjggbXMgICAgMy42
OTEgbXMgICAgICAgICA5NDQgIFFGaWxlSW5mbzo6c3ltTGlua1RhcmdldAogICAgMTkuNDIxIG1z
ICAgIDEuMjQ2IG1zICAgICAgICAzMTg1ICBmZ2V0cwogICAgMTguODQ1IG1zICA2NTkuMzIzIHVz
ICAgICAgICAxOTAwICBRRmlsZUluZm86OmlzRmlsZQogICAgMTguMDM1IG1zICAgIDEuMjA3IG1z
ICAgICAgICAgOTUwICBzdGF0eArigKYKCgpBbm90aGVyIGJpdCBvZiBiYWNrZ3JvdW5kIGluZm9y
bWF0aW9uOgpUaGUgZnVuY3Rpb24g4oCcc3RhdHZmczY04oCdIGdldHMgY2FsbGVkIGJ5IHRoZSBm
dW5jdGlvbiDigJxRU3RvcmFnZUluZm9Qcml2YXRlOjpyZXRyaWV2ZVZvbHVtZUluZm/igJ0KKHdo
aWNoIGlzIGNhbGxlZCBieSB0aGUgZnVuY3Rpb24g4oCcUVN0b3JhZ2VJbmZvUHJpdmF0ZTo6ZG9T
dGF04oCdIGFuZCBzbyBvbikuCmh0dHBzOi8vZ2l0aHViLmNvbS9ibWlub3IvZ2xpYmMvYmxvYi81
OTVjMjJlY2Q4ZTg3YTI3ZmQxOTI3MGVkMzBmZGJhZTlhZDI1NDI2L3N5c2RlcHMvdW5peC9zeXN2
L2xpbnV4L3N0YXR2ZnM2NC5jI0wyNwpodHRwczovL2NvZGUud29ib3Eub3JnL3F0NS9xdGJhc2Uv
c3JjL2NvcmVsaWIvaW8vcXN0b3JhZ2VpbmZvX3VuaXguY3BwLmh0bWwjX1pOMTlRU3RvcmFnZUlu
Zm9Qcml2YXRlMThyZXRyaWV2ZVZvbHVtZUluZm9FdgpodHRwczovL2NvZGUud29ib3Eub3JnL3F0
NS9xdGJhc2Uvc3JjL2NvcmVsaWIvaW8vcXN0b3JhZ2VpbmZvX3VuaXguY3BwLmh0bWwjX1pOMTlR
U3RvcmFnZUluZm9Qcml2YXRlMTRtb3VudGVkVm9sdW1lc0V2CgoKV291bGQgeW91IGxpa2UgdG8g
aGVscCB3aXRoIHRoZSBjbGFyaWZpY2F0aW9uIGZvciB0aGUgc2hvd24gbWVhc3VyZW1lbnRzPwoK
UmVnYXJkcywKTWFya3VzCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
