Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8566AD25B4E
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 12:45:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16BEC3CB486
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 13:45:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BD483CB05E
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 13:45:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9382600052
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 13:45:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96FBB33BAF;
 Wed, 28 Jan 2026 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769604329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUWfHTNMebrk8KvS7P/PK5i6zv3Bq4cO3/mojJj4sCQ=;
 b=AsginETrRqbJHR8wzZ8LJeYAUF2FclFM3d0zeplAtGuBTFp4sPDB9MycmwJmn3Eq2hA9At
 2Oum/pBbL3DLJBl4El++eRuviBVnCy9I1+oGWfYF8h/k1hwFB/LiWo8c/vAy7eQ8N3zh1j
 WFvpGSDxCqLg6BzsuM+xGEUMroPPixc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769604329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUWfHTNMebrk8KvS7P/PK5i6zv3Bq4cO3/mojJj4sCQ=;
 b=HM3Yxu0mBbc5FVaXp7vX0jDUeT18A1ZrD6AGU9WQEYhi4sad8AGUXrkL9iIe4XmmD3zqqb
 3IDjCFrB2r7UC5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769604329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUWfHTNMebrk8KvS7P/PK5i6zv3Bq4cO3/mojJj4sCQ=;
 b=AsginETrRqbJHR8wzZ8LJeYAUF2FclFM3d0zeplAtGuBTFp4sPDB9MycmwJmn3Eq2hA9At
 2Oum/pBbL3DLJBl4El++eRuviBVnCy9I1+oGWfYF8h/k1hwFB/LiWo8c/vAy7eQ8N3zh1j
 WFvpGSDxCqLg6BzsuM+xGEUMroPPixc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769604329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUWfHTNMebrk8KvS7P/PK5i6zv3Bq4cO3/mojJj4sCQ=;
 b=HM3Yxu0mBbc5FVaXp7vX0jDUeT18A1ZrD6AGU9WQEYhi4sad8AGUXrkL9iIe4XmmD3zqqb
 3IDjCFrB2r7UC5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11AAC3EA61;
 Wed, 28 Jan 2026 12:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CmLAOkEeml6FwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 12:45:29 +0000
