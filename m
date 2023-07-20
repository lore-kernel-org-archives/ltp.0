Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88974EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:18:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C22FD3CDC8A
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:18:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93C3A3C0123
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:18:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9C9161400F92
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:18:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D5A922BCD;
 Thu, 20 Jul 2023 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689866288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIduKu+3lB4Wg+Yueg4COzNrAG3bS/krxBhjfDOvL1M=;
 b=oCkHKd0ca4J6bWgdkKas43JlKD+CpFlVPQlZkJg4X1w/xL1cqOd3MNfWl45iaNzFXlaPnj
 QchUqVqSj9v96vaJtzJAaa2tiHW/kpg3Ln8nbvwhyx1BhiZ0epqlHIjo6qi8kBjjfephS0
 A3zXsTnUclH/mTdvg848bzmw/ucJLR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689866288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIduKu+3lB4Wg+Yueg4COzNrAG3bS/krxBhjfDOvL1M=;
 b=s7rgYuCjE1nNpqL9Kto2PJC+xOVHE2yZd3knPDQWOpCs15MdikjKSn9TMO4o3upZoZ37ku
 EPv5XdTluOR1ZYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D039133DD;
 Thu, 20 Jul 2023 15:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r9+SGTBQuWQiEgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Jul 2023 15:18:08 +0000
Message-ID: <adf7fc1d-b43e-fecb-4cbf-7663985a404e@suse.cz>
Date: Thu, 20 Jul 2023 17:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230720150206.1338520-1-pvorel@suse.cz>
 <20230720150206.1338520-3-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230720150206.1338520-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .skip_in_secureboot flag
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

SGksClJldmlld2VkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+CgpPbiAyMC4g
MDcuIDIzIDE3OjAyLCBQZXRyIFZvcmVsIHdyb3RlOgo+IFRoaXMgd2lsbCBiZSB1c2VkIGluIG1v
ZHVsZSByZWxhdGVkIHRlc3RzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6Pgo+IC0tLQo+ICAgZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCB8IDEg
Kwo+ICAgaW5jbHVkZS90c3RfdGVzdC5oICAgICAgICAgICAgICB8IDQgKysrKwo+ICAgbGliL3Rz
dF90ZXN0LmMgICAgICAgICAgICAgICAgICB8IDMgKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGlu
ZXMudHh0IGIvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dAo+IGluZGV4IGI4M2E2ZmRi
Ni4uNmQxYTY5MTY1IDEwMDY0NAo+IC0tLSBhL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50
eHQKPiArKysgYi9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0Cj4gQEAgLTM5Myw2ICsz
OTMsNyBAQCBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL1No
ZWxsLVRlc3QtQVBJW1NoZWxsIFRlc3QgQVBJXS4KPiAgIHwgJy5za2lwX2ZpbGVzeXN0ZW1zJyB8
ICdUU1RfU0tJUF9GSUxFU1lTVEVNUycKPiAgIHwgJy5za2lwX2luX2NvbXBhdCcgfCDigJMKPiAg
IHwgJy5za2lwX2luX2xvY2tkb3duJyB8IOKAkwo+ICt8ICcuc2tpcF9pbl9zZWN1cmVib290JyB8
IOKAkwo+ICAgfCAnLnN1cHBvcnRlZF9hcmNocycgfCBub3QgYXBwbGljYWJsZQo+ICAgfCAnLnRh
Z3MnIHwg4oCTCj4gICB8ICcudGFpbnRfY2hlY2snIHwg4oCTCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdHN0X3Rlc3QuaCBiL2luY2x1ZGUvdHN0X3Rlc3QuaAo+IGluZGV4IDIyYWNmYmE1OS4uMGFj
NDkyYTgwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3Rlc3QuaAo+ICsrKyBiL2luY2x1ZGUv
dHN0X3Rlc3QuaAo+IEBAIC0xNzcsNiArMTc3LDcgQEAgc3RydWN0IHRzdF90ZXN0IHsKPiAgIAlp
bnQgY2hpbGRfbmVlZHNfcmVpbml0OjE7Cj4gICAJaW50IG5lZWRzX2RldmZzOjE7Cj4gICAJaW50
IHJlc3RvcmVfd2FsbGNsb2NrOjE7Cj4gKwo+ICAgCS8qCj4gICAJICogSWYgc2V0IHRoZSB0ZXN0
IGZ1bmN0aW9uIHdpbGwgYmUgZXhlY3V0ZWQgZm9yIGFsbCBhdmFpbGFibGUKPiAgIAkgKiBmaWxl
c3lzdGVtcyBhbmQgdGhlIGN1cnJlbnQgZmlsZXN5c3RlbSB0eXBlIHdvdWxkIGJlIHNldCBpbiB0
aGUKPiBAQCAtMTg2LDggKzE4NywxMSBAQCBzdHJ1Y3QgdHN0X3Rlc3Qgewo+ICAgCSAqIHRvIHRo
ZSB0ZXN0IGZ1bmN0aW9uLgo+ICAgCSAqLwo+ICAgCWludCBhbGxfZmlsZXN5c3RlbXM6MTsKPiAr
Cj4gICAJaW50IHNraXBfaW5fbG9ja2Rvd246MTsKPiArCWludCBza2lwX2luX3NlY3VyZWJvb3Q6
MTsKPiAgIAlpbnQgc2tpcF9pbl9jb21wYXQ6MTsKPiArCj4gICAJLyoKPiAgIAkgKiBJZiBzZXQs
IHRoZSBodWdldGxiZnMgd2lsbCBiZSBtb3VudGVkIGF0IC5tbnRwb2ludC4KPiAgIAkgKi8KPiBk
aWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+IGluZGV4IDA0ZGE0
NTZjNi4uOGY3MjIzYjBlIDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gKysrIGIvbGli
L3RzdF90ZXN0LmMKPiBAQCAtMTE2MCw2ICsxMTYwLDkgQEAgc3RhdGljIHZvaWQgZG9fc2V0dXAo
aW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPiAgIAlpZiAodHN0X3Rlc3QtPnNraXBfaW5fbG9ja2Rv
d24gJiYgdHN0X2xvY2tkb3duX2VuYWJsZWQoKSkKPiAgIAkJdHN0X2JyayhUQ09ORiwgIktlcm5l
bCBpcyBsb2NrZWQgZG93biwgc2tpcHBpbmcgdGVzdCIpOwo+ICAgCj4gKwlpZiAodHN0X3Rlc3Qt
PnNraXBfaW5fc2VjdXJlYm9vdCAmJiB0c3Rfc2VjdXJlYm9vdF9lbmFibGVkKCkpCj4gKwkJdHN0
X2JyayhUQ09ORiwgIlNlY3VyZUJvb3QgZW5hYmxlZCwgc2tpcHBpbmcgdGVzdCIpOwo+ICsKPiAg
IAlpZiAodHN0X3Rlc3QtPnNraXBfaW5fY29tcGF0ICYmIFRTVF9BQkkgIT0gdHN0X2tlcm5lbF9i
aXRzKCkpCj4gICAJCXRzdF9icmsoVENPTkYsICJOb3Qgc3VwcG9ydGVkIGluIDMyLWJpdCBjb21w
YXQgbW9kZSIpOwo+ICAgCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpTVyBR
dWFsaXR5IEVuZ2luZWVyClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0
OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
