Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460CECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:47:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4F13CAA7F
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:47:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 500E83CA9F1
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:47:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 971C3601AED
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:47:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A32AC1F8FB;
 Fri,  9 Sep 2022 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662734849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vy/FI/4vNwE3RbBfNQ8s2N1Dcv7bIdX8hBjEg1y5sUs=;
 b=BuDgaZIK+h6m4E1sk0phFu08tCjD49xjl/uBqBDmlLVvziyZNCbKqZSGzn/KV8wUXI54Q5
 RE/kW7axgEPiMKJb/f76RIRKuylK3PCrv/LPf6Bmmd7JchAeM3CKiIIujU2RuAnF2wQVLF
 0nfzEjkYohZVan6uFTz/S+H5hMctETM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662734849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vy/FI/4vNwE3RbBfNQ8s2N1Dcv7bIdX8hBjEg1y5sUs=;
 b=VzzTlOuU/62elehHfTXlYjib/OXqmH6dRfMSewSgwvA6zFl4pJcyYy/4ElZPPhpYt/xSps
 2GDA1/zowFm9kwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55A6813A93;
 Fri,  9 Sep 2022 14:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F37uEgFSG2NLYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:47:29 +0000
Date: Fri, 9 Sep 2022 16:47:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YxtR/1NJIabAqd5V@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik> <Yxsgg8f7vOFdXV3q@yuki>
 <YxskoojodIaNuI6G@pevik>
 <70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz>
 <YxtMFw25BfJaEsji@pevik>
 <5e01e854-7cc6-7b08-d1f8-7f0709fbc07d@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e01e854-7cc6-7b08-d1f8-7f0709fbc07d@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] tst_supported_fs: Support skip list when
 query single fs
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 09. 09. 22 16:22, Petr Vorel wrote:
> > OK, this is not in v5. I don't mind to send v6 on Monday, if we agree this
> > is wanted. Implementation detail: should I use for -2 and -1 for these two values?
> > (code < 0 would be error, code > 0 would be OK, 0 itself skipped)

> One more thing, the skiplist check should be done before availability check.
> It's faster and it'll save you work when you're trying to fix tests that
> shouldn't be skipped.
Good point. I guess you mean just to reverse order in
tst_fs_is_supported_skiplist(), right?

Kind regards,
Petr

+++ lib/tst_supported_fs_types.c
@@ -137,17 +137,10 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
 enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
 					      *const *skiplist)
 {
-	int ret;
-
-	ret = tst_fs_is_supported(fs_type);
-
-	if (!ret)
-		return ret;
-
 	if (tst_fs_in_skiplist(fs_type, skiplist))
 		return TST_FS_UNSUPPORTED;
 
-	return ret;
+	return tst_fs_is_supported(fs_type);
 }
 
 const char **tst_get_supported_fs_types(const char *const *skiplist)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
