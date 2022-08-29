Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1963AC0502C
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 19:49:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9361A3CA5F3
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 21:49:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCDD73C9655
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 21:49:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B218F60014D
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 21:49:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D91E221F36;
 Mon, 29 Aug 2022 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661802554;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cag8WTFFGUTCvYoa3mIyqLtYHDdpuvNqp+lQAzPWs/c=;
 b=GZtVE810ioAskhwvXzA5CA5sYM3d72w4GQsgnIX7c9AEW7qIsZ57StaEhyEN+K6Fk+M51Y
 iGTgsFljhN6cNgfMSsmK5B1BKtncP3fNyXCSiRG+8ly2t83+y5V/hnowbSLhZE1e5NnhID
 8LRpWGTNvIT2ZVItGTIWgBcTKmwrojQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661802554;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cag8WTFFGUTCvYoa3mIyqLtYHDdpuvNqp+lQAzPWs/c=;
 b=sByPjHhC6Jdj3UO1GV3SdSZ+hfo5XIvoDGtKabkknAwGxL3b5HO9j3jFTZ27/f7UCRFiur
 hWdcUZlhNoNEw5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B39C3133A6;
 Mon, 29 Aug 2022 19:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g+FEKToYDWMGZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 19:49:14 +0000
Date: Mon, 29 Aug 2022 21:49:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: huangjuniter@foxmail.com
Message-ID: <Yw0YOJ07DcV8dSA2@pevik>
References: <tencent_8D749A790ABC81A17D9575610A12AD6D3D05@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_8D749A790ABC81A17D9575610A12AD6D3D05@qq.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pm_include.sh: Fix no_of_sockets calculation
 error of is_multi_socket() function.
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

Hi Jun,

nit: Commit message could be better: shorter subject (first line)
and more descriptive description after single blank line.
That would help me avoiding asking question bellow.

> From: Jun Huang <huangjuniter@foxmail.com>

nit: there should have been your Signed-off-by:

Signed-off-by: Jun Huang <huangjuniter@foxmail.com>

> ---
>  testcases/kernel/power_management/pm_include.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index 35ff0f1e6..f3e160445 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -124,8 +124,8 @@ check_input() {

>  is_multi_socket() {
>  	no_of_sockets=`cat \
> -		/sys/devices/system/cpu/cpu?/topology/physical_package_id \
> -		| uniq | wc -l`
> +		/sys/devices/system/cpu/cpu*/topology/physical_package_id \
> +		| sort -u | wc -l`
>  	[ $no_of_sockets -gt 1 ] ; echo $?
>  }

I was going to merge it, but is it really needed? Unsorted input to unique will
can lead to higher number of count, but because anything higher than 1 results
in echo 0 and 0 will result in 1 due this code:

[ $no_of_sockets -gt 1 ] ; echo $?

i.e. 2 or more different files will result in count higher than 1 regardless
using sorted uniq (sort -u) or just uniq. Or am I missing something?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
