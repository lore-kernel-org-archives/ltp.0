Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C36FC19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 15:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A31F3C9E6D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 16:05:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF04F3C9E08
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 16:04:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C63DC141ECDA
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 16:04:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 483111F38F;
 Fri, 28 Feb 2025 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740755093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gkq4xrBFsFX0KgosrkKzDEgNk5uH/ykQPfOqc28wU0=;
 b=X4zX4GtChHHCSO8WN8t6U/uet0tLEOlf/FuUPua6t2P3QULO1oa6FAoKZq+HfD4Dc3C6nj
 w3ydLcXMEscDzOumGq5GAHMnMKfuVMTnQqNTJ6g1vIPlBtDRkOnQjPjyAAHmP79Gqyf4pb
 Mf02Q5Z3lARYdKOtuajvSWqHWPNrAsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740755093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gkq4xrBFsFX0KgosrkKzDEgNk5uH/ykQPfOqc28wU0=;
 b=zvOumEg2RJaeFgprdBjIWqVfVFVuLdH351UUV6feo7M6OuoclFgorRm2nnKJGyTVdaw+bH
 QcwihGytgJkE4VAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X4zX4GtC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zvOumEg2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740755093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gkq4xrBFsFX0KgosrkKzDEgNk5uH/ykQPfOqc28wU0=;
 b=X4zX4GtChHHCSO8WN8t6U/uet0tLEOlf/FuUPua6t2P3QULO1oa6FAoKZq+HfD4Dc3C6nj
 w3ydLcXMEscDzOumGq5GAHMnMKfuVMTnQqNTJ6g1vIPlBtDRkOnQjPjyAAHmP79Gqyf4pb
 Mf02Q5Z3lARYdKOtuajvSWqHWPNrAsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740755093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gkq4xrBFsFX0KgosrkKzDEgNk5uH/ykQPfOqc28wU0=;
 b=zvOumEg2RJaeFgprdBjIWqVfVFVuLdH351UUV6feo7M6OuoclFgorRm2nnKJGyTVdaw+bH
 QcwihGytgJkE4VAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21C3F1344A;
 Fri, 28 Feb 2025 15:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OyH5BpXQwWf2QgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Feb 2025 15:04:53 +0000
