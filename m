Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F193C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 08:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29CB23D1C09
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 10:42:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAA173D0EA8
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE2E214052E9
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA8A41FCE9;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlEsx/1rfe2CKR3pDFcr9YIwqcE+D0JAm46jMzbzTy0=;
 b=DLVFkGTCUWazYYM/I4mWij/mNhUPsy1sVIK7+pJw+2U35aU57oG/ghHE0N6nTi36LKH9c5
 J0/Fu/XV1fPWymitm4CRqm3nAQYn9H/qPexZwOZdhgeAb41MvA4HopaVzugNTReomTe7fM
 sTDWcjEOC6hO5+lbiC1Pey3YymWjOqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlEsx/1rfe2CKR3pDFcr9YIwqcE+D0JAm46jMzbzTy0=;
 b=zpLiscFW/bJRCPjBboWOZy9cbFdpj9wh3eZ7PNVsGHwI+qVZzvm3o5tfal2/+KHqbUY+kN
 l18EPG7CAmK+TrCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlEsx/1rfe2CKR3pDFcr9YIwqcE+D0JAm46jMzbzTy0=;
 b=DLVFkGTCUWazYYM/I4mWij/mNhUPsy1sVIK7+pJw+2U35aU57oG/ghHE0N6nTi36LKH9c5
 J0/Fu/XV1fPWymitm4CRqm3nAQYn9H/qPexZwOZdhgeAb41MvA4HopaVzugNTReomTe7fM
 sTDWcjEOC6hO5+lbiC1Pey3YymWjOqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlEsx/1rfe2CKR3pDFcr9YIwqcE+D0JAm46jMzbzTy0=;
 b=zpLiscFW/bJRCPjBboWOZy9cbFdpj9wh3eZ7PNVsGHwI+qVZzvm3o5tfal2/+KHqbUY+kN
 l18EPG7CAmK+TrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C4171396E;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJxNJMdsn2Z/bAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 08:41:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 10:41:12 +0200
MIME-Version: 1.0
Message-Id: <20240723-mseal-v2-2-5aa872d611bc@suse.com>
References: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
In-Reply-To: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6133;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=QMs/6VufcdWjcSHeYw01qp6rCyMCtywX4MQVCzhgpxE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn2yy1J6Ue4EH6OHH/9bcCLVKWXvsoOJ3rMs7S
 0NEnQtiZXKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9ssgAKCRDLzBqyILPm
 RrflC/94rN9MsYAOleLlzkT2/ZUO5nnHvBRZxcSNmHZzRDH6xHW0pUlAs3yyg/lCFnRHs+cYLXW
 DsuVTLUq138quy2aRjBiIfXUWfZG7Qs9xaqTYuF2Qe2o+gA+1srMOiV6HARa20NX8KF6Vjq+JLu
 GXBpDdgX6fRGEzgX66SmQ38qV7jqoUCTodsu0GdHK1n2Coy1yGclxFwmML+lFVsPc/xGvPBKBld
 G/FiFHwV/lQU+rMgUSsg9jdpNh5cxcae6CNM82hqvnPjzMmwq7AD06cOaNYIuzBx/OCBj3RzjDw
 6Bb7+6A2gJ4QdiqwP8zLu7wah+GXd53Dr9jiDvO8TMl3A251Y1U4OyFkYn7iGWJqWm8uS1oAV6S
 tmUxzSjRz2qI3NtM7s7/CAvAnib10F02W4tfI4lho9+dfPkKVcGMbbGkqXwqGk4Nis2IUWWrT7F
 JPLOnFcs9V1SNv1kv/htKPyPqW9OqSSo7kBHxNKeXfhpPtyyvw9zhfPJEapJ802nH8mLA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add mseal01 test
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

RnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KClRoaXMg
aXMgYSBzbW9rZSB0ZXN0IHRoYXQgdmVyaWZpZXMgaWYgbXNlYWwoKSBwcm90ZWN0cyBzcGVjaWZp
YyBWTUEKcG9ydGlvbnMgb2YgYSBwcm9jZXNzLiBBY2NvcmRpbmcgdG8gZG9jdW1lbnRhdGlvbiwg
dGhlIHN5c2NhbGwgc2hvdWxkCnByb3RlY3QgbWVtb3J5IGZyb20gdGhlIGZvbGxvd2luZyBhY3Rp
b25zOgoKLSB1bm1hcHBpbmcsIG1vdmluZyB0byBhbm90aGVyIGxvY2F0aW9uLCBhbmQgc2hyaW5r
aW5nIHRoZSBzaXplLCB2aWEKICBtdW5tYXAoKSBhbmQgbXJlbWFwKCkKLSBtb3Zpbmcgb3IgZXhw
YW5kaW5nIGEgZGlmZmVyZW50IFZNQSBpbnRvIHRoZSBjdXJyZW50IGxvY2F0aW9uLCB2aWEKICBt
cmVtYXAoKQotIG1vZGlmeWluZyBhIFZNQSB2aWEgbW1hcChNQVBfRklYRUQpCi0gbXByb3RlY3Qo
KSBhbmQgcGtleV9tcHJvdGVjdCgpCi0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJlaGF2aW9ycyAo
ZS5nLiBNQURWX0RPTlRORUVEKSBmb3IgYW5vbnltb3VzCiAgbWVtb3J5LCB3aGVuIHVzZXJzIGRv
buKAmXQgaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBtZW1vcnkKCkFueSBvZiB0aGUgZGVz
Y3JpYmVkIGFjdGlvbnMgaXMgcmVjb2duaXplZCB2aWEgRVBFUk0gZXJybm8uCgpTaWduZWQtb2Zm
LWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgotLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZSB8ICAgMSArCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL01ha2VmaWxlICAgfCAgIDcgKysKIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jICB8IDE3MyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxODEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZSBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZQpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwMDAuLmUxMzA5MDk5NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZQpAQCAtMCwwICsxIEBACittc2VhbDAxCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL01ha2VmaWxlIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAuLjM1MzE3ZjQ0NgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvTWFrZWZpbGUKQEAgLTAsMCArMSw3IEBACisjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisjIENvcHlyaWdodCAoQykgMjAy
MyBTVVNFIExMQyBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgor
Cit0b3Bfc3JjZGlyCQk/PSAuLi8uLi8uLi8uLgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5j
bHVkZS9tay90ZXN0Y2FzZXMubWsKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dl
bmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbXNlYWwvbXNlYWwwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2Vh
bDAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi4xM2YxYTBiOTIKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEu
YwpAQCAtMCwwICsxLDE3MyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQorLyoKKyAqIENvcHlyaWdodCAoQykgMjAyNCBTVVNFIExMQyBBbmRyZWEgQ2VydmVzYXRv
IDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgorICovCisKKy8qXAorICogW0Rlc2NyaXB0aW9u
XQorICoKKyAqIFRoaXMgaXMgYSBzbW9rZSB0ZXN0IHRoYXQgdmVyaWZpZXMgaWYgbXNlYWwoKSBw
cm90ZWN0cyBzcGVjaWZpYyBWTUEgcG9ydGlvbnMKKyAqIG9mIGEgcHJvY2Vzcy4gQWNjb3JkaW5n
IHRvIGRvY3VtZW50YXRpb24sIHRoZSBzeXNjYWxsIHNob3VsZCBwcm90ZWN0IG1lbW9yeQorICog
ZnJvbSB0aGUgZm9sbG93aW5nIGFjdGlvbnM6CisgKgorICogLSB1bm1hcHBpbmcsIG1vdmluZyB0
byBhbm90aGVyIGxvY2F0aW9uLCBhbmQgc2hyaW5raW5nIHRoZSBzaXplLCB2aWEgbXVubWFwKCkK
KyAqICAgYW5kIG1yZW1hcCgpCisgKiAtIG1vdmluZyBvciBleHBhbmRpbmcgYSBkaWZmZXJlbnQg
Vk1BIGludG8gdGhlIGN1cnJlbnQgbG9jYXRpb24sIHZpYSBtcmVtYXAoKQorICogLSBtb2RpZnlp
bmcgYSBWTUEgdmlhIG1tYXAoTUFQX0ZJWEVEKQorICogLSBtcHJvdGVjdCgpIGFuZCBwa2V5X21w
cm90ZWN0KCkKKyAqIC0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJlaGF2aW9ycyAoZS5nLiBNQURW
X0RPTlRORUVEKSBmb3IgYW5vbnltb3VzIG1lbW9yeSwKKyAqICAgd2hlbiB1c2VycyBkb27igJl0
IGhhdmUgd3JpdGUgcGVybWlzc2lvbiB0byB0aGUgbWVtb3J5CisgKgorICogQW55IG9mIHRoZSBk
ZXNjcmliZWQgYWN0aW9ucyBpcyByZWNvZ25pemVkIHZpYSBFUEVSTSBlcnJuby4KKyAqLworCisj
ZGVmaW5lIF9HTlVfU09VUkNFCisKKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorI2luY2x1ZGUgImxh
cGkvc3lzY2FsbHMuaCIKKworI2RlZmluZSBNRU1QQUdFUyA4CisjZGVmaW5lIE1FTVNFQUwgMgor
CitzdGF0aWMgdm9pZCAqbWVtX2FkZHI7CitzdGF0aWMgaW50IG1lbV9zaXplOworc3RhdGljIGlu
dCBtZW1fb2Zmc2V0Oworc3RhdGljIGludCBtZW1fYWxpZ25tZW50OworCitzdGF0aWMgaW5saW5l
IGludCBzeXNfbXNlYWwodm9pZCAqc3RhcnQsIHNpemVfdCBsZW4pCit7CisJcmV0dXJuIHRzdF9z
eXNjYWxsKF9fTlJfbXNlYWwsIHN0YXJ0LCBsZW4sIDApOworfQorCitzdGF0aWMgdm9pZCB0ZXN0
X21wcm90ZWN0KHZvaWQpCit7CisJVFNUX0VYUF9GQUlMKG1wcm90ZWN0KG1lbV9hZGRyLCBtZW1f
c2l6ZSwgUFJPVF9OT05FKSwgRVBFUk0pOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X3BrZXlfbXBy
b3RlY3Qodm9pZCkKK3sKKwlpbnQgcmV0OworCWludCBwa2V5OworCisJcGtleSA9IHRzdF9zeXNj
YWxsKF9fTlJfcGtleV9hbGxvYywgMCwgMCk7CisJaWYgKHBrZXkgPT0gLTEpIHsKKwkJaWYgKGVy
cm5vID09IEVJTlZBTCkKKwkJCXRzdF9icmsoVENPTkYsICJwa3UgaXMgbm90IHN1cHBvcnRlZCBv
biB0aGlzIENQVSIpOworCisJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJwa2V5X2FsbG9jKCkg
ZXJyb3IiKTsKKwl9CisKKwlUU1RfRVhQX0ZBSUwodHN0X3N5c2NhbGwoX19OUl9wa2V5X21wcm90
ZWN0LAorCQltZW1fYWRkciwgbWVtX3NpemUsCisJCVBST1RfTk9ORSwKKwkJcGtleSksCisJCUVQ
RVJNKTsKKworCXJldCA9IHRzdF9zeXNjYWxsKF9fTlJfcGtleV9mcmVlLCBwa2V5KTsKKwlpZiAo
cmV0ID09IC0xKQorCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAicGtleV9mcmVlKCkgZXJyb3Ii
KTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tYWR2aXNlKHZvaWQpCit7CisJVFNUX0VYUF9GQUlM
KG1hZHZpc2UobWVtX2FkZHIsIG1lbV9zaXplLCBNQURWX0RPTlRORUVEKSwgRVBFUk0pOworfQor
CitzdGF0aWMgdm9pZCB0ZXN0X211bm1hcCh2b2lkKQoreworCVRTVF9FWFBfRkFJTChtdW5tYXAo
bWVtX2FkZHIsIG1lbV9zaXplKSwgRVBFUk0pOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X21yZW1h
cF9yZXNpemUodm9pZCkKK3sKKwl2b2lkICpuZXdfYWRkcjsKKwlzaXplX3QgbmV3X3NpemUgPSAy
ICogbWVtX2FsaWdubWVudDsKKworCW5ld19hZGRyID0gU0FGRV9NTUFQKE5VTEwsIG1lbV9zaXpl
LAorCQlQUk9UX1JFQUQsCisJCU1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFURSwKKwkJLTEsIDAp
OworCisJVFNUX0VYUF9GQUlMX1BUUl9WT0lEKG1yZW1hcChtZW1fYWRkciwgbWVtX3NpemUsIG5l
d19zaXplLAorCQlNUkVNQVBfTUFZTU9WRSB8IE1SRU1BUF9GSVhFRCwKKwkJbmV3X2FkZHIpLAor
CQlFUEVSTSk7CisKKwlTQUZFX01VTk1BUChuZXdfYWRkciwgbmV3X3NpemUpOworfQorCitzdGF0
aWMgdm9pZCB0ZXN0X21tYXBfY2hhbmdlX3Byb3Qodm9pZCkKK3sKKwlUU1RfRVhQX0ZBSUxfUFRS
X1ZPSUQobW1hcChtZW1fYWRkciwgbWVtX3NpemUsCisJCVBST1RfUkVBRCwKKwkJTUFQX0FOT05Z
TU9VUyB8IE1BUF9QUklWQVRFIHwgTUFQX0ZJWEVELAorCQktMSwgMCksIEVQRVJNKTsKK30KKwor
c3RhdGljIHN0cnVjdCB0Y2FzZSB7CisJdm9pZCAoKmZ1bmNfdGVzdCkodm9pZCk7CisJaW50IHBy
b3Q7CisJY2hhciAqbWVzc2FnZTsKK30gdGNhc2VzW10gPSB7CisJe3Rlc3RfbXByb3RlY3QsIFBS
T1RfUkVBRCB8IFBST1RfV1JJVEUsICJtcHJvdGVjdCgpIGF2YWlsYWJpbGl0eSJ9LAorCXt0ZXN0
X3BrZXlfbXByb3RlY3QsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsICJwa2V5X21wcm90ZWN0KCkg
YXZhaWxhYmlsaXR5In0sCisJe3Rlc3RfbWFkdmlzZSwgUFJPVF9SRUFELCAibWFkdmlzZSgpIGF2
YWlsYWJpbGl0eSJ9LAorCXt0ZXN0X211bm1hcCwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgIm11
bm1hcCgpIGF2YWlsYWJpbGl0eSBmcm9tIGNoaWxkIn0sCisJe3Rlc3RfbXJlbWFwX3Jlc2l6ZSwg
UFJPVF9SRUFEIHwgUFJPVF9XUklURSwgIm1yZW1hcCgpIGFkZHJlc3MgbW92ZS9yZXNpemUifSwK
Kwl7dGVzdF9tbWFwX2NoYW5nZV9wcm90LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCAibW1hcCgp
IHByb3RlY3Rpb24gY2hhbmdlIn0sCit9OworCitzdGF0aWMgdm9pZCBjaGlsZCh1bnNpZ25lZCBp
bnQgbikKK3sKKwlzdHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsKKworCW1lbV9hZGRyID0g
U0FGRV9NTUFQKE5VTEwsIG1lbV9zaXplLAorCQl0Yy0+cHJvdCwKKwkJTUFQX0FOT05ZTU9VUyB8
IE1BUF9QUklWQVRFLAorCQktMSwgMCk7CisKKwl0c3RfcmVzKFRJTkZPLCAiVGVzdGluZyAlcyIs
IHRjLT5tZXNzYWdlKTsKKworCVRTVF9FWFBfUEFTUyhzeXNfbXNlYWwobWVtX2FkZHIgKyBtZW1f
b2Zmc2V0LCBtZW1fYWxpZ25tZW50KSk7CisKKwl0Yy0+ZnVuY190ZXN0KCk7Cit9CisKK3N0YXRp
YyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKK3sKKwkvKiB0aGUgcmVhc29uIHdoeSB3ZSBzcGF3
biBhIGNoaWxkIGlzIHRoYXQgbXNlYWwoKSB3aWxsCisJICogcHJvdGVjdCBWTUEgdW50aWwgcHJv
Y2VzcyB3aWxsIGNhbGwgX2V4aXQoKQorCSAqLworCWlmICghU0FGRV9GT1JLKCkpIHsKKwkJY2hp
bGQobik7CisJCV9leGl0KDApOworCX0KKworCXRzdF9yZWFwX2NoaWxkcmVuKCk7CisKKwlpZiAo
bWVtX2FkZHIgIT0gTUFQX0ZBSUxFRCkKKwkJU0FGRV9NVU5NQVAobWVtX2FkZHIsIG1lbV9zaXpl
KTsKK30KKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sKKwltZW1fYWxpZ25tZW50ID0gZ2V0
cGFnZXNpemUoKTsKKwltZW1fc2l6ZSA9IG1lbV9hbGlnbm1lbnQgKiBNRU1QQUdFUzsKKwltZW1f
b2Zmc2V0ID0gbWVtX2FsaWdubWVudCAqIE1FTVNFQUw7Cit9CisKK3N0YXRpYyB2b2lkIGNsZWFu
dXAodm9pZCkKK3sKKwlpZiAobWVtX2FkZHIgIT0gTUFQX0ZBSUxFRCkKKwkJU0FGRV9NVU5NQVAo
bWVtX2FkZHIsIG1lbV9zaXplKTsKK30KKworc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0g
eworCS50ZXN0ID0gcnVuLAorCS50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAorCS5zZXR1cCA9
IHNldHVwLAorCS5jbGVhbnVwID0gY2xlYW51cCwKKwkubWluX2t2ZXIgPSAiNi4xMCIsCisJLmZv
cmtzX2NoaWxkID0gMSwKK307CisKCi0tIAoyLjQzLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
