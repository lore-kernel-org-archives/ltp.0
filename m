Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6849CCD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:43:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C64B23E6B36
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:43:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DCF43E2A2F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:42:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD93C1A00813
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:42:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35C0C768DF;
 Fri, 12 Jun 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781274007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWn7Vv6/Tw3NihiJljD+xfR7eQfqQwyfd4M+pRmsaqM=;
 b=NHa51gcO58UqjfpqRRIPqOmp2tIJudQ62f/55l9q88OsRS98BECX3D9B5ObGny/yy7C54z
 j4cAjsVJHSIUv8D3l0Xo/4Ji18mlWq5ZhpSj4ONV3R+Ja/OH2FIE2JC4hTHQ+cR1dyc+S/
 fag+/M+C4Yp7fpOS/dpcIchfPSXcshg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781274007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWn7Vv6/Tw3NihiJljD+xfR7eQfqQwyfd4M+pRmsaqM=;
 b=ctZQDaTkbpFQ9cQhACwhY8uqCggcUCNoxUAKqdUmRDN85jSmn1DGFXuGIVUiSee3TSD+sY
 of6Wzl2jacHd85Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NHa51gcO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ctZQDaTk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781274007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWn7Vv6/Tw3NihiJljD+xfR7eQfqQwyfd4M+pRmsaqM=;
 b=NHa51gcO58UqjfpqRRIPqOmp2tIJudQ62f/55l9q88OsRS98BECX3D9B5ObGny/yy7C54z
 j4cAjsVJHSIUv8D3l0Xo/4Ji18mlWq5ZhpSj4ONV3R+Ja/OH2FIE2JC4hTHQ+cR1dyc+S/
 fag+/M+C4Yp7fpOS/dpcIchfPSXcshg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781274007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWn7Vv6/Tw3NihiJljD+xfR7eQfqQwyfd4M+pRmsaqM=;
 b=ctZQDaTkbpFQ9cQhACwhY8uqCggcUCNoxUAKqdUmRDN85jSmn1DGFXuGIVUiSee3TSD+sY
 of6Wzl2jacHd85Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 234A4779A7;
 Fri, 12 Jun 2026 14:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UT15B5YVLGqiGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 14:20:06 +0000
Date: Fri, 12 Jun 2026 16:19:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <aiwVhuQXXE4XTRNb@yuki.lan>
References: <20260527092618.14824-1-mmenashe@redhat.com>
 <20260611073814.16334-1-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611073814.16334-1-mmenashe@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 35C0C768DF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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

SGkhCj4gRm9sbG93aW5nIHVwIG9uIHRoaXMgcGF0Y2ggc2VyaWVzICh2MTQpIHNlbnQgb24gTWF5
IDI3dGguIFRoZSBMVFAKPiBBSSBSZXZpZXdlciBoYXMgYXBwcm92ZWQgYWxsIGZvdXIgcGF0Y2hl
cyB3aXRoIG5vIGlzc3VlcyBmb3VuZCwgYW5kCj4gYWxsIHByZXZpb3VzIHJldmlldyBjb21tZW50
cyBoYXZlIGJlZW4gZnVsbHkgYWRkcmVzc2VkLgo+IAo+IEkgbm90aWNlZCBtYXN0ZXIgaGFzbid0
IGhhZCBtZXJnZXMgc2luY2UgTWF5IDEzdGgg4oCUIGlzIHRoZXJlIGEKPiBmcmVlemUgb3IgcXVp
ZXQgcGVyaW9kIEkgc2hvdWxkIGJlIGF3YXJlIG9mPyBIYXBweSB0byB3YWl0IGlmIHNvLAo+IGp1
c3Qgd2FudCB0byBtYWtlIHN1cmUgdGhlIHNlcmllcyBpc24ndCBsb3N0IGluIHRoZSBxdWV1ZS4K
ClNvcnJ5IGZvciBub3QgcmVwbHlpbmcgZWFybGllciwgd2Ugd2VyZSBtb3N0bHkgd29ya2luZyBv
biBNYXkgc3RhYmxlCnJlbGVhc2UgZHVyaW5nIE1heSwgaGVuY2Ugbm8gbmV3IGZlYXR1cmVzIHdl
cmUgcmV2aWV3ZWQgYW5kIGl0IHRvb2sgc29tZQp0aW1lIHRvIGdldCBiYWNrIHRvIHRoZSBiYWNr
bG9nIHRoYXQgYWNjdW11bGF0ZWQgZHVyaW5nIHRoZSByZWxlYXNlLgoKLS0gCkN5cmlsIEhydWJp
cwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
