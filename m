Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F069EB64D8
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 08:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 525E43CC16D
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 10:39:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192963C030D
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 10:38:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EAAEE600629
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 10:38:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66D9B2223D;
 Fri, 16 Jun 2023 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1686904726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzSYxqEZ+XBU81h4+jksDxxxJKsKyFcSCsPVUKON9Oc=;
 b=VEfJTKlQfh0QzMT61Bj89nbGVamYJWuCMU61F7agQ+MHszuptD3/gydOOHaJ3fcl7gyHSk
 ldHuy8WuMZe5Z/d7Y+EOlIIN+M0RhjN4zBzkmPf/v2BBautUD7ZSVTW+AAEvSBiUeZRhWb
 urSat3cMetHiIQVlOPSKZvxFEamLCU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1686904726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzSYxqEZ+XBU81h4+jksDxxxJKsKyFcSCsPVUKON9Oc=;
 b=FRsJKaknnth4oxX7DAve9LFDEa/0pPw8r1RTpJ9a48FswBFXORVskj5SxOxf8RVpjnYl/Y
 zzkz5BUoujotwiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51386138E8;
 Fri, 16 Jun 2023 08:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QzTeEpYfjGRNMwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 16 Jun 2023 08:38:46 +0000
Message-ID: <2ee08acc-2b36-99ca-b891-0928a92ed4df@suse.cz>
Date: Fri, 16 Jun 2023 10:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Li Wang <liwang@redhat.com>, Murphy Zhou <jencce.kernel@gmail.com>
References: <20230615012445.4184243-1-jencce.kernel@gmail.com>
 <CAEemH2f2Rrco5fSMsmezY5sUJtM2vZpm619d5+v6Kjyhwcm1CQ@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2f2Rrco5fSMsmezY5sUJtM2vZpm619d5+v6Kjyhwcm1CQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info
 about the operation
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTYuIDA2LiAyMyA0OjUwLCBMaSBXYW5nIHdyb3RlOgo+IE9uIFRodSwgSnVuIDE1LCAyMDIz
IGF0IDk6MjTigK9BTSBNdXJwaHkgWmhvdSA8amVuY2NlLmtlcm5lbEBnbWFpbC5jb20+IHdyb3Rl
Ogo+IAo+PiBNYWtlIHRoZSBzb3VyY2UgYW5kIHRoZSB0YXJnZXQgdG8gbW91bnQvdW1vdW50IHZp
c2libGUuIEl0J3MKPj4gZ29vZCBmb3IgZGVidWdnaW5nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBN
dXJwaHkgWmhvdSA8amVuY2NlLmtlcm5lbEBnbWFpbC5jb20+Cj4+IC0tLQo+PiB2MzoKPj4gICAg
QXBwbHkgc3VnZ2VzdGlvbnMgZnJvbSBMaSBhbmQgTWFydGluLiBUaGFua3MgdmVyeSBtdWNoIQo+
Pgo+PiAgIGxpYi9zYWZlX21hY3Jvcy5jIHwgMTcgKysrKysrKysrKysrKysrKysKPj4gICAxIGZp
bGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvbGliL3NhZmVf
bWFjcm9zLmMgYi9saWIvc2FmZV9tYWNyb3MuYwo+PiBpbmRleCBhZjZkZDA3MTYuLjI2ZjkxMzZh
ZiAxMDA2NDQKPj4gLS0tIGEvbGliL3NhZmVfbWFjcm9zLmMKPj4gKysrIGIvbGliL3NhZmVfbWFj
cm9zLmMKPj4gQEAgLTg5OCw3ICs4OTgsMTYgQEAgaW50IHNhZmVfbW91bnQoY29uc3QgY2hhciAq
ZmlsZSwgY29uc3QgaW50IGxpbmVubywKPj4gdm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAo+PiAg
ICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSkKPj4gICB7Cj4+ICAgICAgICAgIGludCBy
dmFsID0gLTE7Cj4+ICsgICAgICAgY2hhciBtcGF0aFtQQVRIX01BWF07Cj4+Cj4+ICsgICAgICAg
aWYgKHJlYWxwYXRoKHRhcmdldCwgbXBhdGgpKSB7Cj4+ICsgICAgICAgICAgICAgICB0c3RfcmVz
bV8oZmlsZSwgbGluZW5vLCBUSU5GTywKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIk1vdW50
aW5nICVzIHRvICVzIGZzdHlwPSVzIGZsYWdzPSVseCIsCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHNvdXJjZSwgbXBhdGgsIGZpbGVzeXN0ZW10eXBlLCBtb3VudGZsYWdzKTsKPj4gKyAgICAg
ICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgdHN0X3Jlc21fKGZpbGUsIGxpbmVubywgVEJS
T0sgfCBURVJSTk8sIGNsZWFudXBfZm4sCj4+Cj4gCj4gRm9yZ2V0IHRvIG1lbnRpb24gdGhhdCwg
dGhpcyBzaG91bGQgYmUgdHN0X2Jya21fKC4uLCBUQlJPSyB8IFRFUlJOTywgLi4uKSwKPiBJIG1h
bnVhbGx5IGZpeCBpdCBhbmQgcHVzaGVkLgoKSSB0aG91Z2h0IG15IHJldmlldyBvZiB0aGUgdjIg
cGF0Y2ggd2FzIGNsZWFyIGVub3VnaCB0aGF0IGJvdGggYnJhbmNoZXMgCm9mIHRoaXMgY29uZGl0
aW9uIHNob3VsZCBjYWxsIHRzdF9yZXNtXyguLi4gVElORk8gLi4uKS4gVGhlcmUgaXMgbm8gCnJl
YXNvbiB0byBmYWlsIHRoZSB0ZXN0IGhlcmUuCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFA
c3VzZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEK
S3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
