Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A36C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 09:27:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C29353D0DCB
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 11:27:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 849453CFDB0
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 11:27:08 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B766F10189A7
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 11:27:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD2B121A74;
 Wed, 19 Jun 2024 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718789225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnY139mg326fPxiRWNfnz0rEYxxTnVsyhJ1cCmPnOQ=;
 b=MchVHdHASnK5m/vWgDck0xyX0Rn3O46e1UsnfMfEdju8QUWsIro984hNw9yXh60lq15gxr
 lTRwNb+9m8Fp0/MeZMXXhYGnXtGoUTXromhdW55+bupB/cCWqom0HZtAa/Y04QI00izUIx
 PxS7KHzYHVPyB72cjzGRD8McQbEr3RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718789225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnY139mg326fPxiRWNfnz0rEYxxTnVsyhJ1cCmPnOQ=;
 b=/u/K1ewI1F/LN1GqfCFtsXY+mTHohho+WORo8yJ4WPhmlSHdGfkHZEedeONowSTi+3ZwnR
 sxvjRPjY8C2sCDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718789225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnY139mg326fPxiRWNfnz0rEYxxTnVsyhJ1cCmPnOQ=;
 b=MchVHdHASnK5m/vWgDck0xyX0Rn3O46e1UsnfMfEdju8QUWsIro984hNw9yXh60lq15gxr
 lTRwNb+9m8Fp0/MeZMXXhYGnXtGoUTXromhdW55+bupB/cCWqom0HZtAa/Y04QI00izUIx
 PxS7KHzYHVPyB72cjzGRD8McQbEr3RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718789225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnY139mg326fPxiRWNfnz0rEYxxTnVsyhJ1cCmPnOQ=;
 b=/u/K1ewI1F/LN1GqfCFtsXY+mTHohho+WORo8yJ4WPhmlSHdGfkHZEedeONowSTi+3ZwnR
 sxvjRPjY8C2sCDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB9F413ABD;
 Wed, 19 Jun 2024 09:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tfOzK2mkcmZLLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 09:27:05 +0000
Date: Wed, 19 Jun 2024 11:27:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240619092704.GA428912@pevik>
References: <20240617053436.301336-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240617053436.301336-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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

SGkgTGksCgo+IFRoZXNlIGNoYW5nZXMgaGVscCBlbnN1cmUgdGhhdCB0aGUgbmVjZXNzYXJ5IGZl
YXR1cmVzIGFuZCBkZWZpbml0aW9ucwo+IGFyZSBhdmFpbGFibGUgZHVyaW5nIHRoZSBjb25maWd1
cmF0aW9uIHByb2Nlc3MsIHByZXZlbnRpbmcgcG90ZW50aWFsCj4gaXNzdWVzIHJlbGF0ZWQgdG8g
bWlzc2luZyBvciBpbmNvbXBhdGlibGUgZGVmaW5pdGlvbnMuIFRoaXMgc2hvdWxkCj4gcmVzb2x2
ZSB0aGUgY29tcGlsYXRpb24gZXJyb3IgcmVsYXRlZCB0byBzdHJ1Y3QgZnNfcXVvdGFfc3RhdHY6
Cgo+ICAvdXNyL2luY2x1ZGUveGZzL3hxbS5oOjE2Nzo4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9m
IOKAmHN0cnVjdCBmc19xZmlsZXN0YXR24oCZCgpJIHdvbmRlciBob3cgX0dOVV9TT1VSQ0UgaW5m
bHVlbmNlcyBhbnkgWEZTIGhlYWRlcj8KSSBoYXZlbid0IGZvdW5kIGFueXRoaW5nIGluICg8eGZz
LyouaD4pIG9yIGluIDxzeXMvcXVvdGEuaD4KSSBrbm93IHRoYXQgc29tZSBxdW90YWN0bDBbMjNd
LmMgZGVmaW5lIF9HTlVfU09VUkNFLCBidXQgaXQncyBpbnRlcmVzdGluZyB0aGF0CnRoaXMgaW5m
bHVlbmNlIHRoZSBoZWFkZXIuIEFsc28sIHdoaWNoIFJIRUwgKG9yIHdoYXRldmVyIGRpc3Rybykg
dmVyc2lvbiBoYXMKdGhpcyBwcm9ibGVtPwoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
