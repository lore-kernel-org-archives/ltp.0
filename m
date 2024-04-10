Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B293CD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 09:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54DC83CF75F
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 11:53:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FADE3CF72A
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:53:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E71F460192B
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 11:53:33 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A10505C9E8;
 Wed, 10 Apr 2024 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712742812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPEEWEJiGHdPXZ4ot/RYUh4W5oGRYL8hcZMXwNJ16/s=;
 b=oo3OHx1jUkQVOZUP8hVfYVm8kmACFJAGGAL5k3r6dQsgZ5D3PANUnO6wdwz4qQeQR89nCg
 X7wyjX3ggs6G+SdU5egpQaP7ZBU/4f7tdyhvuKqAdngG0dJu06PXXcc3FTQuz7bo8hlbO1
 469UgWff7zjBKcVuoi6474GLUIBjD/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712742812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPEEWEJiGHdPXZ4ot/RYUh4W5oGRYL8hcZMXwNJ16/s=;
 b=7Yzw1yNZrWj9F7b4dIF8oQH6rp7p6i4P5wfWj5A0Y5IQnNSeJXcgWbKl5fq9T/pNSNpQnY
 5jDY23ntrgOScjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712742811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPEEWEJiGHdPXZ4ot/RYUh4W5oGRYL8hcZMXwNJ16/s=;
 b=wO0Wa5apfVxdZxwWktULodtCIAVN50k6kP4gKPTOtqegqnqsDhQPerTkKrNZfewnsU1KxJ
 emdACFXdBpbE3XkUJ3R7lRiDxDbUEL7g9lNp2+02/Wg7pzBB7Op+dKm8gAj8ToCMU8xxAA
 m8t5q99V+J/t3XctJX9Cd+eN2sGDaEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712742811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPEEWEJiGHdPXZ4ot/RYUh4W5oGRYL8hcZMXwNJ16/s=;
 b=e/BfDcVKBrfdYzxw2xSjyeGgmaWPzd66ISkiFw9G7At7qGBq81pxd0JSKlegYtqtwqKjiA
 tPL6o2/H67sZLaDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 745C413A92;
 Wed, 10 Apr 2024 09:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id xkEbG5thFmYCZQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Apr 2024 09:53:31 +0000
Date: Wed, 10 Apr 2024 11:53:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, samasth.norway.ananda@oracle.com,
 calum.mackay@oracle.com, ltp@lists.linux.it
Message-ID: <20240410095330.GB184706@pevik>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
 <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
 <20240409101753.GA107959@pevik> <ZhZcL9cH5bVDWL_k@yuki>
 <20240410094621.GA184706@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240410094621.GA184706@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgouLi4KPiA+IFNob3VsZG4ndCB3ZSBsaW1pdCB0aGlzIG9ubHkgdG8gbmZzLCB0byBtYWtl
