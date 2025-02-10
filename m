Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D47C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:17:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41FD93C98B6
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:17:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E923C2F65
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:17:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 370FB1BCFDDD
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:17:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB0EA21157;
 Mon, 10 Feb 2025 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739186248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zTV/vjQ4jsxuMxqxLoYJim6In2nFVCpwfllVy4KSc=;
 b=xhoWtcSFe2aFlrT0U9OV5fWVlFdfkBfok+S8dDvQqBrZEJU37riGBunUz59Ufs18upkDjH
 g1m0NlHM0K7TYzfl8NChJpaDkXD9yiy1IooZyTz+bzhyXFqVj9bizx20EU46DqBhP8I9lo
 TxsFwAnC9LBW9VfTVnEYf5C9hCcw3RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739186248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zTV/vjQ4jsxuMxqxLoYJim6In2nFVCpwfllVy4KSc=;
 b=QH9ldNX60t3UQkapXJV5wnDXpw4v60wG7pKo1GplhLBsJ1uebvYsp2LHZKhJUeMrCpHDyU
 SdpTlKQg/+SZo6Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zXK0I88P;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5U0G5sj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739186247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zTV/vjQ4jsxuMxqxLoYJim6In2nFVCpwfllVy4KSc=;
 b=zXK0I88Pr7wNQgrp09gofbGE+bPCc2MGH5KGvcO3ADIRofUho34vf13jRocMPV7jqYXy64
 7Aq4b3QsPda5BGekvdET4oWsE3UpUL6caMnwXL+OFqNZO5djSlGL2xS8GSKH1WBRbJz5rc
 0bsJTD+glF4NqR/f4uGaps1OU0nGouM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739186247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7zTV/vjQ4jsxuMxqxLoYJim6In2nFVCpwfllVy4KSc=;
 b=5U0G5sj+aYUcj/zvtaNWTNhb0QoJ+xlcVhr0OTXpiI2aUpTTEq6J+Y65GctHJIksdzYY9o
 2jRqIvB/1VA2UcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAE9E13A62;
 Mon, 10 Feb 2025 11:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n6OdNEfgqWfsXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:17:27 +0000
Date: Mon, 10 Feb 2025 12:17:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z6ngS8alAdHF95kP@yuki.lan>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-10-chrubis@suse.cz>
 <20241227113648.GI317565@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241227113648.GI317565@pevik>
X-Rspamd-Queue-Id: EB0EA21157
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/13] testcases/kernel/mem: Move KSM bits to ksm
 tests
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

SGkhCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwLi5lYmNlODE5
N2MKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9r
c21fdGVzdC5oCj4gLi4uCj4gPiArc3RhdGljIGlubGluZSB2b2lkIGtzbV9jaGlsZF9tZW1zZXQo
aW50IGNoaWxkX251bSwgaW50IHNpemUsIGludCB0b3RhbF91bml0LAo+ID4gKwkJIHN0cnVjdCBr
c21fbWVyZ2VfZGF0YSBrc21fbWVyZ2VfZGF0YSwgY2hhciAqKm1lbW9yeSkKPiA+ICt7Cj4gPiAr
CWludCBpID0gMCwgajsKPiA+ICsJaW50IHVuaXQgPSBzaXplIC8gdG90YWxfdW5pdDsKPiA+ICsK
PiA+ICsJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGNvbnRpbnVlcy4uLiIsIGNoaWxkX251bSk7
Cj4gPiArCj4gPiArCWlmIChrc21fbWVyZ2VfZGF0YS5tZXJnZWFibGVfc2l6ZSA9PSBzaXplICog
VFNUX01CKSB7Cj4gVGhpcyBpbnRyb2R1Y2VzIG5ldyB3YXJuaW5ncywgYmVjYXVzZSB0aGUgb3Jp
Z2luYWwgY29kZSB1c2VkIE1CIHdoaWNoIGlzIGxvbmcuIAo+IAo+ICNkZWZpbmUgTUIgICAgICAg
ICAgICAgICAgICAoMVVMPDwyMCkKPiAKPiBOb3cgd2UgdXNlIFRTVF9NQiwgd2hpY2ggaXMgcGxh
aW4gaW50Lgo+IAo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBrc21fY29tbW9uLmg6MTYsCj4gICAg
ICAgICAgICAgICAgICBmcm9tIGtzbTA0LmM6NDI6Cj4ga3NtX3Rlc3QuaDogSW4gZnVuY3Rpb24g
4oCYa3NtX2NoaWxkX21lbXNldOKAmToKPiBrc21fdGVzdC5oOjEwODo0Mzogd2FybmluZzogY29t
cGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDi
gJh1bnNpZ25lZCBpbnTigJkgYW5kIOKAmGludOKAmSBbLVdzaWduLWNvbXBhcmVdCj4gICAxMDgg
fCAgICAgICAgIGlmIChrc21fbWVyZ2VfZGF0YS5tZXJnZWFibGVfc2l6ZSA9PSBzaXplICogVFNU
X01CKSB7Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefgo+IGtzbV90ZXN0Lmg6MTE5OjQ1OiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGludGVnZXIg
ZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmHVuc2lnbmVkIGludOKAmSBh
bmQg4oCYaW504oCZIFstV3NpZ24tY29tcGFyZV0KPiAgIDExOSB8ICAgICAgICAgICAgICAgICBm
b3IgKGkgPSAwOyAodW5zaWduZWQgaW50KWkgPCB1bml0ICogVFNUX01COyBpKyspCj4gICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiBrc21fdGVz
dC5oOjEyNjo0Mzogd2FybmluZzogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9m
IGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJh1bnNpZ25lZCBpbnTigJkgYW5kIOKAmGludOKAmSBb
LVdzaWduLWNvbXBhcmVdCj4gICAxMjYgfCAgICAgICAgIGlmIChrc21fbWVyZ2VfZGF0YS5tZXJn
ZWFibGVfc2l6ZSA8IHNpemUgKiBUU1RfTUIpCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCj4ga3NtX3Rlc3QuaDogSW4gZnVuY3Rpb24g4oCYY3Jl
YXRlX2tzbV9jaGlsZOKAmToKPiBrc21fdGVzdC5oOjE2Njo1NDogd2FybmluZzogY29tcGFyaXNv
biBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJh1bnNp
Z25lZCBpbnTigJkgYW5kIOKAmGludOKAmSBbLVdzaWduLWNvbXBhcmVdCj4gICAxNjYgfCAgICAg
ICAgICAgICAgICAgaWYgKGtzbV9tZXJnZV9kYXRhW2pdLm1lcmdlYWJsZV9zaXplIDwgc2l6ZSAq
IFRTVF9NQikgewo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeCj4gSXQgd291bGQgYmUgbmljZSB0byBhZGQgY2FzdCBiZWZvcmUg
bWVyZ2UuCgpTbyB0aGUgc2l6ZSBpcyBzaWduZWQgYnV0IGl0IHdhcyBpbXBsaWNpdGx5IGNhc3Rl
ZCB0byB1bnNpZ25lZCBieSB0aGUKVFNUX01CIGJlaW5nIHVuc2lnbmVkLiBJIGd1ZXNzIHRoYXQg
dGhlIGJlc3QgZml4IGhlcmUgaXMgdG8gbWFrZSB0aGUKc2l6ZSBhbmQgdW5pdCB1bnNpZ25lZCB0
byBiZWdpbiB3aXRoIHNpbmNlIHRoZXNlIGFyZSBudW1iZXJzIHRoYXQgc2hvdWxkCm5vdCBiZSBu
ZWdhdGl2ZSBhdCBhbGwuCgo+ID4gKwkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFsbG9jYXRl
cyAlZCBUU1RfTUIgZmlsbGVkIHdpdGggJyVjJyIsCj4gCj4gVGhpcyBzaG91bGQgdXNlIE1CIChy
ZXBsYWNlIHRvIHdob2xlIGZpbGUgb2J2aW91c2x5IHNob3VsZCBleGNsdWRlIHN0cmluZ3MpOgo+
IAo+IAkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCBNQiBmaWxsZWQgd2l0
aCAnJWMnIiwKPiAKPiA+ICsJCQljaGlsZF9udW0sIHNpemUsIGtzbV9tZXJnZV9kYXRhLmRhdGEp
Owo+ID4gKwo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFs
bG9jYXRlcyAlZCBUU1RfTUIgZmlsbGVkIHdpdGggJyVjJyIKPiAKPiBBbmQgaGVyZSBhcyB3ZWxs
Lgo+IAkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCBNQiBmaWxsZWQgd2l0
aCAnJWMnIgo+ID4gKwkJCQkiIGV4Y2VwdCBvbmUgcGFnZSB3aXRoICdlJyIsCj4gPiArCQkJCWNo
aWxkX251bSwgc2l6ZSwga3NtX21lcmdlX2RhdGEuZGF0YSk7Cj4gPiArCX0KCkFoLCBzb3JyeSwg
dGhhdCBpcyBhIHJlc3VsdCBmcm9tIGJsaW5kbHkgZG9pbmcgc2VkIHMvLi4uCgotLSAKQ3lyaWwg
SHJ1YmlzCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
