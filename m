Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31C3C369CB
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 07:29:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9DFB3CACDB
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 09:29:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32A83C0E24
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 09:29:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE9861A0066C
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 09:29:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A015A2119B;
 Wed, 23 Apr 2025 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745393368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC6QBcPVMHtDir8qzC3h/esQFR07iLWPBm0/ehwfR2o=;
 b=TxnStPzxlk5X1SqTlTHxBow1iocDxzdtj0I93M+8fwGHw4Q1yP7RdOXfWZEcVAHOtuJRKv
 noYKO9yhlIOYR9tu8xWv0TQTbY9N+6BNq5RG9Ij8bigbHDEOuZT9NHuag+o/Gr0MhWFTc/
 JbPvVM+zlt5DaFviA1znqcw5FmMwnS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745393368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC6QBcPVMHtDir8qzC3h/esQFR07iLWPBm0/ehwfR2o=;
 b=PJ3dLvvzRY4ipRsJiA+mkuRgyeQn/f5FKoQGLkgOBesKzv0fVg6Af8/A0Ey8xU4ES7ZvD6
 cMhMPOoB3ttDAzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745393368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC6QBcPVMHtDir8qzC3h/esQFR07iLWPBm0/ehwfR2o=;
 b=TxnStPzxlk5X1SqTlTHxBow1iocDxzdtj0I93M+8fwGHw4Q1yP7RdOXfWZEcVAHOtuJRKv
 noYKO9yhlIOYR9tu8xWv0TQTbY9N+6BNq5RG9Ij8bigbHDEOuZT9NHuag+o/Gr0MhWFTc/
 JbPvVM+zlt5DaFviA1znqcw5FmMwnS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745393368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC6QBcPVMHtDir8qzC3h/esQFR07iLWPBm0/ehwfR2o=;
 b=PJ3dLvvzRY4ipRsJiA+mkuRgyeQn/f5FKoQGLkgOBesKzv0fVg6Af8/A0Ey8xU4ES7ZvD6
 cMhMPOoB3ttDAzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74E9113A3D;
 Wed, 23 Apr 2025 07:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /t3/GdiWCGj3ZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Apr 2025 07:29:28 +0000
