Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D83C433F5
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 09:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B8BF3C9002
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 10:45:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0BDA3C21D9
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 10:45:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C2912000E1
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 10:45:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C7CF212BC;
 Mon,  3 Jan 2022 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641203106;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L3d/uQQhr4SjxLGjE10v9S3RlEdF64+F3Yihcfeu5k=;
 b=3cEWA2gqY2G61rLKIaxR2kYopSinrs+8KGWAQjSw9bd6qlmpEcIxZF72hYwsmzXrAZ42Rp
 lbL62slfw6dTvYT7wA7r0CYpY/c+3lTkbEM8pKzKYibNGlG/yJ9Vi25iCetWcGufT9HOhH
 3lZEKnE832m/OPvgrHU5lrba00F/+Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641203106;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L3d/uQQhr4SjxLGjE10v9S3RlEdF64+F3Yihcfeu5k=;
 b=oMvGuALroC8rswxZrP+bz63vsNjBSmP8FtF82ZKA2twb2i/Wggik6T4wXzYkOZ54jLjkxc
 /SGMwp3PrKIC+JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 382F613A98;
 Mon,  3 Jan 2022 09:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wir4C6LF0mEqVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jan 2022 09:45:06 +0000
Date: Mon, 3 Jan 2022 10:45:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YdLFoNp1m7Yc7BCT@pevik>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211230103718.369-1-rpalethorpe@suse.com>
 <20211230103718.369-5-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211230103718.369-5-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] cgroup: Add memcontrol02
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

SGkgUmljaGllLAoKPiArc3RhdGljIHZvaWQgYWxsb2NfcGFnZWNhY2hlXzUwTV9jaGVjayh2b2lk
KQo+ICt7Cj4gKwljb25zdCBzaXplX3Qgc2l6ZSA9IE1CKDUwKTsKPiArCXNpemVfdCBjdXJyZW50
LCBmaWxlOwo+ICsJY29uc3QgY2hhciAqY29uc3QgZmlsZV9rZXlfZm10ID0gaXNfdjFfbWVtY2cg
PyAiY2FjaGUgJXpkIiA6ICJmaWxlICV6ZCI7Cj4gKwo+ICsJVEVTVChvcGVuKFRNUERJUiIvdG1w
ZmlsZSIsIE9fUkRXUiB8IE9fQ1JFQVQpKTsKRllJIG9wZW4oKSBuZWVkcyB0byBoYXZlIGFsc28g
bW9kZToKVEVTVChvcGVuKFRNUERJUiIvdG1wZmlsZSIsIE9fUkRXUiB8IE9fQ1JFQVQsIDA2MDAp
KTsKClRvIGZpeCBlcnJvcjoKCkFsdGhvdWdoIG1hbiBvcGVuKDIpIHN1Z2dlc3QgaXQgY291bGQg
d29yazoKClRoZSBtb2RlIGFyZ3VtZW50IG11c3QgYmUgc3VwcGxpZWQgaWYgT19DUkVBVCBvciBP
X1RNUEZJTEUgaXMgc3BlY2lmaWVkIGluIGZsYWdzOyBpZiBpdCBpcyBub3Qgc3VwcGxpZWQsIHNv
bWUgYXJiaXRyYXJ5IGJ5dGVzIGZyb20gdGhlIHN0YWNrIHdpbGwgYmUgYXBwbGllZCBhcyB0aGUg
ZmlsZSBtb2RlLgoKPGZjbnRsLmg+IGluIGdsaWJjIGFjdHVhbGx5IGNoZWNrIGZvciBpdCBhbmQg
cmVxdWlyZSBpdDoKCkluIGZ1bmN0aW9uIOKAmG9wZW7igJksCiAgICBpbmxpbmVkIGZyb20g4oCY
YWxsb2NfcGFnZWNhY2hlXzUwTV9jaGVja+KAmSBhdCBtZW1jb250cm9sMDIuYzo5MjoyLAogICAg
aW5saW5lZCBmcm9tIOKAmHRlc3RfbWVtY2dfY3VycmVudOKAmSBhdCBtZW1jb250cm9sMDIuYzox
NDA6NDoKL3Vzci9pbmNsdWRlL2JpdHMvZmNudGwyLmg6NTA6MTE6IGVycm9yOiBjYWxsIHRvIOKA
mF9fb3Blbl9taXNzaW5nX21vZGXigJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IG9w
ZW4gd2l0aCBPX0NSRUFUIG9yIE9fVE1QRklMRSBpbiBzZWNvbmQgYXJndW1lbnQgbmVlZHMgMyBh
cmd1bWVudHMKICAgNTAgfCAgICAgICAgICAgX19vcGVuX21pc3NpbmdfbW9kZSAoKTsKCktpbmQg
cmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
