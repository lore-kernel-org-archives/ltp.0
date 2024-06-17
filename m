Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF4C2BA18
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 15:52:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D86EA3D0D4B
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 17:52:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 434483D0BA2
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 17:51:59 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 659FF600FA0
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 17:51:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE3C36030B;
 Mon, 17 Jun 2024 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718639516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
 b=YLmvU5Yt6tD7rkbCHhRHJA68PGjyw7L2z15Cxnm/lyGphOJclhgkJgY/O4+WSKppLr03Km
 KOkQgBgkxkMu10TPDlxubhnupIRdZFbhIJBIjpfHuEGRMPBYun4+RFRmxCp2RSr3ySqUHi
 NqlPhDYqpDUhGLKIr+AGz/DHCf0URog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718639516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
 b=/1UlUamSzd3ksPvNn1D+TJgERZUeS5WM54FwuAhyJiUuHWbGPv4whdR3bvSBakfNFvMo67
 J88VOS5NVILqCeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718639516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
 b=YLmvU5Yt6tD7rkbCHhRHJA68PGjyw7L2z15Cxnm/lyGphOJclhgkJgY/O4+WSKppLr03Km
 KOkQgBgkxkMu10TPDlxubhnupIRdZFbhIJBIjpfHuEGRMPBYun4+RFRmxCp2RSr3ySqUHi
 NqlPhDYqpDUhGLKIr+AGz/DHCf0URog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718639516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
 b=/1UlUamSzd3ksPvNn1D+TJgERZUeS5WM54FwuAhyJiUuHWbGPv4whdR3bvSBakfNFvMo67
 J88VOS5NVILqCeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C34F139AB;
 Mon, 17 Jun 2024 15:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ohweJpxbcGZocwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:51:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 3F252A0887; Mon, 17 Jun 2024 17:51:56 +0200 (CEST)
