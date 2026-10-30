Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C926606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wfVEu1F/;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uMqEflvD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNTf47L/;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0pXrQJap
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A7673E98D1
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 18:06:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BEF03D266C
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:06:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB9131401106
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:06:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BD6421EE8;
 Fri, 30 Oct 2026 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793379970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
 b=wfVEu1F/4Q+A+z9YUZ8gfuniR8dg1SOoY1owVSAJ6AsBuiSsLT+ce485VvP+l+oTOVwGII
 Lq19jSed3PRHe4IIlOpsoLqu3NAbt3Nhx9/ecM/CZaYAgTGnBESjzMYWz6AjUVPJy3k+5m
 somMCbn02IvccJz8yq0b526W/Bjl4/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793379970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
 b=uMqEflvDiFMf1hXSwxeJ8Afk+RRC4cu5U7ySUCq5F5kCdst88Iq/u0yeGyv8wH6cQT2ea3
 ucIg0fU+bWG6QDBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793379969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
 b=LNTf47L/AigGMo9WAknmSL1JK1RxkOfqDNPxCzGI2Wg/UxkXrTGBn/en2ir67gJeH8RTHw
 SZ0YHdQhMF3jxjSWIk9j9pnSENXuct3PA9Gz8Fcb6rpr4AZHFCGYFjS/K+wMaQM+0qhZcP
 7EJacowjxLxQUimYlFu4f7N6ZwKlY8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793379969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
 b=0pXrQJapwKkl+QEc97GvDsSCyeSztgPm80a+2wuOPkOrkRw5bBD33a9SMtzryFRj4l83DZ
 +pgXAtMVxq7wPXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17CC13625;
 Fri, 30 Oct 2026 17:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EFecIYDO5GrJPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 17:06:08 +0000
Date: Fri, 30 Oct 2026 18:06:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261030170603.GA31132@pevik>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-16.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz,lists.linux.it];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.cz:replyto]
X-Spam-Score: -16.50
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>,
 jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIE9jdCAyOSwgMjAyNiBhdCAxMDowN+KAr1BNIEh1bmd5dSBMaW4gPGRlbm55bGlu
