Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFCDC624CE
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 12:10:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1BEE3E98E1
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 14:10:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8891F3E946D
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 14:10:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB4F01A00CBE
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 14:10:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12F0E21DB6;
 Tue,  1 Sep 2026 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788264624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvgDcyXbdCwzgKEaunLZ2MV3Gdx+qz5Dfjha87YOeNI=;
 b=YJo5XCXoZ8p0mRFIPKdZ/wCm1f9FbCbCPkOC1efTXAE0GUQ31c3tWI0hS8RdbgPBAkVie4
 T+DTIRVGuTQllW+KYxXTe4JwGw0Bmr+ufV/gfV1oUQ3C+QROrlkbirssDHxP3UsMI0wACn
 w2SmGcX4Fnbyp5TdbT582AidWZ3Hphc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788264624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvgDcyXbdCwzgKEaunLZ2MV3Gdx+qz5Dfjha87YOeNI=;
 b=hn86wIfZY9NwXHoA9x8+wrqcJw+H2btyujR+kBrXTqbAp6iZ0sVKDzuWplXA2uCzh0G98o
 mOjTOGmGw7sUnuBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eFgSGkvR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0VsFsb84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788264620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvgDcyXbdCwzgKEaunLZ2MV3Gdx+qz5Dfjha87YOeNI=;
 b=eFgSGkvRiDv+6nh5y5rWfhyDwO3SFmMRdvcRwLakeGcsoVu+N93LIlYDnmDsf5zzY0EJXp
 vV2IB0ePQOqrWWf8RjIIZcRHxiTatsEXEf7b5NIUJeU3bp4nGqyZEdykIC3aLDhVQhvFQq
 B0VCnpYTBA6x7LEALaBjFIJ9E9BMvgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788264620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvgDcyXbdCwzgKEaunLZ2MV3Gdx+qz5Dfjha87YOeNI=;
 b=0VsFsb84/eFaqOEgREuXVXvmAe9DpA5Xq3smTeQ6wxRepuvPXPkpWB8HYzihFOs0Fxr+yu
 hw3GlM2KHba/CSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C320D1369E;
 Tue,  1 Sep 2026 12:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VRTZLavAlmpUZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Sep 2026 12:10:19 +0000
Date: Tue, 1 Sep 2026 14:10:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260901121018.GA862728@pevik>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-3-anonymemeow@gmail.com>
 <20260825103609.GA56957@pevik>
 <apGPksbQajf2vVJF@amir-ThinkPad-T480>
 <CAOQ4uxixsiz-0S6zBjnABNwxiGyThWOoMCKSUz-Pd_fo4WWyBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxixsiz-0S6zBjnABNwxiGyThWOoMCKSUz-Pd_fo4WWyBA@mail.gmail.com>
