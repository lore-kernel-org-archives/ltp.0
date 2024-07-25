Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD84C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 15:13:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B1973D1CBC
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 17:13:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C429D3D0C6D
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:12:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A7901603454
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:12:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ED6421B27;
 Thu, 25 Jul 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721920375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HNo6yZqnvB7ancCpjp3RnYP8f1SFRMLfe9X//0w6bI=;
 b=n0KeUkQ4yiSFiSMKWTd8LZ1dUfYs9+KABUcsx8IRwv8KRSKr9QCKr40wkMCjFjvpzgAT2g
 UywcRNKYkO6gQ1VsUvv15x7rx69rpMhdOqITKQPPJsDlp5ye7RXsJESQfL1tQU4q9F4maY
 Jq03mNmGOHsovv/e3zVuRJFaw0EDrBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721920375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HNo6yZqnvB7ancCpjp3RnYP8f1SFRMLfe9X//0w6bI=;
 b=uA2CqZASe78WMhDdS2eEWYde2SYhk9MvZluNAj4pSeL0+8tizF/luk28PkH8POulJcha1o
 jVKtiCEK7vwvC4AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721920375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HNo6yZqnvB7ancCpjp3RnYP8f1SFRMLfe9X//0w6bI=;
 b=n0KeUkQ4yiSFiSMKWTd8LZ1dUfYs9+KABUcsx8IRwv8KRSKr9QCKr40wkMCjFjvpzgAT2g
 UywcRNKYkO6gQ1VsUvv15x7rx69rpMhdOqITKQPPJsDlp5ye7RXsJESQfL1tQU4q9F4maY
 Jq03mNmGOHsovv/e3zVuRJFaw0EDrBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721920375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HNo6yZqnvB7ancCpjp3RnYP8f1SFRMLfe9X//0w6bI=;
 b=uA2CqZASe78WMhDdS2eEWYde2SYhk9MvZluNAj4pSeL0+8tizF/luk28PkH8POulJcha1o
 jVKtiCEK7vwvC4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC9E13874;
 Thu, 25 Jul 2024 15:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uiV6FndromZdJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jul 2024 15:12:55 +0000
Date: Thu, 25 Jul 2024 17:12:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZqJrVmGNDSpOaFxA@yuki>
References: <ZqEWnS9zi84z2CL2@yuki>
 <7F3E1D80-0F31-4017-9512-A83CA87B4AE1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7F3E1D80-0F31-4017-9512-A83CA87B4AE1@suse.com>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add mseal() syscall declaration
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

SGkhCj4gU29ycnkgYnV0IEkgZG9u4oCZdCBnZXQgaXQuIFJlc29sdmluZyBjb25mbGljdHMgaXMg
cmVhbGx5IHNvbWV0aGluZyB1cAo+IHRvIHBlb3BsZSB3aG8gcHVzaCB0aGUgY29kZSBvbiB0aGUg
bWFpbmxpbmUgKDogQWxzbyBpdCBzaG91bGQgYmUKPiBwcmV0dHkgZWFzeSBzaW5jZSBpdCByZXF1
aXJlcyB0byBhY2NlcHQgYm90aCBoZWFkIGFuZCBjb21pbmcgY2hhbmdlcy4KCkknbSBwcmV0dHkg
c3VyZSB5b3Ugd291bGQgZ2V0IHNvbWUgcHJldHR5IGhhcnMgd29yZCBpZiB5b3Ugc2VuZCBwYXRj
aGVzCnRvIGxpbnV4IGtlcm5lbCB0aGF0IGRvZXMgbm90IGFwcGx5IG9uIHRoZSB0b3Agb2YgZWFj
aCBvdGhlci4uLgoKQW55d2F5cyBJJ20ganVzdCB0cnlpbmcgdG8gZ2V0IHRvIGEgc29sdXRpb24g
dGhhdCB3b3VsZCBzYXZlIHRpbWUgZm9yCmV2ZXJ5b25lLCBiZWNhdXNlIG1hbnVhbGx5IGZpeGlu
ZyBhIHBhdGNoIHRoYXQgZmFpbHMgdG8gYWRkIGEgbGluZSBpbnRvCjE4IGRpZmZlcmVudCBmaWxl
cyBpcyBub3Qgc29tZXRoaW5nIEkgd2FudCB0byBkbyBmb3IgZWFjaCBuZXcgc3lzY2FsbApwYXRj
aHNldCB5b3Ugc2VuZC4uLgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
