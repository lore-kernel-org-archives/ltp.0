Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76801C47DDC
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:34:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28543CFB4A
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 16:34:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 880553CD0F5
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 16:33:51 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B46EB618FED
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 16:33:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92ED822008;
 Wed, 24 Jan 2024 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706110429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pLUHcT6cU/cHb8oNGyWgIa9iWuDmxX3SySwqIC/Zck=;
 b=uIKffU5THUCGqptqqUlwKz9/xNPEL9+SH0QcwbvytVcderW79Udna733oZAktlEWLj5oli
 Bc9RyF+izJiCOQ4bObJvZC6mc15ItWLE+CvgDDqOVI0kAxAMOVWdHJqrZ/iBXoFkrsTgMX
 KFEfVAZkkSgfFsie+gf4aNy9JZgA9nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706110429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pLUHcT6cU/cHb8oNGyWgIa9iWuDmxX3SySwqIC/Zck=;
 b=gWlOIBFZUT8nrGr3WJe3K2Ghie7XfW+Jp+IjtHjZjhAbiwosmW3bT3b97bLsQ8zYKS8sxb
 V8kYEgvawtuFq3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706110429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pLUHcT6cU/cHb8oNGyWgIa9iWuDmxX3SySwqIC/Zck=;
 b=uIKffU5THUCGqptqqUlwKz9/xNPEL9+SH0QcwbvytVcderW79Udna733oZAktlEWLj5oli
 Bc9RyF+izJiCOQ4bObJvZC6mc15ItWLE+CvgDDqOVI0kAxAMOVWdHJqrZ/iBXoFkrsTgMX
 KFEfVAZkkSgfFsie+gf4aNy9JZgA9nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706110429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pLUHcT6cU/cHb8oNGyWgIa9iWuDmxX3SySwqIC/Zck=;
 b=gWlOIBFZUT8nrGr3WJe3K2Ghie7XfW+Jp+IjtHjZjhAbiwosmW3bT3b97bLsQ8zYKS8sxb
 V8kYEgvawtuFq3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C6213786;
 Wed, 24 Jan 2024 15:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pW+XO9wtsWXNEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 15:33:48 +0000
