Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E8C04FF8
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:19:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 099E93CFCF0
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 18:19:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24B863CF915
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 18:18:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B2EF6019B2
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 18:18:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2FDB33E74;
 Thu, 18 Apr 2024 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713457129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uawBcTxecti11L0KxuDAc9IA0MqASTejD5BS12O8WbA=;
 b=w+FLQWO9bCOnWySQWjj/glBYeqxK1GkFvk+GCc2/PDT/tShkXDP0HcdwfJzYDUN1EzfkY5
 QDzBZaf+Q1QoOTxUWKFTlFM2KoZ9m2/aKJDbhC504nUb0nS8iM/xvrxJJCGleoTCV/0P11
 neWuTaWpqmNXJXQqwmepTHgHc7yKjNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713457129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uawBcTxecti11L0KxuDAc9IA0MqASTejD5BS12O8WbA=;
 b=mA+kIoNzc7A47j5k7UrLqnWwZwT6uewoj5pHp+xCqcaqpk2jtdnv6PcDeCzYkHMbmfbZZR
 XsestkV4m3ZoCWAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w+FLQWO9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mA+kIoNz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713457129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uawBcTxecti11L0KxuDAc9IA0MqASTejD5BS12O8WbA=;
 b=w+FLQWO9bCOnWySQWjj/glBYeqxK1GkFvk+GCc2/PDT/tShkXDP0HcdwfJzYDUN1EzfkY5
 QDzBZaf+Q1QoOTxUWKFTlFM2KoZ9m2/aKJDbhC504nUb0nS8iM/xvrxJJCGleoTCV/0P11
 neWuTaWpqmNXJXQqwmepTHgHc7yKjNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713457129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uawBcTxecti11L0KxuDAc9IA0MqASTejD5BS12O8WbA=;
 b=mA+kIoNzc7A47j5k7UrLqnWwZwT6uewoj5pHp+xCqcaqpk2jtdnv6PcDeCzYkHMbmfbZZR
 XsestkV4m3ZoCWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 944D013687;
 Thu, 18 Apr 2024 16:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 791fI+lHIWaLSgAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 18 Apr 2024 16:18:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 18:18:49 +0200