Date: Wed, 23 Apr 2025 09:29:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250423072923.GA969000@pevik>
References: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
 <20250409-fix_make_clean-v3-2-a33a84b2be05@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250409-fix_make_clean-v3-2-a33a84b2be05@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] include/Makefile: Fix cleaning targets
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, Joerg Vehlow <joerg.vehlow@aox.de>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKClsgQ2MgSm9lcmcsIHdobyB0b3VjaGVkIGJ1aWxkIHN5c3RlbSBpbiB0aGUg
cGFzdC4gXQoKPiBBZGQgYWMtY2xlYW4gdGFyZ2V0IGFzIGRlcGVuZGVuY3kgb2YgYWMtbWFpbnRh
aW5lci1jbGVhbiBhbmQgYWRkIG1pc3NpbmcKPiBmaWxlcyB0byB0aGUgcmVtb3ZhbCBsaXN0LiBU
aGlzIHdheSB0aGUgcHJvamVjdCB0b3AgbGV2ZWwgTWFrZWZpbGUgY2xlYW5pbmcKPiB0YXJnZXRz
IGNhbiBtYWtlIHVzZSBvZiBpdC4gQWxzbywgYWRkICJjb21waWxlIiB0byB0aGUgQVVUT01BS0Vf
RklMRVMKPiBsaXN0LgoKbml0OiBZb3UgYWxzbyByZW1vdmUgc3RhbXAtaDEgZnJvbSBBVVRPTUFL
RV9GSUxFUy4gV2h5PyBEaWQgSSBzdWdnZXN0IHRoYXQ/Ckl0J3MgY3JlYXRlZCBieSBjb25maWd1
cmUgKGUuZy4gbm90IGF1dG9tYWtlKSwgYnV0IEkgY29uc2lkZXJlZCBBVVRPTUFLRV9GSUxFUwpo
b2xkaW5nIGZpbGVzIGNyZWF0ZWQgYnkgYXV0b3Rvb2xzLgoKPiBDYzogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KRllJOiB3ZSB1c3VhbGx5IGRvbid0IGtlZXAg
Q2M6IGluIHRoZSBjb21taXQgbWVzc2FnZSAoZ2l0IGZvcm1hdC1wYXRjaCAtLWNjIC4uLgpvciBn
aXQgc2VuZC1lbWFpbCAtLWNjIC4uLiBoYXMgdGhlIHNhbWUgZWZmZWN0IC0gc2VuZGluZyBtYWls
LCBidXQgZG9uJ3QKcHJlc2VydmUgaXQpLiBPZiBjb3Vyc2UgaXQgY2FuIHN0YXkuIEkgcGVyc29u
YWxseSBzZWUgbW9yZSB2YWx1ZSB3aXRoIGFkZGluZwpMaW5rOiB0YWcgdG8gcGF0Y2ggaW4gbG9y
ZSAoZm9yIHRoZXNlIHdobyB3YW50L25lZWQgdG8gZGlnIGluIGhpc3RvcnkpLgoKPiBGaXhlczog
ODE3ZDgwOTVmYmZlICgiUmVuYW1lIGxpbnV4X3N5c2NhbGxfbnVtYmVycy5oIHRvIGxhcGkvc3lz
Y2FsbHMuaCIpCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IFNp
Z25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCgo+
IE5PVEU6IFRoZSAiY29tcGlsZSIgZmlsZSBpcyBhZGRlZCBkdXJpbmcgdGhlIGF1dG90b29scyB0
YXJnZXQ6Cj4gJCBtYWtlIGF1dG90b29scwo+IDxzbmlwPgo+IGNvbmZpZ3VyZS5hYzoyNjogaW5z
dGFsbGluZyAnLi9jb21waWxlJwo+IGNvbmZpZ3VyZS5hYzoyNDogaW5zdGFsbGluZyAnLi9jb25m
aWcuZ3Vlc3MnCj4gY29uZmlndXJlLmFjOjI0OiBpbnN0YWxsaW5nICcuL2NvbmZpZy5zdWInCj4g
Y29uZmlndXJlLmFjOjc6IGluc3RhbGxpbmcgJy4vaW5zdGFsbC1zaCcKPiBjb25maWd1cmUuYWM6
NzogaW5zdGFsbGluZyAnLi9taXNzaW5nJwo+IDxzbmlwPgo+IC0tLQo+ICBpbmNsdWRlL01ha2Vm
aWxlICAgICAgIHwgIDQgKystLQo+ICBpbmNsdWRlL21rL2F1dG9tYWtlLm1rIHwgMTAgKysrKy0t
LS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUgYi9pbmNsdWRlL01ha2VmaWxlCj4gaW5k
ZXggMjVlOTZkZjliOGNkZDdkMWQ3ZTZmMTk5MjViZjIxNjBkNjgyZjBkOS4uNmIzMWIwNDZlNDUy
ZTcxYWZiNTA5N2NjM2ZhZGY4YWYwMTI4MjYyOSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL01ha2Vm
aWxlCj4gKysrIGIvaW5jbHVkZS9NYWtlZmlsZQo+IEBAIC0xOCw4ICsxOCw4IEBAIE1BS0VfVEFS
R0VUUwkJOj0KPiAgZGlzdGNsZWFuOjogY2xlYW4gYWMtZGlzdGNsZWFuCj4gIG1haW50YWluZXIt
Y2xlYW46OiBkaXN0Y2xlYW4gYWMtbWFpbnRhaW5lci1jbGVhbgo+ICBhYy1jbGVhbiBhYy1kaXN0
Y2xlYW46Ogo+IC0JJChSTSkgLWYgY29uZmlnLmgKPiAtYWMtbWFpbnRhaW5lci1jbGVhbjo6Cj4g
KwkkKFJNKSAtZiBjb25maWcuaCBsYXBpL3N5c2NhbGxzLmggc3RhbXAtaDEKPiArYWMtbWFpbnRh
aW5lci1jbGVhbjo6IGFjLWNsZWFuCj4gIAkkKFJNKSAtZiBjb25maWcuaC5pbgoKPiAgdnBhdGgg
JS5oICQoYWJzX3NyY2RpcikKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9tay9hdXRvbWFrZS5tayBi
L2luY2x1ZGUvbWsvYXV0b21ha2UubWsKPiBpbmRleCAzZGYzYjRiYTk5Y2E4NjVjYWE4OTM4ODk5
OWU1M2NiYzUwMDYxNWRjLi4zYjI0OGFjOTU3NWE2MTNjNjk1ZGU3ZWMyMmM0MjdkNGU5N2RhMzlm
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKPiArKysgYi9pbmNsdWRlL21r
L2F1dG9tYWtlLm1rCj4gQEAgLTQ1LDcgKzQ1LDcgQEAgbTQvbHRwLXZlcnNpb24ubTQ6IFZFUlNJ
T04KPiAgCXNlZCAtbiAnMXtzOkxUUC06bTRfZGVmaW5lKFtMVFBfVkVSU0lPTl0sWzo7czokJDpd
KTo7cDtxfScgJDwgPiAkQAoKPiAgLlBIT05ZOiBhdXRvbWFrZQo+IC1BVVRPTUFLRV9GSUxFUyA6
PSBjb25maWcuZ3Vlc3MgY29uZmlnLnN1YiBpbnN0YWxsLXNoIG1pc3Npbmcgc3RhbXAtaDEKPiAr
QVVUT01BS0VfRklMRVMgOj0gY29tcGlsZSBjb25maWcuZ3Vlc3MgY29uZmlnLnN1YiBpbnN0YWxs
LXNoIG1pc3NpbmcKPiAgYXV0b21ha2U6IGFjbG9jYWwgJChBVVRPTUFLRV9GSUxFUykKPiAgJChB
VVRPTUFLRV9GSUxFUyk6IG00L01ha2VmaWxlLmluCj4gIG00L01ha2VmaWxlLmluOiBtNC9NYWtl
ZmlsZS5hbSBhY2xvY2FsLm00Cj4gQEAgLTU1LDE5ICs1NSwxNyBAQCBtNC9NYWtlZmlsZS5pbjog
bTQvTWFrZWZpbGUuYW0gYWNsb2NhbC5tNAo+ICBhYy1jbGVhbjo6Cj4gIAkkKFJNKSAtcmYgYXV0
b200dGUuY2FjaGUKPiAgCSQoUk0pIC1mIGNvbmZpZy5sb2cgY29uZmlnLnN0YXR1cwo+IC0JJChS
TSkgLWYgaW5jbHVkZS9jb25maWcuaCBpbmNsdWRlL3N0YW1wLWgxCj4gIAkkKFJNKSAtZiBtNC9N
YWtlZmlsZSBtNC9sdHAtdmVyc2lvbi5tNAo+IC0JZm9yIGQgaW4gJChBVVRPQ09ORkVEX1NVQkRJ
UlMpOyBkbyBcCj4gKwlmb3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElSUykgaW5jbHVkZTsgZG8g
XApuaXQ6IFdvdWxkbid0IGJlIGJldHRlciB0byBoYXZlIGFub3RoZXIgdmFyaWFibGUgd2hpY2gg
d291bGQgYmUgdXNlZCBpbiBmb3IgbG9vcHM/CgpDTEVBTl9TVUJESVJTID0gJChBVVRPQ09ORkVE
X1NVQkRJUlMpIGluY2x1ZGUKCj4gIAkgICAgJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQi
ICRAOyBcCj4gIAlkb25lCgo+ICBhYy1kaXN0Y2xlYW46OiBhYy1jbGVhbgo+ICBhYy1tYWludGFp
bmVyLWNsZWFuOjogYWMtZGlzdGNsZWFuCj4gLQlmb3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElS
Uyk7IGRvIFwKPiArCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKSBpbmNsdWRlOyBkbyBc
Cj4gIAkgICAgJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQiICRAOyBcCj4gIAlkb25lCj4g
IAkkKFJNKSAtZiBhY2xvY2FsLm00IGNvbmZpZ3VyZSAkKEFVVE9NQUtFX0ZJTEVTKSBtNC9NYWtl
ZmlsZS5pbgo+IC0JJChSTSkgLWYgaW5jbHVkZS8qY29uZmlnLmguaW4KCj4gICMgRG9uJ3QgaW5j
bHVkZSBjb25maWcuaCwgb3IgbWFrZSB3aWxsIChyaWdodGZ1bGx5KSB3aGluZSBhYm91dCBvdmVy
cmlkaW5nCj4gICMgcnVsZXMuCj4gQEAgLTgyLDcgKzgwLDcgQEAgQVVUT0dFTkVSQVRFRF9GSUxF
Uwk9IFwKPiAgCQkJbTQvTWFrZWZpbGUKCj4gIGRpc3RjbGVhbjo6ICU6IGNsZWFuIGFjLWRpc3Rj
bGVhbgo+IC0JZm9yIGQgaW4gJChBVVRPQ09ORkVEX1NVQkRJUlMpOyBkbyBcCj4gKwlmb3IgZCBp
biAkKEFVVE9DT05GRURfU1VCRElSUykgaW5jbHVkZTsgZG8gXAo+ICAJICAgICQoTUFLRSkgLUMg
IiQodG9wX3NyY2RpcikvJCRkIiAkQDsgXAo+ICAJZG9uZQo+ICAJJChSTSkgLWYgJChBVVRPR0VO
RVJBVEVEX0ZJTEVTKQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
