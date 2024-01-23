Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FD6C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:40:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C29383CEE6D
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 18:40:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D45D23CE212
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 18:40:13 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB7F2100EEBC
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 18:40:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F69E1F79A;
 Tue, 23 Jan 2024 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706031611;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsIfVAQboMpewazf+NHk5YfS2MO+uWNnkUdM3ntPzwk=;
 b=zE5XQNbCLsgFR7e1RofgZHxZ4fdQiPsXhMut1Md3rQIMbqDvZG4JzWVTV3gVV0ye6at34a
 r1fPQXOo6l4XLqFaNV99JnOe6WvU/IdjW9HA9RAkTK6G6S4blM8YMBNJGx7qVzaRg7mtg9
 GwaYWlSWByf4fB9kWvWRznFr53tra8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706031611;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsIfVAQboMpewazf+NHk5YfS2MO+uWNnkUdM3ntPzwk=;
 b=h3CalQMuN5cgpa1Dr1zyCBh9sTiNB3NQYdXD4f4SSidrbqBCxkbmpNqAg0gIGGklKFjTsS
 KNQ44qjsqFwIPQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706031610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsIfVAQboMpewazf+NHk5YfS2MO+uWNnkUdM3ntPzwk=;
 b=rL1IGE+FODPayjy84++X7RQVn1bqZ0XaaTNSiHHfL/ghKL/qAJWKmRmkO496aJApVYV8OT
 TPVO1rdAibJ4oQR55dpxA7xGRWOI8sfc3IJKRygBO1hN9MQztnzqkpQQc4LtjlwlhpK5R/
 3cP3PHw+V8cHy0OiThyChdQiZHEwZMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706031610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsIfVAQboMpewazf+NHk5YfS2MO+uWNnkUdM3ntPzwk=;
 b=LOHfARhQurz+xThgMv75Lqczr1Ny8nxbMOdbyz1NwrydyruoYLiOQoyxlWf2y3oF+6/zk3
 y3vxPS/oiPoDPnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B8F136A4;
 Tue, 23 Jan 2024 17:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jcDWNfj5r2W2IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 17:40:08 +0000
Date: Tue, 23 Jan 2024 18:40:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123174005.GB217203@pevik>
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
 <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