IHN1cmUgdGhhdCBmYWxsb2NhdGUoKSBpcwo+ID4gbm90IGFjY2lkZW50YWxseSBkaXNhYmxlZCBv
biBvdGhlciBmaWxlc3lzdGVtcz8gQXQgbGVhc3QgdGhhdCB3aGF0IEkKPiA+IHN1Z2dlc3RlZCB3
aGVuIEkgcmVwbGllZCB0byB0aGUgcGF0Y2guCgo+IFRoYXQncyB3aGF0IEkgYWxzbyBtZWFudCBi
eSBteSBlYXJsaWVyIHN1Z2dlc3Rpb24gKG9yLCBiZXR0ZXIgSSB3YXMgbm90IHN1cmUKPiBteXNl
bGYgaWYgaXQncyBuZWVkZWQpLiBJIHdvdWxkIHZvdGUgZm9yIHRoaXMgY2hlY2suIEJ1dCBzaW5j
ZSB3ZSBhbHJlYWR5IGhhdmUKPiB0aGlzIHByb2JsZW0gaW4gb3RoZXIgZmlsZXMsIEkgd291bGQg
YmUgb2sgdG8gbWVyZ2UgdGhpcyBmaXJzdCBhbmQgaGFuZGxlCj4gcHJvcGVyIGZpeCBhcyBhIHNl
cGFyYXRlIGFwcHJvYWNoIGlmIFNhbWFzdGggZG9lcyBub3QgaGF2ZSB0aW1lIHRvIHNvbHZlIGl0
Cj4gaGltc2VsZi4gQFNhbWFzdGggV0RZVD8KCj4gVGhlIHNvbHV0aW9uIHdvdWxkIGJlIHRvIGF0
IGxlYXN0IGNoZWNrIGZvciB0c3RfZnNfdHlwZSgiLiIpID09IFRTVF9ORlNfTUFHSUMuCj4gUGVy
ZmVjdCBzb2x1dGlvbiB3b3VsZCBJTUhPIGJlIHRvIGNoZWNrIGZvciBORlMgdmVyc2lvbiAoZS5n
LiBpbiAvcHJvYy9tb3VudHMpCj4gYW5kIFRDT05GIG9ubHkgb24gTkZTdjMuCgo+IEJUVyBXaGVu
IEkgZmlyc3QgcmVhZCBtYW4gZmFsbG9jYXRlKDIpLCBJIGludGVycHJldGVkIGZvbGxvd2luZyBu
b3RlIHJlbGF0ZWQgdG8KPiBGQUxMT0NfRkxfUFVOQ0hfSE9MRSBhYm91dCBnZW5lcmFsIGZhbGxv
Y2F0ZSgpIHN1cHBvcnQ6Cgo+IAlOb3QgYWxsIGZpbGVzeXN0ZW1zIHN1cHBvcnQgRkFMTE9DX0ZM
X1BVTkNIX0hPTEU7IGlmIGEgZmlsZXN5c3RlbSBkb2Vzbid0Cj4gCXN1cHBvcnQgdGhlIG9wZXJh
dGlvbiwgYW4gZXJyb3IgaXMgcmV0dXJuZWQuICBUaGUgb3BlcmF0aW9uIGlzIHN1cHBvcnRlZCBv
biBhdAo+IAlsZWFzdCB0aGUgZm9sbG93aW5nIGZpbGVzeXN0ZW1zOgoKPiAJ4oCiICBYRlMgKHNp
bmNlIExpbnV4IDIuNi4zOCkKPiAJ4oCiICBleHQ0IChzaW5jZSBMaW51eCAzLjApCj4gCeKAoiAg
QnRyZnMgKHNpbmNlIExpbnV4IDMuNykKPiAJ4oCiICB0bXBmcyg1KSAoc2luY2UgTGludXggMy41
KQo+IAnigKIgIGdmczIoNSkgKHNpbmNlIExpbnV4IDQuMTYpCgpBY3R1YWxseSwgSSBjb3JyZWN0
IG15c2VsZi4gVmVyeSBwcm9wZXIgY2hlY2sgd291bGQgYmUgc2hvdWxkIFRDT05GIG9ubHkgb24g
YWxsCmZpbGVzeXN0ZW1zIHdlIHRlc3QgKGZzX3R5cGVfd2hpdGVsaXN0W10pICsgdGhlc2UgbGlz
dGVkIGhlcmUgZnJvbSBwYXJ0aWN1bGFyCnZlcnNpb24uIGkuZS4gbm90IG9ubHkgTkZTdjMgaXMg
YWZmZWN0ZWQuIEJ1dCBnaXZlbiBpdCB3b3JrcyBvbiBORlN2NCosIGl0J2QgYmUKZ29vZCB0byBj
aGVjayB0aGUgY3VycmVudCBzdXBwb3J0LiBPciB3ZSBtaWdodCBqdXN0IGlnbm9yZSB0aGUgVENP
TkYgY2hlY2ssIGFzCm1vc3Qgb2YgdGhlIGZpbGVzeXN0ZW1zIGdvdCBzdXBwb3J0IGluIGtlcm5l
bCAzLnggYW5kIHRoZSBvbGRlc3QgKGdmczIpIGlzIDQuMTYuCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gU29tZSBvZiB0aGUgdGVzdHMgd2hpY2ggYXJlIHVzaW5nIGZhbGxvY2F0ZSgpIGluZGVlZCB0
ZXN0IEZBTExPQ19GTF9QVU5DSF9IT0xFOgoKPiAkIGdpdCBncmVwIC1sIEZBTExPQ19GTF9QVU5D
SF9IT0xFIHRlc3RjYXNlcy8KPiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VmYWxs
b2NhdGUvaHVnZWZhbGxvY2F0ZTAxLmMKPiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VmYWxsb2NhdGUvaHVnZWZhbGxvY2F0ZTAyLmMKPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2ZhbGxvY2F0ZS9mYWxsb2NhdGUwNC5jCj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxs
b2NhdGUvZmFsbG9jYXRlMDUuYwo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9jYXRl
L2ZhbGxvY2F0ZTA2LmMKPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21lbWZkX2NyZWF0ZS9t
ZW1mZF9jcmVhdGVfY29tbW9uLmMKCj4gYW5kIG90aGVycyBub3QsIGUuZy46Cj4gdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMFsxLTNdLmMKPiB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21yZW1hcC9tcmVtYXAwNi5jICh3aGljaCBkb2VzIG5vdCBjaGVjayBl
cnJubyBhdCBhbGwsCj4gbGlrZWx5IG5vdCBuZWVkZWQpLgoKPiBUaGVyZWZvcmUgYWxzbyBjaGVj
ayBmb3IgRkFMTE9DX0ZMX1BVTkNIX0hPTEUgd291bGQgYmUgbmVlZGVkIChpbiBhZGRpdGlvbiB0
bwo+IGFsbCBORlMgb3IgTkZTdjMpLgoKPiBCVFcgdGhlIG1hbiBwYWdlIGRvZXMgbm90IG1lbnRp
b24gTkZTIGF0IGFsbC4gQFNhbWFzdGggd291bGQgeW91IHBsZWFzZSBzZW5kIGEKPiBwYXRjaCB0
byBsaW51eC1tYW4gTUw/Cgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
