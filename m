Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9C606A31B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wRd00kpk;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bJPZejz2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XmNxUKbi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JsHj2Fyi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6F293CFC45
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 13:28:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC92A3C01B1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 13:27:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 470D26002C9
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 13:27:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14F8C21DEF;
 Wed, 21 Oct 2026 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792582064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdMCEo7w+O0K3Z+VZ404X73mFVOMGYFAI16bJ/GSoTw=;
 b=wRd00kpktEymdRpoksQRhlpbSEiMMSf2VtGhON0Z/t5eBsX80a201I9fbDPKZew7a0kjBd
 W4aOhCa3DDo5UkkdQc2lLCzWMNf8h3pA0QJH5W+kJLbVSQR0IA49yy+92oGyv1oqSKcUwi
 OZmSm0HYX7spGVIHLo8tazloxqDuH3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792582064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdMCEo7w+O0K3Z+VZ404X73mFVOMGYFAI16bJ/GSoTw=;
 b=bJPZejz2RAxLghQZoY8Qb0q3Gli4rzNxq0m6OYOwWRJQadWDapjzm4XRa44zPEMTD4zb51
 vfVf1WRRx1nO49Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792582063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdMCEo7w+O0K3Z+VZ404X73mFVOMGYFAI16bJ/GSoTw=;
 b=XmNxUKbiVoebwn+9rkgebpN/n/LzacjlNf2JvSTfqd0M4LPqvEmbhVjGefroRJ1qcgmvD5
 7436tAthbDS2AzSbm+XPGKtHhD6k0i0TgN7RYqrOx/pi0P2/Xhx8f9JmrFoB7K1y8CVCjA
 WKaVaPGu4uXTk5Ao5KUwEQ0pHbfLW2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792582063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdMCEo7w+O0K3Z+VZ404X73mFVOMGYFAI16bJ/GSoTw=;
 b=JsHj2Fyia0IorNGgpetSATFvP9+EbP1GWU92HHP0bVpDZ1nkfY7gHA4gT+iZOZ9lAT0Dyz
 iV0U7O4oLZwZj5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C069D1351D;
 Wed, 21 Oct 2026 11:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R8+UJ66h2Gp7EwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Oct 2026 11:27:42 +0000
Date: Wed, 21 Oct 2026 13:27:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Li Wang (Hieco)" <li.wang@linux.dev>
Message-ID: <atihuztAXCPk1kGr@yuki.lan>
References: <20261021031816.166499-1-li.wang@linux.dev>
 <20261021031816.166499-2-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021031816.166499-2-li.wang@linux.dev>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] sys_hwmon01: always report a result
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>     v2:
>         - rename attr_exists() to sysfs_attr_exists() (Xiaochen)
>         - flatten the final result reporting with an early return (Xiaochen)
>         - fix a preexisting off-by-one in the inN channel loop (Xiaochen)

It's very minor however unrelated fixes should be ideally done in a
separate patches.

Feel free to push with my Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
with the off-by-one split into separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
