Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4B1F531F1
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 07:30:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 618D83E26A0
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 09:30:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 762BF3C6334
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:30:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BCD8F10005A0
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:30:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 254D05BDB5;
 Tue, 14 Apr 2026 07:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776151812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
 b=vO9aFAS3JrZqzqhwLzuysdrEi3nzu67BiK7OHpbPoeYJSQSC1AyvqO2Dqt83GymQybvANV
 PSyRWrDeuvPqa/vtam93eG3oJ8j7YwFTJjqROSBh9GufWQwdnDTVqfiS1KbQjTuEx/Jx+K
 jIY2QdAvxbL87SSVt4VOcsHxbQO4VCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776151812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
 b=R4WbjvE+qtSOdfIkDV0P8vGgMAVpLuFFNimEANwsesdPZq7uNtO3wJomXFPSau2tZcaqte
 piriBTRytzJ/F9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776151812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
 b=vO9aFAS3JrZqzqhwLzuysdrEi3nzu67BiK7OHpbPoeYJSQSC1AyvqO2Dqt83GymQybvANV
 PSyRWrDeuvPqa/vtam93eG3oJ8j7YwFTJjqROSBh9GufWQwdnDTVqfiS1KbQjTuEx/Jx+K
 jIY2QdAvxbL87SSVt4VOcsHxbQO4VCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776151812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nljOM/O1kIK+0e+n0gw6fJtlQl6wZ38dkY60SNCfVB8=;
 b=R4WbjvE+qtSOdfIkDV0P8vGgMAVpLuFFNimEANwsesdPZq7uNtO3wJomXFPSau2tZcaqte
 piriBTRytzJ/F9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7B7C4B317;
 Tue, 14 Apr 2026 07:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v42tNwPt3WmiVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Apr 2026 07:30:11 +0000
Date: Tue, 14 Apr 2026 09:30:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20260414073010.GB230573@pevik>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik> <20260412141439.GD21470@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260412141439.GD21470@unreal>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.de,lists.linux.it,gmail.com,redhat.com,ziepe.ca,vger.kernel.org,oss.oracle.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
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
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
 Eric Biggers <ebiggers3@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGVvbiwgYWxsLAoKPiBPbiBUdWUsIEFwciAwNywgMjAyNiBhdCAwMzoyNDoyNlBNICswMjAw
LCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gSGkgQW5kcmVhLAoKPiA+IGl0J3MgYmVlbiBsb25nIHRp
bWUgc2luY2UgdGhpcyB1c2UtYWZ0ZXItZnJlZSB3YXMgZml4ZWQsIGJ1dCBJTUhPIHN0aWxsIHVz
ZWZ1bAo+ID4gdG8gaGF2ZSBhIHRlc3QgKGl0J3MgYWxzbyBraW5kIG9mIHNtb2tlIHRlc3QgZm9y
IHJkbWFfY20pLgo+ID4gQW55d2F5LCBMR1RNLCBidXQgaXQnZCBiZSBuaWNlIHRvIHJlcHJvZHVj
ZSB0aGUgYnVnLgoKPiA+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
Cj4gPiA+IFRlc3QgZm9yIHVzZS1hZnRlci1mcmVlIGluIFJETUEgVUNNQSB0cmlnZ2VyZWQgYnkg
cmFjaW5nIENSRUFURV9JRCwKPiA+ID4gQklORF9JUCwgYW5kIExJU1RFTiBvcGVyYXRpb25zLiBU
aHJlZSB0aHJlYWRzIGNvbmN1cnJlbnRseSBpc3N1ZQo+ID4gPiB0aGVzZSBjb21tYW5kcyB0byAv
ZGV2L2luZmluaWJhbmQvcmRtYV9jbSBhbmQgdGhlIHRlc3QgY2hlY2tzIGZvcgo+ID4gPiBrZXJu
ZWwgdGFpbnQgKEtBU0FOIHVzZS1hZnRlci1mcmVlIGRldGVjdGlvbikuCgo+ID4gPiBUaGUgYnVn
IHdhcyBmaXhlZCBieSBrZXJuZWwgY29tbWl0IDVmZTIzZjI2MmUwNQo+ID4gPiAoInVjbWE6IGZp
eCBhIHVzZS1hZnRlci1mcmVlIGluIHVjbWFfcmVzb2x2ZV9pcCgpIikuCgo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+ID4g
PiAtLS0KPiA+ID4gIHJ1bnRlc3Qva2VybmVsX21pc2MgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKwo+ID4gPiAgdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9NYWtl
ZmlsZSAgICAgICAgICB8ICAgMSArCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2
ZXJzL3JkbWEvLmdpdGlnbm9yZSAgIHwgICAxICsKPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvZGV2
aWNlLWRyaXZlcnMvcmRtYS9NYWtlZmlsZSAgICAgfCAgIDcgKwo+ID4gPiAgdGVzdGNhc2VzL2tl
cm5lbC9kZXZpY2UtZHJpdmVycy9yZG1hL3VjbWFfdWFmMDEuYyB8IDIwOCArKysrKysrKysrKysr
KysrKysrKysrCj4gPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRpb25zKCspCgo+IDwu
Li4+Cgo+ID4gPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiArCS50ZXN0
X2FsbCA9IHJ1biwKPiA+ID4gKwkuc2V0dXAgPSBzZXR1cCwKPiA+ID4gKwkuY2xlYW51cCA9IGNs
ZWFudXAsCj4gPiA+ICsJLnJ1bnRpbWUgPSAzMDAsCj4gPiA+ICsJLm5lZWRzX3Jvb3QgPSAxLAo+
ID4gPiArCS50YWludF9jaGVjayA9IFRTVF9UQUlOVF9XIHwgVFNUX1RBSU5UX0QsCj4gPiA+ICsJ
Lm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gPiA+ICsJCSJDT05GSUdfSU5G
SU5JQkFORCIsCj4gPiA+ICsJCSJDT05GSUdfSU5GSU5JQkFORF9VU0VSX0FDQ0VTUyIsCgo+IEni
gJltIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBMVFAgdGVzdHMsIGJ1dCBJIHdhbnRlZCB0byBwb2lu
dCBvdXQgdGhhdCB0aGVzZQo+IGNvbmZpZyBvcHRpb25zIGFyZSBpbnN1ZmZpY2llbnQuIFlvdSBu
ZWVkIGFuIGFjdHVhbCBvciB2aXJ0dWFsIFJETUEgZGV2aWNlCj4gY29ubmVjdGVkIHRvIHJkbWEt
Y20gZm9yIHRoZSB0ZXN0cyB0byB3b3JrIGNvcnJlY3RseS4KCkxlb24sIHRoYW5rcyBmb3IgbG9v
a2luZyBpbnRvIGl0LiBGWUkgdGhlc2UgYXJlIGp1c3QgY29uZmlnIG9wdGlvbnMgdG8gc2tpcApr
ZXJuZWxzIHdpdGhvdXQgcmVxdWlyZWQga2VybmVsIG1vZHVsZXMuIAoKU28gdXNpbmcgL2Rldi9p
bmZpbmliYW5kL3JkbWFfY20gKHZpYSBSRE1BX0NNX0RFVikgaXMgbm90IGVub3VnaCwgd2UgbmVl
ZAphbm90aGVyIGRldmljZT8KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