SGkgTGksCgo+IEhpIFBldHIsCgo+IE9uIFR1ZSwgSmFuIDIzLCAyMDI0IGF0IDg6MzfigK9QTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgTGksCgo+ID4gPiBIaSBM
aSwKCj4gPiA+IHN3YXBvZmYwMSBmYWlscyBvbiBUTVBESVIgb24gYnRyZnMgKHJlZ2FyZGxlc3Mg
a2VybmVsIHZlcnNpb24pOgoKPiA+IEZZSSBpdCB3b3JrcyBvbiBUdW1ibGV3ZWVkIHdpdGggNi43
IGtlcm5lbC4gSXQncyBicm9rZW4gb24gc29tZSBvbGRlciBTTEVTCj4gPiB3aXRoIDUuMTQgYW5k
IGFsbCBvbGRlciBrZXJuZWxzLiBJIHN1cHBvc2Ugd2l0aCBub2NvdyAoZml4ZXMgSSBzdWdnZXN0
ZWQKPiA+IHByZXZpb3VzbHkpIHdvdWxkIHdvcmsgYXMgZXhwZWN0ZWQgKFRQQVNTLCBvciBUQ09O
RiBvbiBrZXJuZWwgPCA1LjApLgoKCj4gWW91J3JlIHJpZ2h0LgoKPiBXZSBoYXZlIHRvIGd1YXJh
bnRlZSB0aGUgc3dhcGZpbGUgaXMgYSBjb250aWd1b3VzIGZpbGUgd2hhdGV2ZXIgdGhlIEZTIHR5
cGUKPiBpcy4KPiBTbyBoZXJlIG1ha2luZyB1c2Ugb2YgbWFrZV9zd2FwZmlsZSgpIGlzIGEgaGFy
ZCByZXF1aXJlbWVudC4KPiBBbmQsIEkgZG9uJ3QgdGhpbmsgdGhlIGZpbGUgZmlyc3Qgd2l0aCA2
NTUzNiBibG9ja3MgKGluIHN3YXBvZmYwMSkgaXMgbm90Cj4gbmVjZXNzYXJ5LgoKVW5mb3J0dW5h
dGVseSB0aGlzIGNvbW1pdCBvciB0aGUgZm9sbG93aW5nIChsaWJzd2FwOiBJbnRyb2R1Y2UgZmls
ZSBjb250aWd1aXR5CmNoZWNrKSBicmVha3Mgc3dhcG9uMDEuYyBvbiBvbGRlciBTTEVTICg0LjQg
YmFzZWQga2VybmVsIGFuZCBvbGRlcikgb24gWEZTOgoKdHN0X2lvY3RsLmM6MjY6IFRJTkZPOiBG
SUJNQVAgaW9jdGwgaXMgc3VwcG9ydGVkCmxpYnN3YXAuYzoxOTE6IFRGQUlMOiBzd2Fwb24oKSBv
biB4ZnMgZmFpbGVkOiBFSU5WQUwgKDIyKQoKVGhlIGZhaWx1cmUgaXMgaW4gaXNfc3dhcF9zdXBw
b3J0ZWQoKS4KCkknbGwgdHJ5IHRvIGdpdmUgbW9yZSBpbmZvIHRvbW9ycm93LgoKS2luZCByZWdh
cmRzLApQZXRyCgp0c3RfdGVzdC5jOjE3MDk6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyMzA5MjkK
dHN0X3Rlc3QuYzoxNTk1OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDIKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQyIGRvZXMgZXhpc3QKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDMKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQzIGRvZXMgZXhpc3QKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDQKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQ0IGRvZXMgZXhpc3QKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHhmcwp0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZPOiBta2ZzLnhmcyBkb2VzIGV4aXN0CnRzdF9z
dXBwb3J0ZWRfZnNfdHlwZXMuYzo5NzogVElORk86IEtlcm5lbCBzdXBwb3J0cyBidHJmcwp0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZPOiBta2ZzLmJ0cmZzIGRvZXMgZXhpc3QKdHN0
X3N1cHBvcnRlZF9mc190eXBlcy5jOjEwNTogVElORk86IFNraXBwaW5nIGJjYWNoZWZzIGJlY2F1
c2Ugb2YgRlVTRSBibGFja2xpc3QKdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzog
S2VybmVsIHN1cHBvcnRzIHZmYXQKdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzog
bWtmcy52ZmF0IGRvZXMgZXhpc3QKdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjEyODogVElORk86
IEZpbGVzeXN0ZW0gZXhmYXQgaXMgbm90IHN1cHBvcnRlZAp0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVz
LmM6MTI4OiBUSU5GTzogRmlsZXN5c3RlbSBudGZzIGlzIG5vdCBzdXBwb3J0ZWQKdHN0X3N1cHBv
cnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHRtcGZzCnRzdF9zdXBw
b3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1wZnMK
dHN0X3Rlc3QuYzoxNjY5OiBUSU5GTzogPT09IFRlc3Rpbmcgb24gZXh0MiA9PT0KdHN0X3Rlc3Qu
YzoxMTE4OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggZXh0MiBvcHRzPScnIGV4
dHJhIG9wdHM9JycKbWtlMmZzIDEuNDIuMTEgKDA5LUp1bC0yMDE0KQp0c3RfdGVzdC5jOjExMzI6
IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvTFRQX3N3YTRyWVl6NC9tbnRwb2lu
dCBmc3R5cD1leHQyIGZsYWdzPTAKdHN0X2lvY3RsLmM6MjY6IFRJTkZPOiBGSUJNQVAgaW9jdGwg
aXMgc3VwcG9ydGVkCnN3YXBvbjAxLmM6Mjc6IFRQQVNTOiB0c3Rfc3lzY2FsbChfX05SX3N3YXBv
biwgU1dBUF9GSUxFLCAwKSBwYXNzZWQKc3dhcG9uMDEuYzozMDogVElORk86IFN3YXBDYWNoZWQ6
IDM0OCBLYgp0c3RfdGVzdC5jOjE2Njk6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleHQzID09PQp0
c3RfdGVzdC5jOjExMTg6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCBleHQzIG9w
dHM9JycgZXh0cmEgb3B0cz0nJwpta2UyZnMgMS40Mi4xMSAoMDktSnVsLTIwMTQpCnRzdF90ZXN0
LmM6MTEzMjogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfc3dhNHJZWXo0
L21udHBvaW50IGZzdHlwPWV4dDMgZmxhZ3M9MAp0c3RfaW9jdGwuYzoyNjogVElORk86IEZJQk1B
UCBpb2N0bCBpcyBzdXBwb3J0ZWQKc3dhcG9uMDEuYzoyNzogVFBBU1M6IHRzdF9zeXNjYWxsKF9f
TlJfc3dhcG9uLCBTV0FQX0ZJTEUsIDApIHBhc3NlZApzd2Fwb24wMS5jOjMwOiBUSU5GTzogU3dh
cENhY2hlZDogMTM2IEtiCnRzdF90ZXN0LmM6MTY2OTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4
dDQgPT09CnRzdF90ZXN0LmM6MTExODogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRo
IGV4dDQgb3B0cz0nJyBleHRyYSBvcHRzPScnCm1rZTJmcyAxLjQyLjExICgwOS1KdWwtMjAxNCkK
dHN0X3Rlc3QuYzoxMTMyOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0byAvdG1wL0xUUF9z
d2E0cllZejQvbW50cG9pbnQgZnN0eXA9ZXh0NCBmbGFncz0wCnRzdF9pb2N0bC5jOjI2OiBUSU5G
TzogRklCTUFQIGlvY3RsIGlzIHN1cHBvcnRlZApzd2Fwb24wMS5jOjI3OiBUUEFTUzogdHN0X3N5
c2NhbGwoX19OUl9zd2Fwb24sIFNXQVBfRklMRSwgMCkgcGFzc2VkCnN3YXBvbjAxLmM6MzA6IFRJ
TkZPOiBTd2FwQ2FjaGVkOiAxMTYgS2IKdHN0X3Rlc3QuYzoxNjY5OiBUSU5GTzogPT09IFRlc3Rp
bmcgb24geGZzID09PQp0c3RfdGVzdC5jOjExMTg6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9v
cDAgd2l0aCB4ZnMgb3B0cz0nJyBleHRyYSBvcHRzPScnCnRzdF90ZXN0LmM6MTEzMjogVElORk86
IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfc3dhNHJZWXo0L21udHBvaW50IGZzdHlw
PXhmcyBmbGFncz0wCnRzdF9pb2N0bC5jOjI2OiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIHN1cHBv
cnRlZApsaWJzd2FwLmM6MTkxOiBURkFJTDogc3dhcG9uKCkgb24geGZzIGZhaWxlZDogRUlOVkFM
ICgyMikKClN1bW1hcnk6CnBhc3NlZCAgIDMKZmFpbGVkICAgMQpicm9rZW4gICAwCnNraXBwZWQg
IDAKd2FybmluZ3MgMAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
