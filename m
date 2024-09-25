Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEAEC369B0
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 09:14:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D707D3C4D78
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 11:14:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDE253C2978
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 11:14:24 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09F8A600FBE
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 11:14:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EE53211C6;
 Wed, 25 Sep 2024 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727255663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yQzKPuY6AULPzbL0PaJNIfFeupzScxqpwG5tj05OYA=;
 b=YA1uGEKrFdqgDH1S2pT3NhSHjRfYRbCB6piSLZD+hY6Z44DKvSsDcQjZtnS04q4lOsHsn0
 ubuKPQcWUt6+XASaRbhRZ0nqWoa6Ix6iy6Bt4RSCArSdIaj4NOYZvszhcGCMvndQ75W3L2
 pBVl4So6cmscZNh99C0w+e2BqhTPQGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727255663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yQzKPuY6AULPzbL0PaJNIfFeupzScxqpwG5tj05OYA=;
 b=4/GvfFX4UMwDSwNKX80ogN5OrLcsnMBQ9eL5Aqk7TiGAeiZ4NyNTXCft+FBHCGGD1JrvVt
 GFmicjl83LC1U1Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727255663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yQzKPuY6AULPzbL0PaJNIfFeupzScxqpwG5tj05OYA=;
 b=YA1uGEKrFdqgDH1S2pT3NhSHjRfYRbCB6piSLZD+hY6Z44DKvSsDcQjZtnS04q4lOsHsn0
 ubuKPQcWUt6+XASaRbhRZ0nqWoa6Ix6iy6Bt4RSCArSdIaj4NOYZvszhcGCMvndQ75W3L2
 pBVl4So6cmscZNh99C0w+e2BqhTPQGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727255663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yQzKPuY6AULPzbL0PaJNIfFeupzScxqpwG5tj05OYA=;
 b=4/GvfFX4UMwDSwNKX80ogN5OrLcsnMBQ9eL5Aqk7TiGAeiZ4NyNTXCft+FBHCGGD1JrvVt
 GFmicjl83LC1U1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2389513793;
 Wed, 25 Sep 2024 09:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2WdMCG/U82aADwAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 25 Sep 2024 09:14:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Sep 2024 11:14:22 +0200
Message-ID: <2149487.9o76ZdvQCi@localhost>
In-Reply-To: <20240924160028.67124-1-mdoucha@suse.cz>
References: <20240924160028.67124-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fallocate05: Allow ENXIO error from
 lseek(SEEK_DATA) on empty file
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

SGksCgpPbiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgNjowMDoyN+KAr1BNIEdNVCsyIE1h
cnRpbiBEb3VjaGEgd3JvdGU6Cj4gU29tZSBmaWxlc3lzdGVtcyByZWxlYXNlIGRlYWxsb2NhdGVk
IGJsb2NrcyBpbiBsYXJnZXIgY2h1bmtzLgo+IE9uIHRoZXNlIGZpbGVzeXN0ZW1zLCB0aGUgd2hv
bGUgdGVzdCBmaWxlIG5lZWRzIHRvIGJlIGRlYWxsb2NhdGVkCj4gdG8gYWxsb3cgdGhlIGZpbmFs
IHdyaXRlIHRvIHBhc3MuIEhvd2V2ZXIsIGxzZWVrKFNFRUtfREFUQSkgbWF5Cj4gcmV0dXJuIEVO
WElPIGVycm9yIGlmIHRoZSBlbnRpcmUgZmlsZSByYW5nZSBmcm9tIG9mZnNldCB0byBlbmQgb2Yg
ZmlsZQo+IGlzIG9uZSBsYXJnZSBob2xlLiBBbGxvdyBFTlhJTyBlcnJvciBpbiB0aGlzIHNwZWNp
YWwgY2FzZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2Uu
Y3o+CgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+Cgo+IC0tLQo+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwNS5jIHwgNCAr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDUuYwo+IGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDUuYyBpbmRleAo+IDcz
MmEyZjE1ZC4uYjQzNTBjODY1IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFsbG9jYXRlL2ZhbGxvY2F0ZTA1LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwNS5jCj4gQEAgLTE1NCw2ICsxNTQsMTAgQEAgc3RhdGlj
IHZvaWQgcnVuKHZvaWQpCj4gCj4gIAlpZiAoVFNUX1JFVCA9PSBob2xlc2l6ZSkgewo+ICAJCXRz
dF9yZXMoVFBBU1MsICJUZXN0IGZpbGUgZGF0YSBzdGFydCBhdCBvZmZzZXQgJWxkIiwgClRTVF9S
RVQpOwo+ICsJfSBlbHNlIGlmIChUU1RfUkVUID09IC0xICYmIGhvbGVzaXplID49IGJ1ZnNpemUg
KyBleHRzaXplICYmCj4gKwkJVFNUX0VSUiA9PSBFTlhJTykgewo+ICsJCXRzdF9yZXMoVFBBU1Mg
fCBUVEVSUk5PLAo+ICsJCQkibHNlZWsoU0VFS19EQVRBKSBmYWlsZWQgb24gZW1wdHkgZmlsZSIp
Owo+ICAJfSBlbHNlIGlmIChUU1RfUkVUID09IC0xKSB7Cj4gIAkJdHN0X3JlcyhURkFJTCB8IFRU
RVJSTk8sICJsc2VlayhTRUVLX0RBVEEpIGZhaWxlZCIpOwo+ICAJfSBlbHNlIHsKPiAtLQo+IDIu
NDYuMAo+IAo+IAo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCgpSZWdhcmRzLApBdmluZXNoCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