Date: Mon, 17 Jun 2024 17:51:56 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240617155156.hdmwworcnqg5pqyw@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
 <20240617130739.ki5tpsbgvhumdrla@quack3>
 <CAOQ4uxhGD563ye9F=+m_gcaDuYJPbD1mbwmtm0y476Oxe5fH6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhGD563ye9F=+m_gcaDuYJPbD1mbwmtm0y476Oxe5fH6Q@mail.gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_LAST(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIDE3LTA2LTI0IDE2OjQ5OjU1LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBNb24s
IEp1biAxNywgMjAyNCBhdCA0OjA34oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gT24gTW9uIDE3LTA2LTI0IDE1OjA5OjA5LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToK
PiA+ID4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgMTI6MzfigK9QTSBKYW4gS2FyYSA8amFja0Bz
dXNlLmN6PiB3cm90ZToKPiA+ID4gPiBPbiBTYXQgMTUtMDYtMjQgMDc6MzU6NDIsIENocmlzdGlh
biBCcmF1bmVyIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCAxMiBKdW4gMjAyNCAxNzowOTo1NSAr
MTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gPiA+ID4gPiBXaGVuIGEgZmlsZSBpcyBvcGVuZWQg
YW5kIGNyZWF0ZWQgd2l0aCBvcGVuKC4uLiwgT19DUkVBVCkgd2UgZ2V0Cj4gPiA+ID4gPiA+IGJv
dGggdGhlIENSRUFURSBhbmQgT1BFTiBmc25vdGlmeSBldmVudHMgYW5kIHdvdWxkIGV4cGVjdCB0
aGVtIGluIHRoYXQKPiA+ID4gPiA+ID4gb3JkZXIuICAgRm9yIG1vc3QgZmlsZXN5c3RlbXMgd2Ug
Z2V0IHRoZW0gaW4gdGhhdCBvcmRlciBiZWNhdXNlCj4gPiA+ID4gPiA+IG9wZW5fbGFzdF9sb29r
dXBzKCkgY2FsbHMgZnNub2ZpZnlfY3JlYXRlKCkgYW5kIHRoZW4gZG9fb3BlbigpIChmcm9tCj4g
PiA+ID4gPiA+IHBhdGhfb3BlbmF0KCkpIGNhbGxzIHZmc19vcGVuKCktPmRvX2RlbnRyeV9vcGVu
KCkgd2hpY2ggY2FsbHMKPiA+ID4gPiA+ID4gZnNub3RpZnlfb3BlbigpLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBbLi4uXQo+ID4gPiA+ID4KPiA+ID4gPiA+IEFwcGxpZWQgdG8gdGhlIHZmcy5m
aXhlcyBicmFuY2ggb2YgdGhlIHZmcy92ZnMuZ2l0IHRyZWUuCj4gPiA+ID4gPiBQYXRjaGVzIGlu
IHRoZSB2ZnMuZml4ZXMgYnJhbmNoIHNob3VsZCBhcHBlYXIgaW4gbGludXgtbmV4dCBzb29uLgo+
ID4gPiA+ID4KPiA+ID4gPiA+IFBsZWFzZSByZXBvcnQgYW55IG91dHN0YW5kaW5nIGJ1Z3MgdGhh
dCB3ZXJlIG1pc3NlZCBkdXJpbmcgcmV2aWV3IGluIGEKPiA+ID4gPiA+IG5ldyByZXZpZXcgdG8g
dGhlIG9yaWdpbmFsIHBhdGNoIHNlcmllcyBhbGxvd2luZyB1cyB0byBkcm9wIGl0Lgo+ID4gPiA+
ID4KPiA+ID4gPiA+IEl0J3MgZW5jb3VyYWdlZCB0byBwcm92aWRlIEFja2VkLWJ5cyBhbmQgUmV2
aWV3ZWQtYnlzIGV2ZW4gdGhvdWdoIHRoZQo+ID4gPiA+ID4gcGF0Y2ggaGFzIG5vdyBiZWVuIGFw
cGxpZWQuIElmIHBvc3NpYmxlIHBhdGNoIHRyYWlsZXJzIHdpbGwgYmUgdXBkYXRlZC4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBOb3RlIHRoYXQgY29tbWl0IGhhc2hlcyBzaG93biBiZWxvdyBhcmUgc3Vi
amVjdCB0byBjaGFuZ2UgZHVlIHRvIHJlYmFzZSwKPiA+ID4gPiA+IHRyYWlsZXIgdXBkYXRlcyBv
ciBzaW1pbGFyLiBJZiBpbiBkb3VidCwgcGxlYXNlIGNoZWNrIHRoZSBsaXN0ZWQgYnJhbmNoLgo+
ID4gPiA+ID4KPiA+ID4gPiA+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdmZzL3Zmcy5naXQKPiA+ID4gPiA+IGJyYW5jaDogdmZzLmZpeGVz
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gWzEvMV0gVkZTOiBnZW5lcmF0ZSBGU19DUkVBVEUgYmVmb3Jl
IEZTX09QRU4gd2hlbiAtPmF0b21pY19vcGVuIHVzZWQuCj4gPiA+ID4gPiAgICAgICBodHRwczov
L2dpdC5rZXJuZWwub3JnL3Zmcy92ZnMvYy83NTM2YjJmMDY3MjQKPiA+ID4gPgo+ID4gPiA+IEkg
aGF2ZSByZXZpZXdlZCB0aGUgcGF0Y2ggeW91J3ZlIGNvbW1pdHRlZCBzaW5jZSBJIHdhc24ndCBx
dWl0ZSBzdXJlIHdoaWNoCj4gPiA+ID4gY2hhbmdlcyB5b3UncmUgZ29pbmcgdG8gYXBwbHkgYWZ0
ZXIgeW91ciBkaXNjdXNzaW9uIHdpdGggQW1pci4gQW5kIEkgaGF2ZQo+ID4gPiA+IHR3byBjb21t
ZW50czoKPiA+ID4gPgo+ID4gPiA+IEBAIC0xMDg1LDggKzEwODAsMTcgQEAgRVhQT1JUX1NZTUJP
TChmaWxlX3BhdGgpOwo+ID4gPiA+ICAgKi8KPiA+ID4gPiAgaW50IHZmc19vcGVuKGNvbnN0IHN0
cnVjdCBwYXRoICpwYXRoLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKPiA+ID4gPiAgewo+ID4gPiA+ICsg
ICAgICAgaW50IHJldDsKPiA+ID4gPiArCj4gPiA+ID4gICAgICAgICBmaWxlLT5mX3BhdGggPSAq
cGF0aDsKPiA+ID4gPiAtICAgICAgIHJldHVybiBkb19kZW50cnlfb3BlbihmaWxlLCBOVUxMKTsK
PiA+ID4gPiArICAgICAgIHJldCA9IGRvX2RlbnRyeV9vcGVuKGZpbGUsIE5VTEwpOwo+ID4gPiA+
ICsgICAgICAgaWYgKCFyZXQpCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC8qCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAqIE9uY2Ugd2UgcmV0dXJuIGEgZmlsZSB3aXRoIEZNT0RFX09QRU5FRCwg
X19mcHV0KCkgd2lsbCBjYWxsCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIGZzbm90aWZ5X2Ns
b3NlKCksIHNvIHdlIG5lZWQgZnNub3RpZnlfb3BlbigpIGhlcmUgZm9yIHN5bW1ldHJ5Lgo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgKi8KPiA+ID4gPiArICAgICAgICAgICAgICAgZnNub3RpZnlf
b3BlbihmaWxlKTsKPiA+ID4KPiA+ID4gUGxlYXNlIGFkZCB7IH0gYXJvdW5kIG11bHRpIGxpbmUg
aW5kZW50ZWQgdGV4dC4KPiA+ID4KPiA+ID4gPiArICAgICAgIHJldHVybiByZXQ7Cj4gPiA+ID4g
IH0KPiA+ID4gPgo+ID4gPiA+IEFGQUlDVCB0aGlzIHdpbGwgaGF2ZSBhIHNpZGUtZWZmZWN0IHRo
YXQgbm93IGZzbm90aWZ5X29wZW4oKSB3aWxsIGJlCj4gPiA+ID4gZ2VuZXJhdGVkIGV2ZW4gZm9y
IE9fUEFUSCBvcGVuLiBJdCBpcyB0cnVlIHRoYXQgZnNub3RpZnlfY2xvc2UoKSBpcyBnZXR0aW5n
Cj4gPiA+ID4gZ2VuZXJhdGVkIGZvciB0aGVtIGFscmVhZHkgYW5kIHdlIHNob3VsZCBzdHJpdmUg
Zm9yIHN5bW1ldHJ5LiBDb25jZXB0dWFsbHkKPiA+ID4gPiBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2Ug
dG8gbWUgdG8gZ2VuZXJhdGUgZnNub3RpZnkgZXZlbnRzIGZvciBPX1BBVEgKPiA+ID4gPiBvcGVu
cy9jbG9zZXMgYnV0IG1heWJlIEkgbWlzcyBzb21ldGhpbmcuIEFtaXIsIGFueSBvcGluaW9uIGhl
cmU/Cj4gPiA+Cj4gPiA+IEdvb2QgY2F0Y2ghCj4gPiA+Cj4gPiA+IEkgYWdyZWUgdGhhdCB3ZSBk
byBub3QgbmVlZCBPUEVOIG5vciBDTE9TRSBldmVudHMgZm9yIE9fUEFUSC4KPiA+ID4gSSBzdWdn
ZXN0IHRvIHNvbHZlIGl0IHdpdGg6Cj4gPiA+Cj4gPiA+IEBAIC05MTUsNyArOTI5LDcgQEAgc3Rh
dGljIGludCBkb19kZW50cnlfb3BlbihzdHJ1Y3QgZmlsZSAqZiwKPiA+ID4gICAgICAgICBmLT5m
X3NiX2VyciA9IGZpbGVfc2FtcGxlX3NiX2VycihmKTsKPiA+ID4KPiA+ID4gICAgICAgICBpZiAo
dW5saWtlbHkoZi0+Zl9mbGFncyAmIE9fUEFUSCkpIHsKPiA+ID4gLSAgICAgICAgICAgICAgIGYt
PmZfbW9kZSA9IEZNT0RFX1BBVEggfCBGTU9ERV9PUEVORUQ7Cj4gPiA+ICsgICAgICAgICAgICAg
ICBmLT5mX21vZGUgPSBGTU9ERV9QQVRIIHwgRk1PREVfT1BFTkVEIHwgX19GTU9ERV9OT05PVElG
WTsKPiA+ID4gICAgICAgICAgICAgICAgIGYtPmZfb3AgPSAmZW1wdHlfZm9wczsKPiA+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiAgICAgICAgIH0KPiA+Cj4gPiBGaXJzdCBJIHdh
cyBzb21ld2hhdCBuZXJ2b3VzIGFib3V0IHRoaXMgYXMgaXQgcmVzdWx0cyBpbiByZXR1cm5pbmcg
T19QQVRICj4gPiBmZCB3aXRoIF9fRk1PREVfTk9OT1RJRlkgdG8gdXNlcnNwYWNlIGFuZCBJIHdh
cyBhZnJhaWQgaXQgbWF5IGluZmx1ZW5jZQo+ID4gZ2VuZXJhdGlvbiBvZiBldmVudHMgKnNvbWV3
aGVyZSouCj4gCj4gSXQgaW5mbHVlbmNlcyBteSBQT0MgY29kZSBvZiBmdXR1cmUgbG9va3VwIHBl
cm1pc3Npb24gZXZlbnQ6Cj4gaHR0cHM6Ly9naXRodWIuY29tL2FtaXI3M2lsL2xpbnV4L2NvbW1p
dHMvZmFuX2xvb2t1cF9wZXJtLwo+IHdoaWNoIGlzIHN1cHBvc2VkIHRvIGdlbmVyYXRlIGV2ZW50
cyBvbiBsb29rdXAgd2l0aCBPX1BBVEggZmQuCj4gCj4gPiBCdXQgY2hlY2tpbmcgYSBiaXQsIHdl
IHVzZSAnZmlsZScgZm9yCj4gPiBnZW5lcmF0aW5nIG9ubHkgb3BlbiwgYWNjZXNzLCBtb2RpZnks
IGFuZCBjbG9zZSBldmVudHMgc28geWVzLCB0aGlzIHNob3VsZAo+ID4gYmUgc2FmZS4gQWx0ZXJu
YXRpdmVseSB3ZSBjb3VsZCBhZGQgZXhwbGljaXQgY2hlY2tzIGZvciAhT19QQVRIIHdoZW4KPiA+
IGdlbmVyYXRpbmcgb3BlbiAvIGNsb3NlIGV2ZW50cy4KPiA+Cj4gCj4gU28geWVoLCB0aGlzIHdv
dWxkIGJlIGJldHRlcjoKPiAKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKPiBAQCAtMTEyLDcgKzExMiw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGZzbm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsCj4gX191MzIgbWFzaykK
PiAgewo+ICAgICAgICAgY29uc3Qgc3RydWN0IHBhdGggKnBhdGg7Cj4gCj4gLSAgICAgICBpZiAo
ZmlsZS0+Zl9tb2RlICYgRk1PREVfTk9OT1RJRlkpCj4gKyAgICAgICBpZiAoZmlsZS0+Zl9tb2Rl
ICYgKEZNT0RFX05PTk9USUZZIHwgRk1PREVfUEFUSCkpCj4gICAgICAgICAgICAgICAgIHJldHVy
biAwOwo+IAo+ICAgICAgICAgcGF0aCA9ICZmaWxlLT5mX3BhdGg7Cj4gLS0KPiAKPiBJdCBpcyBh
IGRpbGVtbWEsIGlmIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHNlcGFyYXRlLgo+IE9uIHRoZSBvbmUg
aGFuZCBpdCBmaXhlcyB1bmJhbGFuY2VkIENMT1NFIGV2ZW50cyBvbiBPX1BBVEggZmQsCj4gc28g
aXQgaXMgYW4gaW5kZXBlbmRlbnQgZml4Lgo+IE9UT0gsIGl0IGlzIGEgcmVxdWlyZW1lbnQgZm9y
IG1vdmluZyBmc25vdGlmeV9vcGVuKCkgb3V0IG9mCj4gZG9fZGVudHJ5X29wZW4oKSwgc28gbm90
IHNvIGhlYWx0aHkgdG8gc2VwYXJhdGUgdGhlbSwgd2hlbiBpdCBpcyBsZXNzIGNsZWFyCj4gdGhh
dCB0aGV5IG5lZWQgdG8gYmUgYmFja3BvcnRlZCB0b2dldGhlci4KClllYWgsIEkgZ3Vlc3MgYSBz
ZXBhcmF0ZSBwYXRjaCB3b3VsZCBiZSBiZXR0ZXIgYmVjYXVzZSBpdCBhbHNvIG5lZWRzIGEgZ29v
ZApjaGFuZ2Vsb2cgZXhwbGFpbmluZyB0aGlzLgoKPiA+ID4gPiBAQCAtMzYxMiw2ICszNjEyLDkg
QEAgc3RhdGljIGludCBkb19vcGVuKHN0cnVjdCBuYW1laWRhdGEgKm5kLAo+ID4gPiA+ICAgICAg
ICAgaW50IGFjY19tb2RlOwo+ID4gPiA+ICAgICAgICAgaW50IGVycm9yOwo+ID4gPiA+Cj4gPiA+
ID4gKyAgICAgICBpZiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfT1BFTkVEKQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBmc25vdGlmeV9vcGVuKGZpbGUpOwo+ID4gPiA+ICsKPiA+ID4gPiAgICAgICAg
IGlmICghKGZpbGUtPmZfbW9kZSAmIChGTU9ERV9PUEVORUQgfCBGTU9ERV9DUkVBVEVEKSkpIHsK
PiA+ID4gPiAgICAgICAgICAgICAgICAgZXJyb3IgPSBjb21wbGV0ZV93YWxrKG5kKTsKPiA+ID4g
PiAgICAgICAgICAgICAgICAgaWYgKGVycm9yKQo+ID4gPiA+Cj4gPiA+ID4gRnJhbmtseSwgdGhp
cyB3b3JrcyBidXQgbG9va3MgYXMgYW4gb2RkIHBsYWNlIHRvIHB1dCB0aGlzIG5vdGlmaWNhdGlv
biB0by4KPiA+ID4gPiBXaHkgbm90IGp1c3QgcGxhY2luZyBpdCBqdXN0IG5leHQgdG8gd2hlcmUg
ZnNub3RpZnlfY3JlYXRlKCkgaXMgZ2VuZXJhdGVkCj4gPiA+ID4gaW4gb3Blbl9sYXN0X2xvb2t1
cHMoKT8gTGlrZToKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgaWYgKG9wZW5fZmxhZyAmIE9fQ1JF
QVQpCj4gPiA+ID4gICAgICAgICAgICAgICAgIGlub2RlX2xvY2soZGlyLT5kX2lub2RlKTsKPiA+
ID4gPiAgICAgICAgIGVsc2UKPiA+ID4gPiAgICAgICAgICAgICAgICAgaW5vZGVfbG9ja19zaGFy
ZWQoZGlyLT5kX2lub2RlKTsKPiA+ID4gPiAgICAgICAgIGRlbnRyeSA9IGxvb2t1cF9vcGVuKG5k
LCBmaWxlLCBvcCwgZ290X3dyaXRlKTsKPiA+ID4gPiAtICAgICAgIGlmICghSVNfRVJSKGRlbnRy
eSkgJiYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX0NSRUFURUQpKQo+ID4gPiA+IC0gICAgICAgICAg
ICAgICBmc25vdGlmeV9jcmVhdGUoZGlyLT5kX2lub2RlLCBkZW50cnkpOwo+ID4gPiA+ICsgICAg
ICAgaWYgKCFJU19FUlIoZGVudHJ5KSkgewo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZmls
ZS0+Zl9tb2RlICYgRk1PREVfQ1JFQVRFRCkKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBmc25vdGlmeV9jcmVhdGUoZGlyLT5kX2lub2RlLCBkZW50cnkpOwo+ID4gPiA+ICsgICAgICAg
ICAgICAgICBpZiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfT1BFTkVEKQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGZzbm90aWZ5X29wZW4oZmlsZSk7Cj4gPiA+ID4gKyAgICAgICB9Cj4g
PiA+ID4gICAgICAgICBpZiAob3Blbl9mbGFnICYgT19DUkVBVCkKPiA+ID4gPiAgICAgICAgICAg
ICAgICAgaW5vZGVfdW5sb2NrKGRpci0+ZF9pbm9kZSk7Cj4gPiA+ID4gICAgICAgICBlbHNlCj4g
PiA+ID4gICAgICAgICAgICAgICAgIGlub2RlX3VubG9ja19zaGFyZWQoZGlyLT5kX2lub2RlKTsK
PiA+ID4gPgo+ID4gPiA+IFRoYXQgbG9va3MgbGlrZSBhIHBsYWNlIHdoZXJlIGl0IGlzIG11Y2gg
bW9yZSBvYnZpb3VzIHRoaXMgaXMgZm9yCj4gPiA+ID4gYXRvbWljX29wZW4oKSBoYW5kbGluZz8g
Tm93IEkgYWRtaXQgSSdtIG5vdCByZWFsbHkgY2xvc2VseSBmYW1pbGlhciB3aXRoCj4gPiA+ID4g
dGhlIGF0b21pY19vcGVuKCkgcGF0aHMgc28gbWF5YmUgSSBtaXNzIHNvbWV0aGluZyBhbmQgZG9f
b3BlbigpIGlzIGJldHRlci4KPiA+ID4KPiA+ID4gSXQgbG9va3MgbmljZSwgYnV0IEkgdGhpbmsg
aXQgaXMgbWlzc2luZyB0aGUgZmFzdCBsb29rdXAgY2FzZSB3aXRob3V0IE9fQ1JFQVQKPiA+ID4g
KGkuZS4gZ290byBmaW5pc2hfbG9va3VwKS4KPiA+Cj4gPiBJIGRvbid0IHRoaW5rIHNvLiBBRkFJ
Q1QgdGhhdCBjYXNlIHdpbGwgZ2VuZXJhdGUgdGhlIGV2ZW50IGluIHZmc19vcGVuKCkKPiA+IGFu
eXdheSBhbmQgbm90IGluIG9wZW5fbGFzdF9sb29rdXBzKCkgLyBkb19vcGVuKCkuIEFtIEkgbWlz
c2luZyBzb21ldGhpbmc/Cj4gCj4gTm8uIEkgYW0uIFRoaXMgY29kZSBpcyBoYXJkIHRvIGZvbGxv
dy4KPiBJIGFtIGZpbmUgd2l0aCB5b3VyIHZhcmlhbnQsIGJ1dCBtYXliZSBhZnRlciBzbyBtYW55
IGluLXRyZWUgY2hhbmdlcwo+IGluY2x1ZGluZyB0aGUgZXh0cmEgY2hhbmdlIG9mIE9fUEFUSCwg
cGVyaGFwcyBpdCB3b3VsZCBiZSBiZXR0ZXIKPiB0byBtb3ZlIHRoaXMgcGF0Y2ggdG8geW91ciBm
c25vdGlmeSB0cmVlPwoKSSBkb24ndCBjYXJlIG11Y2ggd2hpY2ggdHJlZSB0aGlzIGdvZXMgdGhy
b3VnaCBhcyB0aGUgYWN0dWFsIGFtb3VudCBvZgpjb250ZXh0IGlzIG1pbmltYWwuIEJ1dCBJIGRl
ZmluaXRlbHkgd2FudCB0byBzZW5kIGFub3RoZXIgdmVyc2lvbiBvZiB0aGUKc2VyaWVzIG91dCB0
byB0aGUgdHJlZS4gSSBndWVzcyBJJ2xsIGRvIGl0IGJlY2F1c2UgTmVpbCBtaWdodCBoYXZlIHRy
b3VibGUKanVzdGlmeWluZyB0aGUgT19QQVRIIGNoYW5nZSBpbiB0aGUgY2hhbmdlbG9nIDopLgoK
CQkJCQkJCQlIb256YQoKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENS
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
