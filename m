Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B84E7D277
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 10:28:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0903CDC92
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:28:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5FB3C997B
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:28:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 291CB14010D5
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:28:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D9EBD21855
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695724079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8HIptzUskvt8w4zRqPMeR4c6Hdyqo6k+vpFbEiSmSw=;
 b=kAjnivhfE3DMFDux4o+RfQVD0JoLlhImYIvB1iWAhVqHNvQvrNhXjfgUKM+s9KUfn5Ujb4
 ImeXzw8u362qfzd3yD276OASgm/7Jd9lGcDrNza2qdAE6IHnT05XNyMf/rUwFiHjfdSLws
 nDkwGcSN1jSYokQ4uBhF4NIhO8odsu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695724079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8HIptzUskvt8w4zRqPMeR4c6Hdyqo6k+vpFbEiSmSw=;
 b=BsDjI0eLQXFVUnoo/RkjArjFWp0LxkgKDvCpUpPvkMnzWoCpLhHX0R8dbnRirGwO79ajDv
 +nAcagxyf1VfP3AQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8CD602C142;
 Tue, 26 Sep 2023 10:27:59 +0000 (UTC)
References: <20230925144206.16895-1-mkittler@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Tue, 26 Sep 2023 11:27:04 +0100
Organization: Linux Private Site
In-reply-to: <20230925144206.16895-1-mkittler@suse.de>
Message-ID: <87y1gtdyaa.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Marius Kittler <mkittler@suse.de> writes:

> Otherwise clone303 fails with TBROK when `/sys/fs/cgroup` is mounted as
> read-only which is normal in a container. The test result should better
> be TCONF like it is already done in case of a permission error.
>
> Signed-off-by: Marius Kittler <mkittler@suse.de>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  lib/tst_cgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index fdeac6059..5240aadaa 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -383,6 +383,9 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
>  		tst_brk(TCONF | TERRNO,
>  			"Lack permission to make '%s/%s'; premake it or run as root",
>  			dpath, dir_name);
> +	} else if (errno == EROFS) {
> +		tst_brk(TCONF | TERRNO, "'%s/%s' must not be read-only",
> +			dpath, dir_name);
>  	} else {
>  		tst_brk(TBROK | TERRNO,
>  			"mkdirat(%d<%s>, '%s', 0777)",
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
