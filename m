Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA1CC54F51
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 21:04:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A5323E7484
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 23:04:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB3F63E18C4
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AFAD5600838
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:04:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E35BE3DF5;
 Tue, 28 Jul 2026 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnyYY4NvkFUaWgItFnOvJwZ1u3bnxqaKjAAmcMKXwqo=;
 b=E2qdmSGCv4OYe9sEb8sul+kltoGY13Rj9y4z5y4AsrzxvlsIO268QfDObbNaIMwH0IbqUF
 xlwwQ4SJUe9M/i9zrpLTykiSte0jRKgCZ875MdVn2IEBnT3+G+2T2+FkHLC5OIS7xz4X8K
 zankGpudr4XkcF/uZ/rdlh0G3GUWaOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnyYY4NvkFUaWgItFnOvJwZ1u3bnxqaKjAAmcMKXwqo=;
 b=RiJ+uuQNSGgCU+UHTFAMIgxuUib76GxxPC8Wn3Dx0aNCYO+XeNF2YPsQH2+EsrI+Xy3KhL
 L3qgzV+V00C8RlBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnyYY4NvkFUaWgItFnOvJwZ1u3bnxqaKjAAmcMKXwqo=;
 b=MBLNRO5TYzoYSZn2AU66hFnXCHR/xd0IBoAE0qbvBevdLLeIMD2rscmK8ECFtaj3DiuZGM
 mKKvRz09Nmy9zNFkOmr5uJ0qJUKweiWTqD2Q1UCzghI6gnaNK5TFtPs7DMzozrmdG/3GQb
 mh4uz8R8mcuna0mOQjRoRgdkCWsaqvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnyYY4NvkFUaWgItFnOvJwZ1u3bnxqaKjAAmcMKXwqo=;
 b=19DdTyoCM+KdhhOTIs6NF15xP+kh2qDdmUSuk0KyWHJ8fWEgeKxNMOAcPl8n9UjOE91b55
 iZl26TVyUGSjsMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B88CD779B1;
 Tue, 28 Jul 2026 21:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hrjbKlsZaWqgDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 21:04:27 +0000
Date: Tue, 28 Jul 2026 23:04:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260728210409.GB114518@pevik>
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com>
 <20260727082240.GA1010349@pevik>
 <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
 <20260728131601.GA1065673@pevik>
 <CAASaF6y+umcvL+fvCvr=V=b9qAu2waBu2oUARxze6bA1=Ui45g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y+umcvL+fvCvr=V=b9qAu2waBu2oUARxze6bA1=Ui45g@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,sourceware.org:url,suse.cz:replyto,suse.cz:email,linux.it:url,linux.it:email,list.org:url];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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

