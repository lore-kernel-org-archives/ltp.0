Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684EC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:02:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F7033C6EE1
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 16:02:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25763C02AF
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 16:02:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E0C961A00CB2
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 16:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2657F21181;
 Tue, 22 Apr 2025 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745330538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiOSWeXkiKC55y0i2iZ6Y6aRGRVxQouswvuQZvlkYDk=;
 b=WrHL8nK+VtvKBAEkFEoVBzPeBW3LJnrkI9AVg4SdpB6huyWXSRwBB4kEkLqGopwWjIw61p
 seDI8gndzlSWu3qwTwFUw9ou/3PeKGaTr0jn2qG8L3leqcP12ZmhSv/mdICzs/8sGId2Bc
 ToVndbgcHfuJlYGzUfqUhJM2I7hn7WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745330538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiOSWeXkiKC55y0i2iZ6Y6aRGRVxQouswvuQZvlkYDk=;
 b=XnQ7cQICwFfNrKkPHQGuEOXzEMiCIgZsljqiNfi1lR81H5F3rai+TVIOXRQ4yWez15qnSx
 MGHyee2F8o4JLaDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Q5nhA/ci";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pCqLq8GZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745330537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiOSWeXkiKC55y0i2iZ6Y6aRGRVxQouswvuQZvlkYDk=;
 b=Q5nhA/ciDQ/dWLm9vrHpufkr2DxjClkRbmjtdEyfDmxzVASegg6A7TWmk/Wr3lF9bYsKlu
 RK+Jpsvkz2HZwiZO4bfeWZzJ/Zmidb/wHH2AD7436FUiagFxYiZ2vROL/R3p8F+x1Q/v7o
 dFfTE+975/nbmtasyOS68gtbf+gcyms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745330537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiOSWeXkiKC55y0i2iZ6Y6aRGRVxQouswvuQZvlkYDk=;
 b=pCqLq8GZ3aQn/MWPNbjDGS7+Y0YJEKwSA5ypJpG+KLOZJXQ8NDryaVvoOqCc4p0RzLTmRA
 0NwA2oFisQx2jJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1072F139D5;
 Tue, 22 Apr 2025 14:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+5GAmmhB2hIQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Apr 2025 14:02:17 +0000
