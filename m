Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FCC3DA4A
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 07:32:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C30B63CCF82
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 09:32:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8707B3CAB21
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 09:31:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FFEF20172B
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 09:31:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 873C921D26;
 Tue, 20 Aug 2024 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724139112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8Zb9KnhY9NhlrJ+4CGpr2d3pQeqvshqk5rhO38HLSc=;
 b=AgIe7kxu4nKIkes8Ui7tznrOdK8fmw7mYdycAsjpDZWWKpKWocFPoULAsEO7FBlzxSqfJj
 CLK09E/LMsn8x39Qjh0z2/oupA7du+F1XFMcSU3Tcug0CTVAgZ2gc6N7WgY4xdhmTvJVTN
 FALwdmTH21xYG5yBtm09QRrPr0+cH2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724139112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8Zb9KnhY9NhlrJ+4CGpr2d3pQeqvshqk5rhO38HLSc=;
 b=QL2c3wpmUNJAY3zmk0s35F36EUo+VgtkpT4SUgqT7Ir/w+2ysqrzcxwxJBdXyvZo6se4Wb
 YvnbDAAEPab8xwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724139112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8Zb9KnhY9NhlrJ+4CGpr2d3pQeqvshqk5rhO38HLSc=;
 b=AgIe7kxu4nKIkes8Ui7tznrOdK8fmw7mYdycAsjpDZWWKpKWocFPoULAsEO7FBlzxSqfJj
 CLK09E/LMsn8x39Qjh0z2/oupA7du+F1XFMcSU3Tcug0CTVAgZ2gc6N7WgY4xdhmTvJVTN
 FALwdmTH21xYG5yBtm09QRrPr0+cH2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724139112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8Zb9KnhY9NhlrJ+4CGpr2d3pQeqvshqk5rhO38HLSc=;
 b=QL2c3wpmUNJAY3zmk0s35F36EUo+VgtkpT4SUgqT7Ir/w+2ysqrzcxwxJBdXyvZo6se4Wb
 YvnbDAAEPab8xwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75CF613770;
 Tue, 20 Aug 2024 07:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UkfdG2hGxGb9GwAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 20 Aug 2024 07:31:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Date: Tue, 20 Aug 2024 09:31:52 +0200
Message-ID: <26537985.1r3eYUQgxm@localhost>
Organization: SUSE
In-Reply-To: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
References: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getdents02: Add case for errno EFAULT
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

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgoKT24gTW9u
ZGF5LCBBdWd1c3QgMTksIDIwMjQgMTA6MjI6MTPigK9BTSBHTVQrMiBNYSBYaW5qaWFuIHZpYSBs
dHAgd3JvdGU6Cj4gQ3VycmVudGx5IHRoZXJlIGlzIG5vIGNhc2UgZm9yIEVGQVVMVCwgc28gYSBu
ZXcgY2FzZSBpcyBhZGRlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYSBYaW5qaWFuIDxtYXhqLmZu
c3RAZnVqaXRzdS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVu
dHMvZ2V0ZGVudHMwMi5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMv
Z2V0ZGVudHMwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRkZW50cy9nZXRkZW50
czAyLmMKPiBpbmRleCBhZGUxYzk0NzYuLjU3OGRiOWQxZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDIuYwo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMi5jCj4gQEAgLTE1LDYgKzE1LDcg
QEAKPiAgICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFSU5WQUwgaWYgcmVzdWx0IGJ1ZmZl
ciBpcyB0b28gc21hbGwKPiAgICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFTk9URElSIGlm
IGZpbGUgZGVzY3JpcHRvciBkb2VzIG5vdCByZWZlciB0byBhIGRpcmVjdG9yeQo+ICAgKiAgIC0g
Z2V0ZGVudHMoKSBmYWlscyB3aXRoIEVOT0VOVCBpZiBkaXJlY3Rvcnkgd2FzIHVubGlua2VkKCkK
PiArICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFRkFVTFQgaWYgYXJndW1lbnQgcG9pbnRz
IG91dHNpZGUgdGhlIGNhbGxpbmcgcHJvY2VzcydzIGFkZHJlc3Mgc3BhY2UKPiAgICovCj4gIAo+
ICAjZGVmaW5lIF9HTlVfU09VUkNFCj4gQEAgLTM0LDYgKzM1LDcgQEAgc3RhdGljIHNpemVfdCBz
aXplOwo+ICAKPiAgc3RhdGljIGNoYXIgZGlycDFfYXJyWzFdOwo+ICBzdGF0aWMgY2hhciAqZGly
cDEgPSBkaXJwMV9hcnI7Cj4gK3N0YXRpYyBjaGFyICpkaXJwX2JhZDsKPiAgc3RhdGljIHNpemVf
dCBzaXplMSA9IDE7Cj4gIAo+ICBzdGF0aWMgaW50IGZkX2ludiA9IC01Owo+IEBAIC01MSw2ICs1
Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ICAJeyAmZmQsICZkaXJwMSwgJnNpemUxLCBF
SU5WQUwgfSwKPiAgCXsgJmZkX2ZpbGUsICZkaXJwLCAmc2l6ZSwgRU5PVERJUiB9LAo+ICAJeyAm
ZmRfdW5saW5rZWQsICZkaXJwLCAmc2l6ZSwgRU5PRU5UIH0sCj4gKwl7ICZmZCwgJmRpcnBfYmFk
LCAmc2l6ZSwgRUZBVUxUIH0sCj4gIH07Cj4gIAo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
IEBAIC02Myw2ICs2Niw4IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIAlmZCA9IFNBRkVf
T1BFTigiLiIsIE9fUkRPTkxZKTsKPiAgCWZkX2ZpbGUgPSBTQUZFX09QRU4oInRlc3QiLCBPX0NS
RUFUIHwgT19SRFdSLCAwNjQ0KTsKPiAgCj4gKwlkaXJwX2JhZCA9IHRzdF9nZXRfYmFkX2FkZHIo
TlVMTCk7Cj4gKwo+ICAJU0FGRV9NS0RJUihURVNUX0RJUiwgRElSX01PREUpOwo+ICAJZmRfdW5s
aW5rZWQgPSBTQUZFX09QRU4oVEVTVF9ESVIsIE9fRElSRUNUT1JZKTsKPiAgCVNBRkVfUk1ESVIo
VEVTVF9ESVIpOwo+IAoKUmVnYXJkcywKQXZpbmVzaAoKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
