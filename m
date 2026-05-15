Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1235CD4F25
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 14:43:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10D793E2CA6
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 16:43:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 463A73E241E
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:42:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0276600754
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:42:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E0BC6B44E;
 Fri, 15 May 2026 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778856164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IwoSR5uC3u3FBpVq/ygj7SOHH2EjAytJOJD4XGlAeA=;
 b=a8Eopt5F7q9fxcalnjSROEeVkxIs4aC+zndlzW8lJSf2T/ZO8oEdOTjPEa0l05e9jaSbfn
 mVFT6gt6JtGUOvYbkxyMIAtJZ18+6G2j7OFUF94RAROFW3Kh6ySNXKnerQIiqRZ88jjbpY
 apZU/mMJZFjXlnaMf0mxfAxGSnxJYY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778856164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IwoSR5uC3u3FBpVq/ygj7SOHH2EjAytJOJD4XGlAeA=;
 b=UtxtRfX06D66J6waLtDW3xDMtbHiXMsHtcdbLNuHEd5PgZAgxvc1YlbcapL2TtmCyFpDMY
 GQZycaJeN74CmDDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778856164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IwoSR5uC3u3FBpVq/ygj7SOHH2EjAytJOJD4XGlAeA=;
 b=a8Eopt5F7q9fxcalnjSROEeVkxIs4aC+zndlzW8lJSf2T/ZO8oEdOTjPEa0l05e9jaSbfn
 mVFT6gt6JtGUOvYbkxyMIAtJZ18+6G2j7OFUF94RAROFW3Kh6ySNXKnerQIiqRZ88jjbpY
 apZU/mMJZFjXlnaMf0mxfAxGSnxJYY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778856164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IwoSR5uC3u3FBpVq/ygj7SOHH2EjAytJOJD4XGlAeA=;
 b=UtxtRfX06D66J6waLtDW3xDMtbHiXMsHtcdbLNuHEd5PgZAgxvc1YlbcapL2TtmCyFpDMY
 GQZycaJeN74CmDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCEF4593A9;
 Fri, 15 May 2026 14:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MQI+LeMwB2pPNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 14:42:43 +0000
Date: Fri, 15 May 2026 16:42:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260515144242.GB40164@pevik>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

SGkgYWxsLAoKYWN0dWFsbHkgdjIwIGlzIGJldHRlciB0aGFuIHRoaXMgdjIxID0+IHNldHRpbmcg
aXQgY2hhbmdlcyByZXF1ZXN0ZWQuCkknZCBwcmVmZXIgdG8gbWVyZ2UgdjIwLgoKPiBIaSBQaW90
ciwKCj4gT24gVGh1LCAxNCBNYXkgMjAyNiAxNTozNDo0NyArMDIwMCwgUGlvdHIgS3ViYWogd3Jv
dGU6Cj4gPiB0aGVybWFsOiBhZGQgbmV3IHRlc3QgZ3JvdXAKCj4gPiArCXdoaWxlIChzbGVlcF90
aW1lID4gMCkgewo+ID4gKwkJLi4uCj4gPiArCQlpZiAodGVtcCA+IHRlbXBfaGlnaCkKPiA+ICsJ
CQlicmVhazsKPiA+ICsJCXNsZWVwKHNsZWVwX3RpbWUtLSk7Cgo+IEcyOiBzbGVlcCgpIHVzZWQg
Zm9yIHN5bmNocm9uaXphdGlvbi4gVGhpcyBpcyBub3QgYSB0aW1lciBBUEkgdGVzdCBzbwo+IHRo
ZSBHMiBleGVtcHRpb24gZG9lcyBub3QgYXBwbHkuIENvbnNpZGVyIHBvbGxpbmcgd2l0aAo+IHRz
dF90aW1lcl9leHBpcmVkX21zKCkgb3IgZGlzY3VzcyB3aXRoIG1haW50YWluZXJzIGlmIGEgdGhl
cm1hbC1zcGVjaWZpYwo+IGV4Y2VwdGlvbiBpcyBhcHByb3ByaWF0ZS4KCj4gPiArCQkJdHN0X3Jl
cyhUSU5GTywgIkNvb2xpbmcgZG93biBmb3IgJWQgc2Vjb25kcyIsIENPT0xET1dOKTsKPiA+ICsJ
CQlzbGVlcChDT09MRE9XTik7Cgo+IEcyOiBTYW1lIGlzc3VlIOKAlCBzbGVlcCgpIHVzZWQgYXMg
YSBzeW5jaHJvbml6YXRpb24gYmFycmllciBmb3IgQ1BVCj4gY29vbGRvd24gYmV0d2VlbiB6b25l
IHRlc3RzLiBJZiBhIG5vbi1zbGVlcCBhbHRlcm5hdGl2ZSBpcyBnZW51aW5lbHkKPiBpbmZlYXNp
YmxlIGZvciB0aGVybWFsIHRlc3RpbmcsIHRoaXMgbmVlZHMgZXhwbGljaXQganVzdGlmaWNhdGlv
biBpbiB0aGUKPiBjb21taXQgbWVzc2FnZS4KClllcywgY29vbGRvd24gY291bGQgaGF2ZSBiZWVu
IG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIEknbGwgYWRkIGl0IGZvcgp2MjAuCgpL
aW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