Date: Wed, 24 Jan 2024 16:33:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240124153347.GA309254@pevik>
References: <20240124122130.288374-1-pvorel@suse.cz>
 <CAOQ4uxjtJg7iprcOAizXOUdw=6PouBDtiyL8R3CfqGr6yyR9vw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjtJg7iprcOAizXOUdw=6PouBDtiyL8R3CfqGr6yyR9vw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uIKffU5T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gWlOIBFZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_TO(0.00)[gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 92ED822008
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify: Handle EOPNOTSUPP as TCONF
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
Cc: Dominique Leuenberger <dleuenberger@suse.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAyOjIx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEZvdW5kIG9uIGtlcm5lbCA2LjcgKFR1bWJsZXdlZWQpIG9uIGV4
ZmF0OgoKPiA+IHRzdF90ZXN0LmM6MTY2OTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4ZmF0ID09
PQo+ID4gdHN0X3Rlc3QuYzoxMTE3OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AxIHdpdGgg
ZXhmYXQgb3B0cz0nJyBleHRyYSBvcHRzPScnCj4gPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBN
b3VudGluZyAvZGV2L2xvb3AxIHRvIC90bXAvTFRQX2Zhbm9MOUtMRS9tbnRwb2ludCBmc3R5cD1l
eGZhdCBmbGFncz0wCj4gPiBmYW5vdGlmeTE0LmM6MjQ2OiBUSU5GTzogVGVzdCBjYXNlIDA6IGZh
bm90aWZ5X2luaXQoRkFOX0NMQVNTX0NPTlRFTlQgfCBGQU5fUkVQT1JUX0ZJRCwgT19SRE9OTFkp
Cj4gPiBmYW5vdGlmeTE0LmM6MjYwOiBUUEFTUzogZmFub3RpZnlfaW5pdCh0Yy0+aW5pdC5mbGFn
cywgT19SRE9OTFkpIDogRUlOVkFMICgyMikKPiA+IGZhbm90aWZ5MTQuYzoyNDY6IFRJTkZPOiBU
ZXN0IGNhc2UgMTogZmFub3RpZnlfaW5pdChGQU5fQ0xBU1NfUFJFX0NPTlRFTlQgfCBGQU5fUkVQ
T1JUX0ZJRCwgT19SRE9OTFkpCj4gPiBmYW5vdGlmeTE0LmM6MjYwOiBUUEFTUzogZmFub3RpZnlf
aW5pdCh0Yy0+aW5pdC5mbGFncywgT19SRE9OTFkpIDogRUlOVkFMICgyMikKPiA+IGZhbm90aWZ5
MTQuYzoyNDY6IFRJTkZPOiBUZXN0IGNhc2UgMjogZmFub3RpZnlfaW5pdChGQU5fQ0xBU1NfTk9U
SUYsIE9fUkRPTkxZKQo+ID4gZmFub3RpZnkxNC5jOjI2MzogVFBBU1M6IGZhbm90aWZ5X2luaXQo
dGMtPmluaXQuZmxhZ3MsIE9fUkRPTkxZKSByZXR1cm5lZCBmZCA1Cj4gPiBmYW5vdGlmeTE0LmM6
MjgzOiBUSU5GTzogVGVzdGluZyBGQU5fTUFSS19JTk9ERSB3aXRoIElOT0RFX0VWRU5UUwo+ID4g
ZmFub3RpZnkxNC5jOjI4NTogVFBBU1M6IGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIDB4MDAw
MDAwMDEgfCB0Yy0+bWFyay5mbGFncywgdGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSA6IEVJ
TlZBTCAoMjIpCj4gPiBmYW5vdGlmeTE0LmM6MjQ2OiBUSU5GTzogVGVzdCBjYXNlIDM6IGZhbm90
aWZ5X2luaXQoRkFOX0NMQVNTX05PVElGIHwgRkFOX1JFUE9SVF9GSUQsIE9fUkRPTkxZKQo+ID4g
ZmFub3RpZnkxNC5jOjI2MzogVFBBU1M6IGZhbm90aWZ5X2luaXQodGMtPmluaXQuZmxhZ3MsIE9f
UkRPTkxZKSByZXR1cm5lZCBmZCA1Cj4gPiBmYW5vdGlmeTE0LmM6MjgzOiBUSU5GTzogVGVzdGlu
ZyBGQU5fTUFSS19NT1VOVCB3aXRoIElOT0RFX0VWRU5UUwo+ID4gZmFub3RpZnkxNC5jOjI4NTog
VFBBU1M6IGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIDB4MDAwMDAwMDEgfCB0Yy0+bWFyay5m
bGFncywgdGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSA6IEVJTlZBTCAoMjIpCj4gPiBmYW5v
dGlmeTE0LmM6MjQ2OiBUSU5GTzogVGVzdCBjYXNlIDQ6IGZhbm90aWZ5X2luaXQoRkFOX0NMQVNT
X05PVElGIHwgRkFOX1JFUE9SVF9OQU1FLCBPX1JET05MWSkKPiA+IGZhbm90aWZ5MTQuYzoyNjA6
IFRQQVNTOiBmYW5vdGlmeV9pbml0KHRjLT5pbml0LmZsYWdzLCBPX1JET05MWSkgOiBFSU5WQUwg
KDIyKQo+ID4gZmFub3RpZnkxNC5jOjI0NjogVElORk86IFRlc3QgY2FzZSA1OiBmYW5vdGlmeV9p
bml0KEZBTl9DTEFTU19OT1RJRiB8IEZBTl9SRVBPUlRfRklEIHwgRkFOX1JFUE9SVF9OQU1FLCBP
X1JET05MWSkKPiA+IGZhbm90aWZ5MTQuYzoyNjA6IFRQQVNTOiBmYW5vdGlmeV9pbml0KHRjLT5p
bml0LmZsYWdzLCBPX1JET05MWSkgOiBFSU5WQUwgKDIyKQo+ID4gZmFub3RpZnkxNC5jOjI0Njog
VElORk86IFRlc3QgY2FzZSA2OiBmYW5vdGlmeV9pbml0KEZBTl9DTEFTU19OT1RJRiB8IEZBTl9S
RVBPUlRfVEFSR0VUX0ZJRCB8IEZBTl9SRVBPUlRfREZJRF9OQU1FLCBPX1JET05MWSkKPiA+IGZh
bm90aWZ5MTQuYzoyNjA6IFRQQVNTOiBmYW5vdGlmeV9pbml0KHRjLT5pbml0LmZsYWdzLCBPX1JE
T05MWSkgOiBFSU5WQUwgKDIyKQo+ID4gZmFub3RpZnkxNC5jOjI0NjogVElORk86IFRlc3QgY2Fz
ZSA3OiBmYW5vdGlmeV9pbml0KEZBTl9DTEFTU19OT1RJRiB8IEZBTl9SRVBPUlRfVEFSR0VUX0ZJ
RCB8IEZBTl9SRVBPUlRfREZJRF9GSUQsIE9fUkRPTkxZKQo+ID4gZmFub3RpZnkxNC5jOjI2MDog
VFBBU1M6IGZhbm90aWZ5X2luaXQodGMtPmluaXQuZmxhZ3MsIE9fUkRPTkxZKSA6IEVJTlZBTCAo
MjIpCj4gPiBmYW5vdGlmeTE0LmM6MjQ2OiBUSU5GTzogVGVzdCBjYXNlIDg6IGZhbm90aWZ5X2lu
aXQoRkFOX0NMQVNTX05PVElGIHwgRkFOX1JFUE9SVF9ERklEX0ZJRCwgT19SRE9OTFkpCj4gPiBm
YW5vdGlmeTE0LmM6MjYzOiBUUEFTUzogZmFub3RpZnlfaW5pdCh0Yy0+aW5pdC5mbGFncywgT19S
RE9OTFkpIHJldHVybmVkIGZkIDUKPiA+IGZhbm90aWZ5MTQuYzoyODM6IFRJTkZPOiBUZXN0aW5n
IEZBTl9NQVJLX0lOT0RFIHdpdGggRkFOX1JFTkFNRQo+ID4gZmFub3RpZnkxNC5jOjI4NTogVFBB
U1M6IGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIDB4MDAwMDAwMDEgfCB0Yy0+bWFyay5mbGFn
cywgdGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSA6IEVJTlZBTCAoMjIpCj4gPiBmYW5vdGlm
eTE0LmM6MjQ2OiBUSU5GTzogVGVzdCBjYXNlIDk6IGZhbm90aWZ5X2luaXQoRkFOX0NMQVNTX05P
VElGLCBPX1JET05MWSkKPiA+IGZhbm90aWZ5MTQuYzoyNjM6IFRQQVNTOiBmYW5vdGlmeV9pbml0
KHRjLT5pbml0LmZsYWdzLCBPX1JET05MWSkgcmV0dXJuZWQgZmQgNQo+ID4gZmFub3RpZnkxNC5j
OjI4MzogVElORk86IFRlc3RpbmcgRkFOX01BUktfT05MWURJUiB3aXRoIEZBTl9PUEVOCj4gPiBm
YW5vdGlmeTE0LmM6Mjg1OiBUUEFTUzogZmFub3RpZnlfbWFyayhmYW5vdGlmeV9mZCwgMHgwMDAw
MDAwMSB8IHRjLT5tYXJrLmZsYWdzLCB0Yy0+bWFzay5mbGFncywgZGlyZmQsIHBhdGgpIDogRU5P
VERJUiAoMjApCj4gPiBmYW5vdGlmeTE0LmM6Mjk4OiBUUEFTUzogQWRkaW5nIGFuIGlub2RlIG1h
cmsgb24gZGlyZWN0b3J5IGRpZCBub3QgZmFpbCB3aXRoIEVOT1RESVIgZXJyb3IgYXMgb24gbm9u
LWRpciBpbm9kZQo+ID4gZmFub3RpZnkxNC5jOjI0NjogVElORk86IFRlc3QgY2FzZSAxMDogZmFu
b3RpZnlfaW5pdChGQU5fQ0xBU1NfTk9USUYgfCBGQU5fUkVQT1JUX0RGSURfTkFNRV9UQVJHRVQs
IE9fUkRPTkxZKQo+ID4gZmFub3RpZnkxNC5jOjI2MzogVFBBU1M6IGZhbm90aWZ5X2luaXQodGMt
PmluaXQuZmxhZ3MsIE9fUkRPTkxZKSByZXR1cm5lZCBmZCA1Cj4gPiBmYW5vdGlmeTE0LmM6Mjgz
OiBUSU5GTzogVGVzdGluZyBGQU5fTUFSS19JTk9ERSB3aXRoIEZBTl9ERUxFVEUKPiA+IGZhbm90
aWZ5MTQuYzoyODU6IFRQQVNTOiBmYW5vdGlmeV9tYXJrKGZhbm90aWZ5X2ZkLCAweDAwMDAwMDAx
IHwgdGMtPm1hcmsuZmxhZ3MsIHRjLT5tYXNrLmZsYWdzLCBkaXJmZCwgcGF0aCkgOiBFTk9URElS
ICgyMCkKPiA+IGZhbm90aWZ5MTQuYzoyOTg6IFRQQVNTOiBBZGRpbmcgYW4gaW5vZGUgbWFyayBv
biBkaXJlY3RvcnkgZGlkIG5vdCBmYWlsIHdpdGggRU5PVERJUiBlcnJvciBhcyBvbiBub24tZGly
IGlub2RlCj4gPiBmYW5vdGlmeTE0LmM6MzAzOiBUQlJPSzogZmFub3RpZnlfbWFyayg1LCAweDEw
MSwgMHgyMDAsIC4uLiwgbW50cG9pbnQvZmlsZTEpIHVuc3VwcG9ydGVkOiBFT1BOT1RTVVBQICg5
NSkKCj4gPiBSZXBvcnRlZC1ieTogRG9taW5pcXVlIExldWVuYmVyZ2VyIDxkbGV1ZW5iZXJnZXJA
c3VzZS5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
PiA+IC0tLQo+ID4gSGksCgo+ID4gSSB3b25kZXIsIGlmIHRoaXMgaXMgYSBidWcgb3Igbm90LgoK
PiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeS5oIHwgMTIgKysrKysrKysrLS0tCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gPiBpbmRleCBlMGQxNzhiY2MuLmRk
MWY1Yzg0YyAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkuaAo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeS5oCj4gPiBAQCAtNDcsOSArNDcsMTUgQEAgc3RhdGljIGlubGluZSBpbnQgc2Fm
ZV9mYW5vdGlmeV9tYXJrKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gPiAg
ICAgICAgIHJ2YWwgPSBmYW5vdGlmeV9tYXJrKGZkLCBmbGFncywgbWFzaywgZGZkLCBwYXRobmFt
ZSk7Cgo+ID4gICAgICAgICBpZiAocnZhbCA9PSAtMSkgewo+ID4gLSAgICAgICAgICAgICAgIHRz
dF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgImZhbm90aWZ5X21hcmsoJWQsIDB4JXgsIDB4JWx4LCAuLi4sICVzKSBmYWlsZWQi
LAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIGZkLCBmbGFncywgbWFzaywgcGF0aG5hbWUp
Owo+ID4gKyAgICAgICAgICAgICAgIGlmIChlcnJubyA9PSBFT1BOT1RTVVBQKSB7Cj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRDT05GIHwgVEVSUk5P
LAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZmFub3RpZnlf
bWFyayglZCwgMHgleCwgMHglbHgsIC4uLiwgJXMpIHVuc3VwcG9ydGVkIiwKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmQsIGZsYWdzLCBtYXNrLCBwYXRobmFt
ZSk7Cj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmYW5vdGlmeV9tYXJrKCVkLCAweCV4LCAw
eCVseCwgLi4uLCAlcykgZmFpbGVkIiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZmQsIGZsYWdzLCBtYXNrLCBwYXRobmFtZSk7Cj4gPiArICAgICAgICAgICAg
ICAgfQo+ID4gICAgICAgICB9Cgo+ID4gICAgICAgICBpZiAocnZhbCA8IC0xKSB7Cj4gPiAtLQo+
ID4gMi40My4wCgoKSGkgQW1pciwKCj4gUGV0ciwKCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIHRo
ZSByaWdodCBmaXguCgo+IEFtIEkgY29ycmVjdCB0byBhc3N1bWUgdGhhdCBleGZhdCB3YXMgc2tp
cHBlZCBpbiB0aGlzIHRlc3QgcHJpb3IKPiB0byB2Ni44LXJjMT8KPiAzMGFkMTkzODMyNmIgZmFu
b3RpZnk6IGFsbG93ICJ3ZWFrIiBmc2lkIHdoZW4gd2F0Y2hpbmcgYSBzaW5nbGUgZmlsZXN5c3Rl
bQoKWWVzLCBpdCB3YXMgc2tpcHBlZCBvbiA2LjY6Cgp0c3RfdGVzdC5jOjE2Njk6IFRJTkZPOiA9
PT0gVGVzdGluZyBvbiBleGZhdCA9PT0KdHN0X3Rlc3QuYzoxMTE3OiBUSU5GTzogRm9ybWF0dGlu
ZyAvZGV2L2xvb3AwIHdpdGggZXhmYXQgb3B0cz0nJyBleHRyYSBvcHRzPScnCnRzdF90ZXN0LmM6
MTEzMTogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfZmFueTdmbDIyL21u
dHBvaW50IGZzdHlwPWV4ZmF0IGZsYWdzPTAKZmFub3RpZnkxNC5jOjMyMzogVENPTkY6IEZBTl9S
RVBPUlRfRklEIG5vdCBzdXBwb3J0ZWQgb24gZXhmYXQgZmlsZXN5c3RlbQoKPiBJIGhhdmUgcHJl
cGFyZWQgYSBicmFuY2ggdG8gdGVzdCB0aGUgdjYuOC1yYzEgZmFub3RpZnkgY2hhbmdlczoKCj4g
aHR0cHM6Ly9naXRodWIuY29tL2FtaXI3M2lsL2x0cC9jb21taXRzL2Zhbm90aWZ5X2ZzaWQvCgo+
IE5vcm1hbGx5LCBJIHBvc3QgdGhlIHRlc3RzIG11Y2ggbGF0ZXIgaW4gdGhlIGEgcmVsZWFzZSBj
eWNsZSwgYnV0IHRoZSBjaGFuZ2VzCj4gaW4gdjYuOC1yYzEgd2lsbCBjYXVzZSBzZXZlcmFsIG5l
dyBmaWxlc3lzdGVtcyAoZS5nLiBmdXNlLW50ZnMzKSB0byBzdGFydAo+IHJ1bm5pbmcgdGhlIGZh
bm90aWZ5IHRlc3RzLCBzbyB3ZSBtYXkgbmVlZCB0byBtZXJnZSBzb21lIG9mIHRob3NlIHRlc3QK
PiBmaXhlcyBzb29uZXIuCgorMQoKPiBDYW4geW91IHBsZWFzZSB0ZXN0IGlmIHRoZSBjaGFuZ2Vz
IGluIG15IGJyYW5jaCBmaXggdGhpcyB0ZXN0IGZhaWx1cmUuCj4gTGV0IG1lIGtub3cgaWYgeW91
IG5lZWQgbWUgdG8gcG9zdCB0aGUgY2hhbmdlcyBmb3IgcmV2aWV3LgoKWWVzLCB0aGlzIHlvdXIg
YnJhbmNoIGZhbm90aWZ5X2ZzaWQgd29ya3Mgb24gNi43IGZyb20gVHVtYmxld2VlZC4KRXZlbiBj
aGVycnkgcGlja2luZyB0aGUgY29tbWl0IDNmYzk0OTNlYiAoImZhbm90aWZ5ezE0LDE1LDE2fTog
Q2hlY2sgZm9yCmZpbGVzeXN0ZW0gbWFyayBzdXBwb3J0IG9uIGZpbGVzeXN0ZW0iKSB3b3VsZCBi
ZSBlbm91Z2ggZm9yIG5vdy4KCkkgY2FuIGV2ZW4gZG8gaXQgd2l0aG91dCB5b3Ugc2VuZGluZyBh
IHBhdGNoLCBpZiBpdCdzIG9rIGZvciB5b3UKKGxpbmtpbmcgdGhpcyBkaXNjdXNzaW9uKS4KCktp
bmQgcmVnYXJkcywKUGV0cgoKPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBvbmx5IHRoZSBjaGFuZ2U6
Cj4gMzVmNDlhOWNiIGZhbm90aWZ5MDE6IFRlc3Qgc2V0dGluZyB0d28gbWFya3Mgb24gZGlmZmVy
ZW50IGZpbGVzeXN0ZW1zCgo+IHRlc3RzIGZvciBuZXcgdjYuOC1yYzEgZnVuY3Rpb25hbGl0eSwg
YnV0IGl0IHNob3VsZCBub3QgYWZmZWN0IHJ1bm5pbmcgdGhlCj4gdGVzdCBvbiBvbGRlciBrZXJu
ZWxzLCB3aGVyZSB0aGUgYWZmZWN0ZWQgZmlsZXN5c3RlbXMgYXJlIHNraXBwZWQgYW55d2F5LgoK
PiBUaGFua3MsCj4gQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
