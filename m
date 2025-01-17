Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D963C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:43:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6B983C7B69
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:43:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 355123C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:42:46 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92EF823180E
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:42:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22C9B2116C;
 Fri, 17 Jan 2025 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737110564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kco20o5hhXwffFVl/G6/YWYuInAl0q+CjyDoF+O1/NA=;
 b=WXTZlBlodYvBCAdOf5n8OXVRMePGU7FHVXH74+4DvB634R4gDtI3O9Aajd6vIPILHEf0wY
 I0+TGKm2tJigZ4lA0lm+MzmX7zlJ7KSK63DC5D1scVYJ5y3rkBhgX9XuO5TqnHRxNg9r9h
 YYXWMvV0stprsFZsQ2CUu0aJIEPpc7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737110564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kco20o5hhXwffFVl/G6/YWYuInAl0q+CjyDoF+O1/NA=;
 b=o95dWQP2tm7Tv0O1QMRuDPJB2FRcGQAdWQl6KJfoxcuy6xyUR02GFpvis2SxxVtZFhCZN5
 1mc4Mx1WXWJx6iCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WXTZlBlo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o95dWQP2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737110564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kco20o5hhXwffFVl/G6/YWYuInAl0q+CjyDoF+O1/NA=;
 b=WXTZlBlodYvBCAdOf5n8OXVRMePGU7FHVXH74+4DvB634R4gDtI3O9Aajd6vIPILHEf0wY
 I0+TGKm2tJigZ4lA0lm+MzmX7zlJ7KSK63DC5D1scVYJ5y3rkBhgX9XuO5TqnHRxNg9r9h
 YYXWMvV0stprsFZsQ2CUu0aJIEPpc7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737110564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kco20o5hhXwffFVl/G6/YWYuInAl0q+CjyDoF+O1/NA=;
 b=o95dWQP2tm7Tv0O1QMRuDPJB2FRcGQAdWQl6KJfoxcuy6xyUR02GFpvis2SxxVtZFhCZN5
 1mc4Mx1WXWJx6iCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13B0013332;
 Fri, 17 Jan 2025 10:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /sl/AyQ0imevPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 10:42:44 +0000
Date: Fri, 17 Jan 2025 11:42:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4o0G9xPksd__CiF@yuki.lan>
References: <20250114124023.4702-1-wegao@suse.com>
 <20250114143217.21018-1-wegao@suse.com>
 <20250114143217.21018-3-wegao@suse.com>
 <20250117104041.GA753841@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117104041.GA753841@pevik>
X-Rspamd-Queue-Id: 22C9B2116C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] ptrace06: Refactor the test using new LTP
 API
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

SGkhCj4gPiArLyoKPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTggTGludXggVGVzdCBQcm9qZWN0
Cj4gPiArICogQ29weXJpZ2h0IChDKSAyMDE1IEN5cmlsIEhydWJpcyBjaHJ1YmlzQHN1c2UuY3oK
PiA+ICsgKi8KPiA+ICsKPiA+ICsjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4KPiA+ICsjaW5j
bHVkZSAidHN0X3Rlc3QuaCIKPiA+ICsKPiA+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQo+IAo+IHB0cmFjZTA2X2NoaWxkLmM6MTA6MTQ6IHdhcm5pbmc6IHVudXNlZCBwYXJhbWV0
ZXIg4oCYYXJnY+KAmSBbLVd1bnVzZWQtcGFyYW1ldGVyXQo+ICAgIDEwIHwgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPiAKPiA+ICt7Cj4gPiArCj4gbml0OiBlbXB0eSBsaW5lIF4K
PiA+ICsJdHN0X3JlcyhUUEFTUywgIiVzIGV4ZWN1dGVkIiwgYXJndlswXSk7Cj4gPiArCj4gPiAr
CXJldHVybiAwOwo+ID4gK30KPiAKPiBJIHN1Z2dlc3QgdG8gbWVyZ2UgdGhlIHBhdGNoc2V0IHdp
dGggdGhpcyBjaGFuZ2UgaW4gdGhpcyBjb21taXQuCj4gCj4gQEN5cmlsOiBDYW4gSSBhZGQgeW91
ciBSQlQ/CgpIYXZlIHlvdSBzZWVuIG15IHJldmlldz8gVGhhdCBmaWxlIGlzIG5vdCB1c2VkIGF0
IGFsbC4gQW5kIGFsc28gdGhlClRFU1QoKSBzdGF0ZW1lbnQgaW4gdGhlIGFjdHVhbCB0ZXN0LgoK
LS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
