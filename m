Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316AC07E97
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 12:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F07F43CD942
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 13:08:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1D343CB148
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 13:08:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5CD91BB95B5
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 13:08:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B8C621C6C;
 Fri,  1 Dec 2023 12:08:11 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 397C513928;
 Fri,  1 Dec 2023 12:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id qt+iDKvMaWUfFAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 12:08:11 +0000
Date: Fri, 1 Dec 2023 13:08:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231201120809.GA2779521@pevik>
References: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
 <CAEemH2fJ+HS4pjw75uLE91XM5Ju8z9+pjeNevjwWb9WBSJ28Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fJ+HS4pjw75uLE91XM5Ju8z9+pjeNevjwWb9WBSJ28Zw@mail.gmail.com>
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [7.70 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; ARC_NA(0.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[jit.si:url];
 NEURAL_HAM_LONG(-0.99)[-0.995];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[17.57%]
X-Rspamd-Queue-Id: 6B8C621C6C
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 6th of November 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIEFuZHJlYSwgYWxsLAoKPiBIaSBBbmRyZWEsCgo+IE9uIEZyaSwgRGVjIDEsIDIwMjMg
YXQgNzoyNeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0
Pgo+IHdyb3RlOgoKPiA+IEhlbGxvLAoKPiA+IHRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBm
b3IgdGhlIExUUCBtYWlsaW5nIGxpc3QgYWJvdXQgbW9udGhseSBtZWV0aW5nLgo+ID4gQXMgcHJl
dmlvdXNseSBkaXNjdXNzZWQuCgo+ID4gVGltZSBhbmQgZGF0ZTogRmlyc3QgV2VkbmVzZGF5IGVh
Y2ggbW9udGggYXQgMDk6MDAgVVRDLgo+ID4gUGxhdGZvcm06IGh0dHBzOi8vbWVldC5qaXQuc2kv
bGludXgtdGVzdC1wcm9qZWN0CgoKPiBEbyB3ZSBwbGFuIHRvIHN3aXRjaCB0byBHb29nbGUgbWVl
dD8gYW5kIHdpbGwgd2UgaGF2ZSBhIHZpZGVvIHJlY29yZGluZyBvZgo+IHRoYXQ/CgpHb29kIHBv
aW50LCBXZSBzaG91bGQgZG8uCgo+IEknbSBhZnJhaWQgdGhpcyB0aW1lIEkgaGF2ZSB0byBiZSBh
YnNlbnQgKHNpbmNlIG5vIGxhcHRvcCBvbiBteSB0cmF2ZWxpbmcpLgoKSSdtIHNvcnJ5LCBidXQg
dW5kZXJzdGFuZC4gSGF2ZSBzYWZlIHRyYXZlbGxpbmcuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4g
VGhhbmtzIGEgbG90IGZvciBhcnJhbmdpbmcgdGhpcy4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
