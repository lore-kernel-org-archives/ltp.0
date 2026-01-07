Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7957CD585A
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:32:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C3B3C2CEB
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:32:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1DE3C2A49
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:31:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DF4D600627
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:31:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0D3233C7A;
 Wed,  7 Jan 2026 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767785518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEJqA1bCPHzjj0u6bOA8TIgp6kHxPfNl5xgXEmGj/EM=;
 b=Wwe4l2QLiOAwvlTklkmcNs93sxgoKOf+MSU6ErCY5CUojSTYuHHAdaUNOA/VijUwIAAQQ+
 dmP3WLsB/LERmNDAuGISqWVJqerU4xK4nigj8Ye2uMFPkCVpmPG7ThgY7hX8F2Vq8iYoXJ
 sxH65OofsURLrFBTXxBsQS8ucvS9u0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767785518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEJqA1bCPHzjj0u6bOA8TIgp6kHxPfNl5xgXEmGj/EM=;
 b=qglt0iTeEOPKNc3GAHb7kFbFtHUF8250/KePfj9vGEKw9GzS2mQbFb/gl4684JzGaFsLZr
 Z8UsGkqrew+DpQAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767785517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEJqA1bCPHzjj0u6bOA8TIgp6kHxPfNl5xgXEmGj/EM=;
 b=P4XnILEnfydAGAIiVKbcdA/PQoUrL54nQ6pO7vdXvvp/8fz2ZmgZiKjYOWjGxtCiy6Edgj
 0Dpj6fIeNYtgvX8DbVlbUDAP6hFqJ432+YYigcV+gyhAiJ7BKIBCkcOKzzLNS/nrz8L73V
 v1QKHOcz4KH3hjimFKUrVweOdTcI4mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767785517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEJqA1bCPHzjj0u6bOA8TIgp6kHxPfNl5xgXEmGj/EM=;
 b=xLkxWYLVn6qLPVGgQrSHH8N4UQ12STgzTYo9T9Jhw3TcVwuEhD4Pz3OXRKr3iwyITBiryv
 wZNR6gFC2SDTNlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BFE03EA63;
 Wed,  7 Jan 2026 11:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5WPlGi1EXmmMFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 11:31:57 +0000
Date: Wed, 7 Jan 2026 12:31:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260107113155.GB753482@pevik>
References: <20260107111133.27041-1-chrubis@suse.cz>
 <20260107111133.27041-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260107111133.27041-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: Document process_state
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

