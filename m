Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107D8C36010
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:26:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87EC13CAB8B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:26:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DF943C0509
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:25:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85C176002C8
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:25:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC7DD1F38D;
 Mon, 31 Mar 2025 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743416742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT+UEBiKtF/e3igxlJ8YDarP75zk5rZOT/Isy2M9esU=;
 b=YdwTE84QIXjfYE96yqoGNs6MpKsBCqCbEqvxrShI60W3cWYYXM+mWlkMWjeNx4RMiKnzic
 mJsdZXVHjSd8tBfxmg6Oi+k0iKoLXb4pXhg84l5K4cNQ5IWpNO30OwIvmQcr7yw0/TxL4F
 sGPF/P8lErWMmUWI+PYFVPGtmG6YeQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743416742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT+UEBiKtF/e3igxlJ8YDarP75zk5rZOT/Isy2M9esU=;
 b=GEZ+4nXSNFer46QPlVvQES4vqFEn+7nXlYgi5wyFL7Qy9VkMhwJ35XCKiv5ARV4L69YKF8
 JFDrX2pJ8NrQlaBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AHNoVTU4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TcafF7Qy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743416741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT+UEBiKtF/e3igxlJ8YDarP75zk5rZOT/Isy2M9esU=;
 b=AHNoVTU4Zdl2pkWyJ/UEviSpPv/SSR33rJfHwi6KdgpcuKnpPlTgoMkQCymNiy4CDgNrgO
 rc0ID585sgzNE6eU3aT1/cwtSnr3Qztkx4A0MzGewZLjyQG/rsWlHxgx0K4khv/f7/+h7e
 Z9z3ZntQvBeDVl7eq3j0+6HEvcx+qrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743416741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT+UEBiKtF/e3igxlJ8YDarP75zk5rZOT/Isy2M9esU=;
 b=TcafF7QybTHPH7QyVTOy8IqUnRDDEqYxDDjuZQjU5gJBMWlHHCwoAwKbFHwF49do/dz/ZT
 EoXj/c08h7N8CRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5C65139A1;
 Mon, 31 Mar 2025 10:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SkwTL6Vt6mc2ZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 10:25:41 +0000
Date: Mon, 31 Mar 2025 12:25:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250331102540.GA244431@pevik>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-2-wegao@suse.com>
 <CAEemH2c2WA87RcfeX1VYXYebHBcQpSP2y8umbDEnrWnaKDcApg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c2WA87RcfeX1VYXYebHBcQpSP2y8umbDEnrWnaKDcApg@mail.gmail.com>
X-Rspamd-Queue-Id: EC7DD1F38D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

PiBPbiBNb24sIE1hciAzMSwgMjAyNSBhdCAxMToyMOKAr0FNIFdlaSBHYW8gPHdlZ2FvQHN1c2Uu
Y29tPiB3cm90ZToKCj4gPiBJbXByb3ZlbWVudHMgY29tcGFyZSB3aXRoIHRlc3Q2IHNoZWxsIHRl
c3Q6Cj4gPiAqIFJlbW92ZSAvYmluL2VjaG8gJGxvYWRfYmFsYW5jZSA+ICRwYXRoL2NwdXNldC5z
Y2hlZF9sb2FkX2JhbGFuY2UKPiA+IHNpbmNlIHRlc3QgZm9jdXMgb24gdmVyaWZ5IGh1Z2UgcGFn
ZSBpcyByZWFsbHkgYWxsb2NhdGVkIGluIHRoZSBjb3JyZWN0Cj4gPiBub2RlLCB0YXNrIG5vIG5l
ZWQgYmluZCB0byBzcGVjaWZpYyBjcHVzZXQuCj4gPiAqIERpcmVjdGx5IGtlZXAgMSBocGFnZSBy
ZXNlcnZlZCBpbiBlYWNoIG5vZGUgb3RoZXJ3aXNlIHRlc3QgY2FzZSBoYXMKPiA+IGNoYW5jZSB0
byBmYWlsLCBzaW5jZSBgZWNobyAxID4gL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlc2Agd2lsbCB0
cnkgdG8KPiA+IHJlc2VydmUgMSBwYWdlcyBmcm9tIGEgTlVNQSBub2RlIHJhbmRvbWx5LgoKPiA+
IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+ID4gUmV2aWV3ZWQtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gU3VnZ2VzdGVkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4KCgo+ID4gK3N0YXRpYyB2b2lkIGNoaWxkKHZvaWQpCj4gPiArewo+ID4gKyAgICAgICBj
aGFyICpwOwo+ID4gKyAgICAgICBpbnQgZmRfaHVnZXBhZ2U7Cj4gPiArCj4gPiArICAgICAgIGZk
X2h1Z2VwYWdlID0gU0FGRV9PUEVOKEhVR0VfUEFHRV9GSUxFLCBPX0NSRUFUIHwgT19SRFdSLCAw
NzU1KTsKCgoKPiA+ICtUU1RfRVhQX1BBU1NfU0lMRU5UKHN5c3RlbSgiY2F0IC9wcm9jL21lbWlu
Zm8iKSk7CgoKPiBUaGlzIGxpbmUgaXMgZm9yIGRlYnVnZ2luZyBwdXJwb3NlcywgSSBndWVzcywg
YW5kIGl0IHNob3VsZCBiZSByZW1vdmVkIGluCj4gdGhlIGZvcm1hbCBwYXRjaC4KCisxCgpXaXRo
IHRoYXQgY2hhbmdlZCB5b3UgY2FuIGtlZXAgbXkgUkJULiBJIGhvcGUgdjEwIGNvdWxkIGJlIGZp
bmFsLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
