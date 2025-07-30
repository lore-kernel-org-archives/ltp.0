Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB84C87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 11:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDD603CB00C
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 13:44:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD35F3C3270
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:43:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D8901A00918
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:43:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57AB61F45A;
 Wed, 30 Jul 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 426FF13942;
 Wed, 30 Jul 2025 11:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LBKpD3MFimhxFwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 30 Jul 2025 11:43:47 +0000
Message-ID: <ee700257-7066-48de-943e-d86000a6e83c@suse.cz>
Date: Wed, 30 Jul 2025 13:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20250710082000.11641-1-akumar@suse.de>
 <svs6pl6jmibp7uylvofkia5smvu2cuezfvnawlgkmjiulbrpfm@w7s7dlxxltap>
 <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com> <9489066.CDJkKcVGEf@thinkpad>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <9489066.CDJkKcVGEf@thinkpad>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 57AB61F45A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMzAuIDA3LiAyNSAxMzozMiwgQXZpbmVzaCBLdW1hciB3cm90ZToKPiBIaSBhbGzCuAo+IAo+
IEkgd291bGQgbGlrZSB0byBhc2sgaWYgdGhlcmUgYXJlIGFueSBvdGhlciBzdWdnZXN0aW9ucyBv
biBob3cgdG8gYWRkcmVzcyB0aGlzCj4gaXNzdWUuCj4gSSB0cmllZCBhIHJhdGhlciBzaW1wbGVy
IGFwcHJvYWNoIChhcyBzdWdnZXN0ZWQgYnkgTWFydGluKSBvZiBqdXN0IGFkZGluZyBhCj4gZGVs
YXkgdXNpbmcgc2xlZXAgYWZ0ZXIgdGhlIHVtb3VudCBjYWxsLCB3aGljaCBhbHNvIHNlZW1zIHRv
IHNvbHZlIHRoaXMgaXNzdWUKPiBvZiBpbmNvbXBsZXRlIHVubW91bnRpbmcuCj4gCj4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXAvY2dyb3VwX3JlZ3Jlc3Npb25fdGVz
dC5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwL2Nncm91cF9y
ZWdyZXNzaW9uX3Rlc3Quc2gKPiBAQCAtMTAyLDEwICsxMDIsMTEgQEAgdGVzdDEoKQo+ICAgICAg
ICAgIGNhdCBjZ3JvdXAvdGFza3MgPiAvZGV2L251bGwKPiAgIAo+ICAgICAgICAgIGtpbGwgLVRF
Uk0gJCEKPiAgICAgICAgICB3YWl0ICQhIDI+L2Rldi9udWxsCj4gICAgICAgICAgdW1vdW50IGNn
cm91cC8KPiArICAgICAgIHNsZWVwIDIKPiAgICAgICAgICBjaGVja19rZXJuZWxfYnVnCj4gICB9
Cj4gCj4gSSB3aWxsIHNlbmQgdGhpcyBpbiB0aGUgcGF0Y2ggaWYgd2UgYWdyZWUgdG8gdXNlIHRo
aXMgYXBwcm9hY2ggaW5zdGVhZCBvZgo+IHVuaXF1ZSBuYW1lcy4KCldlbGwsIHRoaXMgbG9va3Mg
bGlrZSB0aGUgdW5tb3VudCBoYXBwZW5zIGFzeW5jaHJvbm91c2x5IGFuZCB0aGUgY29tbWFuZCAK
ZXhpdHMgYmVmb3JlIGl0J3MgYWN0dWFsbHkgZmluaXNoZWQuIEluIHRoYXQgY2FzZSwgc3luYyB3
b3VsZCBiZSB0aGUgCmJlc3Qgc29sdXRpb24uIEJ1dCBJIHRoaW5rIHdlIG5lZWQgc29tZSBmZWVk
YmFjayBmcm9tIGtlcm5lbCBkZXZlbG9wZXJzIAp3aGV0aGVyIHRoZSBhc3luY2hyb25vdXMgYmVo
YXZpb3IgaXMgaW50ZW50aW9uYWwgb3Igbm90LiBTaG91bGQgdGhlIAp1bW91bnQgY29tbWFuZCB3
YWl0IGZvciB0aGUgdGFzayB0byBmaW5pc2g/CgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFA
c3VzZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEK
S3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