SGkgQ3lyaWwsIEFuZHJlYSwKCm1vcmUgZml4ZXMgbmVlZGVkOgoKPiArKysgYi9pbmNsdWRlL3Rz
dF9wcm9jZXNzX3N0YXRlLmgKLi4uCj4gICAqLwo+ICAjZGVmaW5lIFRTVF9QUk9DRVNTX1NUQVRF
X1dBSVQocGlkLCBzdGF0ZSwgbXNlY190aW1lb3V0KSBcCj4gIAl0c3RfcHJvY2Vzc19zdGF0ZV93
YWl0KF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgXAo+ICAJCQkocGlkKSwgKHN0YXRlKSwgKG1z
ZWNfdGltZW91dCkpCgo+IC0vKgo+IC0gKiBDaGVjayB0aGF0IGEgZ2l2ZW4gcGlkIGlzIHByZXNl
bnQgb24gdGhlIHN5c3RlbQo+ICsvKioKPiArICogVFNUX1BST0NFU1NfRVhJVF9XQUlUKCkgLSBX
YWl0cyB3aGlsZSBwaWQgaXMgcHJlc2VudCBvbiB0aGUgc3lzdGVtLgo+ICsgKgo+ICsgKiBMb29w
cyB1bnRpbCBga2lsbCgkUElELCAwKWAgc3VjY2VkcyBvciB0aW1lb3V0IGlzIHJlYWNoZWQuCj4g
KyAqCj4gKyAqIEBwaWQgQSBwcm9jZXNzIHBpZC4KICAgICAgICAgIF4gbWlzc2luZyAnOicgaGVy
ZSBsZWFkcyB0byAicGlkIOKAkyB1bmRlc2NyaWJlZCIgaW4gZ2VuZXJhdGVkIGRvYywKc2VlIC4v
ZG9jL2h0bWwvZGV2ZWxvcGVycy9hcGlfY190ZXN0cy5odG1sI21hY3JvLXRzdC1wcm9jZXNzLWV4
aXQtd2FpdAoKQEFuZHJlYTogSSB3aXNoIHNwaGlueCBkb2Mgd291bGQgd2FybiBhYm91dCAidW5k
ZXNjcmliZWQiIGFuZCBJIHRob3VnaHQgaXQgZGlkCmluIHRoZSBwYXN0LCBidXQgSSBkb24ndCBz
ZWUgaXQuCgpBbHNvIHdlIGhhdmUgdG9vIG1hbnkgKH4gMjIweCkgd2FybmluZ3M6CiJXQVJOSU5H
OiBkdXBsaWNhdGUgbGFiZWwgZGVzY3JpcHRpb24sIG90aGVyIGluc3RhbmNlIGluIC4uLiIgaXQn
cyBub3QgdXNhYmxlLgpBbnkgaGludCB5b3UgY291bGQgaGF2ZSBsb29rIG9uIGl0PyBJZiB3ZSBz
b2x2ZSB0aGlzIHdhcm5pbmcgd291bGQgZ2V0IHVzZWZ1bC4KCj4gKyAqIEBtc2VjX3RpbWVvdXQ6
IEEgdGltZW91dCBmb3IgdGhlIHdhaXQuCj4gICAqLwo+ICAjZGVmaW5lIFRTVF9QUk9DRVNTX0VY
SVRfV0FJVChwaWQsIG1zZWNfdGltZW91dCkgXAo+ICAJdHN0X3Byb2Nlc3NfZXhpdF93YWl0KChw
aWQpLCAobXNlY190aW1lb3V0KSkKCj4gLS8qCj4gLSAqIFdhaXRzIGZvciB0aHJlYWQgc3RhdGUg
Y2hhbmdlLgo+ICsvKioKPiArICogVFNUX1RIUkVBRF9TVEFURV9XQUlUKCkgLSBXYWl0cyBmb3Ig
YSB0aHJlYWQgc3RhdGUgY2hhbmdlLgo+ICAgKgo+IC0gKiBUaGUgc3RhdGUgaXMgb25lIG9mIHRo
ZSBmb2xsb3dpbmc6Cj4gKyAqIFBvbGxzIGAvcHJvYy9zZWxmL3Rhc2svJFRJRC9zdGF0ZWAgZm9y
IGEgdGhyZWFkIHN0YXRlIGNoYW5nZS4KPiAgICoKPiAtICogUiAtIHJ1bm5pbmcKPiAtICogUyAt
IHNsZWVwaW5nCj4gLSAqIEQgLSBkaXNrIHNsZWVwCj4gLSAqIFQgLSBzdG9wcGVkCj4gLSAqIHQg
LSB0cmFjaW5nIHN0b3BwZWQKPiAtICogWiAtIHpvbWJpZQo+IC0gKiBYIC0gZGVhZAo+ICsgKiBQ
b3NzaWJsZSB0aHJlYWQgc3RhdGVzIGFyZSB0aGUgc2FtZSBhcyBmb3IgVFNUX1BST0NFU1NfU1RB
VEVfV0FJVCgpLgoKQW5kIGhlcmUgd2UgaGF2ZSAidW5kZXNjcmliZWQiIGR1ZSBub3QgYmVpbmcg
ZGVzY3JpYmVkOgoKUGFyYW1ldGVyczoKdGlkIOKAkyB1bmRlc2NyaWJlZApzdGF0ZSDigJMgdW5k
ZXNjcmliZWQKbXNlY190aW1lb3V0IOKAkyB1bmRlc2NyaWJlZAoKU2VlIC4vZG9jL2h0bWwvZGV2
ZWxvcGVycy9hcGlfY190ZXN0cy5odG1sI21hY3JvLXRzdC10aHJlYWQtc3RhdGUtd2FpdAoKS2lu
ZCByZWdhcmRzLApQZXRyCgo+ICAgKi8KPiAgI2RlZmluZSBUU1RfVEhSRUFEX1NUQVRFX1dBSVQo
dGlkLCBzdGF0ZSwgbXNlY190aW1lb3V0KSBcCj4gIAl0c3RfdGhyZWFkX3N0YXRlX3dhaXQoKHRp
ZCksIChzdGF0ZSksIChtc2VjX3RpbWVvdXQpKQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
