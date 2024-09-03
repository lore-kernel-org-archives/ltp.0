Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260ADCD342E
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 07:24:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CA433C4E00
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 09:24:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1003F3C01D3
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:24:28 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0F78D60140D
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:24:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6BF821A21;
 Tue,  3 Sep 2024 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725348266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dx56DrS186z563oZsSYQfZ22FvZFd2qky7Ynr0YmwdM=;
 b=CYeQPQWHBn8+uCDZNILqjT+T0sjdsZeTZMNZwIBD6NN64s4JruIPTsBANSmEMMJtSC/kCe
 vovMprEcrl+laoscS9G0xWvWtCL5w6OrAWo/mrJmukiya8bI0tLd5jgNZnOlNxBdYFmvfg
 iT88BEUkSWQfvyEPEo50IlBo7vZdPBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725348266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dx56DrS186z563oZsSYQfZ22FvZFd2qky7Ynr0YmwdM=;
 b=z02zMHupm6kd0OIc/v+lDabszHWDH+tk3FCjRFPO5/DfMJdM/ITq/7whe0XSXv7ZKXjVAu
 U2GnwW/3iJum20Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725348266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dx56DrS186z563oZsSYQfZ22FvZFd2qky7Ynr0YmwdM=;
 b=CYeQPQWHBn8+uCDZNILqjT+T0sjdsZeTZMNZwIBD6NN64s4JruIPTsBANSmEMMJtSC/kCe
 vovMprEcrl+laoscS9G0xWvWtCL5w6OrAWo/mrJmukiya8bI0tLd5jgNZnOlNxBdYFmvfg
 iT88BEUkSWQfvyEPEo50IlBo7vZdPBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725348266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dx56DrS186z563oZsSYQfZ22FvZFd2qky7Ynr0YmwdM=;
 b=z02zMHupm6kd0OIc/v+lDabszHWDH+tk3FCjRFPO5/DfMJdM/ITq/7whe0XSXv7ZKXjVAu
 U2GnwW/3iJum20Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F4D013A52;
 Tue,  3 Sep 2024 07:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6FyFJaq51mbCTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 07:24:26 +0000
Date: Tue, 3 Sep 2024 09:24:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240903072425.GA718469@pevik>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
 <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
 <20240829205007.GA29837@pevik>
 <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ2h1Y2ssCgpmaXJzdCwgdGhhbmtzIGZvciBzaGFyaW5nIGluZm8gaG93IHlvdSB1c2UgTFRQ
