Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C951073C8B
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 10:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE99C3E26AC
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 12:09:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A73E83C1BE3
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:09:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 184A060094A
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:09:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C9E74E944;
 Wed,  8 Apr 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775642968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRk5lR55sne5jeooOQNDDCakSRJ1RPJaS7CkfC7bWPo=;
 b=xIUI2g5O8sK1A1mCYhhy24BiuliYhYaWG/jvAkhAMolq+AhdBqXHZT23PSHOGnWx3KMIsU
 OPeS8Bs6JluMYC3DXNQSBOdnMxvCDivPTRAPcap5VYDVBjIe9X5et/4hnejuALovnyCRii
 csqfpVsFe4alDlMacozy96jqW/NmGcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775642968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRk5lR55sne5jeooOQNDDCakSRJ1RPJaS7CkfC7bWPo=;
 b=y/IrMD6ldi9OKB5N9cjqgmUJrEuIVUW9fQZL1bTNP8HTvnbGY3BkOK7uQggk9zwhJge/xh
 X4JJlESh4JZjEIBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xIUI2g5O;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/IrMD6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775642968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRk5lR55sne5jeooOQNDDCakSRJ1RPJaS7CkfC7bWPo=;
 b=xIUI2g5O8sK1A1mCYhhy24BiuliYhYaWG/jvAkhAMolq+AhdBqXHZT23PSHOGnWx3KMIsU
 OPeS8Bs6JluMYC3DXNQSBOdnMxvCDivPTRAPcap5VYDVBjIe9X5et/4hnejuALovnyCRii
 csqfpVsFe4alDlMacozy96jqW/NmGcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775642968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRk5lR55sne5jeooOQNDDCakSRJ1RPJaS7CkfC7bWPo=;
 b=y/IrMD6ldi9OKB5N9cjqgmUJrEuIVUW9fQZL1bTNP8HTvnbGY3BkOK7uQggk9zwhJge/xh
 X4JJlESh4JZjEIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4860A4A0B3;
 Wed,  8 Apr 2026 10:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mWfBEFgp1mlNXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Apr 2026 10:09:28 +0000
Date: Wed, 8 Apr 2026 12:09:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <adYpY4bs4ImMaR1m@yuki.lan>
References: <20260406155008.2216006-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260406155008.2216006-1-pavrampu@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5C9E74E944
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fixed hugeshmat05 Test Failure with 1GB Hugepages.
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

