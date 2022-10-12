Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3446C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 11:33:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 323703CAEB0
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 13:33:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7134B3CADF8
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 13:33:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A795E2005D0
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 13:33:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B50C71F381;
 Wed, 12 Oct 2022 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665574400;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJ1pCIpGxUSLvJP5UrkF+wbikop7LyLylbly9TWYu5U=;
 b=UraUVfBTXUUQAzq7j0M5LrB/oVmOw5HSStY5o7ApXWN7fnMfyttfN/YHsaDWlBZj972mCm
 AcIAJaGRRCw5xX099zN73o6KxwiykXzuJ+fx2uxtttFzg9+BrUS+BQBuy3WQxg4+fLNP1C
 v2snqOjnngZVINrGju9J/xUw5FqCbtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665574400;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJ1pCIpGxUSLvJP5UrkF+wbikop7LyLylbly9TWYu5U=;
 b=1TBlJ3qIxnXbG1Ak07rEkJf1d81JLlmwHUVgideVOvzyRFYGv16RJeJj4JiSRf+2Zi+VuX
 H1acm7u+21FzQbCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8065213A5C;
 Wed, 12 Oct 2022 11:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /4+vHACmRmP1NQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Oct 2022 11:33:20 +0000
Date: Wed, 12 Oct 2022 13:33:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y0al/lzocpDw6hBb@pevik>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
 <20221012091526.35373-2-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221012091526.35373-2-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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

Hi all,

The subject "lib: Add checking of needs_root" is a bit misleading
as it does not mention at all that it's for the loop device.

> We need to check needs_root is set when tst_test->needs_device or
> tst_test->mount_device is set since access the /dev/* need a
> privilege.

FYI we had some discussion about it, quoting Cyril [1]:

	Well technically you can be added into whatever group is set to
	/dev/loop-control e.g. disk group and then you can create devices
	without a need to be a root.

	So the most correct solution would be checking if we can access
	/dev/loop-control if tst_test.needs_device is set and if not we would
	imply needs_root. However this would need to be rethinked properly so
	that we do not end up creating something complex and not really
	required.

There is also possibility to add custom device via $LTP_DEV. That might allow to
add permissions which allow to test without root.

I'll write to automated-testing ML (and maybe to LKML ML) to see if people
prefers to test without non-root.

Also, if changed, we'd need the same change for C API.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Yx8I0ponDUIFC8le@yuki/

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  lib/tst_test.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8ccde1629..728a1d921 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1196,6 +1196,11 @@ static void do_setup(int argc, char *argv[])
>  		tst_brk(TBROK, "tst_test->mntpoint must be set!");
>  	}

> +	if ((tst_test->needs_device || tst_test->mount_device) &&
> +	     !tst_test->needs_root) {
> +		tst_brk(TBROK, "tst_test->needs_root must be set!");
> +	}
> +
>  	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
>  	    !!tst_test->needs_device > 1) {
>  		tst_brk(TBROK,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
