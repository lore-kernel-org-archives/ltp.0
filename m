Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74980C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 10:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF78C3CD88A
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 11:56:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 080343C2A67
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 11:56:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE8ED2002D8
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 11:56:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2593720022;
 Thu,  9 Mar 2023 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678359389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUr6sYzqTG8uoOxwMxTHn+fXr/iQuaVvS38w0b/nlrA=;
 b=L3Vk19tGwnsBOvBl6nwTHhomjt/pX6lhaYf4ZkDdtYmh3snoqb+QFRlQjTp0eH2wCiabVd
 3pi8tUusvy2wqad8t488GiBJGgjbAMDCYM8/VEs5VWUhpdSub7wj1K9vXwJ35DVDyUGSxQ
 DdoV7xPVRb+sEtSM3jysgFcdjJYcFbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678359389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUr6sYzqTG8uoOxwMxTHn+fXr/iQuaVvS38w0b/nlrA=;
 b=sHwLqk9TnC7juDV4E5qhw2SSG5AiSTdDLlfHpBKARUrA3Z6IlH8CS8haNSJgL8F7bSVJsu
 xlisgrMKaMPdyuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6D1213A10;
 Thu,  9 Mar 2023 10:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qhM0L1y7CWRIPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Mar 2023 10:56:28 +0000
