Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7762F436AD
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 14:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D80E3E5953
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 16:34:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEFB83C0F08
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 16:33:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39DE620013D
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 16:33:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43E086A85C;
 Fri, 17 Apr 2026 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776436416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYuObVEM3VW6xTvSdNfkT5CA+QD3ujvSLnfnskQGngo=;
 b=ByvU68yHGLfWNk2q2lOmgSbwthQMRls48lrQdF+JlfIzwAPUZV30qC9Yrkv7KWJcSrtZno
 5QzVkBP8hafHxwJdR+OwaACNd/0cpP/jVvvTRllPn4A54CG1JFQnLFjADsNxF7+RUw9wws
 hm78QeD+TMTXSKCuX60H7ijqTxqZigE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776436416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYuObVEM3VW6xTvSdNfkT5CA+QD3ujvSLnfnskQGngo=;
 b=GYprtY28QEcW95k8j8JMEx1QcFSz85DGtGVjfifcONxdf93Uyhmj8LKiZ7iOPoUeDySdp5
 qA7typ/C1eULlUDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776436412;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYuObVEM3VW6xTvSdNfkT5CA+QD3ujvSLnfnskQGngo=;
 b=xh+GfWCjfdZ8dM/JE85hUE6AX2J3YKgZf088wNZzYvJPsjPpXBqTxRWrwLRs5KCAq6asJ+
 mdhqW5oG4O4DqrZDrcUEP0d2sTuFKZXO7oHOhqwgTCX5R8gZxi/yCCy33KiwCD+S6CvoWE
 Yvq3AtI15ckr+Xrxq1K3fkYO+e7Sgi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776436412;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYuObVEM3VW6xTvSdNfkT5CA+QD3ujvSLnfnskQGngo=;
 b=x5sCvHS25PmQoEa8UKHDqiaY5/IySsaiSc+s+8AZ+no6CIeWsI00X/SdiUO+rSQeAxI0Qh
 7Dw4WIu+/vad6BDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9589593AE;
 Fri, 17 Apr 2026 14:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rjnyM7tE4mliKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 14:33:31 +0000
