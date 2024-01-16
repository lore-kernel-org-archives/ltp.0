Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353D7C4706C
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 12:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7C33CE322
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 13:38:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418363C05D8
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 13:38:33 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5769560239B
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 13:38:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A60321FDF;
 Tue, 16 Jan 2024 12:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705408710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cu7DfvZ7oC4RC8VCh2dRAgyqYWbPbi12VRvL8FGxFLU=;
 b=OnkS6MtfFnrLU+kWTmKwPlxB22Kd5K1mInnkKsGdaRz0OTdgi/TIN/jNo9BpnvJIkiPtkF
 mfiRjNP8E5IlR3axcnEPYhEilOTRcc1phXUlYOYKqFfShDFUG0xWNR+aWrB80NDgo76y0a
 6s0HLBFFZWe7Q/4qumPlr8S5Coan5mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705408710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cu7DfvZ7oC4RC8VCh2dRAgyqYWbPbi12VRvL8FGxFLU=;
 b=IxQvM3ZAIc3+3JwL4joMeN7nzN0jSXQnnwFCzlDdSBjMc/h7HIJ/v0i9uHjskHTsG2Zt6I
 AUFRLyajbh5va3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705408710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cu7DfvZ7oC4RC8VCh2dRAgyqYWbPbi12VRvL8FGxFLU=;
 b=OnkS6MtfFnrLU+kWTmKwPlxB22Kd5K1mInnkKsGdaRz0OTdgi/TIN/jNo9BpnvJIkiPtkF
 mfiRjNP8E5IlR3axcnEPYhEilOTRcc1phXUlYOYKqFfShDFUG0xWNR+aWrB80NDgo76y0a
 6s0HLBFFZWe7Q/4qumPlr8S5Coan5mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705408710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cu7DfvZ7oC4RC8VCh2dRAgyqYWbPbi12VRvL8FGxFLU=;
 b=IxQvM3ZAIc3+3JwL4joMeN7nzN0jSXQnnwFCzlDdSBjMc/h7HIJ/v0i9uHjskHTsG2Zt6I
 AUFRLyajbh5va3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF57813777;
 Tue, 16 Jan 2024 12:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E/UmNcV4pmWcTgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 16 Jan 2024 12:38:29 +0000
