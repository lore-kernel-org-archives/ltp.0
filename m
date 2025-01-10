Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B26E7719C
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 10:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38443C3076
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 11:36:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF2B93C1112
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 11:36:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7589764F62F
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 11:36:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11B3321102;
 Fri, 10 Jan 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED09E13763;
 Fri, 10 Jan 2025 10:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1dk+Nyz4gGehKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jan 2025 10:36:28 +0000
Date: Fri, 10 Jan 2025 11:36:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <Z4D4ILGMgC7U6sOk@yuki.lan>
References: <20250110083915.538855-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110083915.538855-1-maxj.fnst@fujitsu.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 11B3321102
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [issue] cve-2015-3290: fail to compile
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

SGkhCj4gV2hlbiBJIGNvbXBpbGUgbHRwIG9uIENlbnRvczEwLCBpdCBmYWlsZWQgYXQgY3ZlLTIw
MTUtMzI5MC5jLgo+IElmIGFueW9uZSBjb3VsZCBwcm92aWRlIHNvbWUgYWR2aWNlLCBJIHdvdWxk
IGdyZWF0bHkgYXBwcmVjaWF0ZSBpdC4KPiAKPiBFcnJvciBpbmZvOgo+IGN2ZS0yMDE1LTMyOTAu
YzogSW4gZnVuY3Rpb24g4oCYY2hpbGRfdGhyZWFk4oCZOgo+IGN2ZS0yMDE1LTMyOTAuYzo0Mzc6
MTogZXJyb3I6IGJwIGNhbm5vdCBiZSB1c2VkIGluIOKAmGFzbeKAmSBoZXJlCj4gICA0MzcgfCB9
Cj4gICAgICAgfCBeCj4gbWFrZVsyXTogKioqIFsuLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ1
OiBjdmUtMjAxNS0zMjkwXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFsuLi9pbmNsdWRlL21rL2dl
bmVyaWNfdHJ1bmtfdGFyZ2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgo+IG1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5ICcvcm9vdC9sdHAvdGVzdGNhc2VzJwo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6
ODU6IHRlc3RjYXNlcy1hbGxdIEVycm9yIDIKClRoYXQgbG9va3MgbGlrZToKCmh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8zMTMKCkJ1dCB0aGF0IGlzIHN1
cHBvc2VkbHkgZml4ZWQgYnk6CgpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC9jb21taXQvY2JmYWQzYmEwNzE1NWNmODJlYTRiOGVmYTAzOTA3ODdhZjgxNzMyMwoKLS0g
CkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
