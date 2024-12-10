Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2DCE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 07:00:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A32B33E534D
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 08:00:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62EBE3E5340
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 08:00:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFA87141037A
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 08:00:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44BFE1F392;
 Tue, 10 Dec 2024 07:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733814000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEhZZ3T5H5wD8xRMLReljJsjzkXqfLvNVb5Y5oa1zIc=;
 b=b0C/JdmLiCuhAlo0DGAoZ9N8ggasijlbLGWV8m9/b+C9GO2QJTOgejKQul0npLDrnB0Jn6
 7E5rjP/fuxMnqcwMoUFhcYk12JaVlhx97DkqdgPzkVMyZLYPoW/rcCldjgIXNq5SWEZBhk
 Z0EfI3tn0rfD3JkxoXZPykdOH3+vHR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733814000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEhZZ3T5H5wD8xRMLReljJsjzkXqfLvNVb5Y5oa1zIc=;
 b=S/gbXg5GCy2zJoQABulcWL2fyoPJxmLlzHN3OHn0wpd8fXhhuJwMc9n4tQoDcQ11FHgNZs
 zSCawB7OLbQ5UYCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733814000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEhZZ3T5H5wD8xRMLReljJsjzkXqfLvNVb5Y5oa1zIc=;
 b=b0C/JdmLiCuhAlo0DGAoZ9N8ggasijlbLGWV8m9/b+C9GO2QJTOgejKQul0npLDrnB0Jn6
 7E5rjP/fuxMnqcwMoUFhcYk12JaVlhx97DkqdgPzkVMyZLYPoW/rcCldjgIXNq5SWEZBhk
 Z0EfI3tn0rfD3JkxoXZPykdOH3+vHR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733814000;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEhZZ3T5H5wD8xRMLReljJsjzkXqfLvNVb5Y5oa1zIc=;
 b=S/gbXg5GCy2zJoQABulcWL2fyoPJxmLlzHN3OHn0wpd8fXhhuJwMc9n4tQoDcQ11FHgNZs
 zSCawB7OLbQ5UYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FF81138D2;
 Tue, 10 Dec 2024 07:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TC8BvDmV2dvBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 07:00:00 +0000
Date: Tue, 10 Dec 2024 07:59:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241210065954.GB227882@pevik>
References: <20241206094938.92895-1-pvorel@suse.cz>
 <20241206094938.92895-2-pvorel@suse.cz>
 <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
 <20241209101348.GA206052@pevik>
 <CAEemH2dpExk4HqzGEkpC-oBwnc-fRVMnwy0_n4LbfbS9OoJ1oA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dpExk4HqzGEkpC-oBwnc-fRVMnwy0_n4LbfbS9OoJ1oA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected
 results
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

