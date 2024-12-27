Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990A7E7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 11:37:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0455F3EE9CE
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 12:37:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AEA03E11CF
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:36:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB03F663BB5
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:36:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E96B5336E5;
 Fri, 27 Dec 2024 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735299414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjKUTg+Rihh0nJ0WtoWhJPtDApgFZRn3Q+ghLQYRajw=;
 b=gDlxzZ9fIB2rgG+kAUo7U9Irl7AgRWgBBscZY8CkBMQL95PIdA2SYtM/MWM4jFmyfaK5gi
 DF2duqtTR+03ueH+s8eumHKUbpxB+RObvn4bHFKCTcVNADm6xrKf0bKAYg+IUr93hvUPP4
 jouWK1dwJxqvsxZyYMSlMhkk6sAOdfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735299414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjKUTg+Rihh0nJ0WtoWhJPtDApgFZRn3Q+ghLQYRajw=;
 b=vvMjaIpNY1zxMrrzbvy0kb/pcz6UN/B2xxdVqAPHTLl4jr6BYe/X9InIf0o3/4j9Dl96rU
 7NztUHriDZqxvODA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="VcA/7XMk";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qfz0Jp0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735299413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjKUTg+Rihh0nJ0WtoWhJPtDApgFZRn3Q+ghLQYRajw=;
 b=VcA/7XMkW/CTg4VsU/rrdpmXzCPnVyDVcrXyoNIUtNJnlA0wEvRF0bKPQb8wDqKr1yBxKt
 eEr32Pltzk5duZYNFgXO68VygUFlOGBYnF/rU35pSk97WYJuTz7ckH5QGPZtgSgCAqNcpy
 +V5DdkRJdPReKZvQMa6VF5GYsRbxXMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735299413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjKUTg+Rihh0nJ0WtoWhJPtDApgFZRn3Q+ghLQYRajw=;
 b=qfz0Jp0JQMd7tnPsGUvm/83CcmvklHl5mODvSFQ8+xjC7foWtpGXgaR5/rXt7x6RFegXZU
 bZ3Goof5nf+OT+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C79C613985;
 Fri, 27 Dec 2024 11:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gj2GLlWRbmeCZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 11:36:53 +0000