MDcwN0BnbWFpbC5jb20+IHdyb3RlOgoKPiA+IFF1ZXVlIGFuIHVucGFpcmVkIElOX01PVkVEX0ZS
T00gZXZlbnQsIGZvbGxvd2VkIGJ5IGFuIElOX01PVkVEX0ZST00gYW5kCj4gPiBJTl9NT1ZFRF9U
TyBwYWlyIHdpdGggdGhlIHNhbWUgc291cmNlIHdhdGNoIGRlc2NyaXB0b3IgYW5kIG5hbWUgYXMg
dGhlCj4gPiBmaXJzdCBldmVudC4gV2F0Y2ggb25seSBJTl9NT1ZFIHNvIGNyZWF0aW9uIG9mIHRo
ZSByZXBsYWNlbWVudCBlbnRyeQo+ID4gZG9lcyBub3Qgc2VwYXJhdGUgdGhlIHR3byBJTl9NT1ZF
RF9GUk9NIGV2ZW50cyBpbiB0aGUgcXVldWUuCgo+ID4gQWZmZWN0ZWQga2VybmVscyBjb2FsZXNj
ZSB0aGUgc2Vjb25kIElOX01PVkVEX0ZST00gaW50byB0aGUgZmlyc3QsCj4gPiBsZWF2aW5nIHRo
ZSBJTl9NT1ZFRF9UTyBjb29raWUgd2l0aG91dCBhIG1hdGNoaW5nIElOX01PVkVEX0ZST00gY29v
a2llLgo+ID4gQ2hlY2sgdGhhdCBhbGwgdGhyZWUgZXZlbnRzIGFyZSByZXRhaW5lZCwgdGhlIHR3
byBtb3ZlcyBoYXZlIGRpc3RpbmN0Cj4gPiBjb29raWVzLCBhbmQgdGhlIHNlY29uZCBJTl9NT1ZF
RF9GUk9NIG1hdGNoZXMgdGhlIElOX01PVkVEX1RPIGNvb2tpZS4KPiA+IENvdmVyIGJvdGggcmVn
dWxhciBmaWxlcyBhbmQgZGlyZWN0b3JpZXMuCgo+ID4gU3VnZ2VzdGVkLWJ5OiBBbWlyIEdvbGRz
dGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogSHVuZ3l1IExpbiA8
ZGVubnlsaW4wNzA3QGdtYWlsLmNvbT4KCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGllbmNlIHdp
dGggbXkgcmV2aWV3Cgo+IFJldmlld2VkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21h
aWwuY29tPgoKVGhhbmsgeW91IQoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PgoKSSBoYXZlIG5vIHByb2JsZW0gdG8gZml4IHZlcnkgbWlub3IgaXNzdWVzIHJlcG9ydGVk
IGJ5IGFnZW50IGJlZm9yZSBtZXJnZSwKYnV0IHdoYXQgYm90aGVycyBtZSB0aGVyZSBpcyBubyBr
ZXJuZWwgZml4IGZvciB0aGUgZmFpbHVyZS4gIElmIEknbSBub3QKbWlzdGFrZW4sIHRoZSBmaXgg
aW4ga2VybmVsIFsxXSB3YXMgcmV2aWV3ZWQgWzJdIGJ1dCBub3QgeWV0IG1lcmdlZCAoSSBsb29r
ZWQgdG8KbmV4dCB0cmVlIGFzIHdlbGwpLgpUaGVyZSBhcmUgb3RoZXIgZml4ZXMgZm9yIDYzYzg4
MmEwNTQxNiAoImlub3RpZnk6IHJlaW1wbGVtZW50IGlub3RpZnkgdXNpbmcKZnNub3RpZnkiKSBp
biBzdGFibGUsIGUuZy4gZTQyMjc3N2ZkZDQ3NCAoImZzbm90aWZ5OiBGaXggc3RhbGUgb2JqZWN0
IG1hc2sgYWZ0ZXIKY29uY3VycmVudCBtYXJrIHVwZGF0ZXMiKSwgYnV0IEkgaGF2ZW4ndCBmb3Vu
ZCB0aGlzIG9uZS4KCk1lcmdpbmcgdGVzdCBoZWxwcyBrZXJuZWwgZGV2ZWxvcGVycyB0byB0ZXN0
IGlmIHRoZSBwcm9ibGVtIHdhcyBmaXhlZCBidXQgYnJlYWsKZm9yIGl0IGZvciBhbnlib2R5IHdo
byB1c2VzIG1hc3RlciBmb3IgcmVndWxhciB0ZXN0aW5nIHdpdGhvdXQgZXZlbiBleHBsYWluaW5n
CmZpeCBpcyBXSVAuIEJ1dCBJIHN1cHBvc2UgaXQgd2lsbCBiZSBwcm9jZXNzZWQgc29vbiBiZWNh
dXNlIHN0YWJsZSB3YXMgaW4gQ2MsCnJpZ2h0PwoKV2UgaGF2ZSBydW50ZXN0L3N0YWdpbmcsIGJ1
dCB0aGF0J3MgZm9yIG5ldyBmdW5jdGlvbmFsaXR5LCBub3QgZm9yIHRlc3RzIHdoaWNoCnJlcHJv
ZHVjZSBwcm9ibGVtIHdoaWNoIHdhcyBub3QgZml4ZWQuCgpASmFuIEBBbWlyIGlzIHRoZXJlIGEg
Z2l0IGtlcm5lbCB0cmVlIGZvciBmYW5vdGlmeSBhbmQgaW5vdGlmeT8gSSBmb3VuZCBvbmx5ClZG
Uy4gSWYgeWVzLCBwbGVhc2UgdXBkYXRlIE1BSU5UQUlORVJTIGZpbGUuCgpLaW5kIHJlZ2FyZHMs
ClBldHIKClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYxMDI3MTkyMDI3Ljg2
MTctMS1kZW5ueWxpbjA3MDdAZ21haWwuY29tLwpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9DQU9RNHV4ajNldF9jeXpEMWlXSHIzX3oxZEgxUjNXUU1DT20ra08yUTkwVFhqYVY5cFFA
bWFpbC5nbWFpbC5jb20vClszXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9vdmVybGF5ZnMvdmZzLmdpdC8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
