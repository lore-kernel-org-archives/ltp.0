Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2C3C2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 15:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049D33D10B3
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 17:11:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C7453D0099
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 17:11:28 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1EA911A00EC0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 17:11:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAC2721A85;
 Tue, 25 Jun 2024 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719328287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+z22VEv8BFaSz7irKOTTa1P0QJC53tw04Wbo+4/J9Y=;
 b=xyDLTrrXRbAjx1zwH6bylIFy1LgBWWZnsvmhfZsId56Nv79sP7tmEQsMVjyH7o4DXGx6Vg
 eJHxItxbqfOHL1Kui+q5B2Af4ZZGLqIbjjo+wnxpPnCob/Ra6sstOHIS71r+6gBudVJxy/
 /CRpAY1vKlQDa5coX3aCX8MUKQB15Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719328287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+z22VEv8BFaSz7irKOTTa1P0QJC53tw04Wbo+4/J9Y=;
 b=dEaPoTQx+/Sr2DrGll8EkrB9i37/nda+g83q21sbbxEu5EkP8auNHddA/ihnxa0UJeeP7Y
 myIa1pD1fJR31EAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CHye6e1c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6ensjemh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719328286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+z22VEv8BFaSz7irKOTTa1P0QJC53tw04Wbo+4/J9Y=;
 b=CHye6e1cRWOGFMPE9N/0opvllQBfFHNtzSz3BnKLMK46Spiy+w8mgMM1N1VWN0SI3dbOBn
 GOrw+I3JCi/pb3AubogRkN4GZMVlLjQoJDveHHt6e9GgwvCwKJ/hB2O1wMzmRhBddLsnJi
 Us9RqNFRD5JqxJBtFCyIQM/gk3jvOv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719328286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+z22VEv8BFaSz7irKOTTa1P0QJC53tw04Wbo+4/J9Y=;
 b=6ensjemhlf3oapxjCrx+5+Mf0rupvB02UdtXM5GcHN1ND2Wa7ECfV03RbvMGXYzerDdnza
 52O5gYu8yDcmFOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB2011384C;
 Tue, 25 Jun 2024 15:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pcSqNB7eemY+OgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 25 Jun 2024 15:11:26 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jun 2024 17:11:26 +0200
Message-ID: <4884009.OV4Wx5bFTl@localhost>
Organization: SUSE
In-Reply-To: <20240621105957.671338-3-pvorel@suse.cz>
References: <20240621105957.671338-1-pvorel@suse.cz>
 <20240621105957.671338-3-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EAC2721A85
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] lib: Create tst_tmpdir.h
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

SGkgUGV0ciwKCi4uLgo+IGRpZmYgLS1naXQgYS9saWIvdHN0X3RtcGRpci5jIGIvbGliL3RzdF90
bXBkaXIuYwo+IGluZGV4IGJjYzc4ODM5MC4uMGYxYjE1Y2E0IDEwMDY0NAo+IC0tLSBhL2xpYi90
c3RfdG1wZGlyLmMKPiArKysgYi9saWIvdHN0X3RtcGRpci5jCj4gQEAgLTcyLDYgKzcyLDcgQEAK
PiAgCj4gICNpbmNsdWRlICJ0ZXN0LmgiCj4gICNpbmNsdWRlICJzYWZlX21hY3Jvcy5oIgo+ICsj
aW5jbHVkZSAidHN0X3RtcGRpci5oIgo+ICAjaW5jbHVkZSAibHRwX3ByaXYuaCIKPiAgI2luY2x1
ZGUgImxhcGkvZnV0ZXguaCIKPiAgCgpJIHRoaW5rIHdlIGFsc28gbmVlZCB0byBpbmNsdWRlIHRz
dF90bXBkaXIuaCBpbiB0c3RfdGVzdC5oLCBlbHNlIHdlIGFyZQppbnRyb2R1Y2luZyBpbXBsaWNp
dCBkZWNsYXJhdGlvbiB3YXJuaW5nIGluIGFsbCB0ZXN0cyB3aGVyZSB3ZSB1c2UKdHN0X3B1cmdl
X2RpcigpIGZ1bmN0aW9uLgplLmcuIGNyZWF0MDguYwoKY3JlYXQwOC5jOiBJbiBmdW5jdGlvbiDi
gJhydW7igJk6CmNyZWF0MDguYzoxMjg6OTogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24g4oCYdHN0X3B1cmdlX2RpcuKAmSBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0KICAxMjggfCAgICAgICAgIHRzdF9wdXJnZV9kaXIodG1wZGlyKTsKICAgICAgfCAg
ICAgICAgIF5+fn5+fn5+fn5+fn4KQ0MgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jcmVhdC9j
cmVhdDA4Cgo+IAoKClJlZ2FyZHMsCkF2aW5lc2gKCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