Date: Fri, 27 Dec 2024 12:36:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227113648.GI317565@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-10-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-10-chrubis@suse.cz>
X-Rspamd-Queue-Id: E96B5336E5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi5lYmNl
ODE5N2MKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tz
bV90ZXN0LmgKLi4uCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBrc21fY2hpbGRfbWVtc2V0KGludCBj
aGlsZF9udW0sIGludCBzaXplLCBpbnQgdG90YWxfdW5pdCwKPiArCQkgc3RydWN0IGtzbV9tZXJn
ZV9kYXRhIGtzbV9tZXJnZV9kYXRhLCBjaGFyICoqbWVtb3J5KQo+ICt7Cj4gKwlpbnQgaSA9IDAs
IGo7Cj4gKwlpbnQgdW5pdCA9IHNpemUgLyB0b3RhbF91bml0Owo+ICsKPiArCXRzdF9yZXMoVElO
Rk8sICJjaGlsZCAlZCBjb250aW51ZXMuLi4iLCBjaGlsZF9udW0pOwo+ICsKPiArCWlmIChrc21f
bWVyZ2VfZGF0YS5tZXJnZWFibGVfc2l6ZSA9PSBzaXplICogVFNUX01CKSB7ClRoaXMgaW50cm9k
dWNlcyBuZXcgd2FybmluZ3MsIGJlY2F1c2UgdGhlIG9yaWdpbmFsIGNvZGUgdXNlZCBNQiB3aGlj
aCBpcyBsb25nLiAKCiNkZWZpbmUgTUIgICAgICAgICAgICAgICAgICAoMVVMPDwyMCkKCk5vdyB3
ZSB1c2UgVFNUX01CLCB3aGljaCBpcyBwbGFpbiBpbnQuCgpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
a3NtX2NvbW1vbi5oOjE2LAogICAgICAgICAgICAgICAgIGZyb20ga3NtMDQuYzo0MjoKa3NtX3Rl
c3QuaDogSW4gZnVuY3Rpb24g4oCYa3NtX2NoaWxkX21lbXNldOKAmToKa3NtX3Rlc3QuaDoxMDg6
NDM6IHdhcm5pbmc6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJl
bnQgc2lnbmVkbmVzczog4oCYdW5zaWduZWQgaW504oCZIGFuZCDigJhpbnTigJkgWy1Xc2lnbi1j
b21wYXJlXQogIDEwOCB8ICAgICAgICAgaWYgKGtzbV9tZXJnZV9kYXRhLm1lcmdlYWJsZV9zaXpl
ID09IHNpemUgKiBUU1RfTUIpIHsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefgprc21fdGVzdC5oOjExOTo0NTogd2FybmluZzogY29tcGFyaXNvbiBv
ZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJh1bnNpZ25l
ZCBpbnTigJkgYW5kIOKAmGludOKAmSBbLVdzaWduLWNvbXBhcmVdCiAgMTE5IHwgICAgICAgICAg
ICAgICAgIGZvciAoaSA9IDA7ICh1bnNpZ25lZCBpbnQpaSA8IHVuaXQgKiBUU1RfTUI7IGkrKykK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4Ka3Nt
X3Rlc3QuaDoxMjY6NDM6IHdhcm5pbmc6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9u
cyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYdW5zaWduZWQgaW504oCZIGFuZCDigJhpbnTi
gJkgWy1Xc2lnbi1jb21wYXJlXQogIDEyNiB8ICAgICAgICAgaWYgKGtzbV9tZXJnZV9kYXRhLm1l
cmdlYWJsZV9zaXplIDwgc2l6ZSAqIFRTVF9NQikKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCmtzbV90ZXN0Lmg6IEluIGZ1bmN0aW9uIOKAmGNyZWF0
ZV9rc21fY2hpbGTigJk6CmtzbV90ZXN0Lmg6MTY2OjU0OiB3YXJuaW5nOiBjb21wYXJpc29uIG9m
IGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmHVuc2lnbmVk
IGludOKAmSBhbmQg4oCYaW504oCZIFstV3NpZ24tY29tcGFyZV0KICAxNjYgfCAgICAgICAgICAg
ICAgICAgaWYgKGtzbV9tZXJnZV9kYXRhW2pdLm1lcmdlYWJsZV9zaXplIDwgc2l6ZSAqIFRTVF9N
QikgewogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgpJdCB3b3VsZCBiZSBuaWNlIHRvIGFkZCBjYXN0IGJlZm9yZSBtZXJnZS4KCj4g
KwkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCBUU1RfTUIgZmlsbGVkIHdp
dGggJyVjJyIsCgpUaGlzIHNob3VsZCB1c2UgTUIgKHJlcGxhY2UgdG8gd2hvbGUgZmlsZSBvYnZp
b3VzbHkgc2hvdWxkIGV4Y2x1ZGUgc3RyaW5ncyk6CgoJCXRzdF9yZXMoVElORk8sICJjaGlsZCAl
ZCBhbGxvY2F0ZXMgJWQgTUIgZmlsbGVkIHdpdGggJyVjJyIsCgo+ICsJCQljaGlsZF9udW0sIHNp
emUsIGtzbV9tZXJnZV9kYXRhLmRhdGEpOwo+ICsKPiArCX0gZWxzZSB7Cj4gKwkJdHN0X3JlcyhU
SU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCBUU1RfTUIgZmlsbGVkIHdpdGggJyVjJyIKCkFu
ZCBoZXJlIGFzIHdlbGwuCgkJdHN0X3JlcyhUSU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCBN
QiBmaWxsZWQgd2l0aCAnJWMnIgo+ICsJCQkJIiBleGNlcHQgb25lIHBhZ2Ugd2l0aCAnZSciLAo+
ICsJCQkJY2hpbGRfbnVtLCBzaXplLCBrc21fbWVyZ2VfZGF0YS5kYXRhKTsKPiArCX0KCk90aGVy
d2lzZSBMR1RNLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