Date: Fri, 28 Feb 2025 16:05:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.vnet.ibm.com>
Message-ID: <Z8HQocX4FIupw2A-@yuki.lan>
References: <20241125153006.799645-1-pavrampu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241125153006.799645-1-pavrampu@linux.vnet.ibm.com>
X-Rspamd-Queue-Id: 483111F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 URL_IN_SUBJECT(1.00)[github.com];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Origin:
 https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/shm-getraw.c
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
Cc: ltp@lists.linux.it, rnsastry@linux.ibm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gVGhlIHRlc3QgY3JlYXRlcyBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudCwgdGhlbiBhdHRh
Y2hlcyBpdCB0byB0aGUgcHJvY2Vzc+KAmXMgYWRkcmVzcyBzcGFjZS4KPiBJdCB3cml0ZXMgYSBz
dHJpbmcgdG8gdGhlIHNoYXJlZCBtZW1vcnkgZnJvbSByYXcgZGV2aWNlIGFuZCBkZXRhY2hlcyB0
aGUgc2hhcmVkIG1lbW9yeQo+IHNlZ21lbnQgYW5kIGZpbmFsbHkgcmVtb3ZlcyBpdC4KPiBUaGUg
cHVycG9zZSBvZiB0aGlzIHRlc3QgaXMgdG8gZW5zdXJlIHRoYXQgdGhlIHNoYXJlZCBtZW1vcnkg
c3Vic3lzdGVtIGlzIHdvcmtpbmcgY29ycmVjdGx5Cj4gd2l0aCBodWdlcGFnZXMuIEl0IGNoZWNr
cyB0aGF0IHNoYXJlZCBtZW1vcnkgc2VnbWVudHMgY2FuIGJlIGNyZWF0ZWQsIGF0dGFjaGVkLCB3
cml0dGVuIHRvLAo+IHJlYWQgZnJvbSwgZGV0YWNoZWQsIGFuZCByZW1vdmVkIHdpdGhvdXQgZXJy
b3JzCj4gCj4gU2lnbmVkLW9mZi1ieTogUGF2aXRocmEgPHBhdnJhbXB1QGxpbnV4LnZuZXQuaWJt
LmNvbT4KPiAtLS0KPiAgcnVudGVzdC9odWdldGxiICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDIgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlICAgICAgICAgICAg
ICAgfCAgMSArCj4gIC4uLi9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvTWFrZWZpbGUg
ICB8ICA5ICsrKwo+ICAuLi4vbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5j
ICAgfCA1OCArKysrKysrKysrKysrKysrKysrCj4gIDQgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0
aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRs
Yi9odWdlc2htbWlzYy9NYWtlZmlsZQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tl
cm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9odWdlc2htbWlzYzAxLmMKCk1heWJlIHdlIHNo
b3VsZCBwdXQgdGhlIHRlc3QgaW50byB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1n
YXQvCmluc3RlYWQgb2YgY3JlYXRpbmcgYSBuZXcgZGlyZWN0b3JyaWVzIGluIGh1Z2V0bGIuCgo+
IGRpZmYgLS1naXQgYS9ydW50ZXN0L2h1Z2V0bGIgYi9ydW50ZXN0L2h1Z2V0bGIKPiBpbmRleCBm
Mjk0ZTlhYWEuLjQxMjAwODE4NSAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L2h1Z2V0bGIKPiArKysg
Yi9ydW50ZXN0L2h1Z2V0bGIKPiBAQCAtNTYsMyArNTYsNSBAQCBodWdlc2htZ2V0MDIgaHVnZXNo
bWdldDAyIC1pIDEwCj4gIGh1Z2VzaG1nZXQwMyBodWdlc2htZ2V0MDMgLWkgMTAKPiAgaHVnZXNo
bWdldDA1IGh1Z2VzaG1nZXQwNSAtaSAxMAo+ICBodWdlc2htZ2V0MDYgaHVnZXNobWdldDA2IC1p
IDEwCj4gKwo+ICtodWdlc2htbWlzYzAxIGh1Z2VzaG1taXNjMDEKPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRp
Z25vcmUKPiBpbmRleCBkODg0ODRmYTEuLjg4OTBkNDIyZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdp
dGlnbm9yZQo+IEBAIC00OCw2ICs0OCw3IEBACj4gIC9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNo
bWdldDAzCj4gIC9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDA1Cj4gIC9odWdldGxiL2h1
Z2VzaG1nZXQvaHVnZXNobWdldDA2Cj4gKy9odWdldGxiL2h1Z2VzaG1taXNjL2h1Z2VzaG1taXNj
MDEKPiAgL2tzbS9rc20wMQo+ICAva3NtL2tzbTAyCj4gIC9rc20va3NtMDMKPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmlsZSBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvTWFrZWZpbGUKPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uODQ3MTVjN2I1Cj4gLS0tIC9kZXYvbnVs
bAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvTWFrZWZp
bGUKPiBAQCAtMCwwICsxLDkgQEAKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcgo+ICsjIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lzdGVtcyBJbmMuCj4g
KyMgTmdpZSBDb29wZXIsIEp1bHkgMjAwOQo+ICsKPiArdG9wX3NyY2RpciAgICAgICAgICAgICAg
Pz0gLi4vLi4vLi4vLi4vLi4KPiArCj4gK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21r
L3Rlc3RjYXNlcy5tawo+ICtpbmNsdWRlICQoYWJzX3NyY2RpcikvLi4vTWFrZWZpbGUuaW5jCj4g
K2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsK
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9o
dWdlc2htbWlzYzAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNj
L2h1Z2VzaG1taXNjMDEuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAw
Li43MjgxNDAxZTgKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
aHVnZXRsYi9odWdlc2htbWlzYy9odWdlc2htbWlzYzAxLmMKPiBAQCAtMCwwICsxLDU4IEBACj4g
KyNpbmNsdWRlICJodWdldGxiLmgiCj4gKyNpbmNsdWRlICJ0c3Rfc2FmZV9zeXN2X2lwYy5oIgo+
ICsKPiArI2RlZmluZSBNTlRQT0lOVCAiaHVnZXRsYmZzLyIKPiArI2RlZmluZSBOUl9IVUdFUEFH
RVMgMgo+ICsKPiArc3RhdGljIGludCBzaG1pZCA9IC0xOwo+ICtzdGF0aWMgc2l6ZV90IHNpemU7
Cj4gK3N0YXRpYyBzaXplX3QgaTsKPiArc3RhdGljIHNpemVfdCByZXQ7Cj4gKwo+ICtzdGF0aWMg
dm9sYXRpbGUgY2hhciAqc2htYWRkcjsKClRoZSB2b2xhdGlsZSBzaG91bGRuJ3QgYmUgaGVyZS4K
Cj4gK3N0YXRpYyBpbnQgcmF3X2ZkOwo+ICtzdGF0aWMgbG9uZyBocGFnZV9zaXplOwo+ICsKPiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsJaHBhZ2Vfc2l6ZSA9IHRzdF9nZXRfaHVn
ZXBhZ2Vfc2l6ZSgpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gK3sK
PiArCWlmIChzaG1pZCA+PSAwKQo+ICsJCVNBRkVfU0hNQ1RMKHNobWlkLCBJUENfUk1JRCwgTlVM
TCk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4gK3sKPiArCXNpemUg
PSBocGFnZV9zaXplICogTlJfSFVHRVBBR0VTOwo+ICsJcmF3X2ZkID0gU0FGRV9PUEVOKCIvZGV2
L3JhbmRvbSIsIE9fUkRPTkxZKTsKPiArCXRzdF9yZXMoVElORk8sICJSZXF1ZXN0aW5nICV6dSBi
eXRlc1xuIiwgc2l6ZSk7CgpUaGlzIG1lc3NhZ2UgZG9lcyBub3QgYWRkIGFueSBnb29kIGluZm9y
bWF0aW9uLCBJIHdvdWxkIHJlbW92ZSBpdC4KCj4gKyAgICAgICAgc2htaWQgPSBTQUZFX1NITUdF
VChJUENfUFJJVkFURSwgc2l6ZSwgU0hNX0hVR0VUTEJ8U0hNX1J8U0hNX1cpOwoKV2UgYXJlIG5v
dCB1c2luZyB0aGUgaHVnZXRsYmZzLyBzaW5jZSB3ZSBnZXQgdGhlIGh1Z2VwYWdlcyB2aWEKU0hN
X0hVR0VUTEIsIHNvIHdlIGNhbiByZW1vdmUgdGhlIC5tbnRwb2ludCBhbmQgLm5lZWRzX2h1Z2V0
bGJmcyBmcm9tCnRoZSB0c3RfdGVzdCBzdHJ1Y3R1cmUuCgo+ICsJc2htYWRkciA9IFNBRkVfU0hN
QVQoc2htaWQsIDAsIFNITV9STkQpOwo+ICsJdHN0X3JlcyhUSU5GTywgInNobWFkZHI6ICVwXG4i
LCBzaG1hZGRyKTsKPiArCj4gKwkvKiBSZWFkIGEgcGFnZSBmcm9tIGRldmljZSBhbmQgd3JpdGUg
dG8gc2htIHNlZ21lbnQgKi8KPiArCWZvciAoaSA9IDA7IGkgPCBzaXplOyBpICs9IGhwYWdlX3Np
emUpIHsKPiArCQlpZiAoIXJlYWQocmF3X2ZkLCBzaG1hZGRyLCBocGFnZV9zaXplKSkgewo+ICsJ
CQl0c3RfcmVzKFRGQUlMIHwgVEVSUk5PLCAiQ2FuJ3QgcmVhZCBmcm9tIHJhdyBkZXZpY2UhIik7
Cj4gKwkJfQoKVFNUX0VYUF9WQUwocmVhZCgpLCBocGFnZV9zaXplKTsKCkFsc28gd2UgbWF5IHdh
bnQgdG8gc3dpdGNoIHRvICIvZGV2L3plcm8iIGluc3RlYWQgb2YgIi9kZXYvcmFuZG9tIiBhcwoi
L2Rldi96ZXJvIiBzaG91bGQgYmUgZmFzdGVyLgoKPiArCX0KPiArCj4gKwlTQUZFX1NITURUKChj
b25zdCB2b2lkICopc2htYWRkcik7CgpUaGUgY2FzdCB0byBjb25zdCB2b2lkICogc2hvdWxkbid0
IGJlIHRoZXJlLgoKPiArCXRzdF9yZXMoVFBBU1MsICJUZXN0IFBhc3NlZCEiKTsKClRoaXMgaXMg
bm90IGdvaW5nIHRvIGJlIG5lZWRlZCB3aXRoIFRTVF9FWFBfVkFMKCk7CgoKPiArfQo+ICsKPiAr
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLm5lZWRzX3Jvb3QgPSAxLAo+ICsJ
Lm1udHBvaW50ID0gTU5UUE9JTlQsCj4gKwkubmVlZHNfaHVnZXRsYmZzID0gMSwKPiArCS5zZXR1
cCA9IHNldHVwLAo+ICsJLmNsZWFudXAgPSBjbGVhbnVwLAo+ICsJLnRlc3RfYWxsID0gcnVuX3Rl
c3QsCj4gKwkuaHVnZXBhZ2VzID0gezIsIFRTVF9ORUVEU30sCiAgICAgICAgICAgICAgICAgICAg
ICBeCgkJICAgICAgVGhpcyBzaG91bGQgYmUgTlJfSFVHRVBBR0VTCj4gK307CgpBbmQgbGFzdGx5
IGJ1dCBub3QgbGVhc3QsIHBsZWFzZSB1c2UgJ21ha2UgY2hlY2snIGFuZCBmaXggYWxsIHRoZQpw
cm9ibGVtcyByZXBvcnRlZCwgYmVmb3JlIHNlbmRpbmcgYSBwYXRjaC4KCi0tIApDeXJpbCBIcnVi
aXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
