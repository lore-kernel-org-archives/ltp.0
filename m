Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A23F436A3
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 13:35:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AC9A3E5947
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 15:35:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C554B3E1A57
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:35:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E290160007B
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:35:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A60B26A853;
 Fri, 17 Apr 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97918593AE;
 Fri, 17 Apr 2026 13:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DZ7TJCE34mk4cQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 17 Apr 2026 13:35:29 +0000
Message-ID: <d5b21bfa-5fd7-4e2d-b1c0-c89c6b509dbb@suse.cz>
Date: Fri, 17 Apr 2026 15:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, linuxtestproject.agent@gmail.com
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
 <20260417130920.GA420978@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260417130920.GA420978@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: A60B26A853
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Add common entry point function for all tests
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA0LzE3LzI2IDE1OjA5LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIE1hcnRpbiwKPiAK
Pj4gSGkgTWFydGluLAo+IAo+PiBPbiBUaHUsIDE2IEFwciAyMDI2LCBNYXJ0aW4gRG91Y2hhIHdy
b3RlOgo+Pj4gT3BlblBPU0lYOiBBZGQgY29tbW9uIGVudHJ5IHBvaW50IGZ1bmN0aW9uIGZvciBh
bGwgdGVzdHMKPiAKPj4+IEFkZCBhIG5ldyBzaGFyZWQgc291cmNlIGZpbGUgaW1wbGVtZW50aW5n
IHRoZSBtYWluKCkgZnVuY3Rpb24gYW5kIHJlbmFtZQo+Pj4gdGhlIGV4aXN0aW5nIG1haW4oKSBm
dW5jdGlvbnMgaW4gdGVzdCBjYXNlIHNvdXJjZXMgdG8gdGVzdF9tYWluKCkuIFRoaXMKPj4+IGFs
bG93cyBhZGRpbmcgY3VzdG9tIGRlYnVnIGNvZGUgdG8gYWxsIHRlc3QgY2FzZXMgYXQgb25jZS4K
PiAKPj4gWy4uLl0KPiAKPj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0
c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX2NyZWF0ZS9hc3NlcnRpb25zLnht
bCBiLy4uLgo+Pj4gLSAgTk9URTogdGhhdCB0aGUgdGhyZWFkIGluIHdoaWNoIG1haW4oKSB3YXMg
b3JpZ2luYWxseSBpbnZva2VkIGlzIGRpZmZlcmVudAo+Pj4gKyAgTk9URTogdGhhdCB0aGUgdGhy
ZWFkIGluIHdoaWNoIHRlc3RfbWFpbigpIHdhcyBvcmlnaW5hbGx5IGludm9rZWQgaXMgZGlmZmVy
ZW50Cj4gCj4+IFRoaXMgY2hhbmdlcyB2ZXJiYXRpbSBQT1NJWCBzcGVjaWZpY2F0aW9uIHRleHQu
IFRoZSBhc3NlcnRpb25zLnhtbCBmaWxlcwo+PiBxdW90ZSB0aGUgUE9TSVggc3RhbmRhcmQsIHdo
aWNoIGRlZmluZXMgYmVoYXZpb3VyIHJlbGF0aXZlIHRvIG1haW4oKSDigJQgdGhlIEMKPj4gZW50
cnkgcG9pbnQsIG5vdCBhbiBMVFAtaW50ZXJuYWwgZnVuY3Rpb24gbmFtZS4gUmV2ZXJ0IHRoZXNl
IGh1bmtzIGluIGJvdGgKPj4gcHRocmVhZF9jcmVhdGUvYXNzZXJ0aW9ucy54bWwgYW5kIHB0aHJl
YWRfZXhpdC9hc3NlcnRpb25zLnhtbC4KPiAKPiArMQoKVGhpcyAiaXNzdWUiIGlzIG5vbnNlbnNl
LiBJJ3ZlIGNoZWNrZWQgdGhlIFhNTCBmaWxlcyBhbmQgdGhlIGFzc2VydGlvbnMgCmFyZSBzdGls
bCBjb3JyZWN0IGFzIGlzIHJlZ2FyZGxlc3Mgb2YgcmVuYW1pbmcgYSBmZXcgZnVuY3Rpb25zLiBU
aGUgCnB0aHJlYWRfY3JlYXRlKCkgYW5kIHB0aHJlYWRfZXhpdCgpIHNwZWNpZmljYXRpb24gYXBw
bGllcyBzcGVjaWFsIAp0cmVhdG1lbnQgdG8gdGhlIG1haW4gdGhyZWFkIGFuZCBhZGRpbmcgb25l
IG1vcmUgZnVuY3Rpb24gY2FsbCBiZXR3ZWVuIAp0aGUgbWFpbigpIGZ1bmN0aW9uIGFuZCB0aGUg
dGVzdCBjb2RlIGRvZXMgbm90IGNoYW5nZSB0aGF0LgoKPj4+IGRpZmYgLS1naXQgYS8uLi4vYWlv
X3dyaXRlLzktMi5jIGIvLi4uL2Fpb193cml0ZS85LTIuYwo+Pj4gK2ludCB0ZXN0X21haW4oaW50
IGFyZ2MsIGNoYXIqKiBhcmd2KQo+IAo+PiBzL2NoYXIqKiBhcmd2L2NoYXIgKiphcmd2LyB0byBt
YXRjaCB0aGUgc3R5bGUgdXNlZCBldmVyeXdoZXJlIGVsc2UuCgpUaGlzIHR5cG8gaXMgYWN0dWFs
bHkgaW4gY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zdHJjcHkvMS0xLmMgKGxpbmUgMjM3OTMgCm9m
IHRoZSBwYXRjaCkuIFBsZWFzZSBjaGFuZ2UgdGhlIHRlc3RfbWFpbigpIHNpZ25hdHVyZSB0byB0
aGlzIGR1cmluZyBtZXJnZToKaW50IHRlc3RfbWFpbihpbnQgYXJnYyBQVFNfQVRUUklCVVRFX1VO
VVNFRCwgY2hhciAqKmFyZ3YgClBUU19BVFRSSUJVVEVfVU5VU0VEKQoKSSBkb24ndCB0aGluayBp
dCBtYWtlcyBzZW5zZSB0byBzZW5kIGFub3RoZXIgMU1CIHBhdGNoIHRvIGZpeCBvbmUgbGluZS4K
Ci0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5lZXIK
U1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFn
dWUgOApDemVjaCBSZXB1YmxpYwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