Message-ID: <00ba5590-fe40-485a-9b3f-6e0950747208@suse.cz>
Date: Tue, 16 Jan 2024 13:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20240116031728.2500892-1-liwang@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240116031728.2500892-1-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OnkS6Mtf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IxQvM3ZA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-0.00)[18.14%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 0A60321FDF
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: jhs@mojatatu.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCnRoYW5rcyBmb3IgdGhlIGZpeC4gSSBhZ3JlZSB0aGF0IHRoaXMgZG9lc24ndCBuZWVkIHRv
IGdvIGludG8gTEFQSSAKaGVhZGVycyBzaW5jZSB3ZSBwcm9iYWJseSB3b24ndCBhZGQgYW5vdGhl
ciB0ZXN0IGZvciB0Y2luZGV4LgoKUmV2aWV3ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4KCk9uIDE2LiAwMS4gMjQgNDoxNywgTGkgV2FuZyB3cm90ZToKPiBUaGUgY2hhbmdl
IGFkZHJlc3NlcyBjb21waWxhdGlvbiBlcnJvcnMgZW5jb3VudGVyZWQgaW4gdGhlIHRjaW5kZXgw
MS5jCj4gdGVzdCB3aGVuIGNvbXBpbGVkIGFnYWluc3Qga2VybmVsLTYuNyBhbmQgYWJvdmUuCj4g
Cj4gICAgdGNpbmRleDAxLmM6Njc6NDogZXJyb3I6IOKAmFRDQV9UQ0lOREVYX01BU0vigJkgdW5k
ZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7Cj4gICAgICAgZGlkIHlvdSBtZWFuIOKA
mFRDQV9DT0RFTF9NQVjigJk/Cj4gICAgICAge1RDQV9UQ0lOREVYX01BU0ssICZtYXNrLCBzaXpl
b2YobWFzayksIE5VTEx9LAo+ICAgICAgICBefn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgIFRDQV9D
T0RFTF9NQVgKPiAgICB0Y2luZGV4MDEuYzo2ODo0OiBlcnJvcjog4oCYVENBX1RDSU5ERVhfU0hJ
RlTigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7Cj4gICAgICAgZGlkIHlv
dSBtZWFuIOKAmFRDQV9GTE9XX1JTSElGVOKAmT8KPiAgICAgICB7VENBX1RDSU5ERVhfU0hJRlQs
ICZzaGlmdCwgc2l6ZW9mKHNoaWZ0KSwgTlVMTH0sCj4gICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
Cj4gICAgICAgIFRDQV9GTE9XX1JTSElGVAo+ICAgIENDIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTYt
NzExNwo+ICAgIENDIHV0aWxzL3NjdHAvZnVuY190ZXN0cy90ZXN0X2dldG5hbWVfdjYubwo+ICAg
IHRjaW5kZXgwMS5jOjY5OjQ6IGVycm9yOiDigJhUQ0FfVENJTkRFWF9DTEFTU0lE4oCZIHVuZGVj
bGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pOwo+ICAgICAgIGRpZCB5b3UgbWVhbiDigJhU
Q0FfRkxPV0VSX0NMQVNTSUTigJk/Cj4gICAgICAge1RDQV9UQ0lOREVYX0NMQVNTSUQsICZjbHNp
ZCwgc2l6ZW9mKGNsc2lkKSwgTlVMTH0sCj4gICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4KPiAg
ICAgICAgVENBX0ZMT1dFUl9DTEFTU0lECj4gCj4gVGhlIGVycm9ycyB3ZXJlIGR1ZSB0byB0aGUg
cmVtb3ZhbCBvZiBjZXJ0YWluIFRDQV9UQ0lOREVYXyBjb25zdGFudHMKPiBmcm9tIHRoZSBrZXJu
ZWwncyB1c2VyIEFQSSAodWFwaSksIGFzIGluZGljYXRlZCBieSB0aGUga2VybmVsIGNvbW1pdC4K
PiAKPiAgICBjb21taXQgODJiMjU0NWVkOWEgKG5ldC9zY2hlZDogUmVtb3ZlIHVhcGkgc3VwcG9y
dCBmb3IgdGNpbmRleCBjbGFzc2lmaWVyKQo+IAo+IFRoZSByZWFzb24gd2h5IEkgZGlkbid0IGFk
ZCB0aGlzIGludG8gTFRQIGxpYnJhcnkgaXMgdGhhdCB0aGUgZGVmaW5lcwo+IGhhdmUgYmVlbiBk
cm9wcGVkIHdlIGp1c3QgbmVlZCB0byBzYXRpc2Z5IHRoaXMgb25lIGNhc2UuCj4gLS0tCj4gCj4g
Tm90ZXM6Cj4gICAgICBXZSBuZWVkIHRvIG1lcmdlIHRoaXMgcGF0Y2ggYmVmb3JlIHRoZSBuZXcg
cmVsZWFzZS4KPiAKPiAgIHRlc3RjYXNlcy9jdmUvdGNpbmRleDAxLmMgfCAxNyArKysrKysrKysr
KysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2N2ZS90Y2luZGV4MDEuYyBiL3Rlc3RjYXNlcy9jdmUvdGNpbmRleDAx
LmMKPiBpbmRleCBiNGYyYmIwMWEuLjcwZTU2MzlmMSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMv
Y3ZlL3RjaW5kZXgwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2N2ZS90Y2luZGV4MDEuYwo+IEBAIC0z
Miw2ICszMiwyMyBAQAo+ICAgCj4gICAjZGVmaW5lIERFVk5BTUUgImx0cF9kdW1teTEiCj4gICAK
PiArI2lmbmRlZiBUQ0FfVENJTkRFWF9NQVgKPiArZW51bSB7Cj4gKyAgICAgICBUQ0FfVENJTkRF
WF9VTlNQRUMsCj4gKyAgICAgICBUQ0FfVENJTkRFWF9IQVNILAo+ICsgICAgICAgVENBX1RDSU5E
RVhfTUFTSywKPiArICAgICAgIFRDQV9UQ0lOREVYX1NISUZULAo+ICsgICAgICAgVENBX1RDSU5E
RVhfRkFMTF9USFJPVUdILAo+ICsgICAgICAgVENBX1RDSU5ERVhfQ0xBU1NJRCwKPiArICAgICAg
IFRDQV9UQ0lOREVYX1BPTElDRSwKPiArICAgICAgIFRDQV9UQ0lOREVYX0FDVCwKPiArICAgICAg
IF9fVENBX1RDSU5ERVhfTUFYCj4gK307Cj4gKwo+ICsjZGVmaW5lIFRDQV9UQ0lOREVYX01BWCAg
ICAgKF9fVENBX1RDSU5ERVhfTUFYIC0gMSkKPiArI2VuZGlmCj4gKwo+ICsKPiAgIHN0YXRpYyBj
b25zdCB1aW50MzJfdCBxZF9oYW5kbGUgPSBUQ19IX01BS0UoMSA8PCAxNiwgMCk7Cj4gICBzdGF0
aWMgY29uc3QgdWludDMyX3QgY2xzaWQgPSBUQ19IX01BS0UoMSA8PCAxNiwgMSk7Cj4gICBzdGF0
aWMgY29uc3QgdWludDMyX3Qgc2hpZnQgPSAxMDsKCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNo
YUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5lZXIKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJ
YQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
