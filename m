Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3D9C48297
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37F73CF5D8
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 16:59:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F873CC559
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 16:59:18 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8518110124CB
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 16:59:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D45F1FB70;
 Tue,  6 Feb 2024 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707235156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cy5qxOz2S3SpnrkRi2TOGR/vWf1v7S+amHgPItMfzbA=;
 b=nQSE0RCLhgdNALu6OYM2+uxzcTF50gk8VOMh22M4a0RaV3f72M88LjKDtAjo9iNBRuifnh
 mI79UUk4wqqLlTSLQGpS9pGEp/srMKinzp2brb7l/Kiqf+ctPKeOGtbXjij53bT8I6D6a6
 7Sr6sfCEF55G3LD7n3r77/ojhVpIuck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707235156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cy5qxOz2S3SpnrkRi2TOGR/vWf1v7S+amHgPItMfzbA=;
 b=dZbtuUAlUQeI/c/uxlpAvPGz6df8MrBr0Ie4L+bGCiERgBghYBNFNHl6VH+Wuvufje214c
 yW4Lfy6sNQC8YPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707235156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cy5qxOz2S3SpnrkRi2TOGR/vWf1v7S+amHgPItMfzbA=;
 b=nQSE0RCLhgdNALu6OYM2+uxzcTF50gk8VOMh22M4a0RaV3f72M88LjKDtAjo9iNBRuifnh
 mI79UUk4wqqLlTSLQGpS9pGEp/srMKinzp2brb7l/Kiqf+ctPKeOGtbXjij53bT8I6D6a6
 7Sr6sfCEF55G3LD7n3r77/ojhVpIuck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707235156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cy5qxOz2S3SpnrkRi2TOGR/vWf1v7S+amHgPItMfzbA=;
 b=dZbtuUAlUQeI/c/uxlpAvPGz6df8MrBr0Ie4L+bGCiERgBghYBNFNHl6VH+Wuvufje214c
 yW4Lfy6sNQC8YPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B09B132DD;
 Tue,  6 Feb 2024 15:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HzQzCFRXwmWMagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 15:59:16 +0000
Date: Tue, 6 Feb 2024 16:59:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240206155914.GA3400@pevik>
References: <20231029012755.19969-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231029012755.19969-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nQSE0RCL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dZbtuUAl
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D45F1FB70
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] io_submit04: Add test case for RWF_NOWAIT flag
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

