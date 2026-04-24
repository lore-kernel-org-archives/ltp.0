Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81503FE51FF
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:18:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2215C3E534C
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:18:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36A823E15D7
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:18:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8C6E600A7E
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:18:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 611436A836;
 Fri, 24 Apr 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777025911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt/7eaM4nVTO4W85gpsM88s28i7Wz+s5RH8DUF5qV+o=;
 b=G2bBiiPZKiSAGpSp3FrmyYY9o85DphqVRuTsW27XijTMdP1+8k5nBeC1wW75QD3U5lWycl
 CjdbNd26mgwjiMXv/Rg4nwToRexJrH4SeWvmV6AXozFH5CCru8/jHsE2+UsAvDJVVKo1di
 NAtptqJq7x2VUXq9G5MLUefukdfMJvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777025911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt/7eaM4nVTO4W85gpsM88s28i7Wz+s5RH8DUF5qV+o=;
 b=0pPDmzLyh+j7mrZF6Pf/zJZa9PURskGcmh30qCSvCehO7U49EEe7AbozHAzhlcwEZTDdSK
 OXigWdtrx0gfkHBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G2bBiiPZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0pPDmzLy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777025911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt/7eaM4nVTO4W85gpsM88s28i7Wz+s5RH8DUF5qV+o=;
 b=G2bBiiPZKiSAGpSp3FrmyYY9o85DphqVRuTsW27XijTMdP1+8k5nBeC1wW75QD3U5lWycl
 CjdbNd26mgwjiMXv/Rg4nwToRexJrH4SeWvmV6AXozFH5CCru8/jHsE2+UsAvDJVVKo1di
 NAtptqJq7x2VUXq9G5MLUefukdfMJvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777025911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt/7eaM4nVTO4W85gpsM88s28i7Wz+s5RH8DUF5qV+o=;
 b=0pPDmzLyh+j7mrZF6Pf/zJZa9PURskGcmh30qCSvCehO7U49EEe7AbozHAzhlcwEZTDdSK
 OXigWdtrx0gfkHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2864A593A4;
 Fri, 24 Apr 2026 10:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8GB4CHdD62kgdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 10:18:31 +0000
Date: Fri, 24 Apr 2026 12:18:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260424101825.GB505126@pevik>
References: <20260422113136.416482-1-pvorel@suse.cz>
 <CAASaF6zL2QTXBCCLkWTOt6nE4ywpJd3n8vqP2Tt_jnSy+LKa-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zL2QTXBCCLkWTOt6nE4ywpJd3n8vqP2Tt_jnSy+LKa-A@mail.gmail.com>
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,redhat.com,suse.cz,gmail.com,suse.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 611436A836
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: Remove 'make install' support
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
Cc: Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIEFwciAyMiwgMjAyNiBhdCAxOjMx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IExUUCBoZWFkZXJzIGFyZW4ndCBuZWVkZWQgdG8gYmUgaW5zdGFs
bGVkLCB0aGV5IGFyZSB1bnVzYWJsZSB3aXRob3V0IExUUAo+ID4gY29yZSBsaWJyYXJ5IGFueXdh
eSAod2hpY2ggaXMgbm90IHNlcGFyYXRlZCBmcm9tIHNvdXJjZXMpLiBUaGVyZWZvcmUKPiA+IG5l
d2x5IGFkZGVkIE1ha2VmaWxlIGZvciAnbWFrZSBjaGVjaycgaW4gNjg0Y2FlNzU1MiAoImluY2x1
ZGUvbGFwaTogYWRkCj4gPiBsZWFmIE1ha2VmaWxlIikgZGlkIG5vdCBzdXBwb3J0IGl0LiBSZW1v
dmUgaXQgYWxzbyBmcm9tCj4gPiBpbmNsdWRlL01ha2VmaWxlLgoKPiA+IFNpZ25lZC1vZmYtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiBBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpz
dGFuY2VrQHJlZGhhdC5jb20+CgpKYW4sIHRoYW5rcyBmb3IgeW91ciBhY2suIEkgbWVyZ2VkIHBh
dGNoIHllc3RlcmRheSwgSSdtIHNvcnJ5LCB1bmZvcnR1bmF0ZWx5IEkKZm9yZ290IHRvIHdyaXRl
IHRoYXQgb24gTUwuIE5leHQgdGltZSBJJ2xsIHdhaXQgYSBiaXQgbG9uZ2VyIGFuZCB2ZXJpZnkg
dGhhdCBJCnJlcGxpZWQgdGhhdCBwYXRjaCB3YXMgbWVyZ2VkIChpdCdkIGJlIGdyZWF0IHRvIGhh
dmUgdG9vbGluZyB0byBwb3N0IGluZm8gYWJvdXQKbWVyZ2luZykuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
