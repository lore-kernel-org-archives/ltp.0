Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE8C982FF
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 09:52:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE4453E6C79
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 11:52:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC2DF3E6C78
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:51:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0723E60068F
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:51:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91E0B21A45;
 Tue, 22 Sep 2026 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790070696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mgRLvHADSHjkV9eC16S5iL30B64VxZMyKROGxdd8FJM=;
 b=YkzvjeB3mGcWzyPtygx1ONsb2dN21FyJGt4jI9d8flbWAHUJ4chTf/9WFEUJZv7w/BRmvW
 sFQ4dccumTxCce43cFWFTBaR9qVwwTvY+a4GHqjFruCTqRKg3K99JIjb5ou8Wgj6s5WFNP
 GS81Dj8OE9//Nnibd/G3vSAvX5CM1Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790070696;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mgRLvHADSHjkV9eC16S5iL30B64VxZMyKROGxdd8FJM=;
 b=3o40Sh75AZUfOvuY/9sZUgqAphJ5Xec61pA2LDgPCsMRqtPlHWn5Zd+7fFTeroe66pixOc
 46vhQpEkHzwzARCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790070692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mgRLvHADSHjkV9eC16S5iL30B64VxZMyKROGxdd8FJM=;
 b=h5olDZgb7ZcUlHKo/jenUVlJ/Op3Z3Yn7Q8JCXIOGS5VswGTJ0uKMFx3wtgU8KBLcWhHQ4
 lkaOZEpkbwjuE/VzIVl7m+NNe0K4ZdCSQ4Xf6s61TCVyNEbDhtwrwU3B2MFFajUOPogj6O
 YAge1s2zoDOTNBVKJcZJbXBOdcgWH7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790070692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mgRLvHADSHjkV9eC16S5iL30B64VxZMyKROGxdd8FJM=;
 b=U2wddfm3WXy4VHufQvGubnsUxSwPQuCXXVZ/RVGZ11Ou6RDho1hKKKa97q3hTpgoLpuxDf
 nB9dQ2IprHsZoGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A6AC136D9;
 Tue, 22 Sep 2026 09:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +4HeBKRPsmrAfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 09:51:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 11:51:25 +0200
