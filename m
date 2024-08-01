Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51521C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF8FA3D1F45
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:16:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79E173D1DCB
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:16:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DD9E601021
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:16:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B49E219EA;
 Thu,  1 Aug 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4656213946;
 Thu,  1 Aug 2024 12:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6UAnEJ58q2ZrWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Aug 2024 12:16:30 +0000
Date: Thu, 1 Aug 2024 14:16:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240801121631.GA1510503@pevik>
References: <20240801104004.15514-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240801104004.15514-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6B49E219EA
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] cpuset_memory_test.c: Use $TMPDIR as prefix
 for HUGEPAGE file path
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

SGkgV2VpLAoKPiBUZXN0IGNhc2Ugd2lsbCBmYWlsIHdpdGggZm9sbG93aW5nIGVycm9yIGlmIHJ1
bm5pbmcgb3BlcmF0aW9uIHN5c3RlbQo+IHdoaWNoIGZvcmNlIHJvb3QgcGF0aCByZWFkIE9OTFku
Cgo+IG1rZGlyOiBjYW5ub3QgY3JlYXRlIGRpcmVjdG9yeSDigJgvaHVnZXRsYuKAmTogUmVhZC1v
bmx5IGZpbGUgc3lzdGVtCgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
Pgo+IC0tLQo+ICAuLi4vY3B1c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdC5jICAg
ICAgfCAxMSArKysrKysrKy0tLQo+ICAuLi4vY3B1c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1v
cnlfdGVzdHNldC5zaCAgfCAxNiArKysrKysrKy0tLS0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21l
bW9yeV90ZXN0LmMgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRf
bWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0LmMKPiBpbmRleCA5OTEyZDhkNmEuLjczNzcw
ZmQzYyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9j
cHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0LmMKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9y
eV90ZXN0LmMKPiBAQCAtMTc3LDkgKzE3NywxNCBAQCB2b2lkIG1tYXBfZmlsZShpbnQgZmxhZ19h
bGxvY2F0ZWQpCj4gIAlzdGF0aWMgaW50IGZkX2h1Z2VwYWdlOwo+ICAJaW50IGZkX3RtcDsKCj4g
KwljaGFyIHBhdGhbMTAwXTsKPiArCWNoYXIgKnRtcGRpciA9IGdldGVudigiVE1QRElSIik7Cj4g
Kwo+ICsJc3ByaW50ZihwYXRoLCAiJXMlcyIsIHRtcGRpciwgRklMRV9IVUdFUEFHRSk7CgpGWUks
IHdlIGhhdmUgY3VzdG9tIGZ1bmN0aW9uLCB0aHVzIG5vIG5lZWQgdG8gZGV0ZWN0IFRNUERJUiBp
biB0aGUgdGVzdC4KCkJlY2F1c2UgdGhpcyBpcyBzdGlsbCB0aGUgbGVnYWN5IEFQSSwgY291bGQg
eW91IHBsZWFzZSB1c2UgdHN0X3RtcGRpcl9wYXRoKCk/CgpGWUkgaW4gdGhlIG5ldyBBUEkgV2Ug
aGFkIGZvciBhIGxvbmcgdGltZSB0c3RfZ2V0X3RtcGRpcigpIGZ1bmN0aW9uIG5lZWRlZCB0bwp1
c2UgZnJlZSgpIGFuZCB3YXMgdXNlZCBmb3Igc25wcmludGYoKSwgYnV0IEN5cmlsIGNoYW5nZWQg
dGhhdCBxdWl0ZSByZWNlbnRseToKaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVj
dC9sdHAvY29tbWl0L2M1ZDk1YjZkMzRlMjM1NmJkMTllNmI2NDZkYTA2ZjFiY2U2NmEwMjQKClNp
bmNlIHRoYXQganVzdCB1c2UgdHN0X3RtcGRpcl9wYXRoKCksIG5vIG5lZWQgdG8gZnJlZS4KCklN
SE8gYm90aCBsZWdhY3kgQVBJIGFuZCBuZXcgQVBJIGRvIGNoZGlyKCkgdG8gdGhlIHRlbXBvcmFy
eSBkaXJlY3RvcnksIHNlZQpsaWIvdHN0X3RtcGRpci5jOgoKICAgIGlmIChjaGRpcihURVNURElS
KSA9PSAtMSkgewogICAgICAgIHRzdF9yZXNtKFRFUlJOTywgIiVzOiBjaGRpciglcykgZmFpbGVk
IiwgX19mdW5jX18sIFRFU1RESVIpOwoKVGhlcmVmb3JlIHVubGVzcyB0aGVyZSBpcyBmdWxsIHBh
dGggbmVlZGVkIChlLmcuIHNlYXJjaCBpbiAvcHJvYy9tb3VudHMpIHdlCmNvdWxkIHVzZSByZWxh
dGl2ZSBwYXRoLCBlLmcuIGFkZCAiLi8iIHRvIHRoZSBkZWZpbml0aW9uOgoKCisrKyB0ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21l
bW9yeV90ZXN0LmMKQEAgLTU4LDcgKzU4LDcgQEAgc3RhdGljIGludCBvcHRfdGhyZWFkOwogc3Rh
dGljIGludCBrZXlfaWQ7ICAgICAgICAgICAgICAgICAgICAgLyogdXNlZCB3aXRoIG9wdF9zaG0g
Ki8KIHN0YXRpYyB1bnNpZ25lZCBsb25nIG1lbXNpemU7CgotI2RlZmluZSBGSUxFX0hVR0VQQUdF
ICAiL2h1Z2V0bGIvaHVnZXBhZ2VmaWxlIgorI2RlZmluZSBGSUxFX0hVR0VQQUdFICAiLi9odWdl
dGxiL2h1Z2VwYWdlZmlsZSIKCiAjZGVmaW5lIE1NQVBfQU5PTiAgICAgIChTQ0hBUl9NQVggKyAx
KQogI2RlZmluZSBNTUFQX0ZJTEUgICAgICAoU0NIQVJfTUFYICsgMikKLS0tCgpBbHNvLCB0aGUg
c2FtZSBkZWZpbml0aW9uIGlzIGluCnRlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cv
ZnVuY3Rpb25hbC9tZW1jZ19wcm9jZXNzLmMsIGlzIGl0IGFmZmVjdGVkIGFzCndlbGw/CgpGWUkg
QmVzaWRlcyB0aGF0IGl0J3MgYWx3YXlzIGJldHRlciB0byB1c2UgJ24nIHNwcmludGYgZnVuY3Rp
b25zIChlLmcuCnNucHJpbnRmKCksIGJlY2F1c2UgdGhleSByZXN0cmljdCB0aGUgd3JpdGUgc2l6
ZSAobWFuIHByaW50ZigzKTogIndyaXRlIGF0IG1vc3Qgc2l6ZSBieXRlcyIpCgo+ICsKPiAgCWlm
ICghZmxhZ19hbGxvY2F0ZWQpIHsKPiAgCQlpZiAob3B0X2h1Z2VwYWdlKSB7Cj4gLQkJCWZkX2h1
Z2VwYWdlID0gb3BlbihGSUxFX0hVR0VQQUdFLAo+ICsJCQlmZF9odWdlcGFnZSA9IG9wZW4ocGF0
aCwKPiAgCQkJCQkgICBPX0NSRUFUIHwgT19SRFdSLCAwNzU1KTsKPiAgCQkJaWYgKGZkX2h1Z2Vw
YWdlIDwgMCkKPiAgCQkJCWVycigxLCAib3BlbiBodWdlcGFnZSBmaWxlIGZhaWxlZCIpOwo+IEBA
IC0xOTEsNyArMTk2LDcgQEAgdm9pZCBtbWFwX2ZpbGUoaW50IGZsYWdfYWxsb2NhdGVkKQo+ICAJ
CQkgTUFQX1NIQVJFRCwgZmRfdG1wLCAwKTsKPiAgCQlpZiAocCA9PSBNQVBfRkFJTEVEKSB7Cj4g
IAkJCWlmIChvcHRfaHVnZXBhZ2UpCj4gLQkJCQl1bmxpbmsoRklMRV9IVUdFUEFHRSk7Cj4gKwkJ
CQl1bmxpbmsocGF0aCk7Cj4gIAkJCWVycigxLCAibW1hcChmaWxlKSBmYWlsZWQiKTsKPiAgCQl9
Cj4gIAkJdG91Y2hfbWVtb3J5X2FuZF9lY2hvX25vZGUocCwgbWVtc2l6ZSk7Cj4gQEAgLTIwMSw3
ICsyMDYsNyBAQCB2b2lkIG1tYXBfZmlsZShpbnQgZmxhZ19hbGxvY2F0ZWQpCgo+ICAJCWlmIChv
cHRfaHVnZXBhZ2UpIHsKPiAgCQkJY2xvc2UoZmRfaHVnZXBhZ2UpOwo+IC0JCQl1bmxpbmsoRklM
RV9IVUdFUEFHRSk7Cj4gKwkJCXVubGluayhwYXRoKTsKPiAgCQl9Cj4gIAl9Cj4gIH0KPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9y
eV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdHNldC5zaCBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJv
bGxlcnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfdGVzdC9jcHVzZXRfbWVtb3J5X3Rlc3RzZXQuc2gK
PiBpbmRleCBjMWU3Y2VhOGYuLmI2MzQyNTA4OCAxMDA3NTUKPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90
ZXN0c2V0LnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1
c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdHNldC5zaAo+IEBAIC0xNzUsOCArMTc1
LDggQEAgdGVzdDYoKQo+ICAJCXJldHVybiAwCj4gIAlmaQoKPiAtCW1rZGlyIC9odWdldGxiCj4g
LQltb3VudCAtdCBodWdldGxiZnMgbm9uZSAvaHVnZXRsYgo+ICsJbWtkaXIgJHtUTVBESVJ9L2h1
Z2V0bGIKQ291bGQgeW91IHBsZWFzZSB1c2UgJFRNUERJUiBpbnN0ZWFkIG9mICR7VE1QRElSfT8g
KG1vcmUgcmVhZGFibGUpLgoKPiArCW1vdW50IC10IGh1Z2V0bGJmcyBub25lICR7VE1QRElSfS9o
dWdldGxiCkFuZCBoZXJlICh0aGVyZSBhcmUgbW9yZSBwbGFjZXMpLgoKQlRXIGp1c3QgLi9odWdl
dGxiIGNvdWxkIHdvcmssIHJpZ2h0PyBBbHNvLCBpbiB0aGUgc2hlbGwgQVBJIHdlIGFyZSBpbiB0
aGUKZGlyZWN0b3J5LgoKQW5kIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhlc2UgdGVzdHMsIG9uY2Ug
Q3lyaWwncyBlZmZvcnQgZm9yIG1peGluZyBDIGFuZCBzaGVsbApjb2RlIGlzIG1lcmdlZCwgd2Ug
c2hvdWxkIGFkYXB0IHRoZXNlIHRlc3RzIHRvIHVzZSBpdC4KCmh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcHJvamVjdC9sdHAvbGlzdC8/c2VyaWVzPTQxNzM3MiZzdGF0ZT0qCgpLaW5kIHJl
Z2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
