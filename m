Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D54C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 08:27:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 821663CA4AF
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:27:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4CC3C2C0C
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 09:26:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=hare@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8749E1A00807
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 09:26:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EEF921180;
 Thu, 13 Mar 2025 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741854404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
 b=s6QPuZxWDIOzrqZCj80mMOsICwGCd64xmqDq9AwGpTUk//qO3epEzVzgY5eiwH7TomoCTm
 OoWzTAA1Prq5SkStEfdyFh5R61o6ggLrzIw6ADucfP8SO+DnXK6Sf428+FD0OGtTFOEFeo
 UhjsmZAdTbwkOnNAAemENHDssQXHMwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741854404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
 b=OrN/xvZk/mMIAC02EHTezyPLfw81X+qspMZRCqj08a7WG2wPEF2eMh2SfHonZXmDK4Y+NZ
 B4nqO8fZlm1CZ2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741854403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
 b=lO+RGv9jt7oNdjCbhv+PsTmQELCQs1+GTFqaOaJKaVqCR6+4PgrqzB3chyPwC5qeM3mXV+
 Xxofj+/d+jYTItxJgpBd7gQz+pRJgxbr8vxNavvB1ECEqMXnzjxmmgny0ULX1cAwvQMspf
 W1Bx6FGFZVUAbnBArOXzIzQTF9LRaIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741854403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
 b=p7lzEVQvqtOpfSHWJvDLhXzhIQGfh2xLbwFS5riaYavSoM18lw7jAMxS8NmDPcORS4wwhL
 OAQObUjSG6mR5uCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017B413797;
 Thu, 13 Mar 2025 08:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UehAOsGW0mdGJQAAD6G6ig
 (envelope-from <hare@suse.de>); Thu, 13 Mar 2025 08:26:41 +0000
Message-ID: <5fd7a0de-d496-4430-a099-4c29e3c3f111@suse.de>
Date: Thu, 13 Mar 2025 09:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org>
 <20250312054053.GA12234@lst.de> <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
 <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
 <20250312135912.GB12488@lst.de>
 <CAEemH2c_S_KMMQcyAp702N0DDBWrqOVxgz6GeS=RfVrUCJFE1Q@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAEemH2c_S_KMMQcyAp702N0DDBWrqOVxgz6GeS=RfVrUCJFE1Q@mail.gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[20];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,infradead.org,fromorbit.com,oracle.com,gmail.com,vger.kernel.org,lists.linux.it,intel.com,lists.linux.dev,samsung.com,pankajraghav.com];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:email, suse.de:mid, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE
 limit
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
Cc: p.raghav@samsung.com, ritesh.list@gmail.com, brauner@kernel.org,
 lkp@intel.com, john.g.garry@oracle.com, da.gomez@samsung.com,
 djwong@kernel.org, david@fromorbit.com, oe-lkp@lists.linux.dev,
 willy@infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 oliver.sang@intel.com, gost.dev@samsung.com, kbusch@kernel.org,
 kernel@pankajraghav.com, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMy8xMy8yNSAwMzo1NCwgTGkgV2FuZyB3cm90ZToKPiAKPiAKPiBPbiBXZWQsIE1hciAxMiwg
MjAyNSBhdCA5OjU54oCvUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGUgCj4gPG1haWx0
bzpoY2hAbHN0LmRlPj4gd3JvdGU6Cj4gCj4gICAgIE9uIFdlZCwgTWFyIDEyLCAyMDI1IGF0IDA1
OjE5OjM2UE0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gICAgICA+IFdlbGwsIGRvZXMgdGhhdCBw
YXRjaCBmb3IgaW9jdGxfbG9vcDA2IHN0aWxsIG1ha2Ugc2Vuc2U/Cj4gICAgICA+IE9yIGFueSBv
dGhlciB3b3JrYXJvdW5kPwo+ICAgICAgPiBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFp
bC9sdHAvMjAyNS1NYXJjaC8wNDI1OTkuaHRtbAo+ICAgICA8aHR0cHM6Ly9saXN0cy5saW51eC5p
dC9waXBlcm1haWwvbHRwLzIwMjUtTWFyY2gvMDQyNTk5Lmh0bWw+Cj4gCj4gICAgIFRoZSByZWFs
IHF1ZXN0aW9uIGlzIHdoYXQgYmxvY2sgc2l6ZXMgd2Ugd2FudCB0byBzdXBwb3J0IGZvciB0aGUK
PiAgICAgbG9vcCBkcml2ZXIuwqAgQmVjYXVzZSBpZiBpdCBpcyBsYXJnZXIgdGhhbiB0aGUgcGh5
c2ljYWwgYmxvY2sgc2l6ZQo+ICAgICBpdCBjYW4gbGVhZCB0byB0b3JuIHdyaXRlcy7CoCBCdXQg
SSBndWVzcyBubyBvbmUgY2FyZWQgYWJvdXQgdGhvc2UKPiAgICAgb24gbG9vcCBzbyBmYXIsIHNv
IHdoeSBjYXJlIGFib3V0IHRoaXMgbm93Li4KPiAKPiAKPiBUaGF0J3MgYmVjYXVzZSB0aGUga2Vy
bmVsIHRlc3Qtcm9ib3QgcmVwb3J0cyBhIExUUC9pb2N0bF9sb29wMDYgdGVzdAo+IGZhaWwgaW4g
a2VybmVsIGNvbW1pdDoKPiAgwqAgNDdkZDY3NTMyMzAzODAzwqAgKCJibG9jay9iZGV2OiBsaWZ0
IGJsb2NrIHNpemUgcmVzdHJpY3Rpb25zIHRvIDY0ayIpCj4gCj4gVGhlIGlvY3RsX2xvb3AwNiBp
cyBhIGJvdW5kYXJ5IHRlc3RpbmcgYW5kIGFsd2F5cyBmYWlsIHdpdGgKPiBMT09QX1NFVF9CTE9D
S19TSVpFIHNldCBhIHZhbHVlIGxhcmdlciB0aGFuIFBBR0VfU0laRS4KPiBCdXQgbm93IGl0J3Mg
c2V0IHN1Y2Nlc3NmdWxseSB1bmV4cGVjdGVkbHkuCj4gCj4gSWYgeW91IGFsbCBiZWxpZXZlwqB0
aGUgYm91bmRhcnkgdGVzdCBmb3IgbG9vcGJhY2sgZHJpdmVyIGlzIHJlZHVuZGFudCwKPiBJIGNh
biBoZWxwIHJlbW92ZSB0aGF0IGZyb20gTFRQIGNvZGUuCj4gCkkgd291bGQgcmVtb3ZlIGl0LgpZ
ZXMsIHdlIG1pZ2h0IGluY3VyIHRvcm4gd3JpdGVzLCBidXQgcHJldmlvdXNseSB3ZSBoYWRuJ3Qg
Y2FyZWQgYWJvdXQgCnRoYXQuIEFuZCBpZiB3ZSBjYXJlZCB3ZSBzaG91bGQgaGF2ZSBhIGRlZGlj
YXRlZCB0ZXN0IGZvciB0aGF0OyB0aGVyZSdzCm5vIGd1YXJhbnRlZSB0aGF0IHdlIGNhbm5vdCBo
YXZlIHRvcm4gd3JpdGVzIGV2ZW4gd2l0aCA0ayBibG9ja3MuCgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBGcmFua2Vuc3RyLiAxNDYs
IDkwNDYxIE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBJLiBUb3Rldiwg
QS4gTWNEb25hbGQsIFcuIEtub2JsaWNoCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
