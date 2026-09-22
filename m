Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A76C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C223B3E6CE8
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:10:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ADA43E295D
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 943516003CC
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4B5521AA9;
 Tue, 22 Sep 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNNWjCRYIaDdXRixgs3BlWpEleOWtlc3nzzaBofWDtA=;
 b=bSq44nGErt9IJAOxSB8nu9sGildVEfQ2N7g8j6rj48JZdafg61V27n7yT8lYT9ZWZFOZJc
 u8jwyNUIj04J5peBhHuL/sUTNPUqiMvXwvPYn5vpLE2pj/ShSYC3j8pxaNjr324dbTDGEM
 j7Y6E4m/9mZ4aVlYpG+thMhTQfpSNhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNNWjCRYIaDdXRixgs3BlWpEleOWtlc3nzzaBofWDtA=;
 b=U/9Bd35QSWik4iKpTPOij38siuFZYk+u/TpOyLIGa89ter5VSLUljbKBjA5XghmD7gCnup
 7IMavXchMX9TylCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNNWjCRYIaDdXRixgs3BlWpEleOWtlc3nzzaBofWDtA=;
 b=ahs5xwV8UYnVcUf+i3c6N5CSpU5RtN0nOszVWZumvkKSSrlfHDAYLkekJXP88WUMQMeTZL
 HtS3Tn6uT5pxV1i8C/CTJkRdws6EAe0ChP87KmbcnzAkYgxUGBi4MGOxqq83E+DtB3H7eO
 zeQsEL08Z8gLVO9+n4zOMqONb8hnvCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNNWjCRYIaDdXRixgs3BlWpEleOWtlc3nzzaBofWDtA=;
 b=M0NjIQOwUUOiElcIKHKf/sTASKXyXHfVVws74BKXhL29xTHMKtoUpy9hAhDGXB5d/elpzl
 q5rHLgyLSaTHd4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C9C813A68;
 Tue, 22 Sep 2026 16:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u3mALCuosmouJgAAD6G6ig:T3
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:09:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 18:09:09 +0200
Message-ID: <20260922160911.2271754-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922160911.2271754-1-pvorel@suse.cz>
References: <20260922160911.2271754-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] keyctl: Use struct keyctl_dh_params 'private'
 instead of 'priv'
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TW92ZSBzdHJ1Y3Qga2V5Y3RsX2RoX3BhcmFtcyAncHJpdicgbWVtYmVyIHRvIHVuaW9uLCB0b2dl
dGhlciB3aXRoIG5ld2x5CmFkZGVkICdwcml2YXRlJyBtZW1iZXIuIFRoaXMgaXMgc2ltaWxhciB3
aGF0IFVBUEkgZG9lcyBzaW5jZSBrZXJuZWwgNC4yMApjb21taXQgMmVjZWZhMGExNWZkMCAoImtl
eXM6IEZpeCB0aGUgdXNlIG9mIHRoZSBDKysga2V5d29yZCAicHJpdmF0ZSIKaW4gdWFwaS9saW51
eC9rZXljdGwuaCIpLCB3aGljaCBhZGRzIHByaXZhdGUgbWVtYmVyIGluIHVuaW9uIGluIHN0cnVj
dAprZXljdGxfZGhfcGFyYW1zIGluIDxsaW51eC9rZXljdGwuaD46CgogICAgc3RydWN0IGtleWN0
bF9kaF9wYXJhbXMgewoJICAgIHVuaW9uIHsKICAgICNpZm5kZWYgX19jcGx1c3BsdXMKCQkgICAg
X19zMzIgcHJpdmF0ZTsKICAgICNlbmRpZgoJCSAgICBfX3MzMiBwcml2OwoJICAgIH07CgkgICAg
X19zMzIgcHJpbWU7CgkgICAgX19zMzIgYmFzZTsKICAgIH07CgpUaGlzIGFsbG93cyB0byB1bmNv
bmRpdGlvbmFsbHkgdXNlICdwcml2YXRlJyBtZW1iZXIgaW4ga2V5Y3RsIHRlc3RzCndoaWNoIGZp
eGVzIGNvbXBpbGF0aW9uIG9uIG9sZCBrZXJuZWwgPCA0LjIwOgoKICAgIGtleWN0bDI1LmM6MjU6
MTE6IGVycm9yOiDigJhzdHJ1Y3Qga2V5Y3RsX2RoX3BhcmFtc+KAmSBoYXMgbm8gbWVtYmVyIG5h
bWVkIOKAmHByaXbigJkKCkZpeGVzOiBlZTAyMTE4ZTlmICgibGFwaS9rZXljdGwuaDogQWRkIGZh
bGxiYWNrIGRlZmluaXRpb25zIGZvciBleHRlbmRlZCBvcHMiKQpTdWdnZXN0ZWQtYnk6IEN5cmls
IEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4KLS0tCiBpbmNsdWRlL2xhcGkva2V5Y3RsLmggICAgICAgICAgICAgICAgICAg
ICAgIHwgNSArKysrLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjUu
YyB8IDIgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI2LmMgfCAy
ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNy5jIHwgMiArLQog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjguYyB8IDIgKy0KIDUgZmls
ZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGFwaS9rZXljdGwuaCBiL2luY2x1ZGUvbGFwaS9rZXljdGwuaAppbmRleCA5MmFl
YTg1OGRjLi5lYjRkMjVjNDJkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xhcGkva2V5Y3RsLmgKKysr
IGIvaW5jbHVkZS9sYXBpL2tleWN0bC5oCkBAIC01OCw3ICs1OCwxMCBAQCBzdGF0aWMgaW5saW5l
IGtleV9zZXJpYWxfdCBrZXljdGxfam9pbl9zZXNzaW9uX2tleXJpbmcoY29uc3QgY2hhciAqbmFt
ZSkgewogCiAjaWZuZGVmIEhBVkVfU1RSVUNUX0tFWUNUTF9ESF9QQVJBTVMKIHN0cnVjdCBrZXlj
dGxfZGhfcGFyYW1zIHsKLQlpbnQzMl90IHByaXY7CisJdW5pb24geworCQlpbnQzMl90IHByaXY7
CisJCWludDMyX3QgcHJpdmF0ZTsKKwl9OwogCWludDMyX3QgcHJpbWU7CiAJaW50MzJfdCBiYXNl
OwogfTsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0
bDI1LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNS5jCmluZGV4
IGQxYWEzNDI1ZDQuLjg0ZTc2YzAxOWEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMva2V5Y3RsL2tleWN0bDI1LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9r
ZXljdGwva2V5Y3RsMjUuYwpAQCAtMjIsNyArMjIsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQogewogCVNBRkVfS0VZQ1RMKEtFWUNUTF9KT0lOX1NFU1NJT05fS0VZUklORywgMCwgMCwgMCwg
MCk7CiAKLQlkaF9wYXJhbXMtPnByaXYgPSBTQUZFX05FV19VU0VSX0tFWSgiZGhfcHJpdiIsIGRo
X3ByaXYsIHNpemVvZihkaF9wcml2KSwKKwlkaF9wYXJhbXMtPnByaXZhdGUgPSBTQUZFX05FV19V
U0VSX0tFWSgiZGhfcHJpdiIsIGRoX3ByaXYsIHNpemVvZihkaF9wcml2KSwKIAkJCQkgICAgICAg
S0VZX1NQRUNfUFJPQ0VTU19LRVlSSU5HKTsKIAlkaF9wYXJhbXMtPnByaW1lID0gU0FGRV9ORVdf
VVNFUl9LRVkoImRoX3ByaW1lIiwgZGhfcHJpbWUsIHNpemVvZihkaF9wcmltZSksCiAJCQkJCUtF
WV9TUEVDX1BST0NFU1NfS0VZUklORyk7CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2tleWN0bC9rZXljdGwyNi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXlj
dGwva2V5Y3RsMjYuYwppbmRleCBiZGQ4NTJmYjRjLi45NDg4ZTczNmZhIDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNi5jCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI2LmMKQEAgLTIxLDcgKzIxLDcgQEAgc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKIHsKIAlTQUZFX0tFWUNUTChLRVlDVExfSk9JTl9TRVNTSU9O
X0tFWVJJTkcsIDAsIDAsIDAsIDApOwogCi0JZGhfcGFyYW1zLT5wcml2ID0gU0FGRV9ORVdfVVNF
Ul9LRVkoImRoX3ByaXYiLCBkaF9wcml2LCBzaXplb2YoZGhfcHJpdiksCisJZGhfcGFyYW1zLT5w
cml2YXRlID0gU0FGRV9ORVdfVVNFUl9LRVkoImRoX3ByaXYiLCBkaF9wcml2LCBzaXplb2YoZGhf
cHJpdiksCiAJCQkJICAgICAgIEtFWV9TUEVDX1BST0NFU1NfS0VZUklORyk7CiAJZGhfcGFyYW1z
LT5wcmltZSA9IFNBRkVfTkVXX1VTRVJfS0VZKCJkaF9wcmltZSIsIGRoX3ByaW1lLCBzaXplb2Yo
ZGhfcHJpbWUpLAogCQkJCQlLRVlfU1BFQ19QUk9DRVNTX0tFWVJJTkcpOwpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMjcuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDI3LmMKaW5kZXggMTNhMTUzOGNlNi4uZTY5YjUy
MDY0MCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3Rs
MjcuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyNy5jCkBA
IC0yNyw3ICsyNyw3IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiB7CiAJU0FGRV9LRVlDVEwo
S0VZQ1RMX0pPSU5fU0VTU0lPTl9LRVlSSU5HLCAwLCAwLCAwLCAwKTsKIAotCWRoX3BhcmFtcy0+
cHJpdiA9IFNBRkVfTkVXX1VTRVJfS0VZKCJkaF9wcml2IiwgZGhfcHJpdiwgc2l6ZW9mKGRoX3By
aXYpLAorCWRoX3BhcmFtcy0+cHJpdmF0ZSA9IFNBRkVfTkVXX1VTRVJfS0VZKCJkaF9wcml2Iiwg
ZGhfcHJpdiwgc2l6ZW9mKGRoX3ByaXYpLAogCQkJCSAgICAgICBLRVlfU1BFQ19QUk9DRVNTX0tF
WVJJTkcpOwogCWRoX3BhcmFtcy0+cHJpbWUgPSBTQUZFX05FV19VU0VSX0tFWSgiZGhfcHJpbWUi
LCBkaF9wcmltZSwgc2l6ZW9mKGRoX3ByaW1lKSwKIAkJCQkJS0VZX1NQRUNfUFJPQ0VTU19LRVlS
SU5HKTsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0
bDI4LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwyOC5jCmluZGV4
IDRjN2Y2YmUxN2UuLjE1Y2EzYjhmZWYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMva2V5Y3RsL2tleWN0bDI4LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9r
ZXljdGwva2V5Y3RsMjguYwpAQCAtNzgsNyArNzgsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQogCWtleV9iYXNlID0gU0FGRV9ORVdfVVNFUl9LRVkoImRoX2Jhc2UiLCBkaF9iYXNlLCBzaXpl
b2YoZGhfYmFzZSksCiAJCQkJS0VZX1NQRUNfUFJPQ0VTU19LRVlSSU5HKTsKIAotCWRoX3BhcmFt
cy0+cHJpdiA9IGtleV9wcml2OworCWRoX3BhcmFtcy0+cHJpdmF0ZSA9IGtleV9wcml2OwogCWRo
X3BhcmFtcy0+cHJpbWUgPSBrZXlfcHJpbWU7CiAJZGhfcGFyYW1zLT5iYXNlID0ga2V5X2Jhc2U7
CiAKLS0gCjIuNTUuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