Date: Fri, 17 Apr 2026 16:33:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <martin.doucha@suse.com>
Message-ID: <20260417143317.GB420978@pevik>
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
 <20260417130920.GA420978@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260417130920.GA420978@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Add common entry point function for all tests
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKPiBIaSBNYXJ0aW4sCgo+ID4gSGkgTWFydGluLAoKPiA+IE9uIFRodSwgMTYg
QXByIDIwMjYsIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4gPiA+IE9wZW5QT1NJWDogQWRkIGNvbW1v
biBlbnRyeSBwb2ludCBmdW5jdGlvbiBmb3IgYWxsIHRlc3RzCgo+ID4gPiBBZGQgYSBuZXcgc2hh
cmVkIHNvdXJjZSBmaWxlIGltcGxlbWVudGluZyB0aGUgbWFpbigpIGZ1bmN0aW9uIGFuZCByZW5h
bWUKPiA+ID4gdGhlIGV4aXN0aW5nIG1haW4oKSBmdW5jdGlvbnMgaW4gdGVzdCBjYXNlIHNvdXJj
ZXMgdG8gdGVzdF9tYWluKCkuIFRoaXMKPiA+ID4gYWxsb3dzIGFkZGluZyBjdXN0b20gZGVidWcg
Y29kZSB0byBhbGwgdGVzdCBjYXNlcyBhdCBvbmNlLgoKPiA+IFsuLi5dCgo+ID4gPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFj
ZXMvcHRocmVhZF9jcmVhdGUvYXNzZXJ0aW9ucy54bWwgYi8uLi4KPiA+ID4gLSAgTk9URTogdGhh
dCB0aGUgdGhyZWFkIGluIHdoaWNoIG1haW4oKSB3YXMgb3JpZ2luYWxseSBpbnZva2VkIGlzIGRp
ZmZlcmVudAo+ID4gPiArICBOT1RFOiB0aGF0IHRoZSB0aHJlYWQgaW4gd2hpY2ggdGVzdF9tYWlu
KCkgd2FzIG9yaWdpbmFsbHkgaW52b2tlZCBpcyBkaWZmZXJlbnQKCj4gPiBUaGlzIGNoYW5nZXMg
dmVyYmF0aW0gUE9TSVggc3BlY2lmaWNhdGlvbiB0ZXh0LiBUaGUgYXNzZXJ0aW9ucy54bWwgZmls
ZXMKPiA+IHF1b3RlIHRoZSBQT1NJWCBzdGFuZGFyZCwgd2hpY2ggZGVmaW5lcyBiZWhhdmlvdXIg
cmVsYXRpdmUgdG8gbWFpbigpIOKAlCB0aGUgQwo+ID4gZW50cnkgcG9pbnQsIG5vdCBhbiBMVFAt
aW50ZXJuYWwgZnVuY3Rpb24gbmFtZS4gUmV2ZXJ0IHRoZXNlIGh1bmtzIGluIGJvdGgKPiA+IHB0
aHJlYWRfY3JlYXRlL2Fzc2VydGlvbnMueG1sIGFuZCBwdGhyZWFkX2V4aXQvYXNzZXJ0aW9ucy54
bWwuCgo+ICsxCgo+ID4gPiBkaWZmIC0tZ2l0IGEvLi4uL2Fpb193cml0ZS85LTIuYyBiLy4uLi9h
aW9fd3JpdGUvOS0yLmMKPiA+ID4gK2ludCB0ZXN0X21haW4oaW50IGFyZ2MsIGNoYXIqKiBhcmd2
KQoKPiA+IHMvY2hhcioqIGFyZ3YvY2hhciAqKmFyZ3YvIHRvIG1hdGNoIHRoZSBzdHlsZSB1c2Vk
IGV2ZXJ5d2hlcmUgZWxzZS4KCj4gKzEKCj4gQE1hcnRpbiwgd2lsbCB5b3UgcGxlYXNlIHNlbmQg
djI/CgoKQE1hcnRpbiwgb3IgSSBjYW4gYXBwbHkgdGhlIGZvbGxvd2luZyBkaWZmIGlmIHlvdSBh
Z3JlZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoKZGlmZiAt
LWdpdCB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9wdGhyZWFkX2NyZWF0ZS9hc3NlcnRpb25zLnhtbCB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0
c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX2NyZWF0ZS9hc3NlcnRpb25zLnht
bAppbmRleCA5ZDNjZGE0ZDg3Li43YTVlNjA1NTdkIDEwMDY0NAotLS0gdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9jcmVhdGUvYXNz
ZXJ0aW9ucy54bWwKKysrIHRlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5j
ZS9pbnRlcmZhY2VzL3B0aHJlYWRfY3JlYXRlL2Fzc2VydGlvbnMueG1sCkBAIC0zMywxMiArMzMs
MTIgQEAKICAgSWYgdGhlICdzdGFydF9yb3V0aW5lJyByZXR1cm5zLCB0aGUgZWZmZWN0IHNoYWxs
IGJlIGFzIGlmIHRoZXJlIHdhcyBhbgogICBpbXBsaWNpdCBjYWxsIHRvIHB0aHJlYWRfZXhpdCgp
IHVzaW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgJ3N0YXJ0X3JvdXRpbmUnCiAgIGFzIHRoZSBleGl0
IHN0YXR1cy4KLSAgTk9URTogdGhhdCB0aGUgdGhyZWFkIGluIHdoaWNoIHRlc3RfbWFpbigpIHdh
cyBvcmlnaW5hbGx5IGludm9rZWQgaXMgZGlmZmVyZW50CisgIE5PVEU6IHRoYXQgdGhlIHRocmVh
ZCBpbiB3aGljaCBtYWluKCkgd2FzIG9yaWdpbmFsbHkgaW52b2tlZCBpcyBkaWZmZXJlbnQKICAg
ZnJvbSB0aGlzCiAgIDwvYXNzZXJ0aW9uPgogICA8YXNzZXJ0aW9uIGlkPSI3IiB0YWc9InJlZjpY
U0g2OjMyODQ4OjMyODQ5Ij4KLSAgV2hlbiBpdCByZXR1cm5zIGZyb20gdGVzdF9tYWluKCksIHRo
ZSBlZmZlY3Qgc2hhbGwgYmUgYXMgaWYgdGhlcmUgd2FzIGFuIGltcGxpY2l0Ci0gIGNhbGwgdG8g
ZXhpdCgpIHVzaW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgdGVzdF9tYWluKCkgYXMgdGhlIGV4aXQg
c3RhdHVzLgorICBXaGVuIGl0IHJldHVybnMgZnJvbSBtYWluKCksIHRoZSBlZmZlY3Qgc2hhbGwg
YmUgYXMgaWYgdGhlcmUgd2FzIGFuIGltcGxpY2l0CisgIGNhbGwgdG8gZXhpdCgpIHVzaW5nIHRo
ZSByZXR1cm4gdmFsdWUgb2YgbWFpbigpIGFzIHRoZSBleGl0IHN0YXR1cy4KICAgPC9hc3NlcnRp
b24+CiAgIDxhc3NlcnRpb24gaWQ9IjgiIHRhZz0icmVmOlhTSDY6MzI4NTA6MzI4NTIiPgogICBU
aGUgc2lnbmFsIHN0YXRlIG9mIHRoZSBuZXcgdGhyZWFkIHdpbGwgYmUgaW5pdGlhbGl6ZWQgYXMg
c286CmRpZmYgLS1naXQgdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNl
L2ludGVyZmFjZXMvcHRocmVhZF9leGl0L2Fzc2VydGlvbnMueG1sIHRlc3RjYXNlcy9vcGVuX3Bv
c2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3B0aHJlYWRfZXhpdC9hc3NlcnRp
b25zLnhtbAppbmRleCAxNWQyYTA5YTExLi5mMzRmNmExOTdlIDEwMDY0NAotLS0gdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9leGl0
L2Fzc2VydGlvbnMueG1sCisrKyB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9y
bWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX2V4aXQvYXNzZXJ0aW9ucy54bWwKQEAgLTI0LDcgKzI0
LDcgQEAKICAgPC9hc3NlcnRpb24+CiAgIDxhc3NlcnRpb24gaWQ9IjUiIHRhZz0icmVmOlhTSDY6
MzMwMzE6MzMwMzMiPgogICBBbiBpbXBsaWNpdCBjYWxsIHRvIHB0aHJlYWRfZXhpdCgpIGlzIG1h
ZGUgd2hlbiBhIHRocmVhZCBvdGhlciB0aGFuIHRoZQotICB0aHJlYWQgaW4gd2hpY2ggdGVzdF9t
YWluKCkgd2FzIGZpcnN0IGludm9rZWQgcmV0dXJucyBmcm9tIHRoZSBzdGFydCByb3V0aW5lIHRo
YXQKKyAgdGhyZWFkIGluIHdoaWNoIG1haW4oKSB3YXMgZmlyc3QgaW52b2tlZCByZXR1cm5zIGZy
b20gdGhlIHN0YXJ0IHJvdXRpbmUgdGhhdAogICB3YXMgdXNlZCB0byBjcmVhdGUgaXQuICBUaGUg
ZnVuY3Rpb24ncyByZXR1cm4gdmFsdWUgc2hhbGwgc2VydmUgYXMgdGhlCiAgIHRocmVhZCdzIGV4
aXQgc3RhdHVzLgogICA8L2Fzc2VydGlvbj4KZGlmZiAtLWdpdCB0ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zdHJjcHkvMS0xLmMgdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc3RyY3B5LzEtMS5j
CmluZGV4IDQ0MTY1NGVkNmMuLmU3ODNmYzkyZWEgMTAwNjQ0Ci0tLSB0ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zdHJjcHkvMS0xLmMKKysrIHRl
c3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3N0cmNw
eS8xLTEuYwpAQCAtNDQsNyArNDQsNyBAQCBzdGF0aWMgY2hhciAqcmFuZG9tX3N0cmluZyhpbnQg
bGVuKQogICAgIHJldHVybiBvdXRwdXRfc3RyaW5nOwogfQogCi1pbnQgdGVzdF9tYWluKGludCBh
cmdjLCBjaGFyKiogYXJndikKK2ludCB0ZXN0X21haW4oaW50IGFyZ2MgUFRTX0FUVFJJQlVURV9V
TlVTRUQsIGNoYXIgKiphcmd2IFBUU19BVFRSSUJVVEVfVU5VU0VEKQogewogICAgIGNoYXIgKnJl
dF9zdHI7CiAgICAgaW50IGk7CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