PiBPbiBNb24sIERlYyA5LCAyMDI0IGF0IDY6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgTGksIGFsbCwKCj4gPiAuLi4KPiA+ID4gV2UgY291bGQgYWRk
IGEgYmxhbmsgbGluZSBwcmludCBoZXJlIHRvIG1ha2UgdGhlIG91dHB1dCBiZXR0ZXIgcmVhZGFi
bGUuCgo+ID4gPiAgIGVjaG8gIiIKCj4gPiA+ICsgICAgICAgICAgICAgICBlY2hvICIqKiogUnVu
bmluZyAnJHRlc3QnIChleHA6ICQodHN0X21hc2syZmxhZyAkZXhwKSkKPiA+ICoqKiIKCj4gPiAr
MQoKCj4gPiA+ID4gKyAgICAgICAgICAgICAgICR0ZXN0Cj4gPiA+ID4gKyAgICAgICAgICAgICAg
IHJjPSQ/Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIFsgJHJjID0gMTI3IF07IHRoZW4KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBlY2hvICJUZXN0ICckdGVzdCcgbm90IGZvdW5k
LCBtYXliZSBvdXQtb2YtdHJlZQo+ID4gPiA+IGJ1aWxkIGFuZCB1bnNldCBidWlsZGRpcj8iID4m
Mgo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGV4aXQgMQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICBlbGlmIFsgJHJjID0gMiAtYSAkV0hJVEVMSVNUX0dJVEhVQiA9IDEgLWEKPiA+ID4g
PiAiJEdJVEhVQl9BQ1RJT05TIiBdOyB0aGVuCgoKPiA+ID4gSWYgb25lIG9yIG1vcmUgdmFyaWFi
bGVzIHVzZWQgaW4gdGhlIGNvbmRpdGlvbmFsIHRlc3QgYXJlCj4gPiA+IGVpdGhlciB1bnNldCBv
ciBlbXB0eSwgdGhhdCB3aWxsIGxlYWQgdG8gaW52YWxpZCBzeW50YXguCgo+ID4gPiBTbyBJIHdv
dWxkIHN1Z2dlc3QgdXNpbmcgWyAuLi4gXSBhbmQgJiY6Cgo+ID4gPiAgIGVsaWYgWyAkcmMgPSAy
IF0gJiYgWyAkV0hJVEVMSVNUX0dJVEhVQiA9IDEgXSAmJiBbIC1uICIkR0lUSFVCX0FDVElPTlMi
Cj4gPiA+IF07IHRoZW4KCj4gPiBHb29kIHBvaW50LiBPciBtYXliZSBqdXN0IHF1b3RlPwoKPiA+
IGVsaWYgWyAiJHJjIiA9IDIgLWEgIiRXSElURUxJU1RfR0lUSFVCIiA9IDEgLWEgIiRHSVRIVUJf
QUNUSU9OUyIgXTsgdGhlbgoKCj4gVGhpcyBjYW4gd29yaywgIGJ1dCB1c2luZyAtYSBjYW4gbGVh
ZCB0byBhbWJpZ3VvdXMgb3IgaGFyZC10by1kaWFnbm9zZQo+IGJlaGF2aW9yLiBBIGJldHRlciBh
cHByb2FjaCB3b3VsZCBiZSB0byByZXBsYWNlIC1hIHdpdGggJiYuCgo+IE1heWJlIHRoZSBiZXN0
IHdheSBpczoKCj4gZWxpZiBbICIkcmMiID0gMiBdICYmIFsgIiRXSElURUxJU1RfR0lUSFVCIiA9
IDEgXSAmJiBbIC1uICIkR0lUSFVCX0FDVElPTlMiCj4gXTsgdGhlbgoKVGhhbmsgeW91IGZvciBw
b2ludGluZyB0aGlzLCBJJ2xsIHVzZSB0aGlzLgoKSSB0aG91Z2h0IC1hIHRha2VzIHByZWNlZGVu
Y2UgdG8gLW8gbGlrZSBpbiBDLCBpLmUuIFsgZm9vIC1hIGJhciAtbyBiYXogXSBpcyB0aGUKZXF1
aXZhbGVudCBvZiBbIGZvbyBdICYmIFsgYmFyIF0gfHwgYmF6LgoKQnV0IG5vdyBJIHNlZSBpbiBt
YW4gdGVzdCgxKToKCglCaW5hcnkgLWEgYW5kIC1vIGFyZSBhbWJpZ3VvdXMuICBVc2UgJ3Rlc3Qg
RVhQUjEgJiYgdGVzdCBFWFBSMicgb3IgJ3Rlc3QgRVhQUjEgfHwgdGVzdCBFWFBSMicgaW5zdGVh
ZC4KCkkgYWxzbyB3b25kZXIgaWYgYW55IC1hIG9yIC1vIGlzIGFtYmlndW91cy4gT3IganVzdCBj
b21iaW5hdGlvbiBvZiBib3RoLiBCZWNhdXNlCndlIGhhdmUgc29tZSAiLWEiIGFuZCAiLW8iIHVz
YWdlIGluIHRzdF90ZXN0LnNoLiBTaG91bGQgd2UgdHJhbnNmb3JtIHRoZW0/CgoJaWYgWyAkVFNU
X0JST0sgLWd0IDAgLW8gJFRTVF9GQUlMIC1ndCAwIC1vICRUU1RfV0FSTiAtZ3QgMCBdOyB0aGVu
CgkJX3RzdF9jaGVja19zZWN1cml0eV9tb2R1bGVzCglmaQoKCWlmIFsgIiRUU1RfTkVFRFNfVE1Q
RElSIiA9IDEgLWEgLW4gIiRUU1RfVE1QRElSIiBdOyB0aGVuCgkJcm0gLXIgIiRUU1RfVE1QRElS
IgoJCVsgIiRUU1RfVE1QRElSX1JIT1NUIiA9IDEgXSAmJiB0c3RfY2xlYW51cF9yaG9zdAoJZmkK
CglOT1RFOiB0aGlzIG9uZSBJJ20gZ29pbmcgdG8gY2hhbmdlIGluIHVwY29taW5nIGZpeCBvZiB0
aGUgVEJST0sgPT4gVFdBUk4gZXZhbHVhdGlvbgoJIyBUQlJPSyA9PiBUV0FSTiBvbiBjbGVhbnVw
IG9yIGV4aXQKCWlmIFsgIiRyZXMiID0gVEJST0sgXSAmJiBbICIkVFNUX0RPX0VYSVQiID0gMSAt
byAteiAiJFRTVF9ET19DTEVBTlVQIiAtYSAtbiAiJFRTVF9DTEVBTlVQIiBdOyB0aGVuCgkJdHN0
X3JlcyBUV0FSTiAiJEAiCgkJVFNUX0RPX0NMRUFOVVA9CgkJcmV0dXJuCglmaQoKS2luZCByZWdh
cmRzLApQZXRyCgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
