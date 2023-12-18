Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C95C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 04:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F23473CF380
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 05:30:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B61E3C99F7
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 05:30:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 709CE1000421
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 05:30:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F01AA21E0A;
 Mon, 18 Dec 2023 04:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702873835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQs3rh46LiylPo+bYUPNbnEcN4RS3myoaRs315w2ZnQ=;
 b=K5QXv2iQWHOnG80zoF3sJAiDl4D3kdubcHrxotuyJz99d0DV//HPpxTg71/q/JWw3bAON6
 7SMizFaT8ztIGgecQmozLMcoLhGFlBNXDr7dlpGMYOKpfDAUCPGgRhhz+BHv1SfxPlPbvY
 ic4CIMWYe/I7uCvrxecQIuv05dQ0Wrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702873835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQs3rh46LiylPo+bYUPNbnEcN4RS3myoaRs315w2ZnQ=;
 b=NIbD2NDrCA0J5If13MslZ5yGnamVyBMcImq4LYJZpzg1xLPvV10D1FRtT7dn2yKYVQa60A
 gU/dUNN9x63G8bDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702873834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQs3rh46LiylPo+bYUPNbnEcN4RS3myoaRs315w2ZnQ=;
 b=ecciLhTf911fwzK41PoZXKVKNkcmR1u4YBiPB8YVzZOHjXZJmtXldg+YjRtpVbEHLXxcIT
 RNk7YqwZvD116Zz2rE5zf02wuOIhV+kVEv+gl+Ohe+NdQU3dbpAndXmePbTkNmrk8/Z3k/
 3onEVpk/eTlDmNlt5jaGJxGrrp0q4yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702873834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQs3rh46LiylPo+bYUPNbnEcN4RS3myoaRs315w2ZnQ=;
 b=1CLx57yzQ6U5VYxNvyZibH5moZhQeS6MnU+IoAWSdB3UReu1Le+sfjOYsbgh1mIjrVYnpt
 lAAo7jMjzD/kbIAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D7F8E138EE;
 Mon, 18 Dec 2023 04:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id gbYZNOrKf2VtSAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 04:30:34 +0000
Date: Mon, 18 Dec 2023 05:30:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231218043033.GA160518@pevik>
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com>
 <20231215185749.GA58273@pevik>
 <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ecciLhTf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1CLx57yz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[26.80%]
X-Rspamd-Queue-Id: F01AA21E0A
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

