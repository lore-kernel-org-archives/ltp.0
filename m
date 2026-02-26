Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E00CFC592F
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 12:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE1E43CB98B
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 13:03:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 634473C7BA1
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:02:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 01FE560080C
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:02:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A4CE1F43B;
 Thu, 26 Feb 2026 12:02:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 693843EA62;
 Thu, 26 Feb 2026 12:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id czZeF2k2oGkffQAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 26 Feb 2026 12:02:49 +0000
Message-ID: <5d377172-6ab1-4d53-aa26-f262bd94f547@suse.de>
Date: Thu, 26 Feb 2026 13:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20260223131546.448607-1-rbranco@suse.de>
 <DGOTK9K287T0.3T6OW5Q28DIT9@suse.com>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <DGOTK9K287T0.3T6OW5Q28DIT9@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8A4CE1F43B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] userfaultfd: Add test using UFFDIO_POISON
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAyLzI2LzI2IDExOjI1IEFNLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IEhpIQo+Cj4+
IGluZGV4IDA1YmIzY2ViMS4uMmFkOGY4YjFlIDEwMDY0NAo+PiAtLS0gYS9ydW50ZXN0L3N5c2Nh
bGxzCj4+ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPj4gQEAgLTE3NzUsNiArMTc3NSw3IEBAIHVz
ZXJmYXVsdGZkMDIgdXNlcmZhdWx0ZmQwMgo+PiAgIHVzZXJmYXVsdGZkMDMgdXNlcmZhdWx0ZmQw
Mwo+PiAgIHVzZXJmYXVsdGZkMDQgdXNlcmZhdWx0ZmQwNAo+PiAgIHVzZXJmYXVsdGZkMDUgdXNl
cmZhdWx0ZmQwNQo+PiArdXNlcmZhdWx0ZmQwNiB1c2VyZmF1bHRmZDA1Cj4gY29weS1wYXN0ZSBm
YWlsdXJlIDotKSBwb2ludGluZyB0byB0aGUgd3JvbmcgYmluYXJ5LgoKTE9MLiBGaXhlZCBpbiB2
Ny7CoCBCZWNhdXNlLCBvZmMsIGl0IGhhZCB0byByZWFjaCB2Nwo+PiArCj4+ICtzdGF0aWMgc3Ry
dWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4+ICsJLnRlc3RfYWxsID0gcnVuLAo+PiArCS5zZXR1cCA9
IHNldHVwLAo+PiArfTsKPiBQbGVhc2UgYWRkIGEgLmNsZWFudXAgdG8gY2FsbCByZXNldF9wYWdl
cygpIGluIGNhc2Ugd2UgZmFpbCBzeXNjYWxscy4KCkZpeGVkLiBXaWxsIGRvIGEgZm9sbG93LXVw
IFBSIHRvIHVzZSAuY2xlYW51cCA9IHJlYXNldF9wYWdlcyBpbiB0aGUgcmVzdC4KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