SGkhCj4gTW9kaWZpZWQgdGhlIHRlc3QgdG8gZGV0ZWN0IGxhcmdlIGh1Z2VwYWdlIHNpemVzICji
iaUxR0IpIGFuZCBhZGp1c3QgdGVzdAo+IHNpemVzIGFjY29yZGluZ2x5Lgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IFBhdml0aHJhIDxwYXZyYW1wdUBsaW51eC5pYm0uY29tPgo+IC0tLQo+ICAuLi4vbWVt
L2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA1LmMgICAgICAgfCA0NSArKysrKysrKysrKysr
KystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1h
dC9odWdlc2htYXQwNS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htYXQv
aHVnZXNobWF0MDUuYwo+IGluZGV4IDNiMmFlMzUxYy4uODcwYTYxZWMxIDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA1LmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNS5j
Cj4gQEAgLTM3LDkgKzM3LDEzIEBAIHZvaWQgc2V0dXAodm9pZCkKPiAgewo+ICAJcGFnZV9zaXpl
ID0gZ2V0cGFnZXNpemUoKTsKPiAgCWhwYWdlX3NpemUgPSBTQUZFX1JFQURfTUVNSU5GTygiSHVn
ZXBhZ2VzaXplOiIpICogMTAyNDsKPiArCj4gKwl0c3RfcmVzKFRJTkZPLCAiUGFnZSBzaXplOiAl
bGQgYnl0ZXMiLCBwYWdlX3NpemUpOwo+ICsJdHN0X3JlcyhUSU5GTywgIkh1Z2VwYWdlIHNpemU6
ICVsZCBieXRlcyAoJWxkIE1CKSIsCj4gKwkJaHBhZ2Vfc2l6ZSwgaHBhZ2Vfc2l6ZSAvICgxMDI0
ICogMTAyNCkpOwo+ICB9Cj4gIAo+IC12b2lkIHNobV90ZXN0KGludCBzaXplKQo+ICt2b2lkIHNo
bV90ZXN0KGxvbmcgc2l6ZSkKPiAgewo+ICAJaW50IHNobWlkOwo+ICAJY2hhciAqc2htYWRkcjsK
PiBAQCAtNTYsNyArNjAsNyBAQCB2b2lkIHNobV90ZXN0KGludCBzaXplKQo+ICAJfQo+ICAKPiAg
CXNobWFkZHJbMF0gPSAxOwo+IC0JdHN0X3JlcyhUSU5GTywgImFsbG9jYXRlZCAlZCBodWdlIGJ5
dGVzIiwgc2l6ZSk7Cj4gKwl0c3RfcmVzKFRJTkZPLCAiYWxsb2NhdGVkICVsZCBodWdlIGJ5dGVz
Iiwgc2l6ZSk7Cj4gIAo+ICAJaWYgKHNobWR0KChjb25zdCB2b2lkICopc2htYWRkcikgIT0gMCkg
ewo+ICAJCXNobWN0bChzaG1pZCwgSVBDX1JNSUQsIE5VTEwpOwo+IEBAIC02OSwxNiArNzMsMzkg
QEAgdm9pZCBzaG1fdGVzdChpbnQgc2l6ZSkKPiAgc3RhdGljIHZvaWQgdGVzdF9odWdlc2htYXQo
dm9pZCkKPiAgewo+ICAJdW5zaWduZWQgaW50IGk7Cj4gKwlsb25nIHRzdF9zaXplc1s0XTsKPiAr
Cj4gKwkvKgo+ICsJICogRm9yIGxhcmdlIGh1Z2VwYWdlIHNpemVzIChlLmcuLCAxR0IpLCB3ZSBu
ZWVkIHRvIGVuc3VyZQo+ICsJICogdGVzdCBzaXplcyBhcmUgd2l0aGluIHJlYXNvbmFibGUgYm91
bmRzIGFuZCBwcm9wZXJseSBhbGlnbmVkLgo+ICsJICogVGhlIG9yaWdpbmFsIHRlc3QgdXNlZCBO
KmhwYWdlX3NpemUgd2hpY2ggY291bGQgYmUgNEdCIGZvciAxR0IgcGFnZXMuCj4gKwkgKgo+ICsJ
ICogV2UgYWRqdXN0IHRoZSB0ZXN0IHRvIHVzZSBOLzIgbXVsdGlwbGllciBmb3IgbGFyZ2UgaHVn
ZXBhZ2VzCj4gKwkgKiB0byBhdm9pZCBleGNlc3NpdmUgbWVtb3J5IHJlcXVpcmVtZW50cyB3aGls
ZSBzdGlsbCB0ZXN0aW5nIHRoZQo+ICsJICogYWxpZ25tZW50IGJvdW5kYXJ5IGNvbmRpdGlvbnMg
d2l0aCBtdWx0aXBsZSBwYWdlcy4KPiArCSAqLwo+ICsJaWYgKGhwYWdlX3NpemUgPj0gMTAyNCAq
IDEwMjQgKiAxMDI0KSB7Cj4gKwkJLyogRm9yIDFHQiBvciBsYXJnZXIgaHVnZXBhZ2VzLCB1c2Ug
Ti8yIHBhZ2VzICgyIHBhZ2VzIGZvciBOPTQpICovCj4gKwkJbG9uZyBtdWx0aXBsaWVyID0gTiAv
IDI7CgpUd28gb2J2aW91cyBjb21tZW50cyBmb3IgdGhpcyBpZj8gUmVhbGx5PwoKPiAtCWNvbnN0
IGludCB0c3Rfc2l6ZXNbXSA9IHsKPiAtCQlOICogaHBhZ2Vfc2l6ZSAtIHBhZ2Vfc2l6ZSwKPiAt
CQlOICogaHBhZ2Vfc2l6ZSAtIHBhZ2Vfc2l6ZSAtIDEsCj4gLQkJaHBhZ2Vfc2l6ZSwKPiAtCQlo
cGFnZV9zaXplICsgMQo+IC0JfTsKPiArCQl0c3Rfc2l6ZXNbMF0gPSBtdWx0aXBsaWVyICogaHBh
Z2Vfc2l6ZSAtIHBhZ2Vfc2l6ZTsKPiArCQl0c3Rfc2l6ZXNbMV0gPSBtdWx0aXBsaWVyICogaHBh
Z2Vfc2l6ZSAtIHBhZ2Vfc2l6ZSAtIDE7Cj4gKwkJdHN0X3NpemVzWzJdID0gaHBhZ2Vfc2l6ZTsK
PiArCQl0c3Rfc2l6ZXNbM10gPSBocGFnZV9zaXplICsgMTsKPiArCQl0c3RfcmVzKFRJTkZPLCAi
VXNpbmcgTi8yPSVsZCBodWdlcGFnZSB0ZXN0IHNpemVzIGZvciBsYXJnZSBodWdlcGFnZXMiLCBt
dWx0aXBsaWVyKTsKPiArCX0gZWxzZSB7Cj4gKwkJLyogRm9yIHNtYWxsZXIgaHVnZXBhZ2VzICgy
TUIsIDE2TUIsIGV0Yy4pLCB1c2Ugb3JpZ2luYWwgdGVzdCAqLwo+ICsJCXRzdF9zaXplc1swXSA9
IE4gKiBocGFnZV9zaXplIC0gcGFnZV9zaXplOwo+ICsJCXRzdF9zaXplc1sxXSA9IE4gKiBocGFn
ZV9zaXplIC0gcGFnZV9zaXplIC0gMTsKPiArCQl0c3Rfc2l6ZXNbMl0gPSBocGFnZV9zaXplOwo+
ICsJCXRzdF9zaXplc1szXSA9IGhwYWdlX3NpemUgKyAxOwo+ICsJCXRzdF9yZXMoVElORk8sICJV
c2luZyBOPSVkIGh1Z2VwYWdlIHRlc3Qgc2l6ZXMiLCBOKTsKPiArCX0KClRoaXMgaXMgdWdseS4g
V2h5IGNhbid0IHdlIHNldCBqdXN0IHRoZSBtdWx0aXBsaWVyIGFuZCBpbml0aWFsaXplIHRoZQph
cnJheSBvbmx5IG9uY2U/Cgo+IC0JZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodHN0X3NpemVz
KTsgKytpKQo+ICsJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodHN0X3NpemVzKTsgKytpKSB7
Cj4gKwkJdHN0X3JlcyhUSU5GTywgIlRlc3Rpbmcgc2l6ZTogJWxkIGJ5dGVzIiwgdHN0X3NpemVz
W2ldKTsKClRoaXMgcGF0Y2ggYWRkcyB3YXkgdG9vIG11Y2ggZGVidWdnaW5nIG91dHB1dC4gVGhl
IHNobV90ZXN0IGFscmVhZHkKcHJpbnRzIHRoZSBzaXplLgoKPiAgCQlzaG1fdGVzdCh0c3Rfc2l6
ZXNbaV0pOwo+ICsJfQo+ICAKPiAgCXRzdF9yZXMoVFBBU1MsICJObyByZWdyZXNzaW9uIGZvdW5k
LiIpOwo+ICB9Cj4gLS0gCj4gMi41My4wCj4gCj4gCj4gLS0gCj4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgotLSAKQ3lyaWwgSHJ1YmlzCmNo
cnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