SGkgTGksIGFsbCwKCj4gSGkgUGV0ciwgQWxsLAoKPiBPbiBTYXQsIERlYyAxNiwgMjAyMyBhdCAy
OjU44oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIFdlaSwK
Cj4gPiAuLi4KPiA+ID4gKysrIGIvaW5jbHVkZS90c3RfbWVtdXRpbHMuaAo+ID4gPiBAQCAtNTgs
NCArNTgsMTAgQEAgdm9pZCB0c3RfZW5hYmxlX29vbV9wcm90ZWN0aW9uKHBpZF90IHBpZCk7Cj4g
PiA+ICAgKi8KPiA+ID4gIHZvaWQgdHN0X2Rpc2FibGVfb29tX3Byb3RlY3Rpb24ocGlkX3QgcGlk
KTsKCj4gPiA+ICt2b2lkIHRzdF9wcmludF9tZW1pbmZvKHZvaWQpOwo+ID4gPiArCj4gPiA+ICt2
b2lkIHRzdF9wcmludF9tZW1pbmZvXyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
KTsKPiA+ID4gKwo+ID4gPiArI2RlZmluZSB0c3RfcHJpbnRfbWVtaW5mbygpIHRzdF9wcmludF9t
ZW1pbmZvXyhfX0ZJTEVfXywgX19MSU5FX18pCj4gPiBNb3N0IG9mIHRoZSBtYWNyb3Mgd2UgaGF2
ZSB1cHBlciBjYXNlLCBjYW4gaXQgYmUgcGxlYXNlCj4gPiBUU1RfUFJJTlRfTUVNSU5GTygpID8K
PiA+IEkgZ3Vlc3MgaXQgZG9lcyBub3QgaGF2ZSB0byBiZSBTQUZFX1BSSU5UX01FTUlORk8oKS4K
Cj4gPiBBbmQgYmVjYXVzZSBpdCdzIGp1c3Qgb25lIGxpbmVyLCBjb3VsZCBpdCBiZToKCj4gPiAj
ZGVmaW5lIFRTVF9QUklOVF9NRU1JTkZPKCkgc2FmZV9wcmludF9maWxlKF9fRklMRV9fLCBfX0xJ
TkVfXywKPiA+ICIvcHJvYy9tZW1pbmZvIikKCj4gPiAuLi4KCj4gPiA+ICsrKyBiL2xpYi9zYWZl
X21hY3Jvcy5jCgo+ID4gV2UgZG9uJ3Qgd2FudCB0byBhZGQgYW55dGhpbmcgdG8gdGhlIGxlZ2Fj
eSBBUEkgKG90aGVyd2lzZSBpdCB3b3VsZCBnbyB0bwo+ID4gbGliL3NhZmVfZmlsZV9vcHMuYyks
IHBsZWFzZSBhZGQgdGhpcyB0byBsaWIvdHN0X3NhZmVfbWFjcm9zLmMuCgo+ID4gQlRXIEknbSBz
bGlnaHRseSBjb25mdXNlZCwgd2hhdCB3b3VsZCBiZSB0aGUgYmVzdCBwbGFjZSBmb3IgdGhpcywK
PiA+IGxpYi90c3Rfc2FmZV9tYWNyb3MuYyBpcyBiZWluZyB1c2VkIG5vd2FkYXlzIGZvciBldmVy
eXRoaW5nLiBCdXQgdGhlcmUgaXMKPiA+IGFsc28KCgoKPiA+IGluY2x1ZGUvdHN0X3NhZmVfZmls
ZV9vcHMuaCwgd2hpY2ggZG9lcyBub3QgaGF2ZSBDIGZpbGUKPiA+IChsaWIvdHN0X3NhZmVfZmls
ZV9vcHMuYykgYmVjYXVzZSBpdCBpbnRlcm5hbGx5IHVzZSBsaWIvdHN0X3NhZmVfbWFjcm9zLmMu
CgoKPiBObywgYmFzaWNhbGx5IGl0IGRvZXMgbm90IHVzZSB0aGUgbGliL3RzdF9zYWZlX21hY3Jv
cy5jLgoKWW91J3JlIHJpZ2h0LgoKPiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCAndHN0X3NhZmVf
ZmlsZV9vcHMuaCcgaXMganVzdCBhIGhlYWRlciBmb3IKPiBjb2xsZWN0aW5nCj4gYWxsIHRoZSBm
aWxlIG9wZXJhdGlvbnMgZm9yIExpbnV4LCBpdCBkb2Vzbid0IHRvdWNoIG90aGVyIHN1YmNvbXBv
bmVudCBvcHMuCgpUaGFua3MhIE5vdyBpdCdzIG9idmlvdXMuCgo+ICd0c3Rfc2FmZV9maWxlX29w
cy5oJyBkZWZpbmVzIG1hY3JvcyBmb3IgYWxsIGZ1bmN0aW9ucyBpbgo+ICdzYWZlX2ZpbGVfb3Bz
X2ZuLmgnCj4gYW5kIGFyY2hpdmVkIHRoZW0gaW4gJ3NhZmVfZmlsZV9vcHMuYycgbGliLgoKPiBT
b21ldGhpbmcgbGlrZSB0aGlzIGNvbWJpbmF0aW9uOgoKPiB0c3Rfc2FmZV9maWxlX29wcy5oOgo+
ICAgICBzYWZlX2ZpbGVfb3BzX2ZuLmgKPiAgICAgc2FmZV9maWxlX29wcy5jCgo+IHRzdF9zYWZl
X21hY3Jvcy5oCj4gdHN0X3NhZmVfbWFjcm9zLmMKCgoKPiA+IEkgZ3Vlc3MgY3JlYXRpbmcgbGli
L3RzdF9zYWZlX21hY3Jvcy5jIHdhcyBwb3N0cG9uZWQgdW50aWwgd2UgcmV3cml0ZSBhbGwKPiA+
IHRlc3RzLAo+ID4gbWF5YmUgaXQncyBhIHRpbWUgdG8gY3JlYXRlIGl0LgoKCgoKPiA+IEBMaSBA
Q3lyaWw6IEFsc28gaW5jbHVkZS90c3Rfc2FmZV9maWxlX29wcy5oIGhhcyBTQUZFX1JFQURfTUVN
SU5GTygpIGFuZAo+ID4gU0FGRV9SRUFEX1BST0NfU1RBVFVTKCksIElNSE8gdGhlc2Ugc2hvdWxk
IGJlIGluIGluY2x1ZGUvdHN0X21lbXV0aWxzLmguCj4gPiBPciwgd2Ugc2hvdWxkbid0IGhhdmUg
MiBoZWFkZXJzIGZvciBzaW1pbGFyIHRoaW5nLCBpdCB3b3VsZCBiZSBnb29kIHRvCj4gPiBtZXJn
ZQo+ID4gdGhlc2UgdHdvLgoKCj4gQWdyZWVkLCBhbnl0aGluZyByZWxhdGVkIHRvIHRoZSBkZWRp
Y2F0ZWQgb3BzIHNob3VsZCBiZSBwdXQgaW50byB0aGUKPiBjb3JyZXNwb25kaW5nIGhlYWRlciBm
aWxlcy4gdHN0X3NhZmVfZmlsZV9vcHMuaCBpcyBhIGdlbmVyaWMgb3BlcmF0aW9uCj4gZm9yIExp
bnV4IChidXQgbm90IGZvciBzcGVjaWZpYykgZmlsZXMuIFNvIEkgdm90ZSBmb3IgYWRkaW5nICpf
TUVNSU5GTygpCj4gdG8gdHN0X21lbXV0aWwuaC4KCisxCgpJIHVuZGVyc3RhbmQgdGhhdCBpdCdz
IGEgZ29vZCBpZGVhIHdoZW4gd2Ugc2VwYXJhdGUgdGhpbmdzIGFjY29yZGluZyB0byBlLmcuCmxp
YmMgaGVhZGVyLiBCdXQgd2UgYWxzbyBoYXZlIHNlcGFyYXRlZCBDIGZpbGVzIGluIGxpYi8uCkl0
J3MgcHJvYmFibHkgZWFzaWVyIGlmIHdlIGhhdmUgbW9yZSBzaG9ydGVyIGZpbGVzIHRoYW4gZmV3
ZXIgdmVyeSBsb25nIGZpbGVzLApidXQgSSB3b25kZXIgaWYgc29tZSBzb3VyY2VycyBzaG91bGQg
bm90IGJlIGluIHNpbmdsZSBmaWxlcywgZS5nLiB0aGVzZToKdHN0X3N1cHBvcnRlZF9mc190eXBl
cy5jLCB0c3RfZnNfdHlwZS5jID0+IHRzdF9mcy5jCm9yCnRzdF9maWxsX2ZzLmMsIHRzdF9maWxs
X2ZpbGUuYyA9PiB0c3RfZmlsbC5jCm9yCnRzdF9mc19zZXR1cC5jLCB0c3RfcGF0aF9oYXNfbW50
X2ZsYWdzLmMgPT4gdHN0X21vdW50LmMKKGludG8gc29tZSBtb3JlIGdlbmVyaWMgbmFtZSkKCk5v
dGhpbmcgY3JpdGljYWwsIGl0IGp1c3QgaGF2aW5nIDEtMyBmdW5jdGlvbnMgaW4gc2VwYXJhdGUg
c291cmNlIG1ha2VzIGFjdHVhbGx5CnNlYXJjaCBoYXJkZXIsIGJlY2F1c2UgZmlsZSBuYW1lIGlz
IHZlcnkgc3BlY2lmaWMKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
