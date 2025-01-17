Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F03DC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:16:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E94F3C7C31
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:16:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBE7C3C7B97
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:16:06 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3BCC31420565
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:16:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 936DE21185;
 Fri, 17 Jan 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6258D13332;
 Fri, 17 Jan 2025 09:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AS31FdQfimc1YAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 09:16:04 +0000
Date: Fri, 17 Jan 2025 10:16:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250117091603.GA742253@pevik>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <CAEemH2c82HAwMdWJ7a5WPLzHTJWA-dhunXuJQdt4WK4zWdpPYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c82HAwMdWJ7a5WPLzHTJWA-dhunXuJQdt4WK4zWdpPYg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 936DE21185
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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

PiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA0OjQx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKVEw7RFI6IHdyb25nIHBhdGNoLCBwbGVhc2UgaWdub3JlIGl0LgoKLi4u
Cj4gPiArc3RhdGljIGlubGluZSBpbnQgZm9vKHVuc2lnbmVkIGludCB0aW1lb3V0KQoKCj4gV2hh
dCBpcyB0aGUgZm9vKCkgdXNlZCBmb3I/CgpJJ20gc29ycnksIEkgbm90aWNlZCB0aGlzIGFmdGVy
IHNlbmRpbmcgYXMgd2VsbC4gQnV0IGdvdCBzbG93IGRvd24gZHVlClRTVF9OT19ERUZBVUxUX01B
SU4gaW4gdHN0X3Rlc3QuYyBhcyB3ZWxsLgoKPiA+ICtzdGF0aWMgaW5saW5lIGludCB0c3RfbXVs
dGlwbHlfb25fc2xvd19jb25maWcodW5zaWduZWQgaW50IHRpbWVvdXQpCj4gPiArewo+ID4gKyNp
Zm5kZWYgVFNUX05PX0RFRkFVTFRfTUFJTgo+ID4gKyAgICAgICBpZiAodHN0X2hhc19zbG93X2tj
b25maWcoKSkKPiA+ICsgICAgICAgICAgICAgICB0aW1lb3V0ICo9IDQ7Cj4gPiArI2VuZGlmIC8q
IFRTVF9OT19ERUZBVUxUX01BSU4gKi8KPiA+ICsgICAgICAgcmV0dXJuIHRpbWVvdXQ7Cj4gPiAr
fQoKCj4gQnV0IHRoZSB0c3RfdGVzdC5jIGhhcyBkZWZpbmVkIHRoZSBUU1RfTk9fREVGQVVMVF9N
QUlOIG1hY3JvCj4gc28gaXQgd2lsbCBnbyBjb21wbGllIHdpdGggdGhlIHNlY29uZCBicmFuY2gg
YWx3YXlzLgoKPiBJT1csIHRoZSB0c3RfaGFzX3Nsb3dfa2NvbmZpZygpIHdpbGwgbmV2ZXIgYmUg
cGVyZm9ybWVkLgoKWWVzLCB5b3UncmUgcmlnaHQgdGhpcyB3b3VsZCBub3Qgd29yayAoaXQgdG9v
ayBtZSBhIHdoaWxlIHRvIGZpbmQgaXQgYXMgd2VsbCkuCgpJIGhvcGVkIHdlIHdvdWxkIGhhdmUg
c29tZSBzbWFydCBldmFsdWF0aW9uIHdoaWNoIHdvdWxkIGFsbG93IG5vdCBoYXZpbmcgdG8gYWRk
CmFueXRoaW5nIHRvIGZpbGVzIGluIHRlc3RjYXNlcy9saWIvLCBidXQgdGhpcyB3aWxsIG5vdCB3
b3JrLgoKV2UgY2FuIGVpdGhlciBjb21iaW5lIHlvdXIgYXBwcm9hY2ggd2l0aCB0aGlzIChoYXZl
IGEgbmV3IGRlZmluaXRpb24gKyBzdGF0aWMKZnVuY3Rpb24gaW4gdHN0X3Rlc3QuaCkgb3IgdXNl
IHN0cnVjdCB0c3RfdGVzdCBmbGFnIGFzIEFuZHJlYSBzdWdnZXN0ZWQuIEknbSBub3QKc3VyZSB3
aGF0IGlzIGJldHRlciwgSSBzbGlnaHRseSBwcmVmZXJyZWQgdGhlIGRlZmluaXRpb24sIGJlY2F1
c2Ugb25lIGRheSB3ZQptaWdodCB3YW50IHRvIGdldCByaWQgb2Ygc3RydWN0IHRzdF90ZXN0IHdv
cmthcm91bmRzIGluIHRlc3RjYXNlcy9saWIgdGhlcmVmb3JlCkkgd291bGQgcHJlZmVyIG5vdCB0
byBhZGQgeWV0IGFub3RoZXIuCgpGWUkgdHN0X3Rlc3Qgc3RydWN0IHVzZSBpcyBmb3JjZWQgYnkg
Y29kZSBpbiBzYWZlX2Nsb25lKCkgbGliL3RzdF90ZXN0LmM6CgpwaWRfdCBzYWZlX2Nsb25lKGNv
bnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCgkJIGNvbnN0IHN0cnVjdCB0c3RfY2xv
bmVfYXJncyAqYXJncykKewoJcGlkX3QgcGlkOwoKCWlmICghdHN0X3Rlc3QtPmZvcmtzX2NoaWxk
KQoJCXRzdF9icmsoVEJST0ssICJ0ZXN0LmZvcmtzX2NoaWxkIG11c3QgYmUgc2V0ISIpOwoKVGhp
cyBjb3VsZCBiZSBhbHNvIGd1YXJkZWQgYnkgbmV3IGRlZmluaXRpb24uIFRoZW4gaXQgc2hvdWxk
IGhhdmUgcHJvYmFibHkgYQpkaWZmZXJlbnQgbmFtZSB0aGFuIFRTVF9OT19TTE9XX0tDT05GSUdf
Q0hFQ0suIFN1cmUsIHdlIHBvc3Rwb25lIHRoaXMgY2xlYW51cAphZnRlciB0aGUgcmVsZWFzZS4K
CkJUVyB3ZSBoYXZlIFRDT05GIG9uIHN0YXJ2YXRpb24uYy4gVGhpcyB0ZXN0IHdvdWxkIHdvcmsg
aWYgd2UgZG9uJ3QgcHJvbG9uZyBpdApldmVuIGxvbmdlciB3aXRoIHRzdF9oYXNfc2xvd19rY29u
ZmlnKCksIHRodXMgbWlnaHQgd2FudCB0byByZW1vdmUgVENPTkYgYW5kCmRpc2FibGUgdHN0X2hh
c19zbG93X2tjb25maWcoKSB0aGVyZSBhcyB3ZWxsLiBXZSBjYW4gZG8gaXQgd2l0aCBib3RoIHdh
eXMuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
