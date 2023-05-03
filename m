Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD7C77B7F
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 14:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 347133CB8B9
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 16:33:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C3B83CB878
 for <ltp@lists.linux.it>; Wed,  3 May 2023 16:33:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BCD9E600689
 for <ltp@lists.linux.it>; Wed,  3 May 2023 16:33:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEAC1228CA;
 Wed,  3 May 2023 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683124396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sPrWvFtqZUSoN6V+CAMqeck5Uf/Os5l0LlGNydDKNCI=;
 b=Qd/ZF2T9k75luKWRUp4ACrwCvWF754TaR66p+CNmQti5EkBGCVMO4vIU8DKsuNFn2lgrM0
 13d3edDxsqwPLqRvosR3JD2i089xvhloOnlmLB7xanOH05XgVgkssDqkX7j6e2OICVoPtV
 i6pxVmKBzgDoMaNo2E3UOByYYgUCfB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683124396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sPrWvFtqZUSoN6V+CAMqeck5Uf/Os5l0LlGNydDKNCI=;
 b=m2NXvFPDpDIpYZsFbvLOJoQsK4kBtIB6pEXfMpw7FypLv5svPjwGE0nt5XHX0+l9HtJ3Db
 M4cNEXBBHvzDKpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D8D1331F;
 Wed,  3 May 2023 14:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AeR7H6xwUmQsRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 May 2023 14:33:16 +0000
Date: Wed, 3 May 2023 16:33:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230503143330.GA3750885@pevik>
References: <20230503134807.23636-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230503134807.23636-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for CVE 2021-3653
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> GCC 13 prints out-of-bounds warnings for statements dereferencing avic_ptr.
> According to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105523
> this is a GCC bug.

Fair enough. Thanks a lot for searching and fixes, merged.

Kind regards,
Petr

> Changes since v1:
> - Added missing runfile and .gitignore entries
> - Updated commit message

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
