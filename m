Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908CCA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 15:51:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8795D3CD7D5
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 17:51:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEAE83CA5E4
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 17:50:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E95421000968
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 17:50:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3551460259;
 Wed, 10 Sep 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757519454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CC2H24s6sBSoIhSvu2RZ+eyMjzUAzWeTuPfMduAjkbA=;
 b=ZvegjE12+QbRRav/DjX4W9Zp5qtDuLCmKYiwdGjaRyBjU5g4Oq2xJFuXbk7f7UDQQ2CqnG
 Hn1+nc3A9xHTDG+IrlXFvDo3GoZKSHm873MMShwSA7emoZnv1iRUEeLmEhWdD/fIja/YUC
 Chu08dU7d98OqB8sFh6N05VGhxjj3fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757519454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CC2H24s6sBSoIhSvu2RZ+eyMjzUAzWeTuPfMduAjkbA=;
 b=Eq2Ug7ppc+hIRO9Lvx/jQLWKtvAEbTJ+aBNszZ9g0ulXUSecqpS++j12fay33MO4n5/alZ
 akewdz4fi1Z9qJCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZvegjE12;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Eq2Ug7pp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757519454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CC2H24s6sBSoIhSvu2RZ+eyMjzUAzWeTuPfMduAjkbA=;
 b=ZvegjE12+QbRRav/DjX4W9Zp5qtDuLCmKYiwdGjaRyBjU5g4Oq2xJFuXbk7f7UDQQ2CqnG
 Hn1+nc3A9xHTDG+IrlXFvDo3GoZKSHm873MMShwSA7emoZnv1iRUEeLmEhWdD/fIja/YUC
 Chu08dU7d98OqB8sFh6N05VGhxjj3fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757519454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CC2H24s6sBSoIhSvu2RZ+eyMjzUAzWeTuPfMduAjkbA=;
 b=Eq2Ug7ppc+hIRO9Lvx/jQLWKtvAEbTJ+aBNszZ9g0ulXUSecqpS++j12fay33MO4n5/alZ
 akewdz4fi1Z9qJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26E5213310;
 Wed, 10 Sep 2025 15:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ewBACF6ewWhoPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Sep 2025 15:50:54 +0000
Date: Wed, 10 Sep 2025 17:51:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aMGeffv7V-wbLfCQ@yuki.lan>
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
 <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
 <aLb-uPKS6ZCmpUTc@yuki.lan> <DCOCPDWMUTF5.PXSIFKQYF1IW@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DCOCPDWMUTF5.PXSIFKQYF1IW@suse.com>
