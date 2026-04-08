Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652D105D9AE
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 09:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508733E26AE
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 11:34:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A893E1E07
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 11:34:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B96442001AA
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 11:34:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3867C4E923;
 Wed,  8 Apr 2026 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775640876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55CC2YMpOGkxdqtNQ7fHtn1bg3vd3XqkB7rhL6+iB2o=;
 b=mkH1+QQwUFTdw1H6GqWLCSb3vHurqqYuwamPiSYR6xoQHMRbcd8lT8JmJr0VW7l17vOoY0
 VrE3svW//WfHJ4Gigrp7OErRtP7LaHMXQ0HZYByugQeaLhxYSsWEjbM1GWeQ7/m6Tp3Vfo
 rgjzrXral50xXaRDoUO8PJblktoInrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775640876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55CC2YMpOGkxdqtNQ7fHtn1bg3vd3XqkB7rhL6+iB2o=;
 b=x4oRr/udh6d9Q1966PwlsGRF583w7D97lPYfEbLVbPk6Kbe3UjwLgOAH2k8wG5VG2ue7Ap
 4d49sn7UzzuL7fDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mkH1+QQw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="x4oRr/ud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775640876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55CC2YMpOGkxdqtNQ7fHtn1bg3vd3XqkB7rhL6+iB2o=;
 b=mkH1+QQwUFTdw1H6GqWLCSb3vHurqqYuwamPiSYR6xoQHMRbcd8lT8JmJr0VW7l17vOoY0
 VrE3svW//WfHJ4Gigrp7OErRtP7LaHMXQ0HZYByugQeaLhxYSsWEjbM1GWeQ7/m6Tp3Vfo
 rgjzrXral50xXaRDoUO8PJblktoInrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775640876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55CC2YMpOGkxdqtNQ7fHtn1bg3vd3XqkB7rhL6+iB2o=;
 b=x4oRr/udh6d9Q1966PwlsGRF583w7D97lPYfEbLVbPk6Kbe3UjwLgOAH2k8wG5VG2ue7Ap
 4d49sn7UzzuL7fDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 269844A0B3;
 Wed,  8 Apr 2026 09:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4550CCwh1mlQOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Apr 2026 09:34:36 +0000
Date: Wed, 8 Apr 2026 11:34:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: =?utf-8?B?4oCcU2FtaXI=?= <samir@linux.ibm.com>
Message-ID: <adYhNrtHEGBRO2xF@yuki.lan>
References: <20260407054943.125260-1-samir@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260407054943.125260-1-samir@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid,
 linux.it:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3867C4E923
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmget: Use __func__ instead of hardcoded
 function
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gRml4ZWQgaW46Cj4gLSBodWdlc2htZ2V0MDIuYzo4Mwo+IC0gaHVnZXNobWdldDAzLmM6
NzYKPiAtIGh1Z2VzaG1nZXQwNS5jOjc1Cj4gCj4gQ2hhbmdlZCBmcm9tOiB0c3RfYnJrKFRCUk9L
IHwgVEVSUk5PLCAic2htZ2V0ICNzZXR1cCIpOwo+IENoYW5nZWQgdG86ICAgdHN0X2JyayhUQlJP
SyB8IFRFUlJOTywgInNobWdldCAjJXMiLCBfX2Z1bmNfXyk7CgpZb3Ugc2hvdWxkIHJlYWxseSB1
c2UgU0FGRV9TSE1HRVQoKSBpbiB0aGUgc2V0dXAoKSBpbiB0aGUgMDIgYW5kIDA1CnRlc3RzIGlu
c3RlYWQuCgo+IFNpZ25lZC1vZmYtYnk6IOKAnFNhbWlyIDxzYW1pckBsaW51eC5pYm0uY29tPgo+
IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdl
dDAyLmMgfCAyICstCj4gIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWdldC9o
dWdlc2htZ2V0MDMuYyB8IDIgKy0KPiAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
c2htZ2V0L2h1Z2VzaG1nZXQwNS5jIHwgMiArLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMi5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMi5jCj4gaW5kZXggYmJkOTY4YzA2
Li4wNjVhYTA1ZmMgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9o
dWdlc2htZ2V0L2h1Z2VzaG1nZXQwMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVn
ZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMi5jCj4gQEAgLTgwLDcgKzgwLDcgQEAgdm9pZCBz
ZXR1cCh2b2lkKQo+ICAJc2htX2lkXzEgPSBzaG1nZXQoc2hta2V5LCBzaG1fc2l6ZSwKPiAgCQkJ
ICBTSE1fSFVHRVRMQiB8IElQQ19DUkVBVCB8IElQQ19FWENMIHwgU0hNX1JXKTsKPiAgCWlmIChz
aG1faWRfMSA9PSAtMSkKPiAtCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2htZ2V0ICNzZXR1
cCIpOwo+ICsJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzaG1nZXQgIyVzIiwgX19mdW5jX18p
Owo+ICB9Cj4gIAo+ICB2b2lkIGNsZWFudXAodm9pZCkKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMy5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMy5jCj4gaW5kZXggNjI1
NzYxZjZlLi4xZjA3ZDU4NWEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVn
ZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMy5jCj4gQEAgLTczLDcgKzczLDcgQEAg
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgCQkJCSAgU0hNX0hVR0VUTEIgfCBJUENfQ1JFQVQg
fCBJUENfRVhDTCB8IFNITV9SVyk7Cj4gIAl9Cj4gIAlpZiAoZXJybm8gIT0gRU5PU1BDKQo+IC0J
CXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzaG1nZXQgI3NldHVwIik7Cj4gKwkJdHN0X2JyayhU
QlJPSyB8IFRFUlJOTywgInNobWdldCAjJXMiLCBfX2Z1bmNfXyk7CgpBbmQgaGVyZSB5b3Ugc2hv
dWxkIHByb2JhYmx5IGp1c3QgcHJpbnQgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNobWdldCgp
Iik7CgpUaGVyZSBpcyBlbm91Z2ggaW5mb3JtYXRpb24gcHJpbnRlZCBieSB0aGUgdHN0X2Jyaygp
IHRvIGxvY2F0ZSB0aGUKZmFpbHVyZSwgbm8gbmVlZCB0byBhZGQgbW9yZS4KCj4gIAo+ICBzdGF0
aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYwo+IGluZGV4IDMzNjMxOTYwMy4uYTJi
YjkwMjBkIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNo
bWdldC9odWdlc2htZ2V0MDUuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIv
aHVnZXNobWdldC9odWdlc2htZ2V0MDUuYwo+IEBAIC03Miw3ICs3Miw3IEBAIHZvaWQgc2V0dXAo
dm9pZCkKPiAgCXNobV9pZF8xID0gc2htZ2V0KHNobWtleSwgc2htX3NpemUsCj4gIAkJCSAgU0hN
X0hVR0VUTEIgfCBTSE1fUlcgfCBJUENfQ1JFQVQgfCBJUENfRVhDTCk7Cj4gIAlpZiAoc2htX2lk
XzEgPT0gLTEpCj4gLQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNobWdldCAjc2V0dXAiKTsK
PiArCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2htZ2V0ICMlcyIsIF9fZnVuY19fKTsKPiAg
Cj4gIAkvKiBnZXQgdGhlIHVzZXJpZCBmb3IgYSBub24tcm9vdCB1c2VyICovCj4gIAlsdHBfdWlk
ID0gZ2V0dXNlcmlkKGx0cF91c2VyKTsKPiAtLSAKPiAyLjUyLjAKPiAKPiAKPiAtLSAKPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApD
eXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
