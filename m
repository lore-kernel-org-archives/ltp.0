Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751DBC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C39B3C9E9B
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:17:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6D93C0E63
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:17:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76F3610007FF
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:17:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C31561F3A2;
 Fri, 11 Feb 2022 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644571051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6Q2Eile6wuSzMlnpFMRoaa8laCMf5rNeV4nrLss/hA=;
 b=PNPmB3GHM+HjYKZ0U1eOozjskwu2+z4Lo8DDpSjLNB0BBaTVkWzG5I8QM02QdAU/MJbTyQ
 nXKeyg4S195Sk92bIT6Kf9qpH4oFmc4QTx3x7vCVj7XXmAk6hu7B+MNb9Lso9cnoe40VkV
 r37WxjjwsGdlXssx/Ng6F79aoVQy8gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644571051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6Q2Eile6wuSzMlnpFMRoaa8laCMf5rNeV4nrLss/hA=;
 b=d4rGztKHtc4sPuwkRQZRAfWDZyTZPMsIK8GhiZdncI7Rimo0bJlJTm/jXAq7J0raKicDPt
 pz+72aezyHuZgGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB9CB13BC3;
 Fri, 11 Feb 2022 09:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rmJsKKspBmIjDwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Feb 2022 09:17:31 +0000
Message-ID: <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
Date: Fri, 11 Feb 2022 10:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTEuIDAyLiAyMiA3OjQ3LCBMaSBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgRmViIDExLCAyMDIy
IGF0IDEyOjE4IEFNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jego+IDxtYWlsdG86bWRv
dWNoYUBzdXNlLmN6Pj4gd3JvdGU6Cj4gICAgIEBAIC0xNTYwLDYgKzE1NjgsNyBAQCB2b2lkIHRz
dF9ydW5fdGNhc2VzKGludCBhcmdjLCBjaGFyICphcmd2W10sCj4gICAgIHN0cnVjdCB0c3RfdGVz
dCAqc2VsZikKPiAKPiAgICAgwqAgwqAgwqAgwqAgU0FGRV9TSUdOQUwoU0lHQUxSTSwgYWxhcm1f
aGFuZGxlcik7Cj4gICAgIMKgIMKgIMKgIMKgIFNBRkVfU0lHTkFMKFNJR1VTUjEsIGhlYXJ0YmVh
dF9oYW5kbGVyKTsKPiAgICAgK8KgIMKgIMKgIMKgU0FGRV9TSUdOQUwoU0lHQ0hMRCwgc2lnY2hp
bGRfaGFuZGxlcik7Cj4gCj4gCj4gRG8gd2UgcmVhbGx5IG5lZWQgc2V0dXAgdGhpcyBzaWduYWwg
aGFuZGxlciBmb3IgU0lHQ0hJTEQ/Cj4gCj4gU2luY2Ugd2UgaGF2ZSBhbHJlYWR5IGNhbGxlZCAn
U0FGRV9XQUlUUElEKHRlc3RfcGlkLCAmc3RhdHVzLCAwKScKPiBpbiB0aGUgbGlicmFyeSBwcm9j
ZXNzIChsaWJfcGlkKSB3aGljaCByZWx5IG9uIFNJR0NISUxEIGFzIHdlbGwuCj4gQW5kIGV2ZW4g
dGhpcyBoYW5kbGVyIHdpbGwgYmUgY2FsbGVkIGV2ZXJ5dGltZSB3aGVuIHRlc3QgZXhpdCBub3Jt
YWxseS4KPiAKPiBNYXliZSBiZXR0ZXIganVzdCBhZGQgYSBraWxsIGZ1bmN0aW9uwqB0byBjbGVh
bnVwIHRoZSByZW1haW4KPiBkZXNjZW5kYW50cyBpZiBtYWluIHRlc3QgcHJvY2VzcyBleGl0IHdp
dGggYWJvbm9ybWFsIHN0YXR1cy4KPiAKPiBlLmcuCj4gCj4gLS0tIGEvbGliL3RzdF90ZXN0LmMK
PiArKysgYi9saWIvdHN0X3Rlc3QuYwo+IEBAIC0xNTAzLDYgKzE1MDMsOCBAQCBzdGF0aWMgaW50
IGZvcmtfdGVzdHJ1bih2b2lkKQo+IMKgIMKgIMKgIMKgIGlmIChXSUZFWElURUQoc3RhdHVzKSAm
JiBXRVhJVFNUQVRVUyhzdGF0dXMpKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBX
RVhJVFNUQVRVUyhzdGF0dXMpOwo+IMKgCj4gKyDCoCDCoCDCoCBraWxsKC10ZXN0X3BpZCwgU0lH
S0lMTCk7CgpUaGlzIHdpbGwgbm90IHdvcmsgYmVjYXVzZSBhdCB0aGlzIHBvaW50LCB0aGUgY2hp
bGQgcHJvY2VzcyB3YXMgYWxyZWFkeQpkZXN0cm95ZWQgYnkgd2FpdHBpZCgpIGFuZCBhbGwgaXRz
IHJlbWFpbmluZyBjaGlsZHJlbiB3ZXJlIG1vdmVkIHVuZGVyClBJRCAxIChpbml0KS4gVGhlIG9u
bHkgcGxhY2Ugd2hlcmUgdGhlIGdyYW5kY2hpbGRyZW4gYXJlIHN0aWxsIHJlYWNoYWJsZQp0aGlz
IHdheSBpcyBpbiBTSUdDSExEIGhhbmRsZXIgd2hpbGUgdGhlIGRlYWQgY2hpbGQgcHJvY2VzcyBz
dGlsbCBleGlzdHMKaW4gem9tYmllIHN0YXRlLgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hh
QHN1c2UuY3oKUUEgRW5naW5lZXIgZm9yIFNvZnR3YXJlIE1haW50ZW5hbmNlClNVU0UgTElOVVgs
IHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2gg
UmVwdWJsaWMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
