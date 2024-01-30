Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEEDC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 20:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29F943CF98C
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 21:26:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E9AB3CE11D
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 21:26:10 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC88710009F8
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 21:26:09 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83195221F1;
 Tue, 30 Jan 2024 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706646368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7KHSacnEJLc49L7P59Vw4cPIA1pzgBfYUwrfXGQtr4=;
 b=IGnhKLgUWyt0QdkrRBcfnFzwwsfDrzTF9bd8i2DtwzTYI2LAFu6fNnQAThbCL9KLLxUTQY
 zIKGP6X0+uBqm7oyzqUzraCVDtRc2iFf08x9S7kDPeFsOu5aKvQYcp0bYCIg9HZ1oPK2SV
 2I5ZoY/IuKKglZOrLHzIBlGLaR+zypo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706646368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7KHSacnEJLc49L7P59Vw4cPIA1pzgBfYUwrfXGQtr4=;
 b=VBNP7L8jPg3h4i00UqHZ67LQbTmW6YuGZO3ENXwzEi8twW4wWi+pB1GvVHZlMSatXoOhVX
 ws+kXRKigHGHNZDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706646368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7KHSacnEJLc49L7P59Vw4cPIA1pzgBfYUwrfXGQtr4=;
 b=IGnhKLgUWyt0QdkrRBcfnFzwwsfDrzTF9bd8i2DtwzTYI2LAFu6fNnQAThbCL9KLLxUTQY
 zIKGP6X0+uBqm7oyzqUzraCVDtRc2iFf08x9S7kDPeFsOu5aKvQYcp0bYCIg9HZ1oPK2SV
 2I5ZoY/IuKKglZOrLHzIBlGLaR+zypo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706646368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7KHSacnEJLc49L7P59Vw4cPIA1pzgBfYUwrfXGQtr4=;
 b=VBNP7L8jPg3h4i00UqHZ67LQbTmW6YuGZO3ENXwzEi8twW4wWi+pB1GvVHZlMSatXoOhVX
 ws+kXRKigHGHNZDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 473BF13462;
 Tue, 30 Jan 2024 20:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oNoxDWBbuWX5CwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 20:26:08 +0000
