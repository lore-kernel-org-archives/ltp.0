Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504FE99069
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 10:04:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC6C3E2E40
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 12:04:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ADA43C2DE1
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 12:04:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF4CD1400215
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 12:04:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C55E06A7E8;
 Fri, 10 Apr 2026 10:04:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B18894A0B2;
 Fri, 10 Apr 2026 10:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPsRKhPL2GkoYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Apr 2026 10:04:03 +0000
Date: Fri, 10 Apr 2026 12:04:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Matt Ochs <mochs@nvidia.com>
Message-ID: <adjLGwviRoTSsbgH@yuki.lan>
References: <20260408174406.1572520-1-mochs@nvidia.com>
 <addjDV_wbPgD0y8e@yuki.lan>
 <30B73CA1-6AD3-4926-9E73-3FF5423F34A0@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30B73CA1-6AD3-4926-9E73-3FF5423F34A0@nvidia.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: C55E06A7E8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBXaGVuIEkgcnVuIHRoZSB0ZXN0IEkgc2VlOgo+ID4KPiA+IC4uLgo+ID4gdHN0X3N1
cHBvcnRlZF9mc190eXBlcy5jOjE2NTogVElORk86IFNraXBwaW5nIEZVU0UgYmFzZWQgbnRmcyBh
cyByZXF1ZXN0ZWQgYnkgdGhlIHRlc3QKPiA+IC4uLgo+ID4KPiA+IFNvIGxpa2VseSBzb21ldGhp
bmcgZWxzZSBpcyBhdCBwbGF5IGhlcmUuIEFyZSB5b3Ugc3VyZSB5b3UgYXJlIGRlYWxpbmcKPiA+
IHdpdGggYSBmdXNlIGJhc2VkIG50ZnMgb3Igd2l0aCB0aGUga2VybmVsIGJhc2VkIGltcGxlbWVu
dGF0aW9uPwo+ID4KPgo+IE9uIFVidW50dSwgbnRmczMgaXMgYXZhaWxhYmxlIGFzIGEga2VybmVs
IG1vZHVsZSwgc28KPiBoYXNfa2VybmVsX3N1cHBvcnQoKSBpbiB0c3Rfc3VwcG9ydGVkX2ZzX3R5
cGVzLmMgcHJvYmVzIHRoZSBrZXJuZWwKPiBtb3VudCwgc3VjY2VlZHMsIGFuZCByZXR1cm5zIFRT
VF9GU19LRVJORUwgaW1tZWRpYXRlbHkg4oCUIG5ldmVyCj4gcmVhY2hpbmcgdGhlIEZVU0UgZGV0
ZWN0aW9uIHBhdGguIEFzIGEgcmVzdWx0LCB0aGUgZXhpc3RpbmcgImZ1c2UiCj4gc2tpcCBkb2Vz
bid0IGZpcmUgZXZlbiB0aG91Z2ggc2FmZV9tYWNyb3MgYWx3YXlzIG1vdW50cyBudGZzIHZpYSBG
VVNFCj4gYW55d2F5LgoKSSB0aGluayBJJ3ZlIGZpZ3VyZWQgaXQgb3V0LiBUaGUgbnRmcyBkcml2
ZXIgaW4ga2VybmVsIGlzIHRoZSBvbGQKcmVhZC1vbmx5IG9uZSBhbmQgbnRmczMgaXMgdGhlIG5l
dyByZWFkLXdyaXRlIGtlcm5lbCBkcml2ZXIuCgpXaGF0IHdlIGNhbiBkbyBpbiB0aGUgbGlicmFy
eSBpcyB0byBmaXggdGhlIG50ZnMgZHJpdmVyIHRvIGJlIGFsd2F5cwpoYW5kbGVkIGJ5IGZ1c2Ug
YW5kIGFkZCBudGZzMyB0aGF0IGlzIHRoZSByZWFkLXdyaXRlIGtlcm5lbCBkcml2ZXIuIFdpdGgK
dGhhdCB3ZSB3aWxsIGZpeCB0aGlzIHRlc3QgYnV0IGFsc28gZW5hYmxlIG1vcmUgY292ZXJhZ2Uu
CgpUaGlzIHdvcmtzIGZvciBtZToKCmRpZmYgLS1naXQgYS9saWIvdHN0X21rZnMuYyBiL2xpYi90
c3RfbWtmcy5jCmluZGV4IGM2MTlhMzczZC4uOTYxZmZjMDkxIDEwMDY0NAotLS0gYS9saWIvdHN0
X21rZnMuYworKysgYi9saWIvdHN0X21rZnMuYwpAQCAtNTAsNiArNTAsOSBAQCB2b2lkIHRzdF9t
a2ZzXyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2Zu
KSh2b2lkKSwKICAgICAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CgorICAgICAgIGlmICgh
c3RyY21wKGZzX3R5cGUsICJudGZzMyIpKQorICAgICAgICAgICAgICAgZnNfdHlwZSA9ICJudGZz
IjsKKwogICAgICAgIHNucHJpbnRmKG1rZnMsIHNpemVvZihta2ZzKSwgIm1rZnMuJXMiLCBmc190
eXBlKTsKCiAgICAgICAgaWYgKGZzX29wdHMpIHsKZGlmZiAtLWdpdCBhL2xpYi90c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmMgYi9saWIvdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jCmluZGV4IDBjOGM4
ZGM1MC4uZDMwMjBmYzQ4IDEwMDY0NAotLS0gYS9saWIvdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
CisrKyBiL2xpYi90c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMKQEAgLTMwLDYgKzMwLDcgQEAgc3Rh
dGljIGNvbnN0IGNoYXIgKmNvbnN0IGZzX3R5cGVfd2hpdGVsaXN0W10gPSB7CiAgICAgICAgInZm
YXQiLAogICAgICAgICJleGZhdCIsCiAgICAgICAgIm50ZnMiLAorICAgICAgICJudGZzMyIsCiAg
ICAgICAgInRtcGZzIiwKICAgICAgICBOVUxMCiB9OwpAQCAtNTEsNiArNTIsOSBAQCBzdGF0aWMg
aW50IGhhc19ta2ZzKGNvbnN0IGNoYXIgKmZzX3R5cGUpCiAgICAgICAgICAgICAgICByZXR1cm4g
MTsKICAgICAgICB9CgorICAgICAgIGlmICghc3RyY21wKGZzX3R5cGUsICJudGZzMyIpKQorICAg
ICAgICAgICAgICAgZnNfdHlwZSA9ICJudGZzIjsKKwogICAgICAgIHNwcmludGYoYnVmLCAibWtm
cy4lcyA+L2Rldi9udWxsIDI+JjEiLCBmc190eXBlKTsKCiAgICAgICAgcmV0ID0gdHN0X3N5c3Rl
bShidWYpOwpAQCAtODcsNiArOTEsOSBAQCBzdGF0aWMgZW51bSB0c3RfZnNfaW1wbCBoYXNfa2Vy
bmVsX3N1cHBvcnQoY29uc3QgY2hhciAqZnNfdHlwZSkKICAgICAgICBjaGFyIHRlbXBsYXRlW1BB
VEhfTUFYXTsKICAgICAgICBpbnQgcmV0OwoKKyAgICAgICBpZiAoIXN0cmNtcChmc190eXBlLCAi
bnRmcyIpKQorICAgICAgICAgICAgICAgZ290byBjaGVja19mdXNlOworCiAgICAgICAgc25wcmlu
dGYodGVtcGxhdGUsIHNpemVvZih0ZW1wbGF0ZSksICIlcy9tb3VudFhYWFhYWCIsIHRtcGRpcik7
CiAgICAgICAgaWYgKCFta2R0ZW1wKHRlbXBsYXRlKSkKICAgICAgICAgICAgICAgIHRzdF9icmso
VEJST0sgfCBURVJSTk8sICJta2R0ZW1wKCVzKSBmYWlsZWQiLCB0ZW1wbGF0ZSk7CkBAIC0xMDIs
NiArMTA5LDcgQEAgc3RhdGljIGVudW0gdHN0X2ZzX2ltcGwgaGFzX2tlcm5lbF9zdXBwb3J0KGNv
bnN0IGNoYXIgKmZzX3R5cGUpCgogICAgICAgIFNBRkVfUk1ESVIodGVtcGxhdGUpOwoKK2NoZWNr
X2Z1c2U6CiAgICAgICAgaWYgKHRzdF9mc19pbl9za2lwbGlzdChmc190eXBlLCBmc190eXBlX2Z1
c2VfYmxhY2tsaXN0KSkgewogICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlNraXBwaW5n
ICVzIGJlY2F1c2Ugb2YgRlVTRSBibGFja2xpc3QiLCBmc190eXBlKTsKICAgICAgICAgICAgICAg
IHJldHVybiBUU1RfRlNfVU5TVVBQT1JURUQ7CgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1
c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
