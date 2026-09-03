Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B61C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:26:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA0DD3EAD9A
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:25:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2E8E3CDED8
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:25:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8DA2B600965
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:25:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B06D21A90;
 Thu,  3 Sep 2026 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2FKwFWYWogccTlvzMN8I6O/aI/LwRHHBswzfoS2Ohw=;
 b=Gx405fqdsHr7Y0sYfEi75j1n5jHTBgqCRp4FYlh3l75TKZf8WyO5P5MlHxoMt68YnpARP9
 FKJfKEbHKgAdGOhhF51yhPSzAl3HM5iibWmboasd+moB3Lfx81Cn/lZ7+ZQk27yBwjxzwi
 6p4t1E7MQ0iNbhpBW1gogvKZ4ftVhWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2FKwFWYWogccTlvzMN8I6O/aI/LwRHHBswzfoS2Ohw=;
 b=u59D3HGmU9bwc6m/qeEgHu6scx3WwDcxoukTZ02c65Jc2CMNzwutacAy6DwDpEn5Js4xs6
 VrXGsI2EMgJAcTCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1bdtlm76;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OZscRvWe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449131;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2FKwFWYWogccTlvzMN8I6O/aI/LwRHHBswzfoS2Ohw=;
 b=1bdtlm76OWXacJlclTYizowVOErraDjxUzPHC7vKMFMmhO4Tnhh+PhwZGM7DJReBuuKnQ0
 rhGZAdz9cWaoDuSqqricPOASnhtsXph7uBD7bf2mX3xzSMn+RQpQBAufFAus0582SqqEY5
 vYSxnQoGyqxueltrVUfIXJi3jPpUE6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449131;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2FKwFWYWogccTlvzMN8I6O/aI/LwRHHBswzfoS2Ohw=;
 b=OZscRvWeVzihEZsjgEW4n7XLOn9olAIBMtfqSbzKkZzToIiNa81JYvdpq5oHtufBlInMR3
 +cemPxiPw8ne5lCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4844136D9;
 Thu,  3 Sep 2026 15:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u8GcK2qRmWo6TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 15:25:30 +0000
Date: Thu, 3 Sep 2026 17:25:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903152528.GD1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-2-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B06D21A90
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/31] lib: Add tst_sysfs_assert
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