X-Rspamd-Queue-Id: 3551460259
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] syscalls: lchown03: Merge into lchown02
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBUcnlpbmcgdG8gcmVzb2x2ZSBlaXRoZXIgb2YgdGhlc2UgZW5kcyB1cCBpbiBFTE9P
UC4KPiAKPiBJIGRvbid0IHRoaW5rIHRoYXQgd2lsbCB3b3JrIGZvciBsY2hvd24sIGZyb20gaXQn
cyBtYW4gcGFnZToKPiAKPiAgICAgICAg4oCiICBsY2hvd24oKSBpcyBsaWtlIGNob3duKCksIGJ1
dCBkb2VzIG5vdCBkZXJlZmVyZW5jZSBzeW1ib2xpYyBsaW5rcy4KPiAKPiBJIGd1ZXNzIHRoZSBv
cmlnaW5hbCBjb2RlIHdvcmtzIGJlY2F1c2UgdGhlIGZpbmFsIGNvbXBvbmVudCBpcyBub3QgYSBs
aW5rLgoKQWgsIHllcywgaXQncyBub3QgYXMgZWFzeSB3aXRoIGxjaG93biBzaW5jZSB0aGUgbGFz
dCBjb21wb25lbnQgbXVzdCBub3QKYmUgYSBsaW5rLCBvdGhlcndpc2UgdGhlIGNhbGwgYWN0cyBv
biB0aGUgbGluay4KCkFuZCB0aGUgb3JpZ2luYWwgY29kZSBjcmVhdGVzIGEgZGlyZWN0b3J5IHRo
YXQgcG9pbnRzIHRvIGl0c2VsZiwgaS5lLgpsb25ncGF0aC9sb25ncGF0aCBwb2ludHMgdG8gLi4v
bG9uZ3BhdGggc28gZWFjaCB0aW1lIGxvbmdwYXRoIGlzCnJlc29sdmVkIGl0IGp1c3QgcmV0dXJu
cyBiYWNrLiBBbmQgd2l0aCB0aGF0IHdlIGNhbiB0cmlnZ2VyIEVMT09QIGJ5CnN0YWNraW5nIGVu
b3VnaCBvZiB0aGVzZSByZWRpcmVjdGlvbnMsIHdoaWNoIGlzIHRoZSByZWFzb24gd2h5IHdlCm1h
bmFnZWQgdG8gZ2V0IHRoYXQuIFdlIHdvdWxkIGdldCB0aGUgc2FtZSByZXN1bHQgaWYgd2Ugc3Rh
Y2tlZCBlbm91Z2gKbGlua3MsIGUuZy4gc3ltbGluaygiYSIsICJiIiksIHN5bWxpbmsoImIiLCAi
YyIpIC4uLiBzeW1saW5rKCJ5IiwgInoiKQphbmQgdGhlbiB0cnlpbmcgdG8gcmVzb2x2ZSAiei9m
aWxlIiB3aGljaCBtYXkgYmUgbGVzcyBjb25mdXNpbmcgdGhhbiB0aGUKZGlyZWN0b3J5IHBvaW50
aW5nIHRvIGl0c2VsZiBtYWdpYy4KCj4gSGVyZSdzIHRoZSBkaWZmIChmYWlscyB3aXRoIEVQRVJN
KToKCkl0IHNob3VsZCBoYXZlIHN1Y2NlZWRlZCB0aG91Z2gsIEkgc3VwcG9zZSB0aGF0IGl0IGZh
aWxzIHdpdGggRVBFUk0KYmVjYXVzZSB5b3UgYWRkZWQgdGhlIGNvZGUgdG8gY3JlYXRlIHRoZSBz
eW1saW5rcyBiZWZvcmUgdGhlIHRlc3QKc3dpdGNoZXMgdG8gdGhlIHRlc3QgdXNlci4KCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAyLmMgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9sY2hvd24wMi5jCj4gaW5kZXggZGIwNjg4
NjVhY2RjLi5kYjhiMjljNjFkMDcgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9sY2hvd24vbGNob3duMDIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bGNob3duL2xjaG93bjAyLmMKPiBAQCAtMzMsNiArMzMsNyBAQAo+ICAjZGVmaW5lIFNGSUxFMiAi
dGVzdGRpcl8xL3NmaWxlXzIiCj4gICNkZWZpbmUgVEZJTEUzICJ0X2ZpbGUiCj4gICNkZWZpbmUg
U0ZJTEUzICJ0X2ZpbGUvc2ZpbGUiCj4gKyNkZWZpbmUgRUZJTEUxICJlbG9vcCIKPiAgI2RlZmlu
ZSBURVNUX0VST0ZTICJtbnRwb2ludCIKPiAgI2RlZmluZSBNQVhQQVRIIChQQVRIX01BWCsyKQo+
ICAKPiBAQCAtNDIsNyArNDMsNyBAQCBzdGF0aWMgY2hhciAqYmFkX2FkZHI7Cj4gIHN0YXRpYyBj
aGFyICptYXhwYXRoOwo+ICBzdGF0aWMgY2hhciAqc2ZpbGUzOwo+ICBzdGF0aWMgY2hhciAqZW1w
dHk7Cj4gLXN0YXRpYyBjaGFyICpsb25ncGF0aDsKPiArc3RhdGljIGNoYXIgKmVsb29wOwo+ICBz
dGF0aWMgY2hhciAqZXJvZnM7Cj4gIHN0YXRpYyBzdHJ1Y3QgcGFzc3dkICpsdHB1c2VyOwo+ICAK
PiBAQCAtNTcsMjAgKzU4LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgdGVzdF9jYXNlX3Qgewo+ICAJeyAm
bWF4cGF0aCwgIlBhdGhuYW1lIHRvbyBsb25nIiwgRU5BTUVUT09MT05HIH0sCj4gIAl7ICZzZmls
ZTMsICJQYXRoIGNvbnRhaW5zIHJlZ3VsYXIgZmlsZSIsIEVOT1RESVIgfSwKPiAgCXsgJmVtcHR5
LCAiUGF0aG5hbWUgaXMgZW1wdHkiLCBFTk9FTlQgfSwKPiAtCXsgJmxvbmdwYXRoLCAiVG9vIG1h
bnkgc3ltbGlua3MiLCBFTE9PUCB9LAo+ICsJeyAmZWxvb3AsICJUb28gbWFueSBzeW1saW5rcyIs
IEVMT09QIH0sCj4gIAl7ICZlcm9mcywgIlJlYWQtb25seSBmaWxlc3lzdGVtIiwgRVJPRlMgfSwK
PiAgfTsKPiAgCj4gIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgaSkKPiAgewo+IC0JdWlk
X3QgdXNlcl9pZDsKPiAtCWdpZF90IGdyb3VwX2lkOwo+ICAJc3RydWN0IHRlc3RfY2FzZV90ICp0
YyA9ICZ0ZXN0X2Nhc2VzW2ldOwo+ICAKPiAtCVVJRDE2X0NIRUNLKCh1c2VyX2lkID0gZ2V0ZXVp
ZCgpKSwgImxjaG93biIpOwo+IC0JR0lEMTZfQ0hFQ0soKGdyb3VwX2lkID0gZ2V0ZWdpZCgpKSwg
ImxjaG93biIpOwo+IC0KPiAtCVRTVF9FWFBfRkFJTChsY2hvd24oKnRjLT5wYXRobmFtZSwgdXNl
cl9pZCwgZ3JvdXBfaWQpLCB0Yy0+ZXhwX2Vycm5vLCAiJXMiLCB0Yy0+ZGVzYyk7Cj4gKwlUU1Rf
RVhQX0ZBSUwobGNob3duKCp0Yy0+cGF0aG5hbWUsIGx0cHVzZXItPnB3X3VpZCwgbHRwdXNlci0+
cHdfZ2lkKSwgdGMtPmV4cF9lcnJubywgIiVzIiwgdGMtPmRlc2MpOwo+ICB9Cj4gIAo+ICBzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKQo+IEBAIC04MCwxNSArNzYsMjEgQEAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiAgCW1lbXNldChtYXhwYXRoLCAnYScsIE1BWFBBVEggLSAxKTsKPiAgCW1heHBh
dGhbTUFYUEFUSC0xXSA9IDA7Cj4gIAo+IC0Jc25wcmludGYobG9uZ3BhdGgsIHNpemVvZihsb25n
cGF0aCksICIuIik7Cj4gLQlTQUZFX01LRElSKCJsb25ncGF0aCIsIDA3NTUpOwo+IC0JU0FGRV9T
WU1MSU5LKCIuLi9sb25ncGF0aCIsICJsb25ncGF0aC9sb25ncGF0aCIpOwo+IC0JZm9yIChpbnQg
aSA9IDA7IGkgPCA0MzsgaSsrKQo+IC0JCXN0cmNhdChsb25ncGF0aCwgIi9sb25ncGF0aCIpOwo+
ICsJLy8gc25wcmludGYobG9uZ3BhdGgsIHNpemVvZihsb25ncGF0aCksICIuIik7Cj4gKwkvLyBT
QUZFX01LRElSKCJsb25ncGF0aCIsIDA3NTUpOwo+ICsJLy8gU0FGRV9TWU1MSU5LKCIuLi9sb25n
cGF0aCIsICJsb25ncGF0aC9sb25ncGF0aCIpOwo+ICsJLy8gZm9yIChpbnQgaSA9IDA7IGkgPCA0
MzsgaSsrKQo+ICsJLy8gCXN0cmNhdChsb25ncGF0aCwgIi9sb25ncGF0aCIpOwo+ICsKPiArCVNB
RkVfU1lNTElOSyhFRklMRTEsICJpbmZpbml0ZV9sb29wIik7Cj4gKwlTQUZFX1NZTUxJTksoImlu
ZmluaXRlX2xvb3AiLCBFRklMRTEpOwo+ICAKPiAgCWx0cHVzZXIgPSBTQUZFX0dFVFBXTkFNKFRF
U1RfVVNFUik7Cj4gIAlTQUZFX1NFVEdJRChsdHB1c2VyLT5wd191aWQpOwo+ICAKPiArCVVJRDE2
X0NIRUNLKGx0cHVzZXItPnB3X3VpZCwgImxjaG93biIpOwo+ICsJR0lEMTZfQ0hFQ0sobHRwdXNl
ci0+cHdfZ2lkLCAibGNob3duIik7Cj4gKwo+ICAJU0FGRV9UT1VDSChURklMRTEsIDA2NjYsIE5V
TEwpOwo+ICAJU0FGRV9TRVRFVUlEKDApOwo+ICAJU0FGRV9TWU1MSU5LKFRGSUxFMSwgU0ZJTEUx
KTsKPiBAQCAtMTE1LDcgKzExNyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsK
PiAgCQl7JnNmaWxlMSwgLnN0ciA9IFNGSUxFMX0sCj4gIAkJeyZzZmlsZTIsIC5zdHIgPSBTRklM
RTJ9LAo+ICAJCXsmc2ZpbGUzLCAuc3RyID0gU0ZJTEUzfSwKPiAtCQl7JmxvbmdwYXRoLCAuc2l6
ZSA9IFBBVEhfTUFYfSwKPiArCQl7JmVsb29wLCAuc3RyID0gRUZJTEUxfSwKPiAgCQl7JmVtcHR5
LCAuc3RyID0gIiJ9LAo+ICAJCXsgJmVyb2ZzLCAuc3RyID0gVEVTVF9FUk9GUyB9LAo+ICAJCXt9
Cj4gCj4gCgotLSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
