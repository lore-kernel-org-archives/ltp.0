Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8634BC54E60
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 21:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FEFC3D05AA
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 22:10:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80B863CDC8A
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 22:10:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7414F6005C3
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 22:10:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D49F15BD0E;
 Sun, 17 Mar 2024 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710709806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQJD8dG4TpkvpfsjHsoCKaZHtO3Y9Hpf9Ny05ne1S/E=;
 b=DJ+wHX37im86UU4YrJyS3icYi3NYYfLfrlxf+qTCHZSEmOi4D1D6fPwXVXVy3rJTvYj5FD
 yPRr4VOSbu4ytC0SK2jfLCC9A/P0QdpUntIiOtr1it8vbNzz6JwxsBZXNF22N9igqMox40
 u5A76Er4ATxDOcX+NyXSRkuh03n5njM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710709806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQJD8dG4TpkvpfsjHsoCKaZHtO3Y9Hpf9Ny05ne1S/E=;
 b=/qKiudv5o6s6aSTnHLyOGVyQil13N0pQddzRBIvfa7qR1wQrohCWFxzqOs9I2s19GA0/Yj
 AW+mg6SCDGSUIVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710709803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQJD8dG4TpkvpfsjHsoCKaZHtO3Y9Hpf9Ny05ne1S/E=;
 b=K2IHdm1Yb3Ooj8l97oXN2WQpV1vIDTwe0gsQFkvHeOn+80LeFfOmCsuYCJtuOLB93c0ruM
 Dq6/CRfM45BbINtrn+oeaaVpyiLD5WTAHTKuK+C6tzGTISfp1t3ashYEA83D0bsYOaa3sf
 Pgf46SAl7HZcM8RDbluphuUBHaWEHHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710709803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQJD8dG4TpkvpfsjHsoCKaZHtO3Y9Hpf9Ny05ne1S/E=;
 b=w6IsGiuSpeR9m1QRddcpugi8+Pq0wefvW2gWJDDaS/osM0ZP1JprD7FDBGRDUybbnGNVd3
 QlrJkBz+/xJWK4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B78301349D;
 Sun, 17 Mar 2024 21:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1kzSKytc92V8BQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 17 Mar 2024 21:10:03 +0000
Date: Sun, 17 Mar 2024 22:10:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240317211002.GB358991@pevik>
References: <20240317093901.3212684-1-liwang@redhat.com>
 <20240317093901.3212684-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240317093901.3212684-2-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K2IHdm1Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w6IsGiuS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D49F15BD0E
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] kconfig: add funtion to parse /proc/cmdline
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

