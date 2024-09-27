Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42CCCEBF9A
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:35:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CEE53C4FCF
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 13:35:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C237F3C4E4C
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 13:34:52 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C53D1400F8E
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 13:34:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E61F81FDA3;
 Fri, 27 Sep 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727436890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8lWYkRf2KhnSGOKhfyrjW2WPMj3Bf3E20POmrAwJKU=;
 b=Tr0H8/ar/b5pLZv1BZdNpPZ40gcbcTmMxgysDrte2umZMy3RU06ER1jywQieMq08B67G3Z
 deLm5+66AW08OcMPwomArC/0Q2bbp2Rk+IU8dvuSBOCf/XfCLjpeQV21vsrFgr8Dsox7+w
 gEuSN3Tw/vY3EgBQZVZ/nBR508nk1Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727436890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8lWYkRf2KhnSGOKhfyrjW2WPMj3Bf3E20POmrAwJKU=;
 b=PnjZrX1L+/B3toCx0iX7+VpHLPrwV/Y89mkQ2UN4uOmR6FJJqCs7EA1hXZ0JNjWbdJht3L
 7SfsI3eK3rLQfvBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YHd+wDNM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KmSLnvqA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727436889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8lWYkRf2KhnSGOKhfyrjW2WPMj3Bf3E20POmrAwJKU=;
 b=YHd+wDNMF4rZq1RzlPmwPCzGGmWV92+E/YvAKVz3OcCnczLXGWi9XQoc4HQDV6F10pMk4N
 nidmg7nmaonWgNRVIIav6KprZLnpwl2oCQ1DcYwI3Z9+aXNbSN5A3aq7zEo5Ur5d6pf+Hz
 DojCFyG1HKKlv6XUT+75l6R5x9CpcWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727436889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8lWYkRf2KhnSGOKhfyrjW2WPMj3Bf3E20POmrAwJKU=;
 b=KmSLnvqAKDwMvib1JGskYzAh+GvSkvt9oCNkhvT8QCVNR3b60oaZ4Y19fV+yjZBNjDpEt+
 7340Dhk2+4kFlyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE26D13A73;
 Fri, 27 Sep 2024 11:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K1r5NVmY9mbCbgAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 27 Sep 2024 11:34:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Sep 2024 13:34:45 +0200
Message-ID: <4942786.OV4Wx5bFTl@localhost>
In-Reply-To: <20240927100135.12271-1-chrubis@suse.cz>
References: <20240927100135.12271-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E61F81FDA3
X-Spamd-Result: default: False [-6.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] realtime: Install run.sh script
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAyNCAxMjowMTozNeKAr1BNIEdNVCsyIEN5
cmlsIEhydWJpcyB3cm90ZToKPiBUaGUgUkVBRE1FIGRlc2NyaWJlcyBob3cgdG8gcnVuIHRoZSB0
ZXN0Y2FzZXMgdXNpbmcgdGhlIHJ1bi5zaCBzY3JpcHQKPiBidXQgdGhlIHJ1bi5zaCBzY3JpcHQg
d2FzIG5vdCBpbnN0YWxsZWQgYXQgYWxsLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6PgoKUmV2aWV3ZWQtYnk6IEF2aW5lc2ggS3VtYXIgPGFrdW1hckBz
dXNlLmRlPgoKPiAtLS0KPiAgdGVzdGNhc2VzL3JlYWx0aW1lL01ha2VmaWxlIHwgMyArKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMvcmVhbHRpbWUvTWFrZWZpbGUgYi90ZXN0Y2FzZXMvcmVhbHRpbWUvTWFrZWZpbGUKPiBpbmRl
eCBiOTBlY2Y4YzQuLjRkNzgzYjAxZCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvcmVhbHRpbWUv
TWFrZWZpbGUKPiArKysgYi90ZXN0Y2FzZXMvcmVhbHRpbWUvTWFrZWZpbGUKPiBAQCAtMjgsNiAr
MjgsOSBAQCBMSUJESVIJCQk6PSBsaWIKPiAgRklMVEVSX09VVF9ESVJTCQk6PSAkKExJQkRJUikK
PiAgTElCCQkJOj0gJChMSUJESVIpL2xpYnJlYWx0aW1lLmEKPiAgCj4gK0lOU1RBTExfRElSICAg
ICAgICAgICAgIDo9ICQoc3JjZGlyKQo+ICtJTlNUQUxMX1RBUkdFVFMgICAgICAgICA6PSBydW4u
c2gKPiArCj4gICQoTElCRElSKToKPiAgCW1rZGlyIC1wICIkQCIKPiAgCj4gCgoKCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
