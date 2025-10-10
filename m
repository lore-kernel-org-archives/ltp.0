Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEEDCAC5BB
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 09:13:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C8283CE97A
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:13:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A250D3CD776
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:13:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9338A6002EA
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:13:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFF611F393;
 Fri, 10 Oct 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3ABB13A40;
 Fri, 10 Oct 2025 09:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3OWoMiLO6GiVYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Oct 2025 09:13:06 +0000
Date: Fri, 10 Oct 2025 11:13:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251010091305.GB4281@pevik>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
 <20251010064745.31361-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251010064745.31361-2-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: EFF611F393
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add support option for .needs_cmds
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

SGkgV2VpLAoKPiAtLS0KPiAgaW5jbHVkZS90c3RfY21kLmggIHwgMTMgKysrKysrKysrKysrKwo+
ICBpbmNsdWRlL3RzdF90ZXN0LmggfCAxNSArKysrKysrKysrKysrLS0KPiAgbGliL3RzdF9jbWQu
YyAgICAgIHwgIDcgKysrKysrLQo+ICBsaWIvdHN0X3Rlc3QuYyAgICAgfCAyMiArKysrKysrKysr
KysrKysrKystLS0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkKCnRzdF9uZWVkc19jbWRzMDEuYzoxNToyMzogZXJyb3I6IGluaXRpYWxpemF0aW9u
IG9mIOKAmHN0cnVjdCB0c3RfY21kICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBl
IOKAmGNvbnN0IGNoYXIgKirigJkgWy1XaW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgIDE1
IHwgICAgICAgICAubmVlZHNfY21kcyA9IChjb25zdCBjaGFyICpbXSkgewogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICBeCnRzdF9uZWVkc19jbWRzMDEuYzoxNToyMzogbm90ZTogKG5lYXIg
aW5pdGlhbGl6YXRpb24gZm9yIOKAmHRlc3QubmVlZHNfY21kc+KAmSkKbWFrZVsxXTogKioqIFsu
Li8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ4OiB0c3RfbmVlZHNfY21kczAxXSBFcnJvciAxCgpJ
IGFza2VkIG9uIHYyIG5vdCB0byBicmVhayBidWlsZCBbMV0sIGJ1dCB5b3UgZGlkbid0IHJlZmxl
Y3RlZCB0aGF0LiBUaGUgcmVhc29uCmZvciB0aGlzIHJlcXVpcmVtZW50IGlzIHRoYXQgYWxsIGNv
bW1pdHMgbmVlZCB0byBidWlsdCBkdWUgYWJpbGl0eSB0byBiaXNlY3QKKHF1aXRlIG9idmlvdXMg
cmVxdWlyZW1lbnQpLiAgVGhpcyBtZWFuIHlvdSBuZWVkIGluIHRoaXMgY29tbWl0IGFsc28gbW9k
aWZ5IGFsbAp0aGUgdGVzdHMgd2hpY2ggdXNlIC5uZWVkc19jbWRzLCBpLmUuIDNyZCBjb21taXQg
IlVwZGF0ZSB0ZXN0IGNhc2VzIHVzZSBuZXcKbmVlZHNfY21kcyIgbmVlZHMgdG8gYmUKc3F1YXNo
ZWQgaW50byB0aGlzIDFzdCBjb21taXQuCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
LzIwMjUwOTMwMTMzNjIzLkdCMjM4MDY1QHBldmlrLwoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90
c3RfY21kLmggYi9pbmNsdWRlL3RzdF9jbWQuaAo+IGluZGV4IDkzOTgyNTY0Ni4uNzAzNTg5MDE5
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X2NtZC5oCj4gKysrIGIvaW5jbHVkZS90c3RfY21k
LmgKPiBAQCAtMTYsNiArMTYsMTkgQEAgZW51bSB0c3RfY21kX2ZsYWdzIHsKPiAgCVRTVF9DTURf
VENPTkZfT05fTUlTU0lORyA9IDIsCj4gIH07Cgo+ICsvKioKPiArICogc3RydWN0IHRzdF9jbWQg
LSBUaGlzIHN0cnVjdHVyZSBwcm92aWRlcyBkZXRhaWxzIGFib3V0IGEgY29tbWFuZCBuZWVkZWQg
YnkgTFRQIHRlc3QKCkkgd291bGQgcGVyc29uYWxseSBhdm9pZCAiVGhpcyBzdHJ1Y3R1cmUiIC8g
IlRoaXMgZnVuY3Rpb24iLgpNaXNzaW5nIGRvdCBhdCB0aGUgZW5kLgoKPiArICogQGNtZDogVGhl
IG5hbWUgb2YgdGhlIGNvbW1hbmQuCj4gKyAqIEBvcHRpb25hbDogQSBmbGFnIGluZGljYXRpbmcg
aWYgdGhlIGNvbW1hbmQgaXMgb3B0aW9uYWwuCj4gKyAqIEBwcmVzZW50OiBBIGZsYWcgaW5kaWNh
dGluZyBpZiB0aGUgY29tbWFuZCB3YXMgZm91bmQgYXQgcnVudGltZSwgdGhpcyBpcyBhbiBvdXRw
dXQKTWF5YmUgdXNlIDIgc2VudGVuY2VzOgogICAgKiBAcHJlc2VudDogQSBmbGFnIGluZGljYXRp
bmcgaWYgdGhlIGNvbW1hbmQgd2FzIGZvdW5kIGF0IHJ1bnRpbWUuIFRoaXMgaXMgYW4gb3V0cHV0
Cgo+ICsgKiBwYXJhbWV0ZXIsIHNldCBieSB0aGUgTFRQIGxpYnJhcnkgZHVyaW5nIHRoZSB0ZXN0
IHNldHVwLgo+ICsgKi8KPiArc3RydWN0IHRzdF9jbWQgewo+ICsJY29uc3QgY2hhciAqY21kOwo+
ICsJdW5zaWduZWQgaW50IG9wdGlvbmFsOjE7Cj4gKwl1bnNpZ25lZCBpbnQgcHJlc2VudDoxOwpI
b3BlZnVsbHkgbm9ib2R5IG1pc3VzZXMgdGhpcyB0byBzZXQgaXQgaW4gdGhlIHRlc3QuCgo+ICt9
Owo+ICsKPiAgLyoKPiAgICogdmZvcmsoKSArIGV4ZWN2cCgpIHNwZWNpZmllZCBwcm9ncmFtLgo+
ICAgKgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF90ZXN0LmggYi9pbmNsdWRlL3RzdF90ZXN0
LmgKPiBpbmRleCA5YzIxYzE3MjguLjI3MzBkMjJjMSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Rz
dF90ZXN0LmgKPiArKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKPiBAQCAtNTI0LDcgKzUyNCw3IEBA
IHN0cnVjdCB0c3RfZnMgewo+ICAgKgo+ICAgKiBAdGFnczogQSB7fSB0ZXJtaW5hdGVkIGFycmF5
IG9mIHRlc3QgdGFncy4gU2VlIHN0cnVjdCB0c3RfdGFnIGZvciBkZXRhaWxzLgo+ICAgKgo+IC0g
KiBAbmVlZHNfY21kczogQSBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2YgY29tbWFuZHMgcmVxdWly
ZWQgZm9yIHRoZSB0ZXN0IHRvIHJ1bi4KPiArICogQG5lZWRzX2NtZHM6IEEgTlVMTCB0ZXJtaW5h
dGVkIGFycmF5IG9mIHN0cnVjdCB0c3RfY21kIHJlcXVpcmVkIGZvciB0aGUgdGVzdCB0byBydW4u
Cj4gICAqCj4gICAqIEBuZWVkc19jZ3JvdXBfdmVyOiBJZiBzZXQgdGhlIHRlc3Qgd2lsbCBydW4g
b25seSBpZiB0aGUgc3BlY2lmaWVkIGNncm91cAo+ICAgKiAgICAgICAgICAgICAgICAgICAgdmVy
c2lvbiBpcyBwcmVzZW50IG9uIHRoZSBzeXN0ZW0uCj4gQEAgLTYxNyw3ICs2MTcsNyBAQCBzdHJ1
Y3QgdHN0X2ZzIHsKCj4gIAljb25zdCBzdHJ1Y3QgdHN0X3RhZyAqdGFnczsKCj4gLQljb25zdCBj
aGFyICpjb25zdCAqbmVlZHNfY21kczsKPiArCXN0cnVjdCB0c3RfY21kICpuZWVkc19jbWRzOwoK
PiAgCWNvbnN0IGVudW0gdHN0X2NnX3ZlciBuZWVkc19jZ3JvdXBfdmVyOwoKPiBAQCAtNzIxLDYg
KzcyMSwxNyBAQCBpbnQgdHN0X2NyZWF0X3VubGlua2VkKGNvbnN0IGNoYXIgKnBhdGgsIGludCBm
bGFncywgbW9kZV90IG1vZGUpOwo+ICAgKi8KPiAgY29uc3QgY2hhciAqdHN0X2dldF90bXBkaXJf
cm9vdCh2b2lkKTsKCj4gKy8qKgo+ICsgKiB0c3RfY21kX3ByZXNlbnQoKSAtIENoZWNrIGlmIGEg
Y29tbWFuZCBpcyBwcmVzZW50Cj4gKyAqIEBjbWQ6IFRoZSBuYW1lIG9mIHRoZSBjb21tYW5kIHRv
IGNoZWNrIGZvci4KPiArICoKPiArICogVGhpcyBmdW5jdGlvbiBpdGVyYXRlcyB0aHJvdWdoIHRo
ZSAnbmVlZHNfY21kcycgYXJyYXkuIEl0IGNvbXBhcmVzIHRoZSBnaXZlbiBjb21tYW5kIG5hbWUK
UGxlYXNlIHVzZSAmdHN0X3Rlc3QtPm5lZWRzX2NtZHM6CgogKiBUaGlzIGZ1bmN0aW9uIGl0ZXJh
dGVzIHRocm91Z2ggdGhlICZ0c3RfdGVzdC0+bmVlZHNfY21kcyBhcnJheS4gSXQgY29tcGFyZXMK
ICogdGhlIGdpdmVuIGNvbW1hbmQgbmFtZSB3aXRoIGVhY2ggZW50cnkgaW4gdGhlIGFycmF5IGFu
ZCByZXR1cm5zIHRoZSAncHJlc2VudCcKICogZmxhZyBmb3IgdGhlIG1hdGNoaW5nIGNvbW1hbmQu
CgpUaGF0IGhlbHBzIHN0cnVjdCB0byBiZSBsaW5rYWJsZS4KCj4gKyAqIHdpdGggZWFjaCBlbnRy
eSBpbiB0aGUgYXJyYXkgYW5kIHJldHVybnMgdGhlICdwcmVzZW50JyBmbGFnIGZvciB0aGUgbWF0
Y2hpbmcgY29tbWFuZC4KPiArICoKPiArICogUmV0dXJuOiBgdHJ1ZWAgaWYgdGhlIGNvbW1hbmQg
aXMgcHJlc2VudCwgYGZhbHNlYCBvdGhlcndpc2UuClRoaXMgbmVlZHMgdG8gYmUgUmV0dXJuczog
KG1pc3NpbmcgcykKaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvZG9jLWd1aWRlL2tlcm5lbC1kb2Mu
aHRtbAoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
