Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A1EC83F1A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 08:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C6153CAF4A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:24:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD04C3C65DA
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:24:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21DB11400E4C
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:24:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B373C2117A;
 Thu, 10 Jul 2025 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752135843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rEvM4qfGNRKZ8z0RRPpaszmFsRPSsy2W5a+tm8bYgM=;
 b=bU4tT+wzHRNvxsfuT2Zdd5uEkFslo60HYEtOkA5vXLCxfGuI+FwNPwaQGYVEk1RnuJsvlk
 U2Xp/s9TmNUGR5JPNz7aAbiQ8nSkLE37sFtDQRB2xFJ1E2Sve5kDC7Mu00FxdJSxqWDJFB
 KAJTkWwkh7XTnLBDDhOjlRa5bnKYvxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752135843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rEvM4qfGNRKZ8z0RRPpaszmFsRPSsy2W5a+tm8bYgM=;
 b=/eksGL8NdNk8gScL6d3YJmFHbWRm0jm0HJEmcTnusVwZnJPMti1LAmCiTmyr3DqClbjFK3
 yPcEof0jTmmWrdAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752135843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rEvM4qfGNRKZ8z0RRPpaszmFsRPSsy2W5a+tm8bYgM=;
 b=bU4tT+wzHRNvxsfuT2Zdd5uEkFslo60HYEtOkA5vXLCxfGuI+FwNPwaQGYVEk1RnuJsvlk
 U2Xp/s9TmNUGR5JPNz7aAbiQ8nSkLE37sFtDQRB2xFJ1E2Sve5kDC7Mu00FxdJSxqWDJFB
 KAJTkWwkh7XTnLBDDhOjlRa5bnKYvxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752135843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rEvM4qfGNRKZ8z0RRPpaszmFsRPSsy2W5a+tm8bYgM=;
 b=/eksGL8NdNk8gScL6d3YJmFHbWRm0jm0HJEmcTnusVwZnJPMti1LAmCiTmyr3DqClbjFK3
 yPcEof0jTmmWrdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4093136CB;
 Thu, 10 Jul 2025 08:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6vwoJ6N4b2i7NgAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 10 Jul 2025 08:24:03 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Jul 2025 10:24:03 +0200
Message-ID: <12708664.O9o76ZdvQC@thinkpad>
In-Reply-To: <20250710082000.11641-1-akumar@suse.de>
References: <20250710082000.11641-1-akumar@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Cc: mkoutny@suse.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I forgot to mention that I also tried to use
tst_umount() helper routine, but that did not help as umount does not
really report any failures here.

On Thursday, July 10, 2025 10:17:09 AM CEST Avinesh Kumar wrote:
> Recently we started having failures where mounting cgroup in quick
> succession after umount of same named hierarchy fails with EBUSY
> =

> cgroup_regression_test 1 TPASS: no kernel bug was found
> mount: /tmp/LTP_cgroup_regression_test.ZFwS3JkX4c/cgroup: cgroup already =
mounted or mount point busy.
>        dmesg(1) may have more information after failed mount system call.
> cgroup_regression_test 2 TFAIL: Failed to mount cgroup filesystem
> =

> Updating test to use unique names for cgroup hierarchies in each
> subtest.
> =

> Suggested-by: Michal Koutn=FD <mkoutny@suse.com>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../controllers/cgroup/cgroup_regression_test.sh       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> =

> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.s=
h b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 276231fe8..c1bf4810f 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -93,7 +93,7 @@ test1()
>  	cgroup_regression_fork_processes &
>  	sleep 1
>  =

> -	mount -t cgroup -o none,name=3Dfoo cgroup cgroup/
> +	mount -t cgroup -o none,name=3Dfoo1 cgroup cgroup/
>  	if [ $? -ne 0 ]; then
>  		tst_res TFAIL "failed to mount cgroup filesystem"
>  		kill -TERM $!
> @@ -118,7 +118,7 @@ test2()
>  	local val1
>  	local val2
>  =

> -	mount -t cgroup -o none,name=3Dfoo cgroup cgroup/
> +	mount -t cgroup -o none,name=3Dfoo2 cgroup cgroup/
>  	if [ $? -ne 0 ]; then
>  		tst_res TFAIL "Failed to mount cgroup filesystem"
>  		return
> @@ -204,7 +204,7 @@ test4()
>  		return
>  	fi
>  =

> -	mount -t cgroup -o none,name=3Dfoo cgroup cgroup/
> +	mount -t cgroup -o none,name=3Dfoo4 cgroup cgroup/
>  	mkdir cgroup/0
>  	rmdir cgroup/0
>  	tst_umount $PWD/cgroup
> @@ -309,7 +309,7 @@ test_7_2()
>  {
>  	local subsys=3D$1
>  =

> -	mount -t cgroup -o none,name=3Dfoo cgroup cgroup/
> +	mount -t cgroup -o none,name=3Dfoo72 cgroup cgroup/
>  	if [ $? -ne 0 ]; then
>  		tst_res TFAIL "failed to mount cgroup"
>  		return
> @@ -370,7 +370,7 @@ test7()
>  #-----------------------------------------------------------------------=
----
>  test8()
>  {
> -	mount -t cgroup -o none,name=3Dfoo cgroup cgroup/
> +	mount -t cgroup -o none,name=3Dfoo8 cgroup cgroup/
>  	if [ $? -ne 0 ]; then
>  		tst_res TFAIL "failed to mount cgroup filesystem"
>  		return
> =






-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
