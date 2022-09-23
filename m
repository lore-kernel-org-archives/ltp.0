Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86DC6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 15:27:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EFFF3CADBB
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 17:27:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4EFD3CA756
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:27:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2086A602A1D
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:27:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D7BF1F8E2;
 Fri, 23 Sep 2022 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663946856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5c4DhEjbS4XqpvXGW0oAqYMOmfVn1DiZVqpmViPXck8=;
 b=iB038t2zxKMLUMxQG7hwz6hggkEwd7wv8EsakqMYAJC535zCPoqqpsOj5yRwdV10OP1jsC
 YZjy8FEaOOzG4yA3Lj/iiYd5s9+YznmL+fUbmaRKro66E3zeZVep7xhsI/6/PfjsvEnISa
 xuwiajqzMwezNd2TsldwCJO429IiPTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663946856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5c4DhEjbS4XqpvXGW0oAqYMOmfVn1DiZVqpmViPXck8=;
 b=BgZs+JhDH+8s5QIAFmnAw+X9YNAwEuleXb09SVkVs4wdGfbzg4hUNAXCCFYo7JZCtwhttK
 AddkjjBQb6+ciIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CA3B13AA5;
 Fri, 23 Sep 2022 15:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7Lh/DWjQLWNXPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 23 Sep 2022 15:27:36 +0000
Date: Fri, 23 Sep 2022 17:29:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yy3QzoD5kRFdVzVR@yuki>
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220922210931.23982-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3 v2] tst_test.sh: Fix filesystem support
 detection
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")
>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks like this is the only real fix in the series, right?

The actual change looks good, but I do wonder what exactly has been
broken, git grpe TST_SKIP_FILESYSTEMS does not show any real tests
that would use that variable.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
