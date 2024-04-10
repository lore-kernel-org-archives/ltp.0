Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6AACD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 09:46:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7177B3C60FA
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 11:46:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90B453C60FA
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:46:25 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AACD020023F
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:46:24 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3A8334DD5;
 Wed, 10 Apr 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B80F413A92;
 Wed, 10 Apr 2024 09:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id LlNdK+5fFmZzYwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Apr 2024 09:46:22 +0000
Date: Wed, 10 Apr 2024 11:46:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240410094621.GA184706@pevik>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
 <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
 <20240409101753.GA107959@pevik> <ZhZcL9cH5bVDWL_k@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhZcL9cH5bVDWL_k@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F3A8334DD5
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKPiA+ID4gPiA+IC0JaWYgKHJldCA9PSAtMSkKPiA+ID4gPiA+ICsJaWYgKHJldCAhPSAw
KSB7Cj4gPiA+ID4gPiArCQlpZiAoZXJybm8gPT0gRU9QTk9UU1VQUCB8fCBlcnJubyA9PSBFTk9T
WVMpIHsKPiA+ID4gPiA+ICsJCQl0c3RfYnJrKFRDT05GLAo+ID4gPiA+ID4gKwkJCQkiZmFsbG9j
YXRlIHN5c3RlbSBjYWxsIGlzIG5vdCBpbXBsZW1lbnRlZCIpOwo+ID4gPiA+ID4gKwkJfQo+ID4g
PiA+ID4gICAJCXRzdF9icmsoVEJST0ssICJmYWxsb2NhdGUoKSBmYWlsZWQiKTsKPiA+ID4gPiA+
ICsJCXJldHVybjsKCj4gPiBJIHN1Z2dlc3QgdG8gbWVyZ2UgdGhpcyBub3csIHdpdGhvdXQgcmV0
dXJuIChpdCBjYW4gYmUgcmVtb3ZlZCBiZWZvcmUgbWVyZ2UpLgo+ID4gUmV2aWV3ZWQtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiBTaG91bGRuJ3Qgd2UgbGltaXQgdGhpcyBvbmx5
IHRvIG5mcywgdG8gbWFrZSBzdXJlIHRoYXQgZmFsbG9jYXRlKCkgaXMKPiBub3QgYWNjaWRlbnRh
bGx5IGRpc2FibGVkIG9uIG90aGVyIGZpbGVzeXN0ZW1zPyBBdCBsZWFzdCB0aGF0IHdoYXQgSQo+
IHN1Z2dlc3RlZCB3aGVuIEkgcmVwbGllZCB0byB0aGUgcGF0Y2guCgpUaGF0J3Mgd2hhdCBJIGFs
c28gbWVhbnQgYnkgbXkgZWFybGllciBzdWdnZXN0aW9uIChvciwgYmV0dGVyIEkgd2FzIG5vdCBz
dXJlCm15c2VsZiBpZiBpdCdzIG5lZWRlZCkuIEkgd291bGQgdm90ZSBmb3IgdGhpcyBjaGVjay4g
QnV0IHNpbmNlIHdlIGFscmVhZHkgaGF2ZQp0aGlzIHByb2JsZW0gaW4gb3RoZXIgZmlsZXMsIEkg
d291bGQgYmUgb2sgdG8gbWVyZ2UgdGhpcyBmaXJzdCBhbmQgaGFuZGxlCnByb3BlciBmaXggYXMg
YSBzZXBhcmF0ZSBhcHByb2FjaCBpZiBTYW1hc3RoIGRvZXMgbm90IGhhdmUgdGltZSB0byBzb2x2
ZSBpdApoaW1zZWxmLiBAU2FtYXN0aCBXRFlUPwoKVGhlIHNvbHV0aW9uIHdvdWxkIGJlIHRvIGF0
IGxlYXN0IGNoZWNrIGZvciB0c3RfZnNfdHlwZSgiLiIpID09IFRTVF9ORlNfTUFHSUMuClBlcmZl
Y3Qgc29sdXRpb24gd291bGQgSU1ITyBiZSB0byBjaGVjayBmb3IgTkZTIHZlcnNpb24gKGUuZy4g
aW4gL3Byb2MvbW91bnRzKQphbmQgVENPTkYgb25seSBvbiBORlN2My4KCkJUVyBXaGVuIEkgZmly
c3QgcmVhZCBtYW4gZmFsbG9jYXRlKDIpLCBJIGludGVycHJldGVkIGZvbGxvd2luZyBub3RlIHJl
bGF0ZWQgdG8KRkFMTE9DX0ZMX1BVTkNIX0hPTEUgYWJvdXQgZ2VuZXJhbCBmYWxsb2NhdGUoKSBz
dXBwb3J0OgoKCU5vdCBhbGwgZmlsZXN5c3RlbXMgc3VwcG9ydCBGQUxMT0NfRkxfUFVOQ0hfSE9M
RTsgaWYgYSBmaWxlc3lzdGVtIGRvZXNuJ3QKCXN1cHBvcnQgdGhlIG9wZXJhdGlvbiwgYW4gZXJy
b3IgaXMgcmV0dXJuZWQuICBUaGUgb3BlcmF0aW9uIGlzIHN1cHBvcnRlZCBvbiBhdAoJbGVhc3Qg
dGhlIGZvbGxvd2luZyBmaWxlc3lzdGVtczoKCgnigKIgIFhGUyAoc2luY2UgTGludXggMi42LjM4
KQoJ4oCiICBleHQ0IChzaW5jZSBMaW51eCAzLjApCgnigKIgIEJ0cmZzIChzaW5jZSBMaW51eCAz
LjcpCgnigKIgIHRtcGZzKDUpIChzaW5jZSBMaW51eCAzLjUpCgnigKIgIGdmczIoNSkgKHNpbmNl
IExpbnV4IDQuMTYpCgpTb21lIG9mIHRoZSB0ZXN0cyB3aGljaCBhcmUgdXNpbmcgZmFsbG9jYXRl
KCkgaW5kZWVkIHRlc3QgRkFMTE9DX0ZMX1BVTkNIX0hPTEU6CgokIGdpdCBncmVwIC1sIEZBTExP
Q19GTF9QVU5DSF9IT0xFIHRlc3RjYXNlcy8KdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9o
dWdlZmFsbG9jYXRlL2h1Z2VmYWxsb2NhdGUwMS5jCnRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0
bGIvaHVnZWZhbGxvY2F0ZS9odWdlZmFsbG9jYXRlMDIuYwp0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwNC5jCnRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFs
bG9jYXRlL2ZhbGxvY2F0ZTA1LmMKdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUv
ZmFsbG9jYXRlMDYuYwp0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21lbWZkX2NyZWF0ZS9tZW1m
ZF9jcmVhdGVfY29tbW9uLmMKCmFuZCBvdGhlcnMgbm90LCBlLmcuOgp0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwWzEtM10uYwp0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21yZW1hcC9tcmVtYXAwNi5jICh3aGljaCBkb2VzIG5vdCBjaGVjayBlcnJubyBhdCBh
bGwsCmxpa2VseSBub3QgbmVlZGVkKS4KClRoZXJlZm9yZSBhbHNvIGNoZWNrIGZvciBGQUxMT0Nf
RkxfUFVOQ0hfSE9MRSB3b3VsZCBiZSBuZWVkZWQgKGluIGFkZGl0aW9uIHRvCmFsbCBORlMgb3Ig
TkZTdjMpLgoKQlRXIHRoZSBtYW4gcGFnZSBkb2VzIG5vdCBtZW50aW9uIE5GUyBhdCBhbGwuIEBT
YW1hc3RoIHdvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhCnBhdGNoIHRvIGxpbnV4LW1hbiBNTD8KCktp
bmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