SGkgTGksCgo+IEEgbmV3IHN0cnVjdHVyZSB0c3Rfa2NtZGxpbmVfdmFyIGlzIGRlZmluZWQgdG8g
aG9sZCBhIGNvbW1hbmQtbGluZQo+IGFyZ3VtZW50J3Mga2V5IGFuZCBhIGZpeGVkLXNpemUgdmFs
dWUuIEZ1cnRoZXJtb3JlLCBmdW5jdGlvbgo+IHRzdF9rY21kbGluZV9wYXJzZSBpcyBhZGRlZCB0
byB0aGUgY29ycmVzcG9uZGluZyAuYyBmaWxlLCB3aGljaAo+IHJlYWRzIGZyb20gL3Byb2MvY21k
bGluZSwgcGFyc2VzIHRoZSBjb21tYW5kLWxpbmUgYXJndW1lbnRzLCBhbmQKPiBwb3B1bGF0ZXMg
dGhlIHRzdF9rY21kbGluZV92YXIgYXJyYXkgd2l0aCB0aGUgb2J0YWluZWQga2V5LXZhbHVlCj4g
cGFpcnMsIGVuc3VyaW5nIHNhZmUgZmlsZSBvcGVyYXRpb25zIGFuZCBidWZmZXIgc2l6ZSBjaGVj
a3MuCgpOaWNlLiBKdXN0IGNvbXBpbGVyIHdhcm5pbmcgYW5kIGZvcm1hdHRpbmcgbml0cyBiZWxv
dyAoanVzdCBmaXggdGhlbSBiZWZvcmUgbWVyZ2UpLgpUaGFua3MgYSBsb3QgZm9yIGFkZGluZyBh
IHRlc3QuCgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cgo+IFNpZ25l
ZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICBpbmNsdWRlL3Rz
dF9rY29uZmlnLmggICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKwo+ICBsaWIvbmV3bGli
X3Rlc3RzL3Rlc3Rfa2NvbmZpZzAzLmMgfCA0MCArKysrKysrKysrKysrKysrKysrCj4gIGxpYi90
c3Rfa2NvbmZpZy5jICAgICAgICAgICAgICAgICB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgbGliL25ld2xpYl90ZXN0cy90ZXN0X2tjb25maWcwMy5jCgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3RzdF9rY29uZmlnLmggYi9pbmNsdWRlL3RzdF9rY29uZmlnLmgKPiBpbmRl
eCA4YjI0YTgzODAuLmJiYjg5OTc4NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF9rY29uZmln
LmgKPiArKysgYi9pbmNsdWRlL3RzdF9rY29uZmlnLmgKPiBAQCAtNiw2ICs2LDggQEAKPiAgI2lm
bmRlZiBUU1RfS0NPTkZJR19IX18KPiAgI2RlZmluZSBUU1RfS0NPTkZJR19IX18KCj4gKyNpbmNs
dWRlIDxzdGRib29sLmg+Cj4gKwo+ICAvKioKPiAgICogSW5pdGlhbGl6YXRpb24gaGVscGVyIG1h
Y3JvIGZvciBzdHJ1Y3QgdHN0X2tjb25maWdfdmFyLiBSZXF1aXJlcyA8c3RyaW5nLmg+CnZlcnkg
bmljOiBtaXNzaW5nIGRvdCBhdCB0aGUgZW5kLgo+ICAgKi8KPiBAQCAtNjQsNCArNjYsMzEgQEAg
dm9pZCB0c3Rfa2NvbmZpZ19yZWFkKHN0cnVjdCB0c3Rfa2NvbmZpZ192YXIgdmFyc1tdLCBzaXpl
X3QgdmFyc19sZW4pOwo+ICAgKi8KPiAgaW50IHRzdF9rY29uZmlnX2NoZWNrKGNvbnN0IGNoYXIg
KmNvbnN0IGtjb25maWdzW10pOwoKPiArLyoqCj4gKyAqIE1hY3JvIHRvIGluaXRpYWxpemUgYSB0
c3Rfa2NtZGxpbmVfdmFyIHN0cnVjdHVyZSB3aXRoIGEgc3BlY2lmaWVkIHBhcmFtZXRlcgo+ICsg
KiBuYW1lIGFuZCBhbiBlbXB0eSB2YWx1ZS4gVGhpcyBpcyB1c2VmdWwgZm9yIHNldHRpbmcgdXAg
YW4gYXJyYXkgb2YgcGFyYW1ldGVyCj4gKyAqIHN0cnVjdHVyZXMgYmVmb3JlIHBhcnNpbmcgdGhl
IGFjdHVhbCBjb21tYW5kLWxpbmUgYXJndW1lbnRzLgo+ICsgKi8KPiArI2RlZmluZSBUU1RfS0NN
RExJTkVfSU5JVChwYXJhbmFtZSkgeyBcCj4gKwkua2V5ID0gcGFyYW5hbWUsIFwKPiArCS52YWx1
ZSA9ICIiLCBcCj4gKwkuZm91bmQgPSBmYWxzZSBcCj4gK30KPiArCj4gKy8qKgo+ICsgKiBTdHJ1
Y3R1cmUgZm9yIHN0b3JpbmcgY29tbWFuZC1saW5lIHBhcmFtZXRlciBrZXkgYW5kIGl0cyBjb3Jy
ZXNwb25kaW5nIHZhbHVlCmFuZCBoZXJlLgoKPiArICovCj4gK3N0cnVjdCB0c3Rfa2NtZGxpbmVf
dmFyIHsKPiArCWNvbnN0IGNoYXIgKmtleTsKPiArCWNoYXIgdmFsdWVbMTI4XTsKPiArCWJvb2wg
Zm91bmQ7Cj4gK307Cj4gKwo+ICsvKioKPiArICogUGFyc2VzIGNvbW1hbmQtbGluZSBwYXJhbWV0
ZXJzIGZyb20gL3Byb2MvY21kbGluZSBhbmQgc3RvcmVzIHRoZW0gaW4gcGFyYW1zIGFycmF5Lgo+
ICsgKiBwYXJhbXM6IFRoZSBhcnJheSBvZiB0c3Rfa2NtZGxpbmVfdmFyIHN0cnVjdHVyZXMgdG8g
YmUgZmlsbGVkIHdpdGggcGFyc2VkIGtleS12YWx1ZSBwYWlycy4KPiArICogcGFyYW1zX2xlbjog
VGhlIGxlbmd0aCBvZiB0aGUgcGFyYW1zIGFycmF5LCBpbmRpY2F0aW5nIGhvdyBtYW55IHBhcmFt
ZXRlcnMgdG8gcGFyc2UuCj4gKyAqLwo+ICt2b2lkIHRzdF9rY21kbGluZV9wYXJzZShzdHJ1Y3Qg
dHN0X2tjbWRsaW5lX3ZhciBwYXJhbXNbXSwgc2l6ZV90IHBhcmFtc19sZW4pOwo+ICsKPiAgI2Vu
ZGlmCS8qIFRTVF9LQ09ORklHX0hfXyAqLwo+IGRpZmYgLS1naXQgYS9saWIvbmV3bGliX3Rlc3Rz
L3Rlc3Rfa2NvbmZpZzAzLmMgYi9saWIvbmV3bGliX3Rlc3RzL3Rlc3Rfa2NvbmZpZzAzLmMKPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uOTM3YzJiMjljCj4gLS0tIC9k
ZXYvbnVsbAo+ICsrKyBiL2xpYi9uZXdsaWJfdGVzdHMvdGVzdF9rY29uZmlnMDMuYwo+IEBAIC0w
LDAgKzEsNDAgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDI0IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPgo+ICsgKi8KPiArCj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICsjaW5jbHVkZSAidHN0
X2tjb25maWcuaCIKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X2tjbWRsaW5lX3ZhciBwYXJhbXNb
XSA9IHsKPiArCVRTVF9LQ01ETElORV9JTklUKCJCT09UX0lNQUdFIiksCj4gKwlUU1RfS0NNRExJ
TkVfSU5JVCgicm9vdCIpLAo+ICsJVFNUX0tDTURMSU5FX0lOSVQoImZvbyIpCj4gK307Cj4gKwo+
ICtzdGF0aWMgdm9pZCBkb190ZXN0KHZvaWQpCj4gK3sKPiArCWludCBpLCBOOwo+ICsKPiArCU4g
PSAoaW50KSBBUlJBWV9TSVpFKHBhcmFtcyk7Cj4gKwo+ICsJdHN0X2tjbWRsaW5lX3BhcnNlKHBh
cmFtcywgTik7Cj4gKwo+ICsJZm9yIChpID0gMDsgaSA8IE47IGkrKykgewo+ICsJCWlmIChwYXJh
bXNbaV0uZm91bmQpIHsKPiArCQkJaWYgKHBhcmFtc1tpXS52YWx1ZSkKCnRlc3Rfa2NvbmZpZzAz
LmM6MjU6Mjk6IHdhcm5pbmc6IHRoZSBjb21wYXJpc29uIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFz
IOKAmHRydWXigJkgZm9yIHRoZSBhZGRyZXNzIG9mIOKAmHZhbHVl4oCZIHdpbGwgbmV2ZXIgYmUg
TlVMTCBbLVdhZGRyZXNzXQogICAyNSB8ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChwYXJh
bXNbaV0udmFsdWUpCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgpJ
biBmaWxlIGluY2x1ZGVkIGZyb20gdGVzdF9rY29uZmlnMDMuYzo3OgouLi8uLi9pbmNsdWRlL3Rz
dF9rY29uZmlnLmg6ODU6MTQ6IG5vdGU6IOKAmHZhbHVl4oCZIGRlY2xhcmVkIGhlcmUKICAgODUg
fCAgICAgICAgIGNoYXIgdmFsdWVbMTI4XTsKCkl0IG11c3QgYmU6CmlmIChwYXJhbXNbaV0udmFs
dWVbMF0gIT0gJ1wwJykKCk9yIGp1c3Qgd2l0aG91dCBlbHNlIGF0IGFsbDoKCglmb3IgKGkgPSAw
OyBpIDwgTjsgaSsrKSB7CgkJaWYgKHBhcmFtc1tpXS5mb3VuZCkgewoJCQl0c3RfcmVzKFRQQVNT
LCAicGFyYW1zWyVkXSA9IHslcywgJXN9IiwgaSwgcGFyYW1zW2ldLmtleSwgcGFyYW1zW2ldLnZh
bHVlKTsKCQl9IGVsc2UgewoJCQlpZiAoIXN0cmNtcChwYXJhbXNbaV0ua2V5LCAiZm9vIikpCgkJ
CQl0c3RfcmVzKFRQQVNTLCAiJXMgaXMgbm90IGZvdW5kIGluIC9wcm9jL2NtZGxpbmUiLCBwYXJh
bXNbaV0ua2V5KTsKCQkJZWxzZQoJCQkJdHN0X3JlcyhURkFJTCwgIiVzIGlzIG5vdCBmb3VuZCBp
biAvcHJvYy9jbWRsaW5lIiwgcGFyYW1zW2ldLmtleSk7CgkJfQoKS2luZCByZWdhcmRzLApQZXRy
Cgo+ICsJCQkJdHN0X3JlcyhUUEFTUywgInBhcmFtc1slZF0gPSB7JXMsICVzfSIsIGksIHBhcmFt
c1tpXS5rZXksIHBhcmFtc1tpXS52YWx1ZSk7Cj4gKwkJCWVsc2UKPiArCQkJCXRzdF9yZXMoVFBB
U1MsICJwYXJhbXNbJWRdID0geyVzLCBubyB2YWx1ZX0iLCBpLCBwYXJhbXNbaV0ua2V5KTsKPiAr
CQl9IGVsc2Ugewo+ICsJCQlpZiAoIXN0cmNtcChwYXJhbXNbaV0ua2V5LCAiZm9vIikpCj4gKwkJ
CQl0c3RfcmVzKFRQQVNTLCAiJXMgaXMgbm90IGZvdW5kIGluIC9wcm9jL2NtZGxpbmUiLCBwYXJh
bXNbaV0ua2V5KTsKPiArCQkJZWxzZQo+ICsJCQkJdHN0X3JlcyhURkFJTCwgIiVzIGlzIG5vdCBm
b3VuZCBpbiAvcHJvYy9jbWRsaW5lIiwgcGFyYW1zW2ldLmtleSk7Cj4gKwkJfQo+ICsJfQo+ICt9
Ci4uLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
