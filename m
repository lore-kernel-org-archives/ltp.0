Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4713AC433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:43:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4EA3C6DEC
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 12:42:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A90513C5DF0
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 12:42:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3E951000459
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 12:42:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDD262170C;
 Tue, 30 Nov 2021 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638272566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Swp/3Ef0VmirR1pqyP+XE6PbUi02zdEgkHkaSU2E5zo=;
 b=Lg/6J6QEZ6CmG8mh/4Od0F4yYj51K3VF24hsKUU0JHoNzO2/pDBb6fX8OMI2lu5Zrbmnp6
 LoBurV1bLvL4eGrE/5/t8fjJylBgNtd9nxtCvPVYnIfXUpoKFxQApqHBQU+8yiG9s/77c8
 NYD90gjxCcNWnxhJtF5HB2xsJjiRYlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638272566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Swp/3Ef0VmirR1pqyP+XE6PbUi02zdEgkHkaSU2E5zo=;
 b=qieqPJDEl3ka7Xm8wGHbVLclabFaq/pazxXlVhPuzu3pTTIcfS00tEqjZb7ha4I69YUKhq
 cwxUEDVU3sRRs0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAEB613C98;
 Tue, 30 Nov 2021 11:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ir/3LzYOpmHRXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 11:42:46 +0000
Date: Tue, 30 Nov 2021 12:43:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YaYOfg9kEw2JFRX+@yuki>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-2-rpalethorpe@suse.com>
 <YZ3l+QtJA+/RCp6v@pevik> <87v90akpyy.fsf@suse.de>
 <YaX6nLRGwtfUTjrP@yuki> <YaX7i/ezRhxANBwM@yuki>
 <87mtllly6e.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtllly6e.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tools/sparse: Add static check
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
Cc: chrubis@suze.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I guess that we can also silence some of the useless output by skipping
some old library crap as:

diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
index b1677d336..1a3b4089a 100644
--- a/tools/sparse/sparse-ltp.c
+++ b/tools/sparse/sparse-ltp.c
@@ -98,6 +98,9 @@ static void check_symbol_visibility(const struct symbol *const sym)
        if (!(mod & MOD_TOPLEVEL))
                return;

+       if (!strcmp(name, "TCID") || !strcmp(name, "TST_TOTAL"))
+               return;
+
        if (has_lib_prefix && (mod & MOD_STATIC) && !(mod & MOD_INLINE)) {
                warning(sym->pos,
                        "LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",

Will send another patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
