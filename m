Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E37AC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:44:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA20F3D1EFA
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:44:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACF753CFA07
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:08 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9382200C78
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7F831FB4F;
 Thu,  1 Aug 2024 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiH3x3ZIXp3LMu+52amIVKiolNGXh7XPBHPHUWelQIg=;
 b=kW8WBa8c7/DVzCHzhNBRVcea2WHBFm6HaRyHxkBRY5kgKAUILbJdHNeL5jvDPYbQfV+n+W
 sbfpaPADf/G0MXWwNl/opfSV9/w01fEfcte/7y677FqjyCEGmol8+Uh9/lV0e6evvQcx9A
 dM8dqI3KYcqEZgpqoOf/3aoY3yJF3lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiH3x3ZIXp3LMu+52amIVKiolNGXh7XPBHPHUWelQIg=;
 b=KyQ6MhkuE0qP9MmB+SPNGvW0xoyBJmene0RFcQXxLXXKiG9ffVYcGAZDzvDrrrnXhrCWuj
 1n9pr+WIO9dTBuBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiH3x3ZIXp3LMu+52amIVKiolNGXh7XPBHPHUWelQIg=;
 b=kW8WBa8c7/DVzCHzhNBRVcea2WHBFm6HaRyHxkBRY5kgKAUILbJdHNeL5jvDPYbQfV+n+W
 sbfpaPADf/G0MXWwNl/opfSV9/w01fEfcte/7y677FqjyCEGmol8+Uh9/lV0e6evvQcx9A
 dM8dqI3KYcqEZgpqoOf/3aoY3yJF3lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiH3x3ZIXp3LMu+52amIVKiolNGXh7XPBHPHUWelQIg=;
 b=KyQ6MhkuE0qP9MmB+SPNGvW0xoyBJmene0RFcQXxLXXKiG9ffVYcGAZDzvDrrrnXhrCWuj
 1n9pr+WIO9dTBuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952DF13946;
 Thu,  1 Aug 2024 12:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cILGHhaDq2Z+YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:44:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:43:51 +0200
MIME-Version: 1.0
Message-Id: <20240801-mseal-v3-2-874f149dce87@suse.com>
References: <20240801-mseal-v3-0-874f149dce87@suse.com>
In-Reply-To: <20240801-mseal-v3-0-874f149dce87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5852;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=6LyWIACwBw0SeW8+tOEHjvrXuk6nGSDOEa5xMTjYXMQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq4MU9P+wIDYFSE+At+Oqjr1tLIcqBVYugQFuW
 8x87onoKGeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZquDFAAKCRDLzBqyILPm
 RsaQC/sFz+ke9Xi+k8xzVAGsDTURTn3zx3F4+1vjXJeAqCw4RfBmkTNgBZnPG4wAFTfH2y/pLNK
 jQw4Bp/POqmCupqH08i9NQ3+PcMxxk6xJ1mDC/lRk1H0ZO28Z/7qk1dscfwey0Bk6jx9bmDe37G
 qSAPbtii2OYfNNpXTL/CcLUu4ppzm+wjT+CPTY9AmVNL3FPb9A91rA5T/dNlmWf6138fP2WlQYz
 ml19ILLd4zgoffw+FQQifFFg0pfrj00jGq8THMu2hyx04ZeTUPqmb0N2EN2AxsyjCPy0eeK1sqA
 +umRWtqsh4YevbZgJCYwt06E1TjJ94k55idnhWVoPW7eAD2zHYJi5WGBiWMSljEnrkWXDEK4Ce4
 TWd3WCO/WkGnC/l19tCOZKTCNfh8NMt41bGMiNGrDa36li+plMC+JASzKIYLA22YNTXlceA9VGw
 Pw671xjCSGwOUJ6lMFEQ3wpxGefkIhOUHd3Gts1ANfgVefRckAxas9DsEPEBF9k9yDT18=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add mseal01 test
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
ZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jICB8IDE1NiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
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
bDAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi5lYjJmNGQ1ODgKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEu
YwpAQCAtMCwwICsxLDE1NiBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
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
IHByb3RlY3Rpb24gY2hhbmdlIn0sCit9OworCitzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50
IG4pCit7CisJLyogdGhlIHJlYXNvbiB3aHkgd2Ugc3Bhd24gYSBjaGlsZCBpcyB0aGF0IG1zZWFs
KCkgd2lsbAorCSAqIHByb3RlY3QgVk1BIHVudGlsIHByb2Nlc3Mgd2lsbCBjYWxsIF9leGl0KCkK
KwkgKi8KKwlpZiAoIVNBRkVfRk9SSygpKSB7CisJCXN0cnVjdCB0Y2FzZSAqdGMgPSAmdGNhc2Vz
W25dOworCisJCW1lbV9hZGRyID0gU0FGRV9NTUFQKE5VTEwsIG1lbV9zaXplLAorCQkJdGMtPnBy
b3QsCisJCQlNQVBfQU5PTllNT1VTIHwgTUFQX1BSSVZBVEUsCisJCQktMSwgMCk7CisKKwkJdHN0
X3JlcyhUSU5GTywgIlRlc3RpbmcgJXMiLCB0Yy0+bWVzc2FnZSk7CisKKwkJVFNUX0VYUF9QQVNT
KHN5c19tc2VhbChtZW1fYWRkciArIG1lbV9vZmZzZXQsIG1lbV9hbGlnbm1lbnQpKTsKKworCQl0
Yy0+ZnVuY190ZXN0KCk7CisJCV9leGl0KDApOworCX0KK30KKworc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKK3sKKwltZW1fYWxpZ25tZW50ID0gZ2V0cGFnZXNpemUoKTsKKwltZW1fc2l6ZSA9IG1l
bV9hbGlnbm1lbnQgKiBNRU1QQUdFUzsKKwltZW1fb2Zmc2V0ID0gbWVtX2FsaWdubWVudCAqIE1F
TVNFQUw7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwkudGVzdCA9IHJ1
biwKKwkudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKKwkuc2V0dXAgPSBzZXR1cCwKKwkubWlu
X2t2ZXIgPSAiNi4xMCIsCisJLmZvcmtzX2NoaWxkID0gMSwKK307CisKCi0tIAoyLjQzLjAKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