Date: Tue, 22 Apr 2025 16:02:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250422140211.GB934527@pevik>
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-3-e08e7463bfaa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250414-conversions-mknod-v3-3-e08e7463bfaa@suse.com>
X-Rspamd-Queue-Id: 2657F21181
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/8] syscalls/mknod03: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25v
ZDAzLmMKCj4gQEAgLTEsMjk2ICsxLDY0IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkKVGV4dCBiZWxvdyBzaG93cyAib3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkg
bGF0ZXIgdmVyc2lvbiIgPT4gaXQgc2hvdWxkIGJlIEdQTHYyKy4KLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKCj4gIC8qCj4gLSAqCj4gLSAqICAgQ29weXJpZ2h0
IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMQo+IC0gKgo+
IC0gKiAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yIG1vZGlmeQo+IC0gKiAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Cj4gLSAqICAgdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IK
PiAtICogICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgo+IC0gKgo+IC0gKiAg
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLAo+IC0gKiAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZgo+IC0gKiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZQo+IC0gKiAgIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgo+IC0gKgo+IC0gKiAgIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCj4g
LSAqICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVl
IFNvZnR3YXJlCj4gLSAqICAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBG
aWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQQo+ICsgKiBDb3B5cmlnaHQgKGMp
IEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgQ29ycC4sIDIwMDEKPiArICoJMDcvMjAw
MSBQb3J0ZWQgYnkgV2F5bmUgQm95ZXIKPiArICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExD
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gICAqLwoKLi4uCj4gKy8qXAo+
ICsgKiBWZXJpZnkgdGhhdCBta25vZCgyKSBzdWNjZWVkcyB3aGVuIHVzZWQgdG8gY3JlYXRlIGEg
ZmlsZXN5c3RlbSBub2RlIHdpdGgKPiArICogc2V0LWdyb3VwLUlEIGJpdCBzZXQgb24gYSBkaXJl
Y3Rvcnkgd2l0aCBzZXQtZ3JvdXAtSUQgYml0IHNldC4gVGhlIG5vZGUKPiArICogY3JlYXRlZCBz
aG91bGQgaGF2ZSBzZXQtZ3JvdXAtSUQgYml0IHNldCBhbmQgaXRzIGdpZCBzaG91bGQgYmUgZXF1
YWwgdG8KPiArICogdGhlICJub2JvZHkiIGdpZC4KPiAgICovCi4uLgo+IC0jZGVmaW5lIE1PREVf
UldYCVNfSUZJRk8gfCBTX0lSV1hVIHwgU19JUldYRyB8IFNfSVJXWE8KPiAtI2RlZmluZSBNT0RF
X1NHSUQgICAgICAgU19JRklGTyB8IFNfSVNHSUQgfCBTX0lSV1hVIHwgU19JUldYRyB8IFNfSVJX
WE8KPiAtI2RlZmluZSBESVJfVEVNUAkidGVzdGRpcl8zIgo+IC0jZGVmaW5lIFROT0RFCQkidG5v
ZGVfJWQiCi4uLgo+ICsjZGVmaW5lIE1PREVfUldYIDA3NzcKPiArI2RlZmluZSBNT0RFX1NHSUQg
Mjc3NwoKVGhlIHRlc3QgZmFpbHMgb24gbXkgVk0gKGxhc3QgbWludXRlIGNoYW5nZT8pOgpta25v
ZDAzLmM6MzM6IFRGQUlMOiBidWYuc3RfbW9kZSAmIFNfSVNHSUQgKDApICE9IFNfSVNHSUQgKDEw
MjQpCm1rbm9kMDMuYzozODogVEZBSUw6IGJ1Zi5zdF9naWQgKDY1NTM0KSAhPSBmcmVlX2dpZCAo
NCkKCldoeT8gU19JU0dJRCBpcyAqbm90KiAyMDAwIGJ1dCAwMjAwMCAob2N0YWwgbnVtYmVyLCAx
NTM1IGluIGRlY2ltYWwpLgpJIGFjdHVhbGx5IGZpbmQgKFNfSVNHSUQgfCAwNzc3KSB5b3UgaGFk
IGluIHYyIG1vcmUgcmVhZGFibGUsIGJ1dCBtYXliZSBpdCdzCmp1c3QgbWUgd2hvIG5lZWRzIHRv
IGxvb2sgdXAgc2V0dWlkIGJpdHMgKHVubGlrZSB0eXBpY2FsIHJ3eCBwZXJtaXNzaW9uIGJpdHMp
LgoKPiAtY2hhciAqVENJRCA9ICJta25vZDAzIjsKPiAtaW50IFRTVF9UT1RBTCA9IDE7Cj4gLWNo
YXIgbm9kZV9uYW1lW1BBVEhfTUFYXTsJLyogYnVmZmVyIHRvIGhvbGQgbm9kZSBuYW1lIGNyZWF0
ZWQgKi8KPiArI2RlZmluZSBURU1QX0RJUiAidGVzdGRpciIKPiArI2RlZmluZSBURU1QX05PREUg
VEVNUF9ESVIgIi90ZXN0bm9kZSIKCi4uLgo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAgewou
Li4KPiArCXN0cnVjdCBzdGF0IGJ1ZjsKCj4gKwlTQUZFX1NUQVQoVEVNUF9ESVIsICZidWYpOwpJ
IHdvdWxkIGtlZXAgdGhpcyBmaXJzdCBTQUZFX1NUQVQoKSBpbiB0aGUgc2V0dXAoKSBhcyBpdCB3
YXMgaW4gdGhlIG9yaWdpbmFsCmNvZGUuIFdlIHB1dCB0aGluZ3MgaW4gdGhlIHNldHVwIHdoaWNo
IGFyZSBub3QgcmVsYXRlZCB0byB0aGUgdGVzdGluZyBhbmQgdGh1cwppdCdzIGEgd2FzdGUgb2Yg
dGltZSB0byByZXBlYXQgdGhlbSwgZS5nLiBvbiByZXBlYXRlZCBydW46CiMgLi9ta25vZDAzIC1p
MjAwMAoKPiArCVRTVF9FWFBfRVFfTEkoYnVmLnN0X21vZGUgJiBTX0lTR0lELCBTX0lTR0lEKTsK
QWxzbyB0aGlzIG9yaWdpbmFsIHRlc3Qgc2hvdWxkIHF1aXQgLSB1c2UgdHN0X2JyayhUQlJPSyku
CgpOT1RFOiBhZnRlciBDeXJpbCdzIGNoYW5nZSBbMV0gaXMgbWVyZ2VkLCBpdCB3aWxsIG5vdCBu
ZWVkIHRvIGJlIHRzdF9icmsoVEJST0spLApidXQgaXQgbWFrZXMgc2Vuc2UgdG8gdXNlIFRCUk9L
IChpbnN0ZWFkIG9mIFRGQUlMKSBpbiB0aGUgdGVzdCBzZXR1cCBhbnl3YXkuCgpUaGUgcmVzdCBM
R1RNLgoKS2luZCByZWdhcmRzLApQZXRyCgpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI1MDQwNDE0MzQyMy4xNjI2OC0xLWNocnViaXNAc3VzZS5j
ei8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
