Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5143ECA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 11:57:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52503C4AED
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 13:57:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7533C30FC
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:57:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6060F1A0049B
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:57:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C313D1FBAB;
 Mon,  2 Sep 2024 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725278244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2brwZnuypyvwtjQ+k3SQ4d+uZIbnHrOb+YKH5g8yGNA=;
 b=HBxmZ+JAdG1LIoKigyoC4bzFUnxb2NpY/sOI9sf5qqLce05BOLoZ1ktpRITPeCK7lFMXzk
 3lWi69ACAWuAEdcRBVipfRiau01F8oIWe+ugOfSNof62o/p9ILo8VIjXlSEwlsSG3EY+Bf
 eJ8L1Qn4w5RczsJM1NYqfz4fMWZqKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725278244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2brwZnuypyvwtjQ+k3SQ4d+uZIbnHrOb+YKH5g8yGNA=;
 b=8P/+3gDvfVmpwhAuWbMLoDPhPom+vcmqhycHg4jtgnSbsE87zJoRXDpBFDkj22Nh8IXcNs
 NrusLWWu/Q8fmyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725278244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2brwZnuypyvwtjQ+k3SQ4d+uZIbnHrOb+YKH5g8yGNA=;
 b=HBxmZ+JAdG1LIoKigyoC4bzFUnxb2NpY/sOI9sf5qqLce05BOLoZ1ktpRITPeCK7lFMXzk
 3lWi69ACAWuAEdcRBVipfRiau01F8oIWe+ugOfSNof62o/p9ILo8VIjXlSEwlsSG3EY+Bf
 eJ8L1Qn4w5RczsJM1NYqfz4fMWZqKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725278244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2brwZnuypyvwtjQ+k3SQ4d+uZIbnHrOb+YKH5g8yGNA=;
 b=8P/+3gDvfVmpwhAuWbMLoDPhPom+vcmqhycHg4jtgnSbsE87zJoRXDpBFDkj22Nh8IXcNs
 NrusLWWu/Q8fmyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73E2E13AE0;
 Mon,  2 Sep 2024 11:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7EvVGiSo1WZvBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Sep 2024 11:57:24 +0000
Date: Mon, 2 Sep 2024 13:55:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZtWnz_Me7UbAYIVV@yuki.lan>
References: <20240902080330.356551-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240902080330.356551-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] metaparse: mntpoint implies needs_tmpdir
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

SGkhCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4g
Cj4gSSBzZWUgbGliL3RzdF90ZXN0LmMKPiBzdGF0aWMgaW50IG5lZWRzX3RtcGRpcih2b2lkKQo+
IHsKPiAJcmV0dXJuIHRzdF90ZXN0LT5uZWVkc190bXBkaXIgfHwKPiAJICAgICAgIHRzdF90ZXN0
LT5uZWVkc19kZXZpY2UgfHwKPiAJICAgICAgIHRzdF90ZXN0LT5tbnRwb2ludCB8fAo+IAkgICAg
ICAgdHN0X3Rlc3QtPnJlc291cmNlX2ZpbGVzIHx8Cj4gCSAgICAgICB0c3RfdGVzdC0+bmVlZHNf
Y2hlY2twb2ludHM7Cj4gfQo+IAo+IEJ1dAo+IDEpIEl0IGRvZXMgbm90IGRldGVjdCBpdC4KPiAy
KSAtV2FycmF5LWJvdW5kcyBpcyBpbnRyb2R1Y2VkLgo+IAo+IFdoYXQgYW0gSSBtaXNzaW5nPwo+
IEkgb3JpZ2luYWxseSBjb21lIHRvIHRoaXMgdmlhCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI0MDgyOTExNDEyNC4zMDI5OS0xLXdlZ2FvQHN1c2Uu
Y29tLwo+ICh3aGVyZSBJTUhPIC5uZWVkc190bXBkaXIgPSAxIGlzIG5vdCBuZWVkZWQgZHVlIC5t
bnRwb2ludCkKPgo+ICQgY2F0ID4gZm9vLmMgPDxFT0YKPiAjZGVmaW5lIE1OVFBPSU5UICJtbnRw
b2ludCIKPiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAKPiBzdGF0aWMgdm9pZCBkb190ZXN0KHZv
aWQpCj4gewo+IAl0c3RfcmVzKFRQQVNTLCAiZm9vIik7Cj4gfQo+IEVPRgo+IAo+IHN0YXRpYyBz
dHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAJLnRlc3RfYWxsID0gZG9fdGVzdCwKPiAJLm1udHBv
aW50ID0gTU5UUE9JTlQsCj4gfTsKPiAKPiAkIGNkIG1ldGFkYXRhOyBtYWtlIG1ldGFwYXJzZSAm
JiAuL21ldGFwYXJzZSAtSS4uL2luY2x1ZGUgLUkuLi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3V0aWxzLyAuLi9mb28uYwo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBtZXRhcGFyc2UuYzoxNzoK
PiBJbiBmdW5jdGlvbiDigJhkYXRhX25vZGVfc3RyaW5n4oCZLAo+ICAgICBpbmxpbmVkIGZyb20g
4oCYbWFpbuKAmSBhdCBtZXRhcGFyc2UuYzo4OTI6NjoKPiBkYXRhX3N0b3JhZ2UuaDo4NDoyMDog
d2FybmluZzogYXJyYXkgc3Vic2NyaXB0IOKAmHN0cnVjdCBkYXRhX25vZGVbMF3igJkgaXMgcGFy
dGx5IG91dHNpZGUgYXJyYXkgYm91bmRzIG9mIOKAmHVuc2lnbmVkIGNoYXJbNl3igJkgWy1XYXJy
YXktYm91bmRzPV0KPiAgICA4NCB8ICAgICAgICAgbm9kZS0+dHlwZSA9IERBVEFfU1RSSU5HOwo+
ICAgICAgIHwgICAgICAgICB+fn5+fn5+fn5+fl5+fn5+fn5+fn5+fn4KPiBkYXRhX3N0b3JhZ2Uu
aDo3OTozNDogbm90ZTogb2JqZWN0IG9mIHNpemUgNiBhbGxvY2F0ZWQgYnkg4oCYbWFsbG9j4oCZ
Cj4gICAgNzkgfCAgICAgICAgIHN0cnVjdCBkYXRhX25vZGUgKm5vZGUgPSBtYWxsb2Moc2l6ZSk7
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4K
ClRoaXMgc2VlbXMgdG8gYmUgb25lIG9mIHRoZSBnY2MgYnVncywgd2hlcmUgeW91IHNodWZmbGUg
Y29kZSBhIGxpdHRsZQpiaXQgYW5kIGl0IHRyaWdnZXJzIHVzZWxlc3Mgd2FybmluZ3MuIEkgZ3Vl
c3MgdGhhdCB0aGUgY29tcGlsZXIgaXMKY29uZnVzZWQgYnkgdGhlIHVuaW9uIHVzYWdlLiBJdCBn
b2VzIGF3YXkgaWYgeW91IHJld3JpdGUgdGhlIGNvZGUgYXM6CgpkaWZmIC0tZ2l0IGEvbWV0YWRh
dGEvZGF0YV9zdG9yYWdlLmggYi9tZXRhZGF0YS9kYXRhX3N0b3JhZ2UuaAppbmRleCA5MWVhNzBh
MDIuLmNjOWY5ZjIzMyAxMDA2NDQKLS0tIGEvbWV0YWRhdGEvZGF0YV9zdG9yYWdlLmgKKysrIGIv
bWV0YWRhdGEvZGF0YV9zdG9yYWdlLmgKQEAgLTgxLDggKzgxLDEwIEBAIHN0YXRpYyBpbmxpbmUg
c3RydWN0IGRhdGFfbm9kZSAqZGF0YV9ub2RlX3N0cmluZyhjb25zdCBjaGFyICpzdHJpbmcpCiAg
ICAgICAgaWYgKCFub2RlKQogICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7CgotICAgICAgIG5v
ZGUtPnR5cGUgPSBEQVRBX1NUUklORzsKLSAgICAgICBzdHJjcHkobm9kZS0+c3RyaW5nLnZhbCwg
c3RyaW5nKTsKKyAgICAgICBzdHJ1Y3QgZGF0YV9ub2RlX3N0cmluZyAqc3RyX25vZGUgPSAmbm9k
ZS0+c3RyaW5nOworCisgICAgICAgc3RyX25vZGUtPnR5cGUgPSBEQVRBX1NUUklORzsKKyAgICAg
ICBzdHJjcHkoc3RyX25vZGUtPnZhbCwgc3RyaW5nKTsKCkFsc28gaXQgc2VlbXMgdGhhdCBjbGFu
ZyBpcyBzbWFydCBlbm91Z2ggbm90IHRvIHByb2R1Y2UgdGhlIHdhcm5pbmdzLgoKPiBIT1NUQ0Mg
bWV0YWRhdGEvbWV0YXBhcnNlCj4gICAiZm9vIjogewo+ICAgICJmbmFtZSI6ICIuLi4vZm9vLmMi
Cj4gCj4gIG1ldGFkYXRhL21ldGFwYXJzZS5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9tZXRhZGF0YS9tZXRhcGFyc2UuYyBiL21ldGFk
YXRhL21ldGFwYXJzZS5jCj4gaW5kZXggMjM4NGM3M2M4Ni4uMjRiZjBmMDk2OCAxMDA2NDQKPiAt
LS0gYS9tZXRhZGF0YS9tZXRhcGFyc2UuYwo+ICsrKyBiL21ldGFkYXRhL21ldGFwYXJzZS5jCj4g
QEAgLTgwMSw2ICs4MDEsNyBAQCBzdGF0aWMgc3RydWN0IGltcGxpZXMgewo+ICAJCU5VTEx9fSwK
PiAgCXsiYWxsX2ZpbGVzeXN0ZW1zIiwgKGNvbnN0IGNoYXIgKltdKSB7Im5lZWRzX2RldmljZSIs
ICJuZWVkc190bXBkaXIiLAo+ICAJCU5VTEx9fSwKPiArCXsibW50cG9pbnQiLCAoY29uc3QgY2hh
ciAqW10pIHsibmVlZHNfdG1wZGlyIiwgTlVMTH19LAo+ICAJeyJuZWVkc19kZXZpY2UiLCAoY29u
c3QgY2hhciAqW10pIHsibmVlZHNfdG1wZGlyIiwgTlVMTH19LAo+ICAJeyJuZWVkc19jaGVja3Bv
aW50cyIsIChjb25zdCBjaGFyICpbXSkgeyJuZWVkc190bXBkaXIiLCBOVUxMfX0sCj4gIAl7InJl
c291cmNlX2ZpbGVzIiwgKGNvbnN0IGNoYXIgKltdKSB7Im5lZWRzX3RtcGRpciIsIE5VTEx9fSwK
PiAtLSAKPiAyLjQ1LjIKPiAKCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
