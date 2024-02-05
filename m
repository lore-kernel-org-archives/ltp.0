Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34068C4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 11:01:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E39A3CC6CA
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 12:01:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4D593C8B7A
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 12:00:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7AB1E10007F3
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 12:00:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA4C21D50;
 Mon,  5 Feb 2024 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707130844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Atip8NjAJ+WDOqGObviRd2LMUKxmOEIAAAK1ca2juJ0=;
 b=ePva9xr+Za3jvHgu2gUM5ihQkhEOpwHq0iWiWX4xtArEv1K/DYBtqHwIl53OcGYkMR6GHh
 dyHAdnt+2eINLXm764hQBvltLNOMECA7dbDMyi4AwM9HPFxLZkTJy1HWaj1IMEY4k+FZ+H
 MSV3y3llfm2nVL8oF7G9av/KiXCUDus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707130844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Atip8NjAJ+WDOqGObviRd2LMUKxmOEIAAAK1ca2juJ0=;
 b=oYelrK1rwbTzxBVeeB+OTDigXsA5UQz07KdIhLXlkN8B+xD3rgOuQ3vIfv/cgt2EPnxVMk
 HFk4Z2z9L1UIcFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707130844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Atip8NjAJ+WDOqGObviRd2LMUKxmOEIAAAK1ca2juJ0=;
 b=ePva9xr+Za3jvHgu2gUM5ihQkhEOpwHq0iWiWX4xtArEv1K/DYBtqHwIl53OcGYkMR6GHh
 dyHAdnt+2eINLXm764hQBvltLNOMECA7dbDMyi4AwM9HPFxLZkTJy1HWaj1IMEY4k+FZ+H
 MSV3y3llfm2nVL8oF7G9av/KiXCUDus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707130844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Atip8NjAJ+WDOqGObviRd2LMUKxmOEIAAAK1ca2juJ0=;
 b=oYelrK1rwbTzxBVeeB+OTDigXsA5UQz07KdIhLXlkN8B+xD3rgOuQ3vIfv/cgt2EPnxVMk
 HFk4Z2z9L1UIcFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC55132DD;
 Mon,  5 Feb 2024 11:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R3KOMtu/wGVGOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 11:00:43 +0000
Date: Mon, 5 Feb 2024 12:00:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240205110042.GA201808@pevik>
References: <20240205022857.191692-1-pvorel@suse.cz>
 <20240205022857.191692-2-pvorel@suse.cz>
 <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIEZlYiA1LCAyMDI0IGF0IDEwOjI54oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IHRzdF90ZXN0LmM6MTcwMTogVElORk86ID09PSBUZXN0aW5nIG9u
IGV4dDQgPT09Cj4gPiB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9v
cDAgd2l0aCBleHQ0IG9wdHM9JycgZXh0cmEKPiA+IG9wdHM9JycKPiA+IG1rZTJmcyAxLjQ3LjAg
KDUtRmViLTIwMjMpCj4gPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xv
b3AwIHRvIC90bXAvTFRQX3N3YW5JenRxNy9tbnRwb2ludAo+ID4gZnN0eXA9ZXh0NCBmbGFncz0w
Cj4gPiB0c3RfaW9jdGwuYzoyNjogVElORk86IEZJQk1BUCBpb2N0bCBpcyBzdXBwb3J0ZWQKPiA+
IHN3YXBvbjAzLmM6MTY0OiBUV0FSTjogRmFpbGVkIHRvIGNyZWF0ZSBzd2FwZmlsZTogc3dhcGZp
bGUwMjogRUlOVkFMICgyMikKPiA+IHN3YXBvbjAzLmM6MTc1OiBURkFJTDogRmFpbGVkIHRvIHNl
dHVwIHN3YXBzCgo+ID4gQXQgbGVhc3Qgb24ga2VybmVsIDYuNy4KCj4gPiBGaXhlczogMDA5YTQw
N2EwICgic3dhcG9uL29mZjogZW5hYmxlIGFsbF9maWxlc3lzdGVtIGluIHN3YXAgdGVzdCIpCj4g
PiBSZXBvcnRlZC1ieTogRG9taW5pcXVlIExldWVuYmVyZ2VyIDxkaW1zdGFyQG9wZW5zdXNlLm9y
Zz4KPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gLS0t
Cj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYyB8IDMgKysr
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKPiA+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5jCj4gPiBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAzLmMKPiA+IGluZGV4IDNkYmNkNWJmZC4u
MzczMTRjYzY1IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fw
b24vc3dhcG9uMDMuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24v
c3dhcG9uMDMuYwo+ID4gQEAgLTI0Nyw2ICsyNDcsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQo+ID4gICAgICAgICBpZiAoYWNjZXNzKCIvcHJvYy9zd2FwcyIsIEZfT0spKQo+ID4gICAgICAg
ICAgICAgICAgIHRzdF9icmsoVENPTkYsICJzd2FwIG5vdCBzdXBwb3J0ZWQgYnkga2VybmVsIik7
Cgo+ID4gKyAgICAgICBpZiAodHN0X2ZzX3R5cGUoIi4iKSA9PSBUU1RfVE1QRlNfTUFHSUMpCj4g
PiArICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgInN3YXAgbm90IHN1cHBvcnRlZCBvbiB0
bXBmcyIpOwoKWyBDYyBZYW5nIFh1LCBiZWNhdXNlIGhlIHBvc3RlZCBhIHBhdGNoc2V0IGFib3V0
IE1BWF9TV0FQRklMRVMgWzFdLCBtYXliZSB0aGF0CndvdWxkIGZpeCB0aGUgcHJvYmxlbSBdCgo+
IEkgZGlkbid0IGNhdGNoIHRoZSBwYXRjaCBwb2ludCwgaXNuJ3QgdGhlIGZhaWx1cmUgb24gRVhU
NCwgd2h5IGhlcmUgc2tpcAo+IHRtcGZzPwo+IEFuZCwgc2hvdWxkbid0IHRoZSBGUyBjaGVjayBj
b21wbGV0ZWQgaW4gaXNfc3dhcF9zdXBwb3J0ZWQoKT8KCkknbSBzb3JyeSwgdGhlIHByb2JsZW0g
aXMgd2l0aCBUTVBESVIgb24gdG1wZnMgKHdoaWNoIGlzIG9uIFR1bWJsZXdlZWQpLgoKVGVzdGVk
IG9uIDYuOC4wLXJjMS0yLmdmNGJhNWRiLWRlZmF1bHQgYW5kIDYuNyBzdGFibGUuIE9yIGlzIGl0
IGEgYnVnIGluCkZJQk1BUCBpb2N0bCBkZXRlY3Rpb24/CgpLaW5kIHJlZ2FyZHMsClBldHIKClsx
XSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL2xpc3QvP3Nlcmllcz0z
ODc4MTQmc3RhdGU9KgoKPiA+ICsKPiA+ICAgICAgICAgaXNfc3dhcF9zdXBwb3J0ZWQoVEVTVF9G
SUxFKTsKPiA+ICB9Cgo+ID4gLS0KPiA+IDIuNDMuMAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
