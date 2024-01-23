Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02053C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 15:47:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A303CFB71
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:47:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 259593CD71B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:47:39 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 97FD41A0197D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:47:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9ABC62209F;
 Tue, 23 Jan 2024 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZwWhVKHOQjbAUxCkbd7tJUL15cFMrHpXNPlZgkjtRg=;
 b=jR62PlM4fTzpkNc2BwTjwItVBsdzV+oiMkvth11QWAkTmQaV9VOaNUNGaTX4xkG2qr1mLt
 SZc5bkCv//tKnkSiVkxDpXSweY95AtRifFBCS3dM+xXdMyIpA6hE8wUvNg8qjMsxGbqHAr
 Wr8BpGZ7c98eNhHqU+ndayfazfH665w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZwWhVKHOQjbAUxCkbd7tJUL15cFMrHpXNPlZgkjtRg=;
 b=K7jlxl0cDoxV84bEBVkOya64VLdt8gE32nOYNL6KNYkRnWiKo8J9pQW/sWPZ+p1/5OkrMp
 lxl3sVppBfmoTLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZwWhVKHOQjbAUxCkbd7tJUL15cFMrHpXNPlZgkjtRg=;
 b=jR62PlM4fTzpkNc2BwTjwItVBsdzV+oiMkvth11QWAkTmQaV9VOaNUNGaTX4xkG2qr1mLt
 SZc5bkCv//tKnkSiVkxDpXSweY95AtRifFBCS3dM+xXdMyIpA6hE8wUvNg8qjMsxGbqHAr
 Wr8BpGZ7c98eNhHqU+ndayfazfH665w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024857;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZwWhVKHOQjbAUxCkbd7tJUL15cFMrHpXNPlZgkjtRg=;
 b=K7jlxl0cDoxV84bEBVkOya64VLdt8gE32nOYNL6KNYkRnWiKo8J9pQW/sWPZ+p1/5OkrMp
 lxl3sVppBfmoTLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE7A136A4;
 Tue, 23 Jan 2024 15:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U/V5C5nfr2UHfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 15:47:37 +0000
Date: Tue, 23 Jan 2024 16:47:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123154735.GC201093@pevik>
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
 <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jR62PlM4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K7jlxl0c
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 9ABC62209F
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

PiBIaSBQZXRyLAoKPiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCA4OjM34oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gSGkgTGksCgo+ID4g
PiBzd2Fwb2ZmMDEgZmFpbHMgb24gVE1QRElSIG9uIGJ0cmZzIChyZWdhcmRsZXNzIGtlcm5lbCB2
ZXJzaW9uKToKCj4gPiBGWUkgaXQgd29ya3Mgb24gVHVtYmxld2VlZCB3aXRoIDYuNyBrZXJuZWwu
IEl0J3MgYnJva2VuIG9uIHNvbWUgb2xkZXIgU0xFUwo+ID4gd2l0aCA1LjE0IGFuZCBhbGwgb2xk
ZXIga2VybmVscy4gSSBzdXBwb3NlIHdpdGggbm9jb3cgKGZpeGVzIEkgc3VnZ2VzdGVkCj4gPiBw
cmV2aW91c2x5KSB3b3VsZCB3b3JrIGFzIGV4cGVjdGVkIChUUEFTUywgb3IgVENPTkYgb24ga2Vy
bmVsIDwgNS4wKS4KCgo+IFlvdSdyZSByaWdodC4KCj4gV2UgaGF2ZSB0byBndWFyYW50ZWUgdGhl
IHN3YXBmaWxlIGlzIGEgY29udGlndW91cyBmaWxlIHdoYXRldmVyIHRoZSBGUyB0eXBlCj4gaXMu
Cj4gU28gaGVyZSBtYWtpbmcgdXNlIG9mIG1ha2Vfc3dhcGZpbGUoKSBpcyBhIGhhcmQgcmVxdWly
ZW1lbnQuCj4gQW5kLCBJIGRvbid0IHRoaW5rIHRoZSBmaWxlIGZpcnN0IHdpdGggNjU1MzYgYmxv
Y2tzIChpbiBzd2Fwb2ZmMDEpIGlzIG5vdAo+IG5lY2Vzc2FyeS4KCk1heWJlIG5vdCwgYnV0IG5v
dyB3ZSB0ZXN0IG9uIHNpbmdsZSBzd2FwIHNpemUuIFRlc3Rpbmcgc21hbGwgc3dhcCBhbmQgYmln
IHN3YXAKd2FzIElNSE8gbW9yZSB0ZXN0aW5nIGNvdmVyYWdlICh2YXJpb3VzIGZpbGVzeXN0ZW1z
IGJlaGF2ZSBkaWZmZXJlbnRseSBvbgpkaWZmZXJlbnQgc2l6ZSksIGJ1dCBnaXZlbiB0aGlzIHdv
dWxkIGJlIG1vcmUgaW1wb3J0YW50IGZvciB3aG9sZQouYWxsX2ZpbGVzeXN0ZW1zID0gMSB0ZXN0
aW5nIEknbSBvayB3aXRoIHRoZSBjaGFuZ2UuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBLaW5k
IHJlZ2FyZHMsCj4gPiBQZXRyCgo+ID4gPiAjIC4vc3dhcG9mZjAxCj4gPiA+IHJtIC1mIC1mIC1y
IHN3YXBvZmYwMSBzd2Fwb2ZmMDIgICoubyAqLnB5YyAuY2FjaGUubWsgKi5kd28gLiouZHdvCj4g
PiA+IEJVSUxEIGxpYmx0cHN3YXAuYQo+ID4gPiBtYWtlWzFdOiBOb3RoaW5nIHRvIGJlIGRvbmUg
Zm9yICdhbGwnLgo+ID4gPiBDQyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dh
cG9mZjAxCj4gPiA+IENDIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2Zm
MDIKPiA+ID4gdHN0X3Rlc3QuYzoxNzA5OiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjMwOTI5LTI5
NS1nYzIwYWI0OTlhCj4gPiA+IHRzdF90ZXN0LmM6MTU5NTogVElORk86IFRpbWVvdXQgcGVyIHJ1
biBpcyAwaCAwMG0gMzBzCj4gPiA+IHRzdF9pb2N0bC5jOjIxOiBUSU5GTzogRklCTUFQIGlvY3Rs
IGlzIE5PVCBzdXBwb3J0ZWQ6IEVJTlZBTCAoMjIpCj4gPiA+IGxpYnN3YXAuYzozMzogVElORk86
IEZTX05PQ09XX0ZMIGF0dHJpYnV0ZSBzZXQgb24gLi90c3Rzd2FwCj4gPiA+IHN3YXBvZmYwMS5j
OjI0OiBURkFJTDogRmFpbGVkIHRvIHR1cm4gb24gdGhlIHN3YXAgZmlsZSwgc2tpcHBpbmcgdGVz
dAo+ID4gaXRlcmF0aW9uOiBFSU5WQUwgKDIyKQoKPiA+ID4gPT4gSSBndWVzcyB3ZSB3b3VsZCBu
ZWVkIHRvIHJlcGxhY2UgdHN0X2ZpbGxfZmlsZSgpIHdpdGgKPiA+ID4gcHJlYWxsb2NfY29udGln
dW91c19maWxlKCkgKHdoaWNoIGlzIG5vdCBwdWJsaWMpLCBvciB1c2UgbWFrZV9zd2FwZmlsZSgp
Cj4gPiA+IGRpcmVjdGx5LiBCdXQgaGVyZSB3ZSBjcmVhdGUgZmlsZSBmaXJzdCB3aXRoIDY1NTM2
IGJsb2NrcyBhbmQKPiA+IG1ha2Vfc3dhcGZpbGUoKQo+ID4gPiBjcmVhdGVzIDEwIGJsb2NrIGZp
bGUgKHdpdGggcHJlYWxsb2NfY29udGlndW91c19maWxlKCkgb3IgcHJldmlvdXNseQo+ID4gYWxz
byB3aXRoCj4gPiA+IHRzdF9maWxsX2ZpbGUoKSkuCgo+ID4gPiBLaW5kIHJlZ2FyZHMsCj4gPiA+
IFBldHIKCj4gPiA+IC0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9m
ZjAxLmMKPiA+ID4gKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2Zm
MDEuYwo+ID4gPiBAQCAtNDQsMTEgKzQ0LDggQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+
ID4gICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICJJbnN1ZmZpY2llbnQgZGlzayBzcGFjZSB0byBjcmVhdGUgc3dhcCBmaWxlIik7Cgo+
ID4gPiAtICAgICAgIGlmICh0c3RfZmlsbF9maWxlKCJzd2FwZmlsZTAxIiwgMHgwMCwgMTAyNCwg
NjU1MzYpKQo+ID4gPiArICAgICAgIGlmIChtYWtlX3N3YXBmaWxlKCJzd2FwZmlsZTAxIiwgMSkp
Cj4gPiA+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiRmFpbGVkIHRvIGNyZWF0ZSBm
aWxlIGZvciBzd2FwIik7Cj4gPiA+IC0KPiA+ID4gLSAgICAgICBpZiAoc3lzdGVtKCJta3N3YXAg
c3dhcGZpbGUwMSA+IHRtcGZpbGUgMj4mMSIpICE9IDApCj4gPiA+IC0gICAgICAgICAgICAgICB0
c3RfYnJrKFRCUk9LLCAiRmFpbGVkIHRvIG1ha2Ugc3dhcGZpbGUiKTsKPiA+ID4gIH0KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