SGkgQ3lyaWwsCgpGWUkgbW9yZSBtaW5vciBmb3JtYXR0aW5nIG5vdGVzLiBUaGVyZSBpcyBvZnRl
biBjb25mbGljdCB0aGF0IGRvYyByZWFkYWJsZSBpbgpvcGVuZWQgZmlsZSBoYXMgYnJva2VuIGZv
cm1hdHRpbmcgYW5kIGNvcnJlY3QgZm9ybWF0dGluZyBmb3IgSFRNTCBsb29rcyBzbGlnaHRseQps
ZXNzIHJlYWRhYmxlIHdoZW4gb3BlbmluZyBmaWxlLiBJIHBlcnNvbmFsbHkgcHJlZmVyIGJldHRl
ciBIVE1MIGZvcm1hdHRpbmcuCgpBbnl3YXksIHdob2xlIHN5c2ZzIGxpYnJhcnkgY29kZSBsb29r
cyByZWFsbHkgbmljZS4KUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoK
Li4uCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3N5c2ZzX2Fzc2VydC5oIGIvaW5jbHVkZS90
c3Rfc3lzZnNfYXNzZXJ0LmgKPiArCj4gKy8qKgo+ICsgKiBUU1RfU1lTRlNfQVNTRVJUX0NIT0lD
RSgpIC0gQXNzZXJ0cyB0aGF0IGZpbGUgaXMgYSBsaXN0IG9mIGNob2ljZXMuCj4gKyAqCj4gKyAq
IFZhbGlkYXRlcyBhIGJyYWNrZXRlZC1jaG9pY2UgZmlsZSBzdWNoIGFzOgo+ICsgKgo+ICsgKiAg
ICJub25lIG1xLWRlYWRsaW5lIGt5YmVyIFtiZnFdIgo+ICsgKiAgICJbYWx3YXlzXSBtYWR2aXNl
IG5ldmVyIgoKbml0OiB0aGlzIGlzIGlubGluZSwgYnV0IHdobyBjYXJlcy4KCj4gKyAqCj4gKyAq
IEFzc2VydHMgdGhhdCBleGFjdGx5IG9uZSB0b2tlbiBpcyBbc2VsZWN0ZWRdLiBJZiBhbGxvd2Vk
IGlzIG5vbi1OVUxMIChhCj4gKyAqIE5VTEwtdGVybWluYXRlZCBhcnJheSBvZiBzdHJpbmdzKSBp
dCBhbHNvIGFzc2VydHMgdGhhdCBldmVyeSB0b2tlbiBpcyBhCj4gKyAqIG1lbWJlciBvZiB0aGUg
YWxsb3dlZCBzZXQuIElmIHNlbCBpcyBub24tTlVMTCB0aGUgc2VsZWN0ZWQgdG9rZW4gKHdpdGgg
dGhlCj4gKyAqIGJyYWNrZXRzIHN0cmlwcGVkKSBpcyBjb3BpZWQgaW50byBzZWwsIHRydW5jYXRl
ZCB0byBzZWxfc2l6ZS4KPiArICoKPiArICogU2tpcHMgd2l0aCBUQ09ORiBpZiB0aGUgZmlsZSBk
b2VzIG5vdCBleGlzdC4KPiArICoKPiArICogQGFsbG93ZWQ6IE9wdGlvbmFsIE5VTEwgdGVybWlu
YXRlZCBhcnJheSBvZiBhbGxvd2VkIGNob2ljZXMuCj4gKyAqIEBzZWw6IEEgYnVmZmVyIHRvIGNv
cHkgdGhlIHNlbGVjdGVkIGNob2ljZSBpbnRvLgo+ICsgKiBAc2VsX3NpemU6IEEgc2l6ZSBvZiB0
aGUgc2VsIGJ1ZmZlci4KPiArICogQGZtdDogQSBwcmludGYtbGlrZSBmb3JtYXQgdG8gYnVpbGQg
YSBwYXRoIHRvIHRoZSBmaWxlLgo+ICsgKiBALi4uOiBBIHByaW50Zi1saWtlIHBhcmFtZXRlcnMg
Zm9yIGZtdC4KPiArICovCj4gKyNkZWZpbmUgVFNUX1NZU0ZTX0FTU0VSVF9DSE9JQ0UoYWxsb3dl
ZCwgc2VsLCBzZWxfc2l6ZSwgZm10LCAuLi4pIFwKPiArCXRzdF9zeXNmc19hc3NlcnRfY2hvaWNl
KF9fRklMRV9fLCBfX0xJTkVfXywgYWxsb3dlZCwgc2VsLCBzZWxfc2l6ZSwgXAo+ICsJCWZtdCwg
IyNfX1ZBX0FSR1NfXykKPiArCj4gK3ZvaWQgdHN0X3N5c2ZzX2Fzc2VydF9jaG9pY2UoY29uc3Qg
Y2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArCWNvbnN0IGNoYXIgKmNvbnN0IGFsbG93
ZWRbXSwgY2hhciAqc2VsLCBzaXplX3Qgc2VsX3NpemUsCj4gKwljb25zdCBjaGFyICpmbXQsIC4u
Lik7Cj4gKwo+ICsvKioKPiArICogVFNUX1NZU0ZTX0FTU0VSVF9UT0tFTlMoKSAtIEFzc2VydHMg
dGhhdCBmaWxlIGlzIGEgbGlzdCBvZiB0b2tlbnMuCj4gKyAqCj4gKyAqIFZhbGlkYXRlcyBhIGZp
bGUgdGhhdCBsaXN0cyBhIHdoaXRlc3BhY2Utc2VwYXJhdGVkIHNldCBvZiB0b2tlbnMgd2l0aG91
dCBhbnkKPiArICogYnJhY2tldGVkICJjdXJyZW50IiBzZWxlY3Rpb24sIHN1Y2ggYXMgL3N5cy9w
b3dlci9zdGF0ZToKPiArICoKPiArICogICAiZnJlZXplIG1lbSBkaXNrIgo+ICsgKgo+ICsgKiBB
c3NlcnRzIHRoYXQgdGhlIGZpbGUgaXMgbm9uLWVtcHR5IGFuZCwgaWYgYWxsb3dlZCBpcyBub24t
TlVMTCwgdGhhdCBldmVyeQo+ICsgKiB0b2tlbiBpcyBhIG1lbWJlciBvZiB0aGUgYWxsb3dlZCBz
ZXQgKGEgTlVMTC10ZXJtaW5hdGVkIGFycmF5IG9mIHN0cmluZ3MpLgo+ICsgKgo+ICsgKiBJZiBm
aW5kIGlzIG5vbi1OVUxMIGl0IGFkZGl0aW9uYWxseSBhc3NlcnRzIHRoYXQgZmluZCBpdHNlbGYg
d2FzIHNlZW4KPiArICogYW1vbmcgdGhlIHRva2Vucywgd2hpY2ggaXMgdXNlZnVsIGZvciBjcm9z
cy1jaGVja2luZyBhICJjdXJyZW50IiB2YWx1ZQo+ICsgKiByZWFkIGZyb20gYSBkaWZmZXJlbnQg
ZmlsZSBhZ2FpbnN0IHRoaXMgZmlsZSdzIGxpc3QsIGUuZy46Cj4gKyAqCj4gKyAqICAgVFNUX1NZ
U0ZTX0FTU0VSVF9UT0tFTlMoTlVMTCwgY3VycmVudF9jbG9ja3NvdXJjZSwKPiArICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAiJXMvYXZhaWxhYmxlX2Nsb2Nrc291cmNlIiwgbmFtZSk7CkJ1
dCB0aGlzIGhhcyBjb21wbGV0ZWx5IGJyb2tlbiBmb3JtYXR0aW5nIGluIGdlbmVyYXRlZCBodG1s
LCBsb29raW5nIGxpa2U6CgpUU1RfU1lTRlNfQVNTRVJUX1RPS0VOUyhOVUxMLCBjdXJyZW50X2Ns
b2Nrc291cmNlLAoKCeKAnCVzL2F2YWlsYWJsZV9jbG9ja3NvdXJjZeKAnSwgbmFtZSk7Cgp3aGVy
ZSBmaXJzdCBsaW5lIGlzIGJvbGQgZHVlIHRhYiBzaGlmdC4KCj0+IEknZCBqdXN0IGJlZm9yZSBt
ZXJnZSBwdXQgaXQgd2l0aG91dCB0YWIgYW5kIHB1dCBpbnRvIHNpbmdsZSBsaW5lLgoKICogVFNU
X1NZU0ZTX0FTU0VSVF9UT0tFTlMoTlVMTCwgY3VycmVudF9jbG9ja3NvdXJjZSwgIiVzL2F2YWls
YWJsZV9jbG9ja3NvdXJjZSIsIG5hbWUpOwoKPiArICoKPiArICogU2tpcHMgd2l0aCBUQ09ORiBp
ZiB0aGUgZmlsZSBkb2VzIG5vdCBleGlzdC4KPiArICoKPiArICogQGFsbG93ZWQ6IE9wdGlvbmFs
IE5VTEwgdGVybWluYXRlZCBhcnJheSBvZiBhbGxvd2VkIHRva2Vucy4KPiArICogQGZpbmQ6IE9w
dGlvbmFsIHRva2VuIHRoYXQgbXVzdCBiZSBwcmVzZW50IGluIHRoZSBmaWxlLCBvciBOVUxMIHRv
IHNraXAKPiArICogICAgICAgIHRoaXMgY2hlY2suCj4gKyAqIEBmbXQ6IEEgcHJpbnRmLWxpa2Ug
Zm9ybWF0IHRvIGJ1aWxkIGEgcGF0aCB0byB0aGUgZmlsZS4KPiArICogQC4uLjogQSBwcmludGYt
bGlrZSBwYXJhbWV0ZXJzIGZvciBmbXQuCj4gKyAqLwouLi4KCj4gK3ZvaWQgdHN0X3N5c2ZzX2Fz
c2VydF9saXN0X2NvbnRhaW5zKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4g
KwlpbnQgaWQsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKTsKPiArCj4gKy8qKgo+ICsgKiBlbnVtIHRz
dF9zeXNmc19jbXAgLSBDb21wYXJpc29uIG9wZXJhdG9ycyB1c2VkIGJ5IHRzdF9zeXNmc19hc3Nl
cnRfY21wKCkuCgpuaXQ6IEZZSSB0c3Rfc3lzZnNfYXNzZXJ0X2NtcCgpIGlzIHZpc2libGUgaW4g
SFRNTCBkb2MgLi4uCj4gKyAqCj4gKyAqIEBUU1RfU1lTRlNfQ01QX0VROiB2YWwxID09IHZhbDIK
PiArICogQFRTVF9TWVNGU19DTVBfTFQ6IHZhbDEgPCB2YWwyCj4gKyAqIEBUU1RfU1lTRlNfQ01Q
X0xFOiB2YWwxIDw9IHZhbDIKPiArICovCj4gK2VudW0gdHN0X3N5c2ZzX2NtcCB7Cj4gKwlUU1Rf
U1lTRlNfQ01QX0VRLAo+ICsJVFNUX1NZU0ZTX0NNUF9MVCwKPiArCVRTVF9TWVNGU19DTVBfTEUs
Cj4gK307Cj4gKwoKLi4uIGJlY2F1c2UgdGhpcyBoYXMgbm8gLyoqICovIGRvY3VtZW50YXRpb24u
CgpCdXQgSSBwZXJmZWN0bHkgdW5kZXJzdGFuZCB3aHkgeW91IGRpZCBpdCB0aGlzIHdheSwgbWF5
YmUgbm90ZSBtYWNyb3MgYXMgd2VsbDoKCi8qKgogKiBlbnVtIHRzdF9zeXNmc19jbXAgLSBDb21w
YXJpc29uIG9wZXJhdG9ycyB1c2VkIGJ5IHRzdF9zeXNmc19hc3NlcnRfY21wKCkKICogd2hpY2gg
aXMgdXNlZCBieSBUU1RfU1lTRlNfQVNTRVJUX0VRKCkgYW5kIG90aGVyIHRlc3QgbWFjcm9zLgog
Ki8KCktpbmQgcmVnYXJkcywKUGV0cgoKPiArdm9pZCB0c3Rfc3lzZnNfYXNzZXJ0X2NtcChjb25z
dCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICsJY29uc3QgY2hhciAqcGF0aDEsIGVu
dW0gdHN0X3N5c2ZzX2NtcCBvcCwgY29uc3QgY2hhciAqcGF0aDIpOwouLi4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