Message-ID: <20260922095126.2169599-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,linux.dev,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] keyctl: Vendor struct keyctl_dh_params
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
Cc: linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Q29weSBzdHJ1Y3Qga2V5Y3RsX2RoX3BhcmFtcyBkZWZpbml0aW9uIGludG8gTFRQIHNwZWNpZmlj
IHN0cnVjdApsdHBfa2V5Y3RsX2RoX3BhcmFtcy4gKFVzZSBzdHJ1Y3QgZGVmaW5pdGlvbiBmcm9t
IGtleXV0aWxzLmggZnJvbQprZXl1dGlscyB1c2Vyc3BhY2UgbGlicmFyeSwgVUFQSSBpbiBrZXJu
ZWwga2VlcHMgYWxzbyBwcml2YXRlIGhpZGRlbgpmcm9tIEMrKyBieSAjaWZuZGVmIGd1YXJkIHdo
aWNoIHdlIDEpIGRvbid0IG5lZWQgMikgY2Fubm90IHVzZSBuZXN0ZWQgI2lmbmRlZi4pCgpUaGlz
IGhlbHBzIHRvIGZpeCBjb21waWxhdGlvbiBvbiBvbGQga2VybmVsIDwgNC4yMDoKCiAgICBrZXlj
dGwyNS5jOjI1OjExOiBlcnJvcjog4oCYc3RydWN0IGtleWN0bF9kaF9wYXJhbXPigJkgaGFzIG5v
IG1lbWJlciBuYW1lZCDigJhwcml24oCZCgoncHJpdicgc3RydWN0IG1lbWJlciB3YXMgYWRkZWQg
aW4ga2VybmVsIHY0LjIwICh3aGljaCB3ZSBzdGlsbCBzdXBwb3J0KQppbiBjb21taXQgMmVjZWZh
MGExNWZkMCAoImtleXM6IEZpeCB0aGUgdXNlIG9mIHRoZSBDKysga2V5d29yZCAicHJpdmF0ZSIK
aW4gdWFwaS9saW51eC9rZXljdGwuaCIpCgpWZW5kb3Jpbmcgc3RydWN0IGhlbHBzIHVzIHRvIHJl
bW92ZSBhdXRvdG9vbHMgY2hlY2sgKHNwZWVkdXApLgoKRml4ZXM6IGVlMDIxMThlOWYgKCJsYXBp
L2tleWN0bC5oOiBBZGQgZmFsbGJhY2sgZGVmaW5pdGlvbnMgZm9yIGV4dGVuZGVkIG9wcyIpClJl
cG9ydGVkLWJ5OiBsaW51eHRlc3Rwcm9qZWN0LmFnZW50QGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLS0tCkNoYW5nZXMgdjEtPnYyOgoqIFZlbmRv
ciBzdHJ1Y3QgaW5zdGVhZCBvZiB1c2luZyBkYW5nZXJvdXMgbWFjcm8gZGVmaW5pdGlvbi4KCkxp
bmsgdG8gdjE6Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9sdHAvcGF0Y2gv
MjAyNjA5MjExMTE0MDcuMjEzNzQ2Ny0xLXB2b3JlbEBzdXNlLmN6LwpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sdHAvMjAyNjA5MjIwODU1MTQuR0EyMTUwMjg1QHBldmlrL1QvI3QKCiBpbmNsdWRl
L2xhcGkva2V5Y3RsLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKystLS0KIG00L2x0cC1r
ZXl1dGlscy5tNCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArLS0tLQogdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjUuYyB8ICAyICstCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNi5jIHwgIDIgKy0KIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMva2V5Y3RsL2tleWN0bDI3LmMgfCAgMiArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9rZXljdGwva2V5Y3RsMjguYyB8IDEwICsrKysrLS0tLS0KIDYgZmlsZXMgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
YXBpL2tleWN0bC5oIGIvaW5jbHVkZS9sYXBpL2tleWN0bC5oCmluZGV4IGZkYjY4ZDE3MjUuLmNj
NDlhMjliMzIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGFwaS9rZXljdGwuaAorKysgYi9pbmNsdWRl
L2xhcGkva2V5Y3RsLmgKQEAgLTYxLDEzICs2MSwxMiBAQCBzdGF0aWMgaW5saW5lIGtleV9zZXJp
YWxfdCBrZXljdGxfam9pbl9zZXNzaW9uX2tleXJpbmcoY29uc3QgY2hhciAqbmFtZSkgewogCiAj
ZW5kaWYgLyogZGVmaW5lZChIQVZFX0tFWVVUSUxTX0gpICYmIGRlZmluZWQoSEFWRV9MSUJLRVlV
VElMUykgKi8KIAotI2lmbmRlZiBIQVZFX1NUUlVDVF9LRVlDVExfREhfUEFSQU1TCi1zdHJ1Y3Qg
a2V5Y3RsX2RoX3BhcmFtcyB7CisvKiBGcm9tIGxpYmtleXV0aWxzIGtleXV0aWxzLmggKi8KK3N0
cnVjdCBsdHBfa2V5Y3RsX2RoX3BhcmFtcyB7CiAJaW50MzJfdCBwcml2OwogCWludDMyX3QgcHJp
bWU7CiAJaW50MzJfdCBiYXNlOwogfTsKLSNlbmRpZgogCiAjaWZuZGVmIEhBVkVfU1RSVUNUX0tF
WUNUTF9LREZfUEFSQU1TCiBzdHJ1Y3Qga2V5Y3RsX2tkZl9wYXJhbXMgewpkaWZmIC0tZ2l0IGEv
bTQvbHRwLWtleXV0aWxzLm00IGIvbTQvbHRwLWtleXV0aWxzLm00CmluZGV4IDM1YmFkNzgzZTUu
LmIwNzMxODM0MDUgMTAwNjQ0Ci0tLSBhL200L2x0cC1rZXl1dGlscy5tNAorKysgYi9tNC9sdHAt
a2V5dXRpbHMubTQKQEAgLTksOSArOSw2IEBAIEFDX0RFRlVOKFtMVFBfQ0hFQ0tfS0VZVVRJTFNf
U1VQUE9SVF0sIFsKIAlbQUNfREVGSU5FKEhBVkVfTElCS0VZVVRJTFMsIDEsIFtEZWZpbmUgdG8g
MSBpZiB5b3UgaGF2ZSBsaWJrZXl1dGlscyBpbnN0YWxsZWQuXSkKIAkgICAgICBBQ19TVUJTVChL
RVlVVElMU19MSUJTLCAiLWxrZXl1dGlscyIpXSkKIAotCUFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3Qg
a2V5Y3RsX2RoX3BhcmFtcywgc3RydWN0IGtleWN0bF9rZGZfcGFyYW1zLAotCQkJc3RydWN0IGtl
eWN0bF9wa2V5X3F1ZXJ5LCBzdHJ1Y3Qga2V5Y3RsX3BrZXlfcGFyYW1zXSwsLAorCUFDX0NIRUNL
X1RZUEVTKFtzdHJ1Y3Qga2V5Y3RsX2tkZl9wYXJhbXMsIHN0cnVjdCBrZXljdGxfcGtleV9xdWVy
eSwgc3RydWN0IGtleWN0bF9wa2V5X3BhcmFtc10sLCwKIAkJCVsjaW5jbHVkZSA8bGludXgva2V5
Y3RsLmg+XSkKLQotCUFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBrZXljdGxfZGhfcGFyYW1zLnBy
aXZdLCwsWyNpbmNsdWRlIDxsaW51eC9rZXljdGwuaD5dKQogXSkKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI1LmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNS5jCmluZGV4IGQxYWEzNDI1ZDQuLmE5OTUwMzE4M2Eg
MTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI1LmMK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjUuYwpAQCAtMTUs
NyArMTUsNyBAQAogI2luY2x1ZGUgImtleWN0bF9jb21tb24uaCIKICNpbmNsdWRlICJrZXljdGxf
ZGhfZGF0YS5oIgogCi1zdGF0aWMgc3RydWN0IGtleWN0bF9kaF9wYXJhbXMgKmRoX3BhcmFtczsK
K3N0YXRpYyBzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJhbXMgKmRoX3BhcmFtczsKIHN0YXRpYyB1
bnNpZ25lZCBjaGFyIG91dF9idWZbMjU2XTsKIAogc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI2LmMgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNi5jCmluZGV4IGJkZDg1MmZi
NGMuLmRmODBhYWRiNmMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5
Y3RsL2tleWN0bDI2LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5
Y3RsMjYuYwpAQCAtMTUsNyArMTUsNyBAQAogI2luY2x1ZGUgImtleWN0bF9jb21tb24uaCIKICNp
bmNsdWRlICJrZXljdGxfZGhfZGF0YS5oIgogCi1zdGF0aWMgc3RydWN0IGtleWN0bF9kaF9wYXJh
bXMgKmRoX3BhcmFtczsKK3N0YXRpYyBzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJhbXMgKmRoX3Bh
cmFtczsKIAogc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIHsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI3LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2tleWN0bC9rZXljdGwyNy5jCmluZGV4IDEzYTE1MzhjZTYuLjBlY2Y3ZGMzODkgMTAw
NjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI3LmMKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjcuYwpAQCAtMTksNyAr
MTksNyBAQAogCiAjZGVmaW5lIEtERl9PVEhFUklORk8JIkxUUC1LREYtVEVTVC1JTkZPIgogCi1z
dGF0aWMgc3RydWN0IGtleWN0bF9kaF9wYXJhbXMgKmRoX3BhcmFtczsKK3N0YXRpYyBzdHJ1Y3Qg
bHRwX2tleWN0bF9kaF9wYXJhbXMgKmRoX3BhcmFtczsKIHN0YXRpYyBzdHJ1Y3Qga2V5Y3RsX2tk
Zl9wYXJhbXMgKmtkZl9wYXJhbXM7CiBzdGF0aWMgdW5zaWduZWQgY2hhciBvdXRfYnVmWzMyXTsK
IApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjgu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI4LmMKaW5kZXggNGM3
ZjZiZTE3ZS4uNTNhNTkzMjJiNCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9rZXljdGwva2V5Y3RsMjguYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0
bC9rZXljdGwyOC5jCkBAIC0yMSw5ICsyMSw5IEBACiAjaW5jbHVkZSAia2V5Y3RsX2NvbW1vbi5o
IgogI2luY2x1ZGUgImtleWN0bF9kaF9kYXRhLmgiCiAKLXN0YXRpYyBzdHJ1Y3Qga2V5Y3RsX2Ro
X3BhcmFtcyAqZGhfcGFyYW1zOwotc3RhdGljIHN0cnVjdCBrZXljdGxfZGhfcGFyYW1zICpkaF9i
b2d1c19wcmltZTsKLXN0YXRpYyBzdHJ1Y3Qga2V5Y3RsX2RoX3BhcmFtcyAqZGhfbm9udXNlcl9w
cmltZTsKK3N0YXRpYyBzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJhbXMgKmRoX3BhcmFtczsKK3N0
YXRpYyBzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJhbXMgKmRoX2JvZ3VzX3ByaW1lOworc3RhdGlj
IHN0cnVjdCBsdHBfa2V5Y3RsX2RoX3BhcmFtcyAqZGhfbm9udXNlcl9wcmltZTsKIAogc3RhdGlj
IHN0cnVjdCBrZXljdGxfa2RmX3BhcmFtcyAqa2RmX3ZhbGlkOwogc3RhdGljIHN0cnVjdCBrZXlj
dGxfa2RmX3BhcmFtcyAqa2RmX3NwYXJlX25vbnplcm87CkBAIC0zMyw3ICszMyw3IEBAIHN0YXRp
YyBzdHJ1Y3Qga2V5Y3RsX2tkZl9wYXJhbXMgKmtkZl91bmtub3duX2hhc2g7CiBzdGF0aWMgdW5z
aWduZWQgY2hhciBvdXRfYnVmWzEwMjVdOwogCiBzdGF0aWMgc3RydWN0IHRjYXNlIHsKLQlzdHJ1
Y3Qga2V5Y3RsX2RoX3BhcmFtcyAqKnBhcmFtczsKKwlzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJh
bXMgKipwYXJhbXM7CiAJdm9pZCAqYnVmZmVyOwogCXNpemVfdCBidWZsZW47CiAJc3RydWN0IGtl
eWN0bF9rZGZfcGFyYW1zICoqa2RmOwpAQCAtMTA1LDcgKzEwNSw3IEBAIHN0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpCiBzdGF0aWMgdm9pZCB2ZXJpZnlfbmVnYXRpdmUodW5zaWduZWQgaW50IG4pCiB7
CiAJc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbbl07Ci0Jc3RydWN0IGtleWN0bF9kaF9wYXJh
bXMgKnAgPSAqdGMtPnBhcmFtczsKKwlzdHJ1Y3QgbHRwX2tleWN0bF9kaF9wYXJhbXMgKnAgPSAq
dGMtPnBhcmFtczsKIAlzdHJ1Y3Qga2V5Y3RsX2tkZl9wYXJhbXMgKmtkZiA9IHRjLT5rZGYgPyAq
dGMtPmtkZiA6IE5VTEw7CiAKIAlUU1RfRVhQX0ZBSUwyKGtleWN0bChLRVlDVExfREhfQ09NUFVU
RSwgKHVuc2lnbmVkIGxvbmcpcCwKLS0gCjIuNTUuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
