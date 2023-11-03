Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA35C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 22:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 410493CE95B
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 23:16:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 046423C31BB
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 23:16:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1487C1400B61
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 23:16:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 209DE1F388;
 Fri,  3 Nov 2023 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699049792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5LwqBR6bj3cYzbESym6FYw8uyzxSTe9VOowoXojtcg=;
 b=HXHRNFtUWBfNFr3qKbo71NZyAQlPN59brwA45G0s707hZUcHWVplXm2FBecgRjBI3BPG0i
 KZhfw9x1bFj8AKoijdjf9Klm+g4zrbfcAbKxJZpC+5DVBej5bZsmFvoz8f2HRNOXuZ+0TW
 t23FfGpcBdE+m3CMZcnCgOGb4/Bpe0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699049792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5LwqBR6bj3cYzbESym6FYw8uyzxSTe9VOowoXojtcg=;
 b=qL2eL9buD2EgGteJziKd7RAF9YNv6Ccxb1hnOrmTIPyvrrHVN4Auee6CgGB4fnptsgNmXz
 EUF+569zKb6bP8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52901348C;
 Fri,  3 Nov 2023 22:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1fU8Kj9xRWWYUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 22:16:31 +0000
Date: Fri, 3 Nov 2023 23:16:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20231103221630.GA1149500@pevik>
References: <20231103160350.1096410-1-pvorel@suse.cz>
 <CAG4es9UBvDeQr6Rm-XU_t=O14OTudTT3yeZQDMexqv98B8cbZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9UBvDeQr6Rm-XU_t=O14OTudTT3yeZQDMexqv98B8cbZA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib/tst_module.c: Replace "rmmod" with
 "modprobe -r"
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRWR3YXJkLAoKPiBIaSwKCgoKPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDk6MDPigK9BTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gIm1vZHByb2JlIC1yIiB3aWxs
IHJlbW92ZSBhbHNvIHRoZSBkZXBlbmRlbmNpZXMgbG9hZGVkIGZvciBrZXJuZWwKPiA+IG1vZHVs
ZXMuCgo+ID4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+
IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gLS0tCj4gPiAg
bGliL3RzdF9tb2R1bGUuYyB8IDIgKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9tb2R1bGUuYyBiL2xp
Yi90c3RfbW9kdWxlLmMKPiA+IGluZGV4IDliZDQ0MzYyMy4uZTUyYmI2ZTAwIDEwMDY0NAo+ID4g
LS0tIGEvbGliL3RzdF9tb2R1bGUuYwo+ID4gKysrIGIvbGliL3RzdF9tb2R1bGUuYwo+ID4gQEAg
LTEwNSw3ICsxMDUsNyBAQCB2b2lkIHRzdF9tb2R1bGVfdW5sb2FkXyh2b2lkIChjbGVhbnVwX2Zu
KSh2b2lkKSwgY29uc3QgY2hhciAqbW9kX25hbWUpCj4gPiAgewo+ID4gICAgICAgICBpbnQgaSwg
cmM7Cgo+ID4gLSAgICAgICBjb25zdCBjaGFyICpjb25zdCBhcmd2W10gPSB7ICJybW1vZCIsIG1v
ZF9uYW1lLCBOVUxMIH07Cj4gPiArICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IGFyZ3ZbXSA9IHsg
Im1vZHByb2JlIiwgIi1yIiwgbW9kX25hbWUsIE5VTEwgfTsKCj4gPiAgICAgICAgIHJjID0gMTsK
PiA+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IDUwOyBpKyspIHsKPiA+IC0tCj4gPiAyLjQyLjAK
Cgo+IFRoaXMgaXMgZmluZSB3aXRoIGFsbCB0aGUgc3VwcG9ydGVkIHZlcnNpb25zIG9mIEFuZHJv
aWQgR0tJLgo+IFJldmlld2VkLWJ5OiBFZHdhcmQgTGlhdyA8ZWRsaWF3QGdvb2dsZS5jb20+CgpU
aGFua3MgZm9yIGNvbmZpcm1hdGlvbi4gQWx0aG91Z2ggdGhpcyBwYXRjaCB3aWxsIG5vdCBiZSBt
ZXJnZWQsIHdlIGtub3cgd2UgY2FuCnVzZSAnbW9kcHJvYmUgLXInLgoKQlRXIGlzIGl0IG9rIGZv
ciBBT1NQIHdoaWNoIHVzZXMgbGF0ZXN0IExUUCB0byByZWx5IG9uIG1vZHVsZXMuYnVpbHRpbiBh
bmQKbW9kdWxlcy5kZXA/ICh0aGVyZSBpcyAjaWZkZWYgX19BTkRST0lEX18gaW4gdHN0X3NlYXJj
aF9kcml2ZXIoKSkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
