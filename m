Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09538C54E4A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 07:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326E53CE96B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 08:16:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83033C08BD
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 08:16:00 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12ED11000451
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 08:15:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36BEC67655;
 Fri,  8 Mar 2024 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709881952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFbmENIMDNNMOY4/iYdFeMSwXeZFKUmCzLjCLZgEc/Y=;
 b=Tph8uJjEd7OZ4KIAQyDQ1lF2wC+vQbAxj1sPCzvEE5wu4b5Kr1Xf686zmk7CL1FomxXMOh
 qQjUqhoEM5rIH4OPG/2Kc+5Ogh/nj9alVcPE7OIX66ByBTPSECtdCMpKjSdyvSxeiWe3H7
 QBQPA2AyDAAOZgs9dCQwxDhzomVz6vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709881952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFbmENIMDNNMOY4/iYdFeMSwXeZFKUmCzLjCLZgEc/Y=;
 b=N2sXf8SL4DoH2nPwwgyoUfFMFhWRkC/0ZEc+wC2tktYUj4fwjelx+xKC6wPzQq/2IPJ+VT
 /8DhOVXemrqZqlDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709881952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFbmENIMDNNMOY4/iYdFeMSwXeZFKUmCzLjCLZgEc/Y=;
 b=Tph8uJjEd7OZ4KIAQyDQ1lF2wC+vQbAxj1sPCzvEE5wu4b5Kr1Xf686zmk7CL1FomxXMOh
 qQjUqhoEM5rIH4OPG/2Kc+5Ogh/nj9alVcPE7OIX66ByBTPSECtdCMpKjSdyvSxeiWe3H7
 QBQPA2AyDAAOZgs9dCQwxDhzomVz6vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709881952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFbmENIMDNNMOY4/iYdFeMSwXeZFKUmCzLjCLZgEc/Y=;
 b=N2sXf8SL4DoH2nPwwgyoUfFMFhWRkC/0ZEc+wC2tktYUj4fwjelx+xKC6wPzQq/2IPJ+VT
 /8DhOVXemrqZqlDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DB881391D;
 Fri,  8 Mar 2024 07:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id JeouBmC66mX6HAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Mar 2024 07:12:32 +0000
Date: Fri, 8 Mar 2024 08:12:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240308071230.GB238191@pevik>
References: <20240308045230.3106549-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308045230.3106549-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] kconfig: add funtion to parse /proc/cmdline
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