Date: Tue, 30 Jan 2024 21:26:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240130202606.GA883611@pevik>
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240130130712.GB778733@pevik>
 <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
 <20240130184451.GA873803@pevik>
 <CAOQ4uxhaSak9S3dN_uYfgF5tUMd0BPrCZOQxKCm2hW88x1SB1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhaSak9S3dN_uYfgF5tUMd0BPrCZOQxKCm2hW88x1SB1A@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IGnhKLgU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VBNP7L8j
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 83195221F1
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEphbiAzMCwgMjAyNCBhdCA4OjQ04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEFtaXIsCgo+ID4gPiBPbiBUdWUsIEphbiAzMCwgMjAyNCBh
dCAzOjA34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gPiBI
aSBBbWlyLCBKYW4sCgo+ID4gPiA+IEkgd2FzIGdvaW5nIHRvIG1lcmdlLCBidXQgSSBzdXNwZWN0
IHRoaXMgZG9lcyBub3Qgd29yayBvbiBUTVBESVIgb24gYnRyZnMuCgoKPiA+ID4gVGhpcyBpcyBh
IHByb2JsZW0gYmVjYXVzZSB0aGUgdGVzdCByZXN1bHQgZGVwZW5kcyBvbiB0aGUgdHlwZSBvZiBU
TVBESVIuCj4gPiA+IFRoZSBmYWlsdXJlIGluIHlvdXIgY2FzZSBpcyBiZWNhdXNlIFRNUERJUiBp
cyBub3Qgb25seSBidHJmcywgYnV0IGEKPiA+ID4gYnRyZnMgc3Vidm9sLgo+ID4gPiBKYW4gaGFz
IGRlYWx0IHdpdGggc2V2ZXJhbCByZWxhdGVkIGZhbm90aWZ5IHRlc3RzIGZhaWx1cmVzIGxhdGVs
eS4KCj4gPiA+ID4gVGVzdGVkIG9uIFNMRSAxNS1TUDYgKGtlcm5lbCA2LjQpLCBvbiAxNS1TUDQg
KGtlcm5lbCA1LjE0KSwgVHVtYmxld2VlZCAoa2VybmVsCj4gPiA+ID4gNi44LjAtcmMxKSwgQWxw
aW5lIExpbnV4IChrZXJuZWwgNi40KSBJIGdldDoKCj4gPiA+ID4gZmFub3RpZnkwMS5jOjM0MTog
VEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAwMDA4LCAt
MTAwLCAiLiIpIGZhaWxlZDogRVhERVYgKDE4KQoKPiA+ID4gPiBmb3IgdGVzdHMgIzMsICM0IGFu
ZCAjNSBvbiBhbGwgZmlsZXN5c3RlbXMuCgo+ID4gPiA+IFRlc3Rpbmcgb24gb3RoZXIgb24gb3Ro
ZXIgZmlsZXN5c3RlbSBpdCB3b3JrczogRGViaWFuIGtlcm5lbCA1LjEwLCA2LjEgb24gZXh0NCwK
PiA+ID4gPiBBbHBpbmUgTGludXgga2VybmVsIDYuNCBvbiB0bXBmcywgVHVtYmxld2VlZCBrZXJu
ZWwgNi44LjAtcmMxIG9uIHRtcGZzLgoKPiA+ID4gPiBTaG91bGQgYmUgYnRyZnMgaGFuZGxlZCBk
aWZmZXJlbnRseSBvciBza2lwcGVkPyAoYmVsb3cpCj4gPiA+ID4gT3IgdGVzdCBFWERFViBmb3Ig
IzMsICM0IGFuZCAjNT8gKG5vdCBzdXJlIGhvdyBoYW5kbGUganVzdCBoYWxmIG9mIHRoZSB0ZXN0
cyBvbgo+ID4gPiA+IGJ0cmZzIGRpZmZlcmVudGx5KS4KCj4gPiA+ID4gS2luZCByZWdhcmRzLAo+
ID4gPiA+IFBldHIKCj4gPiA+ID4gZGlmZiAtLWdpdCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MDEuYwo+ID4gPiA+IGluZGV4IGJhMDlmMzA5ZC4uOTdhZGUxODI5IDEwMDY0NAo+
ID4gPiA+IC0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEu
Ywo+ID4gPiA+ICsrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5
MDEuYwo+ID4gPiA+IEBAIC0zMzUsOCArMzM1LDE1IEBAIHBhc3M6Cj4gPiA+ID4gICAgICAgICAg
KiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgYXJlIHN1cHBvcnRlZC4KPiA+ID4gPiAgICAgICAgICAq
IFdoZW4gdGVzdGVkIGZzIGhhcyB6ZXJvIGZzaWQgKGUuZy4gZnVzZSkgYW5kIGV2ZW50cyBhcmUg
cmVwb3J0ZWQKPiA+ID4gPiAgICAgICAgICAqIHdpdGggZnNpZCtmaWQsIHdhdGNoaW5nIGRpZmZl
cmVudCBmaWxlc3lzdGVtcyBpcyBub3Qgc3VwcG9ydGVkLgo+ID4gPiA+ICsgICAgICAgICogTm90
IHN1cHBvcnRlZCBvbiBCdHJmcy4KPiA+ID4gPiAgICAgICAgICAqLwo+ID4gPiA+ICsgICAgICAg
aWYgKHRzdF9mc190eXBlKCIuIikgPT0gVFNUX0JUUkZTX01BR0lDKSB7Cj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJza2lwcGVkIG9uIEJ0cmZzIik7Cj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiArICAgICAgIH0KPiA+ID4gPiArCgo+ID4gPiBO
b3RlIHRoYXQgYnRyZnMgaXMgbm90IHRoZSBGUyB1bmRlciB0ZXN0LiBJdCBpcyB0aGUgRlMgb2Yg
VE1QRlMsCj4gPiA+IHNvIGV2ZW4gaWYgeW91IGRpZCBza2lwLCB0aGlzIG1lc3NhZ2Ugd291bGQg
aGF2ZSBiZWVuIHdyb25nLgoKPiA+ID4gUGxlYXNlIHRyeSB0aGUgcGF0Y2ggYmVsb3cuCgo+ID4g
R3JlYXQsIHdvcmtzIGFzIGV4cGVjdGVkLgoKPiA+IEkgY2FuIG1lcmdlIGFtZW5kZWQgY29tbWl0
IFsxXSwgb3IgZmVlbCBmcmVlIHRvIHNlbmQgdjIgaWYgeW91IHdhbnQgdG8gbWVudGlvbgo+ID4g
YnRyZnMgc3Vidm9sIGluIHRoZSBjb21taXQgbWVzc2FnZS4KCgo+IEFtZW5kZWQgY29tbWl0IGxv
b2tzIGZpbmUuCgo+IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSBuZWVkIHRvIHNwZWNpZnkgYnRy
ZnMgc3Vidm9sIFRNUERJUiBpbiB0aGUKPiBjb21taXQgbWVzc2FnZS4KPiBJdCBpcyBhIG1pbm9y
IGltcGxlbWVudGF0aW9uIGRldGFpbCwgbm90IHRoZSBtYWluIHRoaW5nLgoKR29vZCwgbWVyZ2Vk
IQoKVGhhbmtzIQpQZXRyCgo+IFRoYW5rcywKPiBBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
