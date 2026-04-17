Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B180F4369D
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 13:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 386483E594C
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 15:09:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EACBC3E1BB6
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:09:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C0E21000D29
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:09:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43C555BCC4;
 Fri, 17 Apr 2026 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776431370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjWAxIi6htKRa9UKKhPHkPeXKW4j82r6s4kwbH7+sFI=;
 b=es9da/K4mRTAw8RjAPbR444BSMkc2gX1jctn/iQh0kE++OjFEzhbzT/i86vjoLpbl61VEy
 X9rcVBFECBr7s4C1rMdxzj0DdykkOWp9aYfUGxmjMjs5CSApcL+ySp4N7csdQLKFWPG8ea
 Y+Sr8xx7e4KzD5DWOt2E4iajAt5k6ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776431370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjWAxIi6htKRa9UKKhPHkPeXKW4j82r6s4kwbH7+sFI=;
 b=HZ1TTXtirNnKNckDJ3qkZQVVzPVUIT/DwNNBwsQqGtMk9IT794o2BOZu+XxFerBLu44WdN
 x3VouItXstRMaPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776431370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjWAxIi6htKRa9UKKhPHkPeXKW4j82r6s4kwbH7+sFI=;
 b=es9da/K4mRTAw8RjAPbR444BSMkc2gX1jctn/iQh0kE++OjFEzhbzT/i86vjoLpbl61VEy
 X9rcVBFECBr7s4C1rMdxzj0DdykkOWp9aYfUGxmjMjs5CSApcL+ySp4N7csdQLKFWPG8ea
 Y+Sr8xx7e4KzD5DWOt2E4iajAt5k6ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776431370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjWAxIi6htKRa9UKKhPHkPeXKW4j82r6s4kwbH7+sFI=;
 b=HZ1TTXtirNnKNckDJ3qkZQVVzPVUIT/DwNNBwsQqGtMk9IT794o2BOZu+XxFerBLu44WdN
 x3VouItXstRMaPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1BE593AE;
 Fri, 17 Apr 2026 13:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFu2BAox4mmNVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 13:09:30 +0000
Date: Fri, 17 Apr 2026 15:09:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260417130920.GA420978@pevik>
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKPiBIaSBNYXJ0aW4sCgo+IE9uIFRodSwgMTYgQXByIDIwMjYsIE1hcnRpbiBE
b3VjaGEgd3JvdGU6Cj4gPiBPcGVuUE9TSVg6IEFkZCBjb21tb24gZW50cnkgcG9pbnQgZnVuY3Rp
b24gZm9yIGFsbCB0ZXN0cwoKPiA+IEFkZCBhIG5ldyBzaGFyZWQgc291cmNlIGZpbGUgaW1wbGVt
ZW50aW5nIHRoZSBtYWluKCkgZnVuY3Rpb24gYW5kIHJlbmFtZQo+ID4gdGhlIGV4aXN0aW5nIG1h
aW4oKSBmdW5jdGlvbnMgaW4gdGVzdCBjYXNlIHNvdXJjZXMgdG8gdGVzdF9tYWluKCkuIFRoaXMK
PiA+IGFsbG93cyBhZGRpbmcgY3VzdG9tIGRlYnVnIGNvZGUgdG8gYWxsIHRlc3QgY2FzZXMgYXQg
b25jZS4KCj4gWy4uLl0KCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVz
dHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9jcmVhdGUvYXNzZXJ0aW9ucy54
bWwgYi8uLi4KPiA+IC0gIE5PVEU6IHRoYXQgdGhlIHRocmVhZCBpbiB3aGljaCBtYWluKCkgd2Fz
IG9yaWdpbmFsbHkgaW52b2tlZCBpcyBkaWZmZXJlbnQKPiA+ICsgIE5PVEU6IHRoYXQgdGhlIHRo
cmVhZCBpbiB3aGljaCB0ZXN0X21haW4oKSB3YXMgb3JpZ2luYWxseSBpbnZva2VkIGlzIGRpZmZl
cmVudAoKPiBUaGlzIGNoYW5nZXMgdmVyYmF0aW0gUE9TSVggc3BlY2lmaWNhdGlvbiB0ZXh0LiBU
aGUgYXNzZXJ0aW9ucy54bWwgZmlsZXMKPiBxdW90ZSB0aGUgUE9TSVggc3RhbmRhcmQsIHdoaWNo
IGRlZmluZXMgYmVoYXZpb3VyIHJlbGF0aXZlIHRvIG1haW4oKSDigJQgdGhlIEMKPiBlbnRyeSBw
b2ludCwgbm90IGFuIExUUC1pbnRlcm5hbCBmdW5jdGlvbiBuYW1lLiBSZXZlcnQgdGhlc2UgaHVu
a3MgaW4gYm90aAo+IHB0aHJlYWRfY3JlYXRlL2Fzc2VydGlvbnMueG1sIGFuZCBwdGhyZWFkX2V4
aXQvYXNzZXJ0aW9ucy54bWwuCgorMQoKPiA+IGRpZmYgLS1naXQgYS8uLi4vYWlvX3dyaXRlLzkt
Mi5jIGIvLi4uL2Fpb193cml0ZS85LTIuYwo+ID4gK2ludCB0ZXN0X21haW4oaW50IGFyZ2MsIGNo
YXIqKiBhcmd2KQoKPiBzL2NoYXIqKiBhcmd2L2NoYXIgKiphcmd2LyB0byBtYXRjaCB0aGUgc3R5
bGUgdXNlZCBldmVyeXdoZXJlIGVsc2UuCgorMQoKQE1hcnRpbiwgd2lsbCB5b3UgcGxlYXNlIHNl
bmQgdjI/CgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