X-Rspamd-Queue-Id: 12F0E21DB6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] fanotify21: Stop relying on exited child
 for pidfd error
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
Cc: jack@suse.cz, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBGcmksIEF1ZyAyOCwgMjAyNiBhdCAzOjM54oCvUE0gQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6Cgo+ID4gT24gVHVlLCBBdWcgMjUsIDIwMjYgYXQgMTI6MzY6
MDlQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+ID4gSGkgYWxsLAoKPiA+ID4gPiBmYW5v
dGlmeTIxIHVzZWQgdG8gdmVyaWZ5IHRoZSBwaWRmZCBlcnJvciBjYXNlIGJ5IGdlbmVyYXRpbmcg
YW4gZXZlbnQKPiA+ID4gPiBmcm9tIGEgY2hpbGQgcHJvY2VzcyBhbmQgcmVhZGluZyB0aGUgZXZl
bnQgYWZ0ZXIgdGhlIGNoaWxkIGhhZCBleGl0ZWQuCj4gPiA+ID4gVGhpcyBpcyBubyBsb25nZXIg
YSBzdGFibGUgd2F5IHRvIHRyaWdnZXIgYSBwaWRmZCBlcnJvciwgYmVjYXVzZSBuZXdlcgo+ID4g
PiA+IGtlcm5lbHMgY2FuIHJlcG9ydCBwaWRmZHMgZm9yIGV4aXRlZCBldmVudCBwcm9jZXNzZXMu
Cgo+ID4gPiA+IFJlYWQgdGhlIGV2ZW50IGZyb20gYSBjaGlsZCBwcm9jZXNzIGluIGEgZGVzY2Vu
ZGFudCBQSUQgbmFtZXNwYWNlCj4gPiA+ID4gaW5zdGVhZC4gVGhlIHJlYWRlciBjYW5ub3QgZ2V0
IHRoZSBwaWRmZCBpbiB0aGUgcGFyZW50IFBJRCBuYW1lc3BhY2UKPiA+ID4gPiBmcm9tIGZhbm90
aWZ5LCBzbyBwaWRmZCBjcmVhdGlvbiB3aWxsIGZhaWwgYW5kIHRoZSB0ZXN0IGNhbiB2ZXJpZnkK
PiA+ID4gPiBGQU5fTk9QSURGRCwgb3IgLUVTUkNIIHdpdGggRkFOX1JFUE9SVF9GRF9FUlJPUi4K
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5vbnltZU1lb3cgPGFub255bWVtZW93QGdtYWlsLmNv
bT4KPiA+ID4gPiBSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiA+ID4gPiBS
ZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCj4gPiA+IC4u
Lgo+ID4gPiA+ICAgICAvKgo+ID4gPiA+IC0gICAgKiBHZW5lcmF0ZSB0aGUgZXZlbnQgaW4gZWl0
aGVyIHNlbGYgb3IgYSBjaGlsZCBwcm9jZXNzLiBFdmVudAo+ID4gPiA+IC0gICAgKiBnZW5lcmF0
aW9uIGluIGEgY2hpbGQgcHJvY2VzcyBpcyBkb25lIHNvIHRoYXQgdGhlIEZBTl9OT1BJREZEIGNh
c2UKPiA+ID4gPiAtICAgICogY2FuIGJlIHZlcmlmaWVkLgo+ID4gPiA+ICsgICAgKiBSZWFkIHRo
ZSBldmVudCBpbiBlaXRoZXIgc2VsZiBvciBhIGNoaWxkIHByb2Nlc3MgaW4gYSBkZXNjZW5kYW50
Cj4gPiA+ID4gKyAgICAqIFBJRCBuYW1lc3BhY2UuIEEgcmVhZGVyIGluIGEgZGVzY2VuZGFudCBQ
SUQgbmFtZXNwYWNlIGNhbm5vdCBvYnRhaW4KPiA+ID4gPiArICAgICogdGhlIHBpZGZkIG9mIHRo
ZSBldmVudCBwcm9jZXNzIGluIHRoZSBwYXJlbnQgUElEIG5hbWVzcGFjZSBzbyB0aGF0Cj4gPiA+
ID4gKyAgICAqIHRoZSBGQU5fTk9QSURGRCBjYXNlIGNhbiBiZSB2ZXJpZmllZC4KPiA+ID4gPiAg
ICAgICovCj4gPiA+ID4gLSAgIGlmICh0Yy0+Zm9yaykKPiA+ID4gPiAtICAgICAgICAgICBkb19m
b3JrKCk7Cj4gPiA+ID4gLSAgIGVsc2UKPiA+ID4gPiAtICAgICAgICAgICBnZW5lcmF0ZV9ldmVu
dCgpOwo+ID4gPiA+ICsgICBpZiAodGMtPndhbnRfcGlkZmRfZXJyICYmIChyZWFkZXJfcGlkID0g
U0FGRV9DTE9ORSgmY2xvbmVfYXJncykpKSB7Cj4gPiA+IG5pdDogYWx0aG91Z2ggSSdkIHdyaXRl
IGl0IHRoaXMgd2F5IGFzIHdlbGwsIGNoZWNrcGF0Y2ggZG9lcyBub3QgbGlrZSB0aGlzCj4gPiA+
IGVmZmVjdGl2ZSB3YXkgOikgKGRvIG5vdCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24p
LgoKPiA+ID4gPiArICAgICAgICAgICBTQUZFX1dBSVRQSUQocmVhZGVyX3BpZCwgJnJlYWRlcl9l
eGl0X3N0YXR1cywgMCk7Cj4gPiA+ID4gKyAgICAgICAgICAgaWYgKCFXSUZFWElURUQocmVhZGVy
X2V4aXRfc3RhdHVzKSB8fCBXRVhJVFNUQVRVUyhyZWFkZXJfZXhpdF9zdGF0dXMpKQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInJlYWRlciBwcm9jZXNzIGV4aXRl
ZCBpbmNvcnJlY3RseSIpOwoKPiA+ID4gbml0OiBBbmQgdGhlIGFib3ZlIHNob3VsZCBiZSBwcm9i
YWJseSByZXBsYWNlZCB3aXRoIHRzdF9yZWFwX2NoaWxkcmVuKCkuCgo+ID4gPiBCdXQgYmVjYXVz
ZSBJIHNob3VsZCBoYXZlIG1lcmdlZCB0aGlzIGxvbmcgdGltZSBhZ28gdG8gcHJldmVudCBmYWxz
ZSBwb3NpdGl2ZSBvbgo+ID4gPiA3LjIsIG1lcmdpbmcgaXQgbm93LiBDbGVhbnVwIGNhbiBiZSBk
b25lIGxhdGVyICh0b2dldGhlciB3aXRoIHVzaW5nIGRlc2lnbmF0ZWQKPiA+ID4gaW5pdGlhbGl6
ZXJzKS4KCj4gPiA+IE1lcmdlZCB0aGUgcmVzdCBvZiB0aGUgcGF0Y2gsIHRoYW5rIHlvdSEKCgo+
ID4gSGkgUGV0ciwKCj4gPiBTb3JyeSBJIGRpZCBub3QgaGF2ZSB0aW1lIHRvIGludmVzdGlnYXRl
IGFuZCBuZWVkIHRvIGxlYXZlIG5vdwo+ID4ganVzdCB3YW50ZWQgdG8gbGV0IHlvdSBrbm93IHRo
YXQgdGVzdCBlbmRzIHdpdGggZmFpbHVyZSBleGl0IGNvZGUuCj4gPiBhbmQgZG9lcyBub3Qgc2Vl
bSB0byBydW4gd2l0aCBwcmV0dHkgcmVjZW50IHJjNyBrZXJuZWwuCgo+ID4gSXMgdGhhdCBleHBl
Y3RlZD8KPiA+IE1heWJlIGl0J3Mgc29tZXRoaW5nIGluIG15IG93biB0ZXN0IGVudi4KCj4gPiBU
aGFua3MsCj4gPiBBbWlyLgoKPiA+IHJvb3RAa3ZtLXhmc3Rlc3RzOn4vbHRwIyAuL2Zhbm90aWZ5
L2Zhbm90aWZ5MjAgfHwgZWNobyBGQUlMCj4gPiB0c3RfdG1wZGlyLmM6MzA4OiBUSU5GTzogVXNp
bmcgL3RtcC9MVFBfZmFuVFRBd0gxIGFzIHRtcGRpciAodG1wZnMgZmlsZXN5c3RlbSkKPiA+IHRz
dF9rY29uZmlnLmM6OTA6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcgJy9wcm9jL2NvbmZp
Zy5neicKPiA+IHRzdF9rY29uZmlnLmM6NzU2OiBUSU5GTzogQ09ORklHX1BST1ZFX0xPQ0tJTkcg
a2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGljaCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiA+
IHRzdF9kZXZpY2UuYzoxMDM6IFRJTkZPOlsgIDc4Ny4zNjc0OTJdIGxvb3AwOiBkZXRlY3RlZCBj
YXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDYxNDQwMAo+ID4gIEZvdW5kIGZyZWUgZGV2aWNlIDAg
Jy9kZXYvbG9vcDAnCj4gPiB0c3RfdGVzdC5jOjIwNDg6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAy
NjA1MjktMjQzLWc5MTE4YTQ4MGMKPiA+IHRzdF90ZXNbICA3ODcuMzkxNTI5XSAvZGV2L3plcm86
IENhbid0IGxvb2t1cCBibG9ja2Rldgo+ID4gdC5jOjIwNTE6IFRJTkZPOiBUZXN0ZWQga2VybmVs
OiA3LjIuMC1yYzcteGZzdGVzdHMtMDAwMDgtZzU1ZDU3NjNkYjFkZSAjMjk4MiBTTVAgUFJFRU1Q
VF9EWU5BTUlDIFRodSBBdWcgMjcgMTI6MDQ6MDQgQ0VTVCAyMDI2IHg4Nl82NAo+ID4gdHN0X3Rl
c3QuYzoxODc2OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwo+
ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjEwODogVElORk86IEtlcm5lbCBzdXBwb3J0cyBl
eHQyCj4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6Njc6IFRJTkZPOiBta2ZzLmV4dDIgZG9l
cyBleGlzdAo+ID4gWyAgNzg3LjQxODE0M10gL2Rldi96ZXJvOiBDYW4ndCBsb29rdXAgYmxvY2tk
ZXYKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMDg6IFRJTkZPOiBLZXJuZWwgc3VwcG9y
dHMgZXh0Mwo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjY3OiBUSU5GTzogbWtmcy5leHQz
IGRvZXMgZXhpc3QKPiA+IFsgIDc4Ny40NDM2NTddIC9kZXYvemVybzogQ2FuJ3QgbG9va3VwIGJs
b2NrZGV2Cj4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTA4OiBUSU5GTzogS2VybmVsIHN1
cHBvcnRzIGV4dDQKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2NzogVElORk86IG1bICA3
ODcuNDY3NDg5XSAvZGV2L3plcm86IENhbid0IGxvb2t1cCBibG9ja2Rldgo+ID4ga2ZzLmV4dDQg
ZG9lcyBleGlzdAo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjEwODogVElORk86IEtlcm5l
bCBzdXBwb3J0cyB4ZnMKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2NzogVElORk86IG1r
ZnMueGZzIGRvZXMgZXhpc3QKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMDg6IFRJTkZP
OiBLZXJuZWwgc3VwcG9ydHMgYnRyZnMKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2Nzog
VElORk86IG1rZnMuYnRyZnMgZG9lcyBleGlzdAo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
OjExNzogVElORk86IFNraXBwaW5nIGJjYWNoZWZzIGJlY2F1c2Ugb2YgRlVTRSBibGFja2xpc3QK
PiA+IFsgIDc4Ny41MjE1MTVdIC9kZXYvemVybzogQ2FuJ3QgbG9va3VwIGJsb2NrZGV2Cj4gPiB0
c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTA4OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHZmYXQK
PiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2NzogVElORk86IG1rZnMudmZhdCBkb2VzIGV4
aXN0Cj4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTQwOiBUSU5GTzogRmlsZXN5c3RlbSBl
eGZhdCBpcyBub3Qgc3VwcG9ydGVkCj4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTQ0OiBU
SU5GTzogRlVTRSBkb2VzIHN1cHBvcnQgbnRmcwo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
OjYzOiBUSU5GTzogbWtmcy5udGZzIGRvZXMgbm90IGV4aXN0Cj4gPiBbICA3ODcuNTc2NDIwXSAv
ZGV2L3plcm86IENhbid0IGxvb2t1cCBibG9ja2Rldgo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBl
cy5jOjEwODogVElORk86IEtlcm5lbCBzdXBwb3J0cyBudGZzMwo+ID4gdHN0X3N1cHBvcnRlZF9m
c190eXBlcy5jOjYzOiBUSU5GTzogbWtmcy5udGZzIGRvZXMgbm90IGV4aXN0Cj4gPiB0c3Rfc3Vw
cG9ydGVkX2ZzX3R5cGVzLmM6MTA4OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHRtcGZzCj4gPiB0
c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NTE6IFRJTkZPOiBta2ZzIGlzIG5vdCBuZWVkZWQgZm9y
IHRtcGZzCj4gPiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleHQyID09
PQo+ID4gZmFub3RpZnkyMC5jOjUxOiBUQ09ORjogRkFOX1JFUE9SVF9QSURGRCB8IEZBTl9SRVBP
UlRfVElEIGlzIHN1cHBvcnRlZCBzaW5jZSB2Ny4yCj4gPiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZP
OiA9PT0gVGVzdGluZyBvbiBleHQzID09PQo+ID4gZmFub3RpZnkyMC5jOjUxOiBUQ09ORjogRkFO
X1JFUE9SVF9QSURGRCB8IEZBTl9SRVBPUlRfVElEIGlzIHN1cHBvcnRlZCBzaW5jZSB2Ny4yCj4g
PiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleHQ0ID09PQo+ID4gZmFu
b3RpZnkyMC5jOjUxOiBUQ09ORjogRkFOX1JFUE9SVF9QSURGRCB8IEZBTl9SRVBPUlRfVElEIGlz
IHN1cHBvcnRlZCBzaW5jZSB2Ny4yCj4gPiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZPOiA9PT0gVGVz
dGluZyBvbiB4ZnMgPT09Cj4gPiBmYW5vdGlmeTIwLmM6NTE6IFRDT05GOiBGQU5fUkVQT1JUX1BJ
REZEIHwgRkFOX1JFUE9SVF9USUQgaXMgc3VwcG9ydGVkIHNpbmNlIHY3LjIKPiA+IHRzdF90ZXN0
LmM6MTk4NjogVElORk86ID09PSBUZXN0aW5nIG9uIGJ0cmZzID09PQo+ID4gZmFub3RpZnkyMC5j
OjUxOiBUQ09ORjogRkFOX1JFUE9SVF9QSURGRCB8IEZBTl9SRVBPUlRfVElEIGlzIHN1cHBvcnRl
ZCBzaW5jZSB2Ny4yCj4gPiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiB2
ZmF0ID09PQo+ID4gZmFub3RpZnkyMC5jOjUxOiBUQ09ORjogRkFOX1JFUE9SVF9QSURGRCB8IEZB
Tl9SRVBPUlRfVElEIGlzIHN1cHBvcnRlZCBzaW5jZSB2Ny4yCj4gPiB0c3RfdGVzdC5jOjE5ODY6
IFRJTkZPOiA9PT0gVGVzdGluZyBvbiB0bXBmcyA9PT0KPiA+IGZhbm90aWZ5MjAuYzo1MTogVENP
TkY6IEZBTl9SRVBPUlRfUElERkQgfCBGQU5fUkVQT1JUX1RJRCBpcyBzdXBwb3J0ZWQgc2luY2Ug
djcuMgoKPiA+IFN1bW1hcnk6Cj4gPiBwYXNzZWQgICAwCj4gPiBmYWlsZWQgICAwCj4gPiBicm9r
ZW4gICAwCj4gPiBza2lwcGVkICA3Cj4gPiB3YXJuaW5ncyAwCgo+ID4gRkFJTAoKPiBPay4gSSBz
ZWUgdGhhdCBUQ09ORiBmb3IgYWxsIHJldHVybmluZyBub24gMCBpcyBleHBlY3RlZC4KCj4gU29y
cnkgZm9yIHRoZSBub2lzZS4KCk5vIHByb2JsZW0sIHRoYW5rcyBmb3IgeW91ciBsb25nIHRlcm0g
Y2FyZSBvZiBmYW5vdGlmeSB0ZXN0cyEKCkZZSSB3ZSBuZWVkIHRvIGV4aXQgd2l0aCBub24temVy
byBleGl0IGNvZGUgb25seSB0byBkZXRlY3QgdGhhdCBzb21ldGhpbmcKd2FzIHNraXBwZWQgKHVz
ZWZ1bCB0byBub3RpY2UpLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFRoYW5rcywKPiBBbWlyLgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