PiBPbiBUdWUsIEp1bCAyOCwgMjAyNiBhdCAzOjE24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEJyaWFuLAoKPiA+ID4gSGkgUGV0ciwKCj4gPiA+IEhhcHB5
IHRvIGNvbnRyaWJ1dGUhCj4gPiBXZSBhcmUgaGFwcHkgdG8gZ2V0IG5ldyBjb250cmlidXRvcnMg
OikuCgo+ID4gPiBUaGFuayB5b3UgZm9yIGxldHRpbmcgbWUga25vdywgdGhhdCBpcyBzdHJhbmdl
LiBPbiBteSBzeXN0ZW0gaXQncwo+ID4gPiBjb25maWd1cmVkIGNvcnJlY3RseS4gRGlnZ2luZyBh
IGxpdHRsZSBkZWVwZXIsIEkgdGhpbmsgaXQgbWlnaHQgYmUgYQo+ID4gPiBjb3Jwb3JhdGUgc210
cCBpc3N1ZS4KCj4gPiBGWUkgaXQncyBtYW5nbGVkICJGcm9tOiIgbWFpbCBoZWFkZXIgWzFdOiAi
RnJvbTogQnJpYW4gR3JlY2ggdmlhIGx0cAo+ID4gPGx0cEBsaXN0cy5saW51eC5pdD4iLiBJdCdz
IHByb2JhYmx5IERNQVJDICsgTWFpbG1hbiByZWxhdGVkLgoKPiA+IEJUVyBJIHRob3VnaHQgaXQg
c2hvdWxkIG5vdCBiZSBvbiByZWRoYXQuY29tIHNpZGUsIGJlY2F1c2UgSmFuIFN0YW5jZWsgZG9l
cyBub3QKPiA+IGhhdmUgdGhhdCBwcm9ibGVtLCBidXQgYWN0dWFsbHkgaGUgZG9lcyBoYXZlIHRo
YXQgcHJvYmxlbSBhcyB3ZWxsIFszXSAiRnJvbTogSmFuCj4gPiBTdGFuY2VrIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4iLiBJdCdzIGp1c3QgaGUgcHJvYmFibHkgZG9lcyBtZXJnZSB0aGVz
ZQo+ID4gcGF0Y2hlcyBkaXJlY3RseSB3aXRob3V0IGZpcnN0IGRvd25sb2FkaW5nIHRoZW0gZnJv
bSB0aGUgbWFpbGluZyBsaXN0LgoKPiBIbSBpbnRlcmVzdGluZywgaXQgYXBwZWFycyB0byBiZSBv
bmx5IExUUC4gVGhlIHBhdGNoIEkgc2VudCBsYXN0IHdlZWsKPiB0byBsa21sIGFwcGVhcnMgdG8g
YmUgT0ssCj4gYW5kIGl0J3MgdGhlIHNhbWUgZ2l0Y29uZmlnIHNldHVwOgo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvODRhMzVlMTZmNzIzMzBkNmU3YjJkNmU5NjkwNDBmMzY5NTllMmRh
ZC4xNzg0NjMwMjkwLmdpdC5qc3RhbmNla0ByZWRoYXQuY29tL3JhdwoKSXQgbG9va3Mgc29tZXRo
aW5nIGF0IGxlYXN0IHJlbGF0ZWQgdG8gb3VyIG9sZCBNYWlsbWFuIG9uIGxpc3RzLmxpbnV4Lml0
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+ID4gQW55d2F5LCB2ZXJ5IG1pbm9yIHByb2JsZW0sIGJ1
dCBpdCdkIGJlIG5pY2UgdG8gZ2V0IGl0IGZpeGVkLiBPdXIgbGlzdCBoYXMKPiA+IHNldHVwOiBm
cm9tX2lzX2xpc3QgPSBuby4gSSBzdXBwb3NlIHRoaXMgaXMgY29ycmVjdCAobG9va2luZyBhdCB0
aGUgZG9jcyBbNF0gYW5kCj4gPiBhbHNvIGNoZWNrIG90aGVyIHByb2plY3RzIHNldHVwIFs1XSku
Cgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgoKPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sdHAvMjAyNjA3MjIyMTI2NDYuMjM0MDM0MC0xLWJncmVjaEByZWRoYXQuY29tL3Jhdwo+
ID4gWzJdIGh0dHBzOi8vd2lraS5saXN0Lm9yZy9ERVYvRE1BUkMKPiA+IFszXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sdHAvMDhjODVjZjY0ZDcwM2RmYWJhMzEzOThhYjlkOWI0ODA0ODhmZTMz
OC4xNzQ3MjI3NDgxLmdpdC5qc3RhbmNla0ByZWRoYXQuY29tL3Jhdwo+ID4gWzRdIGh0dHBzOi8v
bGlzdC5vcmcvbWFpbG1hbi1hZG1pbi50eHQKPiA+IFs1XSBodHRwczovL3NvdXJjZXdhcmUub3Jn
L3BpcGVybWFpbC9iaW51dGlscy8yMDIzLU9jdG9iZXIvMTI5ODUyLmh0bWwKCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