Date: Thu, 9 Mar 2023 11:56:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230309105627.GA10008@pevik>
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/yTyk9rYYsPJyVA@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKWyBDYyBMaSAtIHF1ZXN0aW9uIGZyb20gQ3lyaWwgYXQgdGhlIGVuZCBdCgpGYWJy
aWNlLCB0aGFua3MgZm9yIGZpeGluZyB0aGlzIGxvbmcgc3RhbmRpbmcgaXNzdWUuCgo+IEhpIQo+
ID4gQ29tbWl0IGI4NTdmODcyM2YzMGE0Yjk1NTRiZjZiMGZmOGZhNTJmZDA3ZThiNjAgdHJpZWQg
dG8gZml4IGJ1aWxkIHdpdGgKPiA+IGxhdGVzdCBnbGliYyB3aGljaCBwcm92aWRlcyBtb3VudF9h
dHRyIGluIHN5cy9tb3VudC5oLiBVbmZvcnR1bmF0ZWx5LAo+ID4gdGhlIGZvbGxvd2luZyBidWls
ZCBmYWlsdXJlIGlzIHN0aWxsIHJhaXNlZCBiZWNhdXNlIHN5cy9tb3VudCBpcyBub3cKPiA+IHVu
Y29uZGl0aW9uYWxseSBpbmNsdWRlZCBpbiBpbmNsdWRlL2xhcGkvZnNtb3VudC5oOgoKPiA+IElu
IGZpbGUgaW5jbHVkZWQgZnJvbSBmc2NvbmZpZzAxLmM6OToKPiA+IC4uLy4uLy4uLy4uL2luY2x1
ZGUvbGFwaS9mc21vdW50Lmg6NTU6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiAnc3RydWN0IG1v
dW50X2F0dHInCj4gPiAgICA1NSB8IHN0cnVjdCBtb3VudF9hdHRyIHsKPiA+ICAgICAgIHwgICAg
ICAgIF5+fn5+fn5+fn4KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi8uLi8uLi8uLi9pbmNs
dWRlL2xhcGkvZnNtb3VudC5oOjE0Ogo+ID4gL2hvbWUvYXV0b2J1aWxkL2F1dG9idWlsZC9pbnN0
YW5jZS00L291dHB1dC0xL2hvc3QvYXJtZWItYnVpbGRyb290LWxpbnV4LWdudWVhYmkvc3lzcm9v
dC91c3IvaW5jbHVkZS9zeXMvbW91bnQuaDoyMTA6ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVk
IGhlcmUKPiA+ICAgMjEwIHwgc3RydWN0IG1vdW50X2F0dHIKPiA+ICAgICAgIHwgICAgICAgIF5+
fn5+fn5+fn4KCj4gPiBGaXhlczoKPiA+ICAtIGh0dHA6Ly9hdXRvYnVpbGQuYnVpbGRyb290Lm9y
Zy9yZXN1bHRzLzRkYmI3MmUxYmYwODFhZmQzY2Q5NDQ1NzFiOWJlZWVmYzc2MDg4NjUKCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEZvbnRhaW5lIDxmb250YWluZS5mYWJyaWNlQGdtYWlsLmNv
bT4KPiA+IC0tLQo+ID4gIGNvbmZpZ3VyZS5hYyB8IDYgKysrLS0tCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCj4gPiBkaWZmIC0tZ2l0IGEvY29u
ZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCj4gPiBpbmRleCBjMmIwZjQ4ZTcuLmE2ZDhhYzgyNiAx
MDA2NDQKPiA+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+ID4gKysrIGIvY29uZmlndXJlLmFjCj4gPiBA
QCAtMjI1LDEwICsyMjUsMTAgQEAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBfX2tlcm5lbF9vbGRf
dGltZXZhbCwgc3RydWN0IF9fa2VybmVsX29sZF90aW1lc3BlYywgc3RydWMKCj4gPiAgQUNfQ0hF
Q0tfVFlQRVMoW3N0cnVjdCBmdXRleF93YWl0dl0sLCxbI2luY2x1ZGUgPGxpbnV4L2Z1dGV4Lmg+
XSkKPiA+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IG1vdW50X2F0dHJdLCwsWwo+ID4gLSNpZmRl
ZiBIQVZFX0xJTlVYX01PVU5UX0gKPiA+IC0jIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+Cj4gPiAt
I2Vsc2UKPiA+ICsjaWZkZWYgSEFWRV9NT1VOVF9TRVRBVFRSCj4gPiAgIyBpbmNsdWRlIDxzeXMv
bW91bnQuaD4KPiA+ICsjZWxpZiBIQVZFX0xJTlVYX01PVU5UX0gKPiA+ICsjIGluY2x1ZGUgPGxp
bnV4L21vdW50Lmg+Cj4gPiAgI2VuZGlmCj4gPiAgXSkKCj4gSSB3b25kZXIgaWYgd2UgY2FuIGdl
dCB0aGlzIHdob2xlIG1lc3Mgb2YgdHdvIGRpZmZlcmVudCBmYWxsYmFjayBoZWFkZXJzCj4gc2lt
cGxpZmllZC4gTG9va2luZyBhdCB0aGUgZ2xpYmMgaW1wbGVtZW50YXRpb24gaXQgc2VlbXMgdG8g
aW5jbHVkZQo+ICJsaW51eC9tb3VudC5oIiBpZiBpdCBkb2VzIGV4aXN0LiBTbyBtb3N0IHJlYXNv
bmFibGUgc29sdXRpb24gd291bGQgZG8KPiB0aGUgc2FtZSBJIGd1ZXNzIHdoaWNoIHdlIGRpZCBi
ZWZvcmUgdGhlIGNvbW1pdCB5b3UgcmVmZXJlbmNlLgoKPiBATGkgV2FuZyB3aGVyZSBkb2VzIHRo
ZSB0aGUgc3lzL21vdW50LmggYW5kIGxpbnV4L21vdW50LmggY29uZmxpY3Q/IEFzCj4gZmFyIGFz
IEkgY2FuIHRlbGwgdGhlIFVBUEkgbGludXgvbW91bnQuaCBuZXZlciBkZWZpbmVkIGFueSBmdW5j
dGlvbnMsCj4ganVzdCBjb25zdGFudHMsIHdoaWNoIHNob3VsZCBiZSBzb2x2YWJsZSB3aXRob3V0
IHRoZSBjb21wbGV4IGlmZGVmcywgd2UKPiBqdXN0IG5lZWQgdG8gY2hlY2sgZm9yIGV4aXN0ZW5j
ZSBvZiB0aGUgdHlwZXMgYW5kIGRlZmluZSB0aGVtIG9ubHkgaWYKPiBtaXNzaW5nLgoKUXVvdGlu
ZyBbMV06CgpUaGUgbmV3ZXIgR2xpYmMgYWxyZWFkeSBwcm92aWRlZCB3cmFwcGVyIGZvciB0aGUg
c2VyaWVzIHBpZGZkIHN5c2NhbGwsCnNvIGxldCdzIGluY2x1ZGUgdGhlIGhlYWRlciBmaWxlIGNv
bmRpdGlvbmFsbHkuCgogICMgcnBtIC1xIGdsaWJjLWRldmVsCiAgZ2xpYmMtZGV2ZWwtMi4zNS45
MDAwLTMxLmZjMzcucHBjNjRsZQoKICAjIHJwbSAtcWwgZ2xpYmMtZGV2ZWwgfCBncmVwIHBpZGZk
CiAgL3Vzci9pbmNsdWRlL3N5cy9waWRmZC5oCgpUbyBnZXQgcmlkIG9mIGNvbXBpbGluZyBlcnJv
ciBmcm9tIGZlZG9yYS1yYXdoaWRlOgoKICB0c3Rfc2FmZV9tYWNyb3MuYzogSW4gZnVuY3Rpb24g
4oCYc2FmZV9waWRmZF9vcGVu4oCZOgogIHRzdF9zYWZlX21hY3Jvcy5jOjEzNToxNjogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHBpZGZkX29wZW7igJkgWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgMTM1IHwgICAgICAgICBydmFsID0g
cGlkZmRfb3BlbihwaWQsIGZsYWdzKTsKICAgICAgfAoKPT4gTGksIGRvZXMgdGhlIHByb2JsZW0g
c3RpbGwgcGVyc2lzdHM/IElmIHllcywgSSdkIGJlIGZvciBtZXJnaW5nIHRoaXMgcGF0Y2guCkNv
dWxkIHlvdSBhbHNvIHRlc3QgaXQgb24gbmV3ZXN0IGdsaWJjIGluIEZlZG9yYT8KCkN5cmlsLCBG
WUkgbXVzbCBuZXZlciBpbmNsdWRlcyBsaW51eCBoZWFkZXJzIChSaWNoIEZlbGtlciBoYXMgYWx3
YXlzIGJlZW4KYWdhaW5zdCB0aGlzIHByYWN0aXNlKS4KCktpbmQgcmVnYXJkcywKUGV0cgoKWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDIyMDgwNTA2MzQwMS4xNjQ3NDc5LTItbGl3
YW5nQHJlZGhhdC5jb20vCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
