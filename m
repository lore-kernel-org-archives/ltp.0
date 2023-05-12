Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AC3C7EE24
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 08:28:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0883CB690
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 10:28:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2892D3CB469
 for <ltp@lists.linux.it>; Fri, 12 May 2023 10:28:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E83C200B9C
 for <ltp@lists.linux.it>; Fri, 12 May 2023 10:28:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4885F20424;
 Fri, 12 May 2023 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683880092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wX8ed+f+FouCUCanwjjSorI8wl6LXoG9LIs1C0jzkWo=;
 b=cVK+fEXZ3OLyIRSdQPQzMx3aL6GoWSXfxIMNXP+qCHF2Gkf/dKgTHqVjgfcqsuPS4idmMW
 E+1PBsTRFsm2Fbb0J1O/JI3/XnQtFGNH+dO0RpBnw9opMNy30YyOuJ5qxDDXeiWiDts66Z
 KOGmjfhxdxrimdgVqYxi6hYy7pk6aJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683880092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wX8ed+f+FouCUCanwjjSorI8wl6LXoG9LIs1C0jzkWo=;
 b=7V9b0OeprLTrggTlaaS3D1qeSBSwRP/kQl2EXFWjFYrI01ZQaMcvvv8lcSxMfpXAO1rGo9
 N3mRsh3HJA8jdfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F9EB13466;
 Fri, 12 May 2023 08:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dWdFCpz4XWS6IgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 12 May 2023 08:28:12 +0000
Date: Fri, 12 May 2023 10:29:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sowmya Indranna <reachmesowmyati@gmail.com>
Message-ID: <ZF341lpGJUKXBvKk@yuki>
References: <20230512080749.1232-1-sowmya.indranna@ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230512080749.1232-1-sowmya.indranna@ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cputest_regression_test to skip if cgroup version2
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
Cc: ltp@lists.linux.it, Sowmya Indranna <sowmya.indranna@ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 1ae8933bc..9e89fe3ed 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -130,6 +130,11 @@ setup()
>  
>  	tst_res TINFO "test starts with cgroup version $cgroup_version"
>  
> +	if [ "$cgroup_version" = "2" ]; then
> +            tst_brk TCONF "cgroup v2 found, skipping test"
> +            return
> +        fi

Since we are heading for a release I've fixed the whitespaces here,
adjusted the description and pushed, thanks.

Please mind that LTP uses tabs in shell scripts next time.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