Date: Wed, 28 Jan 2026 13:45:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260128124527.GA34683@pevik>
References: <20260128080121.18878-1-pvorel@suse.cz>
 <CAEemH2ef_LQ_SbmmWM2nfsacn9y94eCzC7GVjcz7EggtbnfVYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ef_LQ_SbmmWM2nfsacn9y94eCzC7GVjcz7EggtbnfVYw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check
 rules
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
Cc: Ricardo Branco <rbranco@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IEhpIFBldHIsCgo+IEdlbmVyYWxseSBsb29rcyBnb29kLCBqdXN0IGEgZmV3IGNv
bW1lbnRzIHRvIHBvbGlzaCBpdC4KClRoYW5rIHlvdSEgQWxsIGZvbGxvd2VkIHN1Z2dlc3Rpb25z
IG1ha2VzIHNlbnNlIHRvIG1lLiBJIGNhbiBmaXggdGhhdCBiZWZvcmUKbWVyZ2UgKHVubGVzcyBz
b21lYm9keSBwcmVmZXJzIG1lIHRvIHNlbmQgdjIpLgoKSXQnZCBiZSBuaWNlIHRvIGdldCB0aGlz
IHJlc29sdmVkIHNvIHRoYXQgd2UgaGF2ZSB0aGlzIGZpeCBtZXJnZWQKKHJlbGF0ZWQgdG8gdGhp
cyBwb2xpY3kpOgpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9wdWxs
LzEyODUKCktpbmQgcmVnYXJkcywKUGV0cgoKPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+CgoKPiBPbiBXZWQsIEphbiAyOCwgMjAyNiBhdCA0OjAx4oCvUE0gUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gLS0tCj4gPiBCYXNlZCBvbiBhIGRpc2N1c3Npb24gdmFy
aW91cyBkaXNjdXNzaW9uczoKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDEy
MzEyMjU0NS5HQTEyMjMzMUBwZXZpay8KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8y
MDI2MDEyODA3MjQ0NS5HQjEzNDk1QHBldmlrLwoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIK
Cj4gPiAgZG9jL2RldmVsb3BlcnMvZ3JvdW5kX3J1bGVzLnJzdCB8IDE3ICsrKysrKysrKysrKysr
KysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCj4gPiBkaWZmIC0tZ2l0
IGEvZG9jL2RldmVsb3BlcnMvZ3JvdW5kX3J1bGVzLnJzdAo+ID4gYi9kb2MvZGV2ZWxvcGVycy9n
cm91bmRfcnVsZXMucnN0Cj4gPiBpbmRleCAwNWU0NzNjYWQ1Li45MGZlN2E2NGVlIDEwMDY0NAo+
ID4gLS0tIGEvZG9jL2RldmVsb3BlcnMvZ3JvdW5kX3J1bGVzLnJzdAo+ID4gKysrIGIvZG9jL2Rl
dmVsb3BlcnMvZ3JvdW5kX3J1bGVzLnJzdAo+ID4gQEAgLTE3NCwzICsxNzQsMjAgQEAgVGhlc2Ug
cGF0Y2hlcyBzaG91bGQgYWxzbyBhZGQgYSBbU1RBR0lOR10ga2V5d29yZAo+ID4gaW50byB0aGUg
cGF0Y2ggc3ViamVjdCwgZS5nLgo+ID4gIEluIGEgY2FzZSB0aGF0IGEgdGVzdCBmb3IgdW5yZWxl
YXNlZCBrZXJuZWwgaXMgcmVhbGx5IG5lZWRlZCB0byBiZSBtZXJnZWQKPiA+IHdlIGRvCj4gPiAg
bm90IGFkZCBpdCB0byB0aGUgbGlzdCBvZiB0ZXN0IGV4ZWN1dGVkIGJ5IGRlZmF1bHQgYW5kIGtl
ZXAgaXQgaW4KPiA+ICA6bWFzdGVyOmBydW50ZXN0L3N0YWdpbmdgIGZpbGUgdW50aWwgdGhlIGtl
cm5lbCBjb2RlIGlzIGZpbmFsaXplZC4KPiA+ICsKPiA+ICtLZXJuZWwgZmVhdHVyZXMgY2hlY2sK
PiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICsKPiA+ICtXZSBwcmVmZXIgdG8gdXNlIDpj
OnR5cGU6YC5uZWVkc19rY29uZmlncyA8dHN0X3Rlc3Q+YCAoa2VybmVsIGtjb25maWcKPiA+IGNo
ZWNrKS4KPiA+ICtCdXQgZG8gKm5vdCogdXNlIGl0IHdoZW4gdGhlcmUgaXMgYW5vdGhlciB3YXkg
dG8gZGV0ZWN0IHRoZSBmdW5jdGlvbmFsaXR5Cj4gPiAoZS5nLgo+ID4gK3ZpYSBkZXRlY3Rpbmcg
ZnVuY3Rpb25hbGl0eSB2aWEgYGAvcHJvY3xzeXNgYCkgKmFuZCogYW55IG9mIHRoZXNlIHJ1bGVz
Cj4gPiBhcHBsaWVzOgoKCj4gUGVyaGFwcyByZXBsYWNlICJkZXRlY3QiIHdpdGggImltcGFjdCI/
CgoKCj4gPiArLSBLZXJuZWwgYWxsb3dzIHRvIGRpc2FibGUgZnVuY3Rpb25hbGl0eSB2aWEgYGtl
cm5lbOKAmXMgY29tbWFuZC1saW5lCj4gPiBwYXJhbWV0ZXIKPiA+ICsgIDwKPiA+IGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0
ZXJzLmh0bWwKPiA+ID5gXwo+ID4gKyAgKGl0IGNhbiBiZSBkaXNhYmxlZCBpbiBydW50aW1lKS4K
Cgo+IC0gUnVudGltZS1kaXNhYmxlIHBvc3NpYmxlOiBrZXJuZWwgZXhwb3NlcyBhIGNvbW1hbmQt
bGluZSBwYXJhbWV0ZXIKPiAgICAob3IgcnVudGltZSBrbm9iKSB0aGF0IGNhbiBlbmFibGUvZGlz
YWJsZSB0aGUgZnVuY3Rpb25hbGl0eSwgc28gYQo+IGJ1aWxkLXRpbWUKPiAgICBrY29uZmlnIGRv
ZXMgbm90IHJlZmxlY3QgcnVudGltZSBhdmFpbGFiaWxpdHkuCgo+ICstIEl0J3MgYSBjaGVjayBm
b3IgYSBmdW5jdGlvbmFsaXR5IHdoaWNoIGNhbiBiZSBjb21waWxlZCBhcyBtb2R1bGUKPiA+ICsg
IChgdHJpc3RhdGUKPiA+ICsgIDxodHRwczovL2RvY3Mua2VybmVsLm9yZy9rYnVpbGQva2NvbmZp
Zy1sYW5ndWFnZS5odG1sI21lbnUtYXR0cmlidXRlcwo+ID4gPmBfLAo+ID4gKyAgbW9kdWwgbWln
aHQgbm90IGJlIGF2YWlsYWJsZSkuCgoKPiAtIFRyaXN0YXRlL21vZHVsZSBmZWF0dXJlOiBUaGUg
ZnVuY3Rpb25hbGl0eSBpcyBjb250cm9sbGVkIGJ5IGEKPiAgICBgdHJpc3RhdGUgPAo+IGh0dHBz
Oi8vZG9jcy5rZXJuZWwub3JnL2tidWlsZC9rY29uZmlnLWxhbmd1YWdlLmh0bWwjbWVudS1hdHRy
aWJ1dGVzPmBfCj4gICAgIG9wdGlvbiAoaS5lLiBpdCBtYXkgYmUgYnVpbHQgYXMgYSBtb2R1bGUp
LCBhbmQgdGhlIG1vZHVsZSBtaWdodCBub3QgYmUKPiBwcmVzZW50Cj4gICAgIG9yIGxvYWRlZCBh
dCBydW50aW1lLgoKCj4gPiArLSBOZXcga2VybmVsIGZ1bmN0aW9uYWxpdHkgd2hpY2ggaXMgdW5s
aWtlbHkgdG8gYmUgYmFja3BvcnRlZCAodXNlCj4gPiArICA6Yzp0eXBlOmAubWluX2t2ZXIgPHRz
dF90ZXN0PmAgaW5zdGVhZCkuCgoKPiAtIE5ldyBub24tYmFja3BvcnRlZCBmdW5jdGlvbmFsaXR5
OiBUaGUgdGVzdCB0YXJnZXRzIGEgbmV3IHVwc3RyZWFtIGtlcm5lbAo+IGZlYXR1cmUKPiAgICB0
aGF0IGlzIHVubGlrZWx5IHRvIGJlIGJhY2twb3J0ZWQuIFByZWZlciA6Yzp0eXBlOmAubWluX2t2
ZXIgPHRzdF90ZXN0PmAKPiBmb3IgZ2F0aW5nCj4gICAgaW5zdGVhZCBvZiBLY29uZmlnIHN5bWJv
bHMuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