SGkgV2VpLAoKPiBGaXhzOiAjNDY3CkZpeGVzOiAjNDY3CgorKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lvX3N1Ym1pdC9NYWtlZmlsZQpAQCAtNiw1ICs2LDYgQEAgdG9wX3NyY2RpciAg
ICAgICAgICAgICAgPz0gLi4vLi4vLi4vLi4KIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRl
L21rL3Rlc3RjYXNlcy5tawogCiBMRExJQlMgICAgICAgICAgICAgICAgICs9ICQoQUlPX0xJQlMp
CgpCVFcgT25seSBpb19zdWJtaXQwMS5jIHVzZXMgbGliYWlvLCBidXQgYWxsIGZpbGVzIGFyZSBs
aW5rZWQgYWdhaW5zdCAtbGFpbwpiZWNhdXNlIE1ha2VmaWxlIGRvZXMgbm90IHByZWZpeCB0aGF0
IHNldHVwIHdpdGggaW9fc3VibWl0MDEuCgorTERGTEFHUyAgICAgICAgICAgICAgICAgICAgICAg
ICs9IC1wdGhyZWFkCgpTbyBmb3IgdGhlIHNhbWUgcmVhc29uIEkgd291bGQgcHJlZml4IHRoaXMg
Zm9yIHRoaXMgdGVzdCBvbmx5Ogppb19zdWJtaXQwNDoJTERGTEFHUwkrPSAtcHRocmVhZAouLi4K
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3N1Ym1pdC9pb19zdWJtaXQwNC5j
Cj4gQEAgLTAsMCArMSwxNzggQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb3ItbGF0ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDIzIFdlaSBHYW8gPHdlZ2Fv
QHN1c2UuY29tPgo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAqCj4g
KyAqIFNpbWlsYXJpbHkgdG8gdGhlIHByZWFkdjIsIHRoaXMgaXMgYSBiYXNpYyB0ZXN0IGZvciBp
b19zdWJtaXQKcy9TaW1pbGFyaWx5L1NpbWlsYXJseS8KCkJ1dCBJIHdvdWxkIHJlbW92ZSAiU2lt
aWxhcmlseSB0byB0aGUgcHJlYWR2MiIKCj4gKyAqIFJXRl9OT1dBSVQgZmxhZywgd2UgYXJlIGF0
dGVtcHRpbmcgdG8gZm9yY2UgaW9fc3VibWl0IHJldHVybgo+ICsgKiBFQUdBSU4gd2l0aCB0aHJl
YWQgY29uY3VyZW50bHkgcnVubmluZyB0aHJlYWRzLgo+ICsgKgpuaXQ6IGVtcHR5IGJsYW5rIGxp
bmUuCj4gKyAqLwoKLi4uCj4gK3N0YXRpYyB2b2lkICp3cml0ZXJfdGhyZWFkKHZvaWQgKnVudXNl
ZCkKPiArewo+ICsJd2hpbGUgKCFzdG9wKQo+ICsJCXdyaXRlX3Rlc3QoKTsKPiArCj4gKwlyZXR1
cm4gdW51c2VkOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBkcm9wX2NhY2hlcyh2b2lkKQo+ICt7
Cj4gKwlTQUZFX0ZJTEVfUFJJTlRGKCIvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMiLCAiMyIpOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCAqY2FjaGVfZHJvcHBlcih2b2lkICp1bnVzZWQpCj4gK3sK
PiArCXVuc2lnbmVkIGludCBkcm9wX2NudCA9IDA7Cj4gKwo+ICsJd2hpbGUgKCFzdG9wKSB7Cj4g
KwkJZHJvcF9jYWNoZXMoKTsKPiArCQlkcm9wX2NudCsrOwo+ICsJfQo+ICsKPiArCXRzdF9yZXMo
VElORk8sICJDYWNoZSBkcm9wcGVkICV1IHRpbWVzIiwgZHJvcF9jbnQpOwo+ICsKPiArCXJldHVy
biB1bnVzZWQ7Cj4gK30KPiArCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgaW9fc3VibWl0KHZvaWQp
Cj4gK3sKPiArCXN0cnVjdCBpb19ldmVudCBldmJ1ZjsKPiArCXN0cnVjdCB0aW1lc3BlYyB0aW1l
b3V0ID0geyAudHZfc2VjID0gMSB9OwoKPiArCj4gKwlUU1RfRVhQX1ZBTF9TSUxFTlQodHN0X3N5
c2NhbGwoX19OUl9pb19zdWJtaXQsIGN0eCwgMSwgaW9jYnMpLCAxKTsKCkl0IGZhaWxzIHdpdGgg
RU9QTk9UU1VQUCBvbiBUTVBESVIgb24gdG1wZnMgKGUuZy4gb24gVHVtYmxld2VlZCkuCgojIC4v
aW9fc3VibWl0MDQKLi4uCnRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMg
aXMgbm90IG5lZWRlZCBmb3IgdG1wZnMKdHN0X3Rlc3QuYzoxNzAxOiBUSU5GTzogPT09IFRlc3Rp
bmcgb24gZXh0MiA9PT0KdHN0X3Rlc3QuYzoxMTE3OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xv
b3AwIHdpdGggZXh0MiBvcHRzPScnIGV4dHJhIG9wdHM9JycKbWtlMmZzIDEuNDcuMCAoNS1GZWIt
MjAyMykKdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0byAvdG1w
L0xUUF9pb19iaG90TVIvbW50cG9pbnQgZnN0eXA9ZXh0MiBmbGFncz0wCmlvX3N1Ym1pdDA0LmM6
ODU6IFRGQUlMOiB0c3Rfc3lzY2FsbChfX05SX2lvX3N1Ym1pdCwgY3R4LCAxLCBpb2NicykgcmV0
dmFsIC0xICE9IDE6IEVPUE5PVFNVUFAgKDk1KQoKaW9fc3VibWl0MDQuYzo4NzogVEZBSUw6IHRz
dF9zeXNjYWxsKF9fTlJfaW9fZ2V0ZXZlbnRzLCBjdHgsIDEsIDEsICZldmJ1ZiwgJnRpbWVvdXQp
IHJldHZhbCAwICE9IDE6IFNVQ0NFU1MgKDApCmlvX3N1Ym1pdDA0LmM6ODU6IFRGQUlMOiB0c3Rf
c3lzY2FsbChfX05SX2lvX3N1Ym1pdCwgY3R4LCAxLCBpb2NicykgcmV0dmFsIC0xICE9IDE6IEVP
UE5PVFNVUFAgKDk1KQppb19zdWJtaXQwNC5jOjg3OiBURkFJTDogdHN0X3N5c2NhbGwoX19OUl9p
b19nZXRldmVudHMsIGN0eCwgMSwgMSwgJmV2YnVmLCAmdGltZW91dCkgcmV0dmFsIDAgIT0gMTog
U1VDQ0VTUyAoMCkKaW9fc3VibWl0MDQuYzo4NTogVEZBSUw6IHRzdF9zeXNjYWxsKF9fTlJfaW9f
c3VibWl0LCBjdHgsIDEsIGlvY2JzKSByZXR2YWwgLTEgIT0gMTogRU9QTk9UU1VQUCAoOTUpCmlv
X3N1Ym1pdDA0LmM6ODc6IFRGQUlMOiB0c3Rfc3lzY2FsbChfX05SX2lvX2dldGV2ZW50cywgY3R4
LCAxLCAxLCAmZXZidWYsICZ0aW1lb3V0KSByZXR2YWwgMCAhPSAxOiBTVUNDRVNTICgwKQoKRmly
c3QsIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gcXVpdCB0aGlzIGZpbGVzeXN0ZW0gdGVzdCBvbiBm
aXJzdCBlcnJvciwgYmVjYXVzZQppdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIHJ1biB0ZXN0IDEw
MHggd2hlbiBpdCBmYWlscy4gQnV0IHRoYXQgd2lsbCBuZWVkIHRvCnJlZGVzaWduIHdheSBob3cg
eW91IHRlc3QgaXQsIG90aGVyd2lzZSBjbGVhbnVwIGJyZWFrcy4KCldoeT8gQmVjYXVzZSAubW50
cG9pbnQgPSBNTlRQT0lOVCBkb2VzIG5vdCBtZWFuIGl0IHdpbGwgY2QgaW50byB0aGUgZGlyZWN0
b3J5LgoKWW91IG5lZWQgdG8gYWRkOgoJU0FGRV9DSERJUihNTlRQT0lOVCk7CgooVGhpcyBuZWVk
IGlzIGEgYml0IGNvbmZ1c2luZywgSSBkb24ndCByZW1lbWJlciB0aGUgcmVhc29uIHdoeSB0ZXN0
IGRvZXMgbm90IGRvIGl0LikKCkFuZCBpZiB5b3UgYWRkIGl0LCB5b3UgZmluZHMgdGhhdCBpdCBm
YWlscyBvbiB2YXJpb3VzIGZpbGVzeXN0ZW1zLCB5b3UgbmVlZCB0bwphZGQ6CgoJLnNraXBfZmls
ZXN5c3RlbXMgPSAoY29uc3QgY2hhciAqY29uc3RbXSkgewoJCSJ2ZmF0IiwKCQkiZXhmYXQiLAoJ
CSJudGZzIiwKCQkidG1wZnMiLAoJCU5VTEwKCX0sCgpNYXliZSBldmVuIGZ1c2Ugd291bGQgYmUg
cHJvYmxlbWF0aWMsIGJ1dCBub3Qgc3VyZSAob24gbXkgc3lzdGVtIG50ZnMgd2FzCmFjdHVhbGx5
IHRlc3RlZCB2aWEgZnVzZSkuCgpBbmQgbWFrZSBjaGVjayB3YXJuaW5nOgoKJCBtYWtlIGNoZWNr
LWlvX3N1Ym1pdDA0CkNIRUNLIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fc3VibWl0L2lv
X3N1Ym1pdDA0LmMKaW9fc3VibWl0MDQuYzo2MzogV0FSTklORzogUHJlZmVyIHVzaW5nICciJXMu
Li4iLCBfX2Z1bmNfXycgdG8gdXNpbmcgJ2Ryb3BfY2FjaGVzJywgdGhpcyBmdW5jdGlvbidzIG5h
bWUsIGluIGEgc3RyaW5nCm1ha2U6IFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjU2
OiBjaGVjay1pb19zdWJtaXQwNF0gRXJyb3IgMSAoaWdub3JlZCkKCj4gKwo+ICsJVFNUX0VYUF9W
QUxfU0lMRU5UKHRzdF9zeXNjYWxsKF9fTlJfaW9fZ2V0ZXZlbnRzLCBjdHgsIDEsIDEsICZldmJ1
ZiwKPiArCQkJJnRpbWVvdXQpLCAxKTsKPiArCj4gKwlpZiAoZXZidWYucmVzID09IC1FQUdBSU4p
Cj4gKwkJcmV0dXJuIDE7Cj4gKwllbHNlCj4gKwkJcmV0dXJuIDA7Cm5pdDogcmV0dXJuIGV2YnVm
LnJlcyA9PSAtRUFHQUlOCj4gK30KLi4uCgo+ICtzdGF0aWMgaW5saW5lIHZvaWQgaW9fcHJlcF9v
cHRpb24oc3RydWN0IGlvY2IgKmNiLCBpbnQgZmQsIHZvaWQgKmJ1ZiwKPiArCQkJc2l6ZV90IGNv
dW50LCBsb25nIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBpbnQgb3Bjb2RlKQo+ICt7Cj4gKwltZW1z
ZXQoY2IsIDAsIHNpemVvZigqY2IpKTsKPiArCWNiLT5haW9fZmlsZGVzID0gZmQ7Cj4gKwljYi0+
YWlvX2xpb19vcGNvZGUgPSBvcGNvZGU7Cj4gKwljYi0+YWlvX2J1ZiA9ICh1aW50NjRfdClyX2J1
ZjsKCkNvbXBpbGUgd2FybmluZyAoSSBndWVzcyBpdCdzIG5vdCBhIGZpcnN0IHRpbWUgSSBhc2sg
dG8gcGF5IGF0dGVudGlvbiB0byB0aGUKY29tcGlsZSB3YXJuaW5ncyk6Cgppb19zdWJtaXQwNC5j
OiBJbiBmdW5jdGlvbiDigJhpb19wcmVwX29wdGlvbuKAmToKaW9fc3VibWl0MDQuYzozNTo2Njog
d2FybmluZzogdW51c2VkIHBhcmFtZXRlciDigJhidWbigJkgWy1XdW51c2VkLXBhcmFtZXRlcl0K
ICAgMzUgfCBzdGF0aWMgaW5saW5lIHZvaWQgaW9fcHJlcF9vcHRpb24oc3RydWN0IGlvY2IgKmNi
LCBpbnQgZmQsIHZvaWQgKmJ1ZiwKCj0+IG1heWJlIHVzZSBhY3R1YWxseSB0aGUgcGFyYW1ldGVy
IGJ1ZiwgaW5zdGVhZCBvZiB1c2luZyB0aGUgc3RhdGljIHJfYnVmPwoJY2ItPmFpb19idWYgPSAo
dWludDY0X3QpYnVmOwoKT3IsIHlvdSBtYXkganVzdCByZW1vdmUgdm9pZCAqYnVmLCBhcyByX2J1
ZiBpcyBzdGF0aWMgYW55d2F5IGFuZCB1c2VkIGluIHRoZQpzZXR1cC4KCj4gKwljYi0+YWlvX29m
ZnNldCA9IG9mZnNldDsKPiArCWNiLT5haW9fbmJ5dGVzID0gY291bnQ7Cj4gKwljYi0+YWlvX3J3
X2ZsYWdzID0gUldGX05PV0FJVDsKPiArfQo+ICsKLi4uCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gK3sKPiArCm5pdDogZW1wdHkgbGluZSBeCj4gKwlUU1RfRVhQX1BBU1NfU0lMRU5UKHRz
dF9zeXNjYWxsKF9fTlJfaW9fc2V0dXAsIDEsICZjdHgpKTsKSSBndWVzcyB0aGlzIHNob3VsZCB0
c3RfYnJrKCkgaWYgZmFpbGVkLCByaWdodD8KClRoZXJlZm9yZSBqdXN0OgppZiAoIXRzdF9zeXNj
YWxsKF9fTlJfaW9fc2V0dXAsIDEsICZjdHgpKQoJdHN0X2JyayhUQlJPSywgLi4uKTsKCj4gKwo+
ICsJZmQgPSBTQUZFX09QRU4oVEVTVF9GSUxFLCBPX1JEV1IgfCBPX0NSRUFULCBNT0RFKTsKPiAr
Cj4gKwltZW1zZXQod19idWYsICdhJywgQlVGX0xFTik7Cj4gKwltZW1zZXQocl9idWYsICdiJywg
QlVGX0xFTik7Cj4gKwo+ICsJaW9fcHJlcF9vcHRpb24oJmlvY2IsIGZkLCByX2J1ZiwgQlVGX0xF
TiwgMCwgSU9DQl9DTURfUFJFQUQpOwpOT1RFOiBIZXJlIHlvdSBwYXNzIHJfYnVmCgo+ICt9Cj4g
Kwo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gK3sKPiArCWlmIChmZCA+IDApCj4gKwkJ
U0FGRV9DTE9TRShmZCk7Cj4gKwo+ICsJaWYgKHRzdF9zeXNjYWxsKF9fTlJfaW9fZGVzdHJveSwg
Y3R4KSkKPiArCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAiaW9fZGVzdHJveSgpIGZhaWxlZCIp
OwpNYXliZSBqdXN0IHRzdF9yZXMoVFdBUk4gfCBURVJSTk8sIC4uLikgYmVjYXVzZSBpdCdzIGlu
IGEgY2xlYW51cCBmdW5jdGlvbj8KPiArfQo+ICsKPiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2b2lk
KQo+ICt7Cj4gKwo+ICsJcHRocmVhZF90IHJlYWRlciwgZHJvcHBlciwgd3JpdGVyOwo+ICsJdm9p
ZCAqZWFnYWluczsKPiArCj4gKwlzdG9wID0gMDsKPiArCj4gKwlTQUZFX1BUSFJFQURfQ1JFQVRF
KCZkcm9wcGVyLCBOVUxMLCBjYWNoZV9kcm9wcGVyLCBOVUxMKTsKPiArCVNBRkVfUFRIUkVBRF9D
UkVBVEUoJnJlYWRlciwgTlVMTCwgbm93YWl0X3JlYWRlciwgTlVMTCk7Cj4gKwlTQUZFX1BUSFJF
QURfQ1JFQVRFKCZ3cml0ZXIsIE5VTEwsIHdyaXRlcl90aHJlYWQsIE5VTEwpOwo+ICsKPiArCXdo
aWxlICghc3RvcCAmJiB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSkKPiArCQl1c2xlZXAoMTAwMDAw
KTsKPiArCj4gKwlzdG9wID0gMTsKSSdtIG5vdCByZWFsbHkgc3VyZSBhYm91dCB0aGlzIHN0b3Ag
PSAxIHNldHVwLCB3aGljaCBpcyBkb25lIGFsc28gb24Kbm93YWl0X3JlYWRlcigpLiBUaGlzIGlz
IHByb2JhYmx5IG9idmlvdXMgdG8gdGhlIG90aGVyIHJldmlld2Vycy4KCj4gKwo+ICsJU0FGRV9Q
VEhSRUFEX0pPSU4ocmVhZGVyLCAmZWFnYWlucyk7Cj4gKwlTQUZFX1BUSFJFQURfSk9JTihkcm9w
cGVyLCBOVUxMKTsKPiArCVNBRkVfUFRIUkVBRF9KT0lOKHdyaXRlciwgTlVMTCk7Cj4gKwo+ICsJ
aWYgKGVhZ2FpbnMpCj4gKwkJdHN0X3JlcyhUUEFTUywgIkdvdCBzb21lIEVBR0FJTiIpOwo+ICsJ
ZWxzZQo+ICsJCXRzdF9yZXMoVEZBSUwsICJIYXZlbid0IGdvdCBFQUdBSU4iKTsKPiArCj4gK30K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