LgoKPiA+IE9uIEF1ZyAyOSwgMjAyNCwgYXQgNDo1MOKAr1BNLCBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6CgoKCj4gPj4+IE9uIEF1ZyAyOCwgMjAyNCwgYXQgNjo0OOKAr1BNLCBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4+PiBIaSBDaHVjaywKCj4gPj4+
PiBIaS0KCj4gPj4+PiBJJ20gZmluZGluZyB0aGF0IGx0cCAyMDI0MDUyNCBkb2VzIG5vdCBidWls
ZCBvbiBGZWRvcmEgNDAgZHVlCj4gPj4+PiB0byBhIG1pc3NpbmcgaGVhZGVyOgoKPiA+Pj4gSSBn
dWVzcyB5b3UgbmVlZCB0byBiYWNrcG9ydCBnY2MtMTQgZml4IGIwYWUxZWUyMzkgKCJycGNfc3Zj
XzE6IEZpeCBpbmNvbXBhdGlibGUKPiA+Pj4gcG9pbnRlciB0eXBlIGVycm9yIikgWzFdIChvciBi
dWlsZCB3aXRoIG9sZGVyIGdjYykuCgo+ID4+Pj4gbHRwL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNl
LWRyaXZlcnMvdGJpby90YmlvX2tlcm5lbC9sdHBfdGJpby5jOjQ2OjEwOiBmYXRhbCBlcnJvcjog
bGludXgvZ2VuaGQuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+ID4+Pj4gIDQ2IHwgI2lu
Y2x1ZGUgPGxpbnV4L2dlbmhkLmg+Cj4gPj4+PiAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+
fn4KPiA+Pj4+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCgo+ID4+IEJ1aWxkaW5nIGx0cCBvbiBj
b21taXQgYjBhZTFlZTIzOSBpbmRlZWQgZml4ZWQgdGhlIHByb2JsZW0gb24gRmVkb3JhIDQwLgo+
ID4+IEkgZ3Vlc3MgdGhlICJnZW5oZC5oIiBlcnJvciBtaXNkaXJlY3RlZCBtZS4gVGhhbmtzLCBQ
ZXRyIQoKPiA+IFlvdSdyZSB3ZWxjb21lICh3ZSBhcHByZWNpYXRlIHdoZW4ga2VybmVsIG1haW50
YWluZXJzIGxvb2sgaW50byBMVFApLAo+ID4gZmVlbCBmcmVlIHRvIGFzayBpZiB5b3UgZW5jb3Vu
dGVyIG1vcmUgcHJvYmxlbXMuCgo+ID4gSSB3b3VsZCBzYXkgbW9zdGx5IHRoZSBjdXJyZW50IG1h
c3RlciBicmFuY2ggaXMgdGhlIGJlc3QgTFRQLCBJIHdvdWxkIGZhbGxiYWNrCj4gPiB0byB0aGUg
bGF0ZXN0IHN0YWJsZSByZWxlYXNlIG9ubHkgd2hlbiBtYXN0ZXIgZG9lcyBub3QgYnVpbGQuCgo+
IEkgdGhpbmsgaW4gZ2VuZXJhbCB3ZSBzdGljayB3aXRoIGEgZml4ZWQgdmVyc2lvbiBvZiB0ZXN0
cwo+IHNvIHRoYXQgdGhleSBhcmUgcmVwZWF0YWJsZSBhbmQgZG9uJ3QgY2hhbmdlIGJlY2F1c2Ug
dGhlCj4gdGVzdHMgaGF2ZSB1bmV4cGVjdGVkbHkgY2hhbmdlZCByYXRoZXIgdGhhbiBkdWUgdG8g
YWN0dWFsCj4gc291cmNlIGNvZGUgYnJlYWthZ2UuCgo+IFVwZGF0aW5nIHRoZSB0ZXN0IHZlcnNp
b24gaXMgdGhlcmVmb3JlIGEgbWFudWFsIHN0ZXAsIGJ1dAo+IHRoYXQgbWVhbnMgdGhlcmUncyBh
IGJyaWdodCBsaW5lIChhIGNvbW1pdCBtZXNzYWdlIGFuZCBzb21lCj4gdGVzdCByZXN1bHRzIHRo
YXQgc2hvdyB0aGUgbmV3IHRlc3RzIGRvbid0IGludHJvZHVjZQo+IGFueXRoaW5nIHVuZXhwZWN0
ZWQpLgoKWWVzLCB3ZSBhbHNvIHVzZSBzdGFibGUgTFRQIGZvciBzb21lIFNMRSB2ZXJzaW9ucy4g
QnV0IGZvciBwcm9kdWN0cyBpbgpkZXZlbG9wbWVudCBhbmQgZm9yIFR1bWJsZXdlZWQgKHdoaWNo
IHVzZSBsYXRlc3Qgc3RhYmxlIHVwc3RyZWFtIGtlcm5lbCkKd2UgcHJlZmVyIHRvIHVzZSBMVFAg
bWFzdGVyLiBXZSB1c3VhbGx5IGZpeCBmZXcgcHJvYmxlbXMgd2hpY2ggYXJpc2VzIHF1aWNrbHkK
YW5kIExUUCBzdGFibGUgdmVyc2lvbiBnZXRzIG91dGRhdGVkIGZvciBuZXcgZGlzdHJvcyAoZS5n
LiB0aGUgcHJvYmxlbSB5b3UKZW5jb3VudGVyZWQpLgoKPiBJdCB3b24ndCBiZSBkaWZmaWN1bHQg
dG8gcHVsbCBiMGFlMWVlMjM5IGp1c3QgZm9yIG15Cj4gRmVkb3JhIDQwIHN5c3RlbXMgdW50aWwg
dGhlcmUgaXMgYSB0YWdnZWQgcmVsZWFzZSBvZiBsdHAKPiB3aXRoIHRoaXMgZml4IGJha2VkIGlu
LiAoQXMgeW91IG5vdGljZWQsIEkgYW0gcmVndWxhcmx5Cj4gdGVzdGluZyB0aGUgTFRTIGtlcm5l
bHMgdG9vLCBhbmQgdGhvc2UgcnVuIG9sZGVyIEZlZG9yYQo+IHJlbGVhc2VzIHdoaWNoIHVzZSBh
biBvbGRlciB2ZXJzaW9uIG9mIGdjYykuCgoKPiA+IEFsc28sIGluIHlvdXIgY2FzZSwgZm9yIE5G
UyB0ZXN0aW5nIHlvdSBuZWVkIGp1c3QgdG8gY29tcGlsZQo+ID4gdGVzdGNhc2VzL25ldHdvcmsv
bmZzeyx2NH0gZGlyZWN0b3JpZXMgYW5kIHRoZWlyIGRlcGVuZGVuY2llcwo+ID4gKHRlc3RjYXNl
cy9saWIvIHRlc3RjYXNlcy9uZXR3b3JrL25ldHN0cmVzcy8pLgoKPiBKdXN0IHRvIGF2b2lkIGJl
aW5nIG15c3RlcmlvdXMgYWJvdXQgaXQuLi4uCgo+IEkgaGF2ZSBpbnRlZ3JhdGVkIGx0cCBpbnRv
IGtkZXZvcHMgWzFdIGFzIGl0cyBvd24gd29ya2Zsb3csCj4gd2l0aCBzZXZlcmFsIHNlcGFyYXRl
bHktZW5hYmxlZCB0ZXN0IGdyb3VwcywgaW5jbHVkaW5nIE5GUywKPiBSUEMsIGZhbm90aWZ5LCBh
bmQgZnMuCgpTdXJlLCBoYXZpbmcgYXV0b21hdGVkIENJIGlzIHRoZSBiZXN0LiBJIHdhcyBub3Qg
c3VyZSBpZiB5b3UganVzdCByYW5kb21seSB0ZXN0CkxUUCBtYW51YWxseS4KCj4gVGhlIGtkZXZv
cHMgd29ya2Zsb3cgdHlwaWNhbGx5IGJ1aWxkcyBhbmQgaW5zdGFsbHMgdGhlIHdob2xlCj4gc3Vp
dGUgaW4gZWFjaCB0ZXN0IGd1ZXN0LCB0byBrZWVwIHRoZSBhdXRvbWF0aW9uIHNpbXBsZTsKPiB0
aGVuIEFuc2libGUgaXMgdXNlZCB0byBzdGFydCB0aGUgcGFydGljdWxhciBzZXQgb2YgdGVzdHMK
PiB0aGF0IHdlIHdhbnQgdG8gcnVuIGluIHRoYXQgdGVzdCBncm91cC4gKFdlIGNvdWxkIHRyaW0g
ZG93bgo+IHRoZSBidWlsZHMsIHRob3VnaCEpCgo+IFRoZSBwb2ludCBvZiBrZGV2b3BzIGlzIHRv
IGJlIGEgU3dpc3MgQXJteSBrbmlmZSBmb3IgYXV0b21hdGVkCj4gZmlsZSBzeXN0ZW0gdGVzdGlu
ZzsgdGhlc2Ugd29ya2Zsb3dzIChpbmNsdWRpbmcgbHRwKSBjYW4gcnVuCj4gZm9yIHNldmVyYWwg
b3RoZXIgZmlsZSBzeXN0ZW0gdHlwZXMgaW4gdGhlIGtlcm5lbCBhc2lkZSBmcm9tCj4gTkZTICh0
b2RheSwgdGhhdCdzIHhmcywgZXh0NCwgYnRyZnMsIGFuZCB0bXBmcykuCgpZZWFoLCBJTUhPIEx1
aXMgQ2hhbWJlcmxhaW4gc3RhcnRlZCBrZGV2b3BzIHdoaWxlIGhlIHdvcmtlZCBoZXJlIGF0IFNV
U0UgWzFdLgoKV2UgaGVyZSBpbiBTVVNFIHVzZSBkaWZmZXJlbnQgZnJhbWV3b3JrIChvcGVuUUEp
LCBidXQgc29tZSBTVVNFIGtlcm5lbCBkZXZzCnByb2JhYmx5IHVzZSBrZGV2b3BzIGFzIHdlbGwu
CgpGb3IgYmlzZWN0aW5nIGtlcm5lbCBJIGZvdW5kIHF1aXRlIHVzZWZ1bCByYXBpZG8gWzJdICh3
aGljaCBzdXBwb3J0cyB2YXJpb3VzCmtlcm5lbCB0ZXN0c3VpdGVzKSwgYnV0IGZvciBMVFAgTkZT
IHRlc3RzIGl0IHdvdWxkIHJlcXVpcmUgc29tZSBlbmhhbmNlbWVudHMuCgpJZiBrZGV2b3BzIHN1
cHBvcnRzIGVhc2lseSBtdWx0aSBtYWNoaW5lIHRlc3RpbmcsIHlvdSBjYW4gc2V0dXAgdHdvIGhv
c3QKY29uZmlndXJhdGlvbiBmb3IgTFRQIFszXSAoYnkgZGVmYXVsdCBpcyBuZXR3b3JrIG5hbWVz
cGFjZXMuCgo+IFNvLCBjb3JyZWN0LCBJIGFtIHVzaW5nIGl0IGZvciB1cHN0cmVhbSBORlMgdGVz
dGluZywgYnV0IHRoZQo+IGtkZXZvcHMgd29ya2Zsb3cgSSBidWlsdCBpcyBzdXBwb3NlZCB0byBi
ZSBtb3JlIGdlbmVyaWNhbGx5Cj4gdXNlZnVsLgoKPiBJbnB1dCBpcyB3ZWxjb21lIGhlcmU7IHRo
ZSBsdHAgd29ya2Zsb3cgaXMgcHJldHR5IGZyZXNoLCBzbwo+IG5vdCBldmVyeXRoaW5nIGlzIHdv
cmtpbmcgMTAwJSBzbW9vdGhseSB5ZXQuIEl0IHdvdWxkIGJlCj4gcHJldHR5IGVhc3kgdG8gYWRk
IG1vcmUgdGVzdCBncm91cHMgaWYgeW91IHRoaW5rIGEKPiBwYXJ0aWN1bGFyIHRlc3QgbWlnaHQg
YmUgdmFsdWFibGUgZm9yIHRoZSBMaW51eCBmaWxlIHN5c3RlbQo+IGNvbW11bml0eSwgZm9yIGV4
YW1wbGUuCgpGWUkgKHlvdSBwcm9iYWJseSBub3RpY2VkKSBMVFAgaXRzZWxmIGFsbG93cyB0byB0
ZXN0IG9uIG1vcmUgZmlsZXN5c3RlbXMgKHZpYQpmb3JtYXR0aW5nIGxvb3AgZGV2aWNlLCBDIEFQ
STogLmFsbF9maWxlc3lzdGVtcyA9IDEgWzRdLCBzaGVsbCBBUEk6ClRTVF9BTExfRklMRVNZU1RF
TVM9MSBbNV0sIHdoaWNoIGlzIHVzZWQgaW4gTkZTIHRlc3RzIHRvIHRlc3QgYnRyZnMsIGV4dDQs
IHhmcykuCgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL3d3dy55b3V0dWJlLmNvbS93
YXRjaD92PTlQWWpSWWJjLU1zClsyXSBodHRwczovL2dpdGh1Yi5jb20vcmFwaWRvLWxpbnV4L3Jh
cGlkby8KWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3RyZWUv
bWFzdGVyL3Rlc3RjYXNlcy9uZXR3b3JrI3R3by1ob3N0LWNvbmZpZ3VyYXRpb24KWzRdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2RvYy9vbGQv
Qy1UZXN0LUFQSS5hc2NpaWRvYwpbNl0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvYmxvYi9tYXN0ZXIvZG9jL29sZC9TaGVsbC1UZXN0LUFQSS5hc2NpaWRvYwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