SGkgTGksCgo+IEluIHRzdF9rY29uZmlnLmMsIGl0IGFkZHMgdGhlIHRzdF9rY21kbGluZV9wYXJz
ZSBmdW5jdGlvbiB0bwo+IHJlYWQgYW5kIHBhcnNlIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXJzIGZy
b20gL3Byb2MvY21kbGluZS4KPiBUaGlzIGZ1bmN0aW9uIHRva2VuaXplcyB0aGUgY29tbWFuZCBs
aW5lLCBtYXRjaGVzIGtleXMgd2l0aAo+IHRoZSBwcm92aWRlZCBwYXJhbWV0ZXIgYXJyYXksIGFu
ZCBzdG9yZXMgdGhlIGFzc29jaWF0ZWQgdmFsdWVzLgo+IFRoZSB1cGRhdGUgZW5oYW5jZXMgdGhl
IHRlc3RpbmcgZnJhbWV3b3JrJ3MgYWJpbGl0eSB0byBoYW5kbGUKPiBrZXJuZWwgY29uZmlndXJh
dGlvbiBwYXJhbWV0ZXJzIGR5bmFtaWNhbGx5LgoKPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaW5jbHVkZS90c3Rfa2NvbmZpZy5oIHwgMjMgKysr
KysrKysrKysrKysrKysrKysrKysKPiAgbGliL3RzdF9rY29uZmlnLmMgICAgIHwgNDEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA2
NCBpbnNlcnRpb25zKCspCgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9rY29uZmlnLmggYi9p
bmNsdWRlL3RzdF9rY29uZmlnLmgKPiBpbmRleCA4YjI0YTgzODAuLjBlY2YyYzBkMSAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL3RzdF9rY29uZmlnLmgKPiArKysgYi9pbmNsdWRlL3RzdF9rY29uZmln
LmgKPiBAQCAtNjQsNCArNjQsMjcgQEAgdm9pZCB0c3Rfa2NvbmZpZ19yZWFkKHN0cnVjdCB0c3Rf
a2NvbmZpZ192YXIgdmFyc1tdLCBzaXplX3QgdmFyc19sZW4pOwo+ICAgKi8KPiAgaW50IHRzdF9r
Y29uZmlnX2NoZWNrKGNvbnN0IGNoYXIgKmNvbnN0IGtjb25maWdzW10pOwoKPiArLyoqCj4gKyAq
IE1hY3JvIHRvIGluaXRpYWxpemUgYSB0c3Rfa2NtZGxpbmVfcGFyYW0gc3RydWN0dXJlIHdpdGgg
YSBzcGVjaWZpZWQgcGFyYW1ldGVyCj4gKyAqIG5hbWUgYW5kIGFuIGVtcHR5IHZhbHVlLiBUaGlz
IGlzIHVzZWZ1bCBmb3Igc2V0dGluZyB1cCBhbiBhcnJheSBvZiBwYXJhbWV0ZXIKPiArICogc3Ry
dWN0dXJlcyBiZWZvcmUgcGFyc2luZyB0aGUgYWN0dWFsIGNvbW1hbmQtbGluZSBhcmd1bWVudHMu
Cj4gKyAqLwo+ICsjZGVmaW5lIFRTVF9LQ01ETElORV9JTklUKHBhcmFuYW1lKSB7IFwKPiArCS5r
ZXkgPSBwYXJhbmFtZSwgXAo+ICsJLnZhbHVlID0gIiIgXAo+ICt9Cj4gKwo+ICsvKiBTdHJ1Y3R1
cmUgZm9yIHN0b3JpbmcgY29tbWFuZC1saW5lIHBhcmFtZXRlciBrZXkgYW5kIGl0cyBjb3JyZXNw
b25kaW5nIHZhbHVlICovCj4gK3N0cnVjdCB0c3Rfa2NtZGxpbmVfcGFyYW0gewo+ICsJY29uc3Qg
Y2hhciAqa2V5Owo+ICsJY2hhciB2YWx1ZVsxMjhdOwo+ICt9Owo+ICsKPiArLyoqCj4gKyAqIFBh
cnNlcyBjb21tYW5kLWxpbmUgcGFyYW1ldGVycyBmcm9tIC9wcm9jL2NtZGxpbmUgYW5kIHN0b3Jl
cyB0aGVtIGluIHBhcmFtcyBhcnJheQo+ICsgKiBwYXJhbXM6IFRoZSBhcnJheSBvZiB0c3Rfa2Nt
ZGxpbmVfcGFyYW0gc3RydWN0dXJlcyB0byBiZSBmaWxsZWQgd2l0aCBwYXJzZWQga2V5LXZhbHVl
IHBhaXJzCj4gKyAqIHBhcmFtc19sZW46IFRoZSBsZW5ndGggb2YgdGhlIHBhcmFtcyBhcnJheSwg
aW5kaWNhdGluZyBob3cgbWFueSBwYXJhbWV0ZXJzIHRvIHBhcnNlCj4gKyAqLwo+ICt2b2lkIHRz
dF9rY21kbGluZV9wYXJzZShzdHJ1Y3QgdHN0X2tjbWRsaW5lX3BhcmFtIHBhcmFtc1tdLCBzaXpl
X3QgcGFyYW1zX2xlbik7Cj4gKwo+ICAjZW5kaWYJLyogVFNUX0tDT05GSUdfSF9fICovCj4gZGlm
ZiAtLWdpdCBhL2xpYi90c3Rfa2NvbmZpZy5jIGIvbGliL3RzdF9rY29uZmlnLmMKPiBpbmRleCA1
OTVlYTRiMDkuLmY3OWRlYTVjNiAxMDA2NDQKPiAtLS0gYS9saWIvdHN0X2tjb25maWcuYwo+ICsr
KyBiL2xpYi90c3Rfa2NvbmZpZy5jCj4gQEAgLTU2NSwzICs1NjUsNDQgQEAgY2hhciB0c3Rfa2Nv
bmZpZ19nZXQoY29uc3QgY2hhciAqY29uZm5hbWUpCgo+ICAJcmV0dXJuIHZhci5jaG9pY2U7Cj4g
IH0KPiArCj4gK3ZvaWQgdHN0X2tjbWRsaW5lX3BhcnNlKHN0cnVjdCB0c3Rfa2NtZGxpbmVfcGFy
YW0gcGFyYW1zW10sIHNpemVfdCBwYXJhbXNfbGVuKSB7Cj4gKwlGSUxFICpwcm9jX2NtZGxpbmU7
Cj4gKwljaGFyIGNtZGxpbmVbNDA5Nl07Cj4gKwljaGFyICp0b2tlbiwgKmtleSwgKnZhbHVlOwo+
ICsKPiArCXByb2NfY21kbGluZSA9IGZvcGVuKCIvcHJvYy9jbWRsaW5lIiwgInIiKTsKV2h5IG5v
dCBTQUZFX0ZPUEVOKCkgPwo+ICsJaWYgKHByb2NfY21kbGluZSA9PSBOVUxMKQo+ICsJCXRzdF9i
cmsoVEJST0sgfCBURVJSTk8sICJGYWlsZWQgdG8gb3BlbiAvcHJvYy9jbWRsaW5lIGZvciByZWFk
aW5nIik7Cj4gKwo+ICsJaWYgKGZnZXRzKGNtZGxpbmUsIHNpemVvZihjbWRsaW5lKSwgcHJvY19j
bWRsaW5lKSA9PSBOVUxMKSB7Cj4gKwkJZmNsb3NlKHByb2NfY21kbGluZSk7Ck1heWJlIFNBRkVf
RkNMT1NFKCkgPwo+ICsKPiArCQlpZiAoZmVvZihwcm9jX2NtZGxpbmUpKQp0c3Rfa2NvbmZpZy5j
OjU4MToyMTogd2FybmluZzogcG9pbnRlciDigJhwcm9jX2NtZGxpbmXigJkgdXNlZCBhZnRlciDi
gJhmY2xvc2XigJkgWy1XdXNlLWFmdGVyLWZyZWVdCiAgNTgxIHwgICAgICAgICAgICAgICAgIGlm
IChmZW9mKHByb2NfY21kbGluZSkpCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn5+fn4KdHN0X2tjb25maWcuYzo1Nzk6MTc6IG5vdGU6IGNhbGwgdG8g4oCYZmNsb3Nl
4oCZIGhlcmUKICA1NzkgfCAgICAgICAgICAgICAgICAgZmNsb3NlKHByb2NfY21kbGluZSk7CiAg
ICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+Cgo+ICsJCQl0c3RfYnJr
KFRCUk9LLCAiRW5kLW9mLUZpbGUgcmVhY2hlZCBvbiAvcHJvYy9jbWRsaW5lIHdpdGhvdXQgcmVh
ZGluZyBhbnkgZGF0YSIpOwo+ICsJCWVsc2UKPiArCQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywg
IkZhaWxlZCB0byByZWFkIGZyb20gL3Byb2MvY21kbGluZSIpOwo+ICsJfQo+ICsJZmNsb3NlKHBy
b2NfY21kbGluZSk7Ck1heWJlIFNBRkVfRkNMT1NFKCkgPwoKS2luZCByZWdhcmRzLApQZXRyCgo+
ICsKPiArCXRva2VuID0gc3RydG9rKGNtZGxpbmUsICIgIik7Cj4gKwl3aGlsZSAodG9rZW4gIT0g
TlVMTCkgewo+ICsJCWtleSA9IHRva2VuOwo+ICsJCXZhbHVlID0gc3RyY2hyKHRva2VuLCAnPScp
Owo+ICsKPiArCQlpZiAodmFsdWUgIT0gTlVMTCkgewo+ICsJCQkvKiBTcGxpdCB0aGUgdG9rZW4g
aW50byBrZXkgYW5kIHZhbHVlIGF0ICc9JyAqLwo+ICsJCQkqdmFsdWUrKyA9ICdcMCc7Cj4gKwo+
ICsJCQlmb3IgKHNpemVfdCBpID0gMDsgaSA8IHBhcmFtc19sZW47IGkrKykgewo+ICsJCQkJaWYg
KHN0cmNtcChwYXJhbXNbaV0ua2V5LCBrZXkpID09IDApIHsKPiArCQkJCQlzdHJuY3B5KHBhcmFt
c1tpXS52YWx1ZSwgdmFsdWUsIHNpemVvZihwYXJhbXNbaV0udmFsdWUpIC0gMSk7Cj4gKwkJCQkJ
cGFyYW1zW2ldLnZhbHVlW3NpemVvZihwYXJhbXNbaV0udmFsdWUpIC0gMV0gPSAnXDAnOwo+ICsJ
CQkJCWJyZWFrOwo+ICsJCQkJfQo+ICsJCQl9Cj4gKwkJfQo+ICsKPiArCQl0b2tlbiA9IHN0cnRv
ayhOVUxMLCAiICIpOwo+ICsJfQo+ICt9CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