Message-ID: <3476487.LZWGnKmheA@localhost>
Organization: SUSE
In-Reply-To: <20240416080414.22637-1-xuyang2018.jy@fujitsu.com>
References: <20240416080414.22637-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 HAS_ORG_HEADER(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A2FDB33E74
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] gethostname: Add negative test for gethostname
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWWFuZyBYdSwKUGxlYXNlIHNlZSBjb21tZW50cyBiZWxvdwoKT24gVHVlc2RheSwgQXByaWwg
MTYsIDIwMjQgMTA6MDQ6MTTigK9BTSBHTVQrMiBZYW5nIFh1IHZpYSBsdHAgd3JvdGU6Cj4gQWRk
IG5lZ2F0aXZlIGNhc2VzIGZvciBnZXRob3N0bmFtZSgpLCB3aGVuIGVycm5vIGlzIEVOQU1FVE9P
TE9ORwo+IAo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5j
b20+Cj4gLS0tCj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAxICsKPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9nZXRob3N0bmFtZS8uZ2l0aWdub3JlICAg
IHwgIDEgKwo+ICAuLi4vc3lzY2FsbHMvZ2V0aG9zdG5hbWUvZ2V0aG9zdG5hbWUwMi5jICAgICAg
fCA0MSArKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9u
cygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRo
b3N0bmFtZS9nZXRob3N0bmFtZTAyLmMKPiAKPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxs
cyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCBkZTRmNWE2MzMuLmNjMWUzOWMwNSAxMDA2NDQK
PiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC00
NzcsNiArNDc3LDcgQEAgZ2V0aG9zdGJ5bmFtZV9yMDEgZ2V0aG9zdGJ5bmFtZV9yMDEKPiAgZ2V0
aG9zdGlkMDEgZ2V0aG9zdGlkMDEKPiAKPiAgZ2V0aG9zdG5hbWUwMSBnZXRob3N0bmFtZTAxCj4g
K2dldGhvc3RuYW1lMDIgZ2V0aG9zdG5hbWUwMgo+IAo+ICBnZXRpdGltZXIwMSBnZXRpdGltZXIw
MQo+ICBnZXRpdGltZXIwMiBnZXRpdGltZXIwMgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2dldGhvc3RuYW1lLy5naXRpZ25vcmUKPiBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZ2V0aG9zdG5hbWUvLmdpdGlnbm9yZSBpbmRleAo+IGQwOWQ1ZDI4OC4uZDZlNGNm
ZmNiIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0aG9zdG5hbWUv
LmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0aG9zdG5hbWUv
LmdpdGlnbm9yZQo+IEBAIC0xICsxLDIgQEAKPiAgL2dldGhvc3RuYW1lMDEKPiArL2dldGhvc3Ru
YW1lMDIKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRob3N0bmFt
ZS9nZXRob3N0bmFtZTAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0aG9zdG5h
bWUvZ2V0aG9zdG5hbWUwMi5jIG5ldyBmaWxlIG1vZGUKPiAxMDA2NDQKPiBpbmRleCAwMDAwMDAw
MDAuLmU5ZDk3ZDA1YQo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldGhvc3RuYW1lL2dldGhvc3RuYW1lMDIuYwo+IEBAIC0wLDAgKzEsNDEgQEAKPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArLyoKPiArICog
Q29weXJpZ2h0IChjKSAyMDI0IEZVSklUU1UgTElNSVRFRC4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4K
PiArICogQXV0aG9yOiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPgo+ICsgKi8K
PiArCj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAqCj4gKyAqIFZlcmlmeSB0aGF0IGdl
dGhvc3RuYW1lKDIpIGZhaWxzIHdpdGgKPiArICoKPiArICogLSBFTkFNRVRPT0xPTkcgd2hlbiBs
ZW4gaXMgc21hbGxlciB0aGFuIHRoZSBhY3R1YWwgc2l6ZQo+ICsgKi8KPiArCj4gKyNpbmNsdWRl
ICJ0c3RfdGVzdC5oIgo+ICsKPiArc3RhdGljIGNoYXIgaG9zdG5hbWVfZW5hbWV0b29sb25nWzEw
MF07Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArCWNoYXIgKmhvc3RuYW1l
Owo+ICsJaW50IHNpemU7Cj4gKwlpbnQgZXhwZWN0ZWRfZXJybm87Cj4gKwljaGFyICpkZXNjOwo+
ICt9IHRjYXNlc1tdID0gewo+ICsJe2hvc3RuYW1lX2VuYW1ldG9vbG9uZywgMSwgRU5BTUVUT09M
T05HLApJZiBJIGZvdW5kIGNvcnJlY3RseSwgbWluaW11bSBwb3NzaWJsZSBzaXplIGZvciBob3N0
bmFtZSBjYW4gYmUganVzdCAxIGNoYXIuClNvIGlmIHdlIHdhbnQgdG8gdGVzdCBFTkFNRVRPT0xP
TkcgZXJybm8gYnkgcGFzc2luZyBhIGxlbiB2YWx1ZSB3aGljaCBpcyBub3QKZW5vdWdoIHRvIHN0
b3JlIHRoZSBob3N0bmFtZSB2YWx1ZSwgbWF5YmUgb25lIGFwcHJvYWNoIGNhbiBiZSwgZmlyc3Qg
ZmV0Y2ggdGhlCmhvc3RuYW1lIHZhbHVlIGJ5IGEgc3VjY2Vzc2Z1bCBnZXRob3N0bmFtZSgpIGNh
bGwsIGFuZCB0aGVuIHBhc3MgdGhlIHNtYWxsZXIKbGVuIHZhbHVlIHRoYW4gdGhlIHJlY2VpdmVk
IGhvc3RuYW1lIGxlbmd0aCB0byB2ZXJpZnkgdGhpcyBlcnJubyBzY2VuYXJpby4KCkFsc28sIGlm
IHdlIGFyZSB0ZXN0aW5nIGp1c3QgYSBzaW5nbGUgY2FzZSwgaW1obyBsZXRzIG5vdCB1c2UgdGhl
CnRlc3RfY2FzZV90IHN0cnVjdC4KCj4gKwkJImxlbiBpcyBzbWFsbGVyIHRoYW4gdGhlIGFjdHVh
bCBzaXplIn0sCj4gK307Cj4gKwo+ICtzdGF0aWMgdm9pZCB2ZXJpZnlfZ2V0aG9zdG5hbWUodW5z
aWduZWQgaW50IGkpCj4gK3sKPiArCXN0cnVjdCB0ZXN0X2Nhc2VfdCAqdGMgPSAmdGNhc2VzW2ld
Owo+ICsKPiArCVRTVF9FWFBfRkFJTChnZXRob3N0bmFtZSh0Yy0+aG9zdG5hbWUsIHNpemVvZih0
Yy0+c2l6ZSkpLApJIGFtIGNvbmZ1c2VkIHdoeSB3ZSBoYXZlIHNpemVvZigpIGhlcmUuCj4gKwkJ
dGMtPmV4cGVjdGVkX2Vycm5vLCAiJXMiLCB0Yy0+ZGVzYyk7Cj4gK30KPiArCj4gK3N0YXRpYyBz
dHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiArCS50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+
ICsJLnRlc3QgPSB2ZXJpZnlfZ2V0aG9zdG5hbWUsCj4gKwkubmVlZHNfcm9vdCA9IDEsCkkgZ3Vl
c3Mgcm9vdCBpcyBub3QgcmVxdWlyZWQuCj4gK307CgpSZWdhcmRzLApBdmluZXNoCgoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
