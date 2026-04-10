Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF15F459EB
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 15:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B7D03E4CED
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFD993E2160
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 17:00:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 402D4600A69
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 17:00:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D197F5BCF4;
 Fri, 10 Apr 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 603FA4A0B2;
 Fri, 10 Apr 2026 15:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VG10EYAQ2Wk9CAAAD6G6ig
 (envelope-from <>); Fri, 10 Apr 2026 15:00:16 +0000
From: acervesato@git
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Apr 2026 15:00:14 +0000
Message-ID: <20260410150014.4177-1-ltp-ci@noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304-stream_refactoring-v2-2-3e48ada8ff1a@suse.com>
References: <20260304-stream_refactoring-v2-2-3e48ada8ff1a@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 FROM_NO_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 noreply.github.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 10 Apr 2026 17:03:39 +0200
Subject: Re: [LTP] Add safe macros for stream testing suite
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

SGkgQW5kcmVhLAoKb3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4K
ClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdo
IG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGgg
dGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dl
c3Rpb25zLgoKLS0tIFJlcGx5IHRvIFtQQVRDSCAxLzZdIC0tLQoKT24gMjAyNi0wMy0wNCwgQW5k
cmVhIENlcnZlc2F0byB3cm90ZToKPiBBZGQgc2FmZSBtYWNyb3MgZm9yIHN0cmVhbSB0ZXN0aW5n
IHN1aXRlCgo+ICtzaXplX3Qgc2FmZV9mcmVhZChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQg
bGluZW5vLAo+ICsJdm9pZCAqcHRyLCBzaXplX3Qgc2l6ZSwgc2l6ZV90IG4sIEZJTEUgKnN0cmVh
bSkKPiArewo+ICsJc2l6ZV90IHJldDsKPiArCj4gKwlyZXQgPSBmcmVhZChwdHIsIHNpemUsIG4s
IHN0cmVhbSk7Cj4gKwlpZiAocmV0ICE9IG4pIHsKPiArCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5v
LCBUQlJPSywgTlVMTCwKPiArCQkJImZyZWFkKCVwLCAlbHUsICVsdSwgJXApIHJlYWQgJWx1IGJ5
dGVzIiwKPiArCQkJcHRyLCBzaXplLCBuLCBzdHJlYW0sIHJldCk7CgolbHUgaXMgd3JvbmcgZm9y
IHNpemVfdCBvbiBJTFAzMjsgdXNlICV6dS4gQWxzbywgcmV0IGlzIGFuIGl0ZW0gY291bnQsCm5v
dCBieXRlcyDigJQgdGhlIG1lc3NhZ2UgaXMgbWlzbGVhZGluZy4gU2FtZSBpc3N1ZSBpbiBzYWZl
X2Z3cml0ZS4KClVzZSBUQlJPSyB8IFRFUlJOTyBoZXJlIGFuZCBpbiBzYWZlX2Z3cml0ZTsgZXJy
bm8gaXMgc2V0IG9uIGFjdHVhbCBJL08KZXJyb3JzLCBub3QganVzdCBFT0YuCgo+ICtGSUxFICpz
YWZlX2ZyZW9wZW4oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArCSAgICAg
ICBjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICptb2RlLCBGSUxFICpzdHJlYW0pCgpDb250
aW51YXRpb24tbGluZSBhbGlnbm1lbnQgaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIGRlY2xhcmF0
aW9uIGluCnNhZmVfc3RkaW9fZm4uaC4gU2FtZSBhcHBsaWVzIHRvIHNhZmVfZnNlZWssIHNhZmVf
ZnRlbGwuIEFsaWduIHRvIHRoZQpvcGVuaW5nIHBhcmVudGhlc2lzIHVzaW5nIHRhYnMrc3BhY2Vz
IGFzIGluIHRoZSBoZWFkZXIuCgotLS0gUmVwbHkgdG8gW1BBVENIIDIvNl0gLS0tCgpPbiAyMDI2
LTAzLTA0LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IGZzOiByZXdyaXRlIHN0cmVhbTAxIHRl
c3QgdXNpbmcgbmV3IEFQSQoKQ29tbWl0IGJvZHkgaXMgbWlzc2luZy4gRXhwbGFpbiB3aHkgdGhl
IGNvbnZlcnNpb24gaXMgZG9uZSAoZS5nLiAiT2xkCkFQSSBpcyBkZXByZWNhdGVkOyBjb252ZXJ0
IHRvIG5ldyB0c3RfdGVzdC5oLWJhc2VkIEFQSS4iKS4gU2FtZSBhcHBsaWVzCnRvIHBhdGNoZXMg
My824oCTNi82LgoKPiArc3RhdGljIHZvaWQgcmVhZF9maWxlKGNvbnN0IGNoYXIgKmZpbGUsIGNv
bnN0IGNoYXIgKnN0ciwgc2l6ZV90IG4pCj4gK3sKPiArCWNoYXIgYnVmW25dOwo+ICsJLi4uCj4g
KwlsZW4gPSBTQUZFX0ZSRUFEKGJ1Ziwgbiwgbiwgc3RyZWFtKTsKCmZyZWFkKGJ1Ziwgbiwgbikg
YXR0ZW1wdHMgdG8gcmVhZCBuKm4gYnl0ZXMgaW50byBhIG4tYnl0ZSBWTEEg4oCUIGJ1ZmZlcgpv
dmVyZmxvdy4gQ2hhbmdlIHRvIFNBRkVfRlJFQUQoYnVmLCAxLCBuLCBzdHJlYW0pLgoKPiArCVNB
RkVfRldSSVRFKGJ1ZmZfZmlsZTEsIHN0cmxlbihidWZmX2ZpbGUxKSwgMywgc3RyZWFtKTsKCmZ3
cml0ZSgiYWJjIiwgMywgMykgcmVhZHMgOSBieXRlcyBmcm9tIGEgMy1ieXRlIGxpdGVyYWwg4oCU
IG91dC1vZi1ib3VuZHMKcmVhZC4gQ2hhbmdlIHRvIFNBRkVfRldSSVRFKGJ1ZmZfZmlsZTEsIDEs
IHN0cmxlbihidWZmX2ZpbGUxKSwgc3RyZWFtKS4KCi0tLSBSZXBseSB0byBbUEFUQ0ggMy82XSAt
LS0KCk9uIDIwMjYtMDMtMDQsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gZnM6IHJld3JpdGUg
c3RyZWFtMDIgdGVzdCB1c2luZyBuZXcgQVBJCgo+ICsJCXN0cmVhbSA9IFNBRkVfRk9QRU4oRklM
RU5BTUUsIG1vZGVzW2ldKTsKPiArCQlpZiAoIXN0cmVhbSkgewo+ICsJCQl0c3RfcmVzKFRGQUlM
LCAiZm9wZW4oJXMpIHJldHVybmVkIE5VTEwgcG9pbnRlciIsIG1vZGVzW2ldKTsKPiArCQkJcmV0
dXJuOwo+ICsJCX0KClNBRkVfRk9QRU4gbmV2ZXIgcmV0dXJucyBOVUxMIOKAlCBpdCBjYWxscyB0
c3RfYnJrKFRCUk9LKSBvbiBmYWlsdXJlLgpSZW1vdmUgdGhlIGRlYWQgbnVsbCBjaGVjay4KCi0t
LSBSZXBseSB0byBbUEFUQ0ggNC82XSAtLS0KCk9uIDIwMjYtMDMtMDQsIEFuZHJlYSBDZXJ2ZXNh
dG8gd3JvdGU6Cj4gZnM6IHJld3JpdGUgc3RyZWFtMDMgdGVzdCB1c2luZyBuZXcgQVBJCgo+ICsJ
cmV3aW5kKHN0cmVhbSk7Cj4gKwlUU1RfRVhQX0VRX0xJKFNBRkVfRlRFTEwoc3RyZWFtKSwgU0VF
S19TRVQpOwoKU0VFS19TRVQgaXMgYSBzZWVrLWRpcmVjdGlvbiBjb25zdGFudCAodmFsdWUgMCks
IG5vdCBhIGZpbGUgcG9zaXRpb24uClVzZSAwIGFzIHRoZSBleHBlY3RlZCB2YWx1ZSB0byBhdm9p
ZCBjb25mdXNpb24uCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
