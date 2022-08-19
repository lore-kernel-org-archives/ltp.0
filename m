Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F32C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 15:27:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C1CE3CA255
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 17:27:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 054693C1BC6
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 17:27:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA1A920017D
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 17:27:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E12734B5E;
 Fri, 19 Aug 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660922822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEmoq56SnloaKxp+V1tU1bRvok3MftDxrxVxYxNefWw=;
 b=a90IhlMX0nZZbnD0Z8swR2Goql4zb2xFS0rXMYG2yy+rGfQb+8PrffT473KLmr+H/5i7QW
 ymOP8E3Z7KK7eix0p2EI9gStCop/UDEWmFhQa/D+DG6m3oPB7DmqXXCIBOPZV6XknnFmtZ
 w1RMu9SUxxXbLROdITnkTOptFgqFewU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660922822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEmoq56SnloaKxp+V1tU1bRvok3MftDxrxVxYxNefWw=;
 b=1x5FMN92QGv0i4CxhDUnIKzg6tr1iDqFmy8TI1K0hrNaVvKGcyavyvxqJY1elbNXV/SoAe
 OgbW9ZlNqDzmpcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73CEB13AE9;
 Fri, 19 Aug 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CsowGsar/2J9DgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 15:27:02 +0000
Date: Fri, 19 Aug 2022 17:27:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Yv+rxD5EO4MDayXT@pevik>
References: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
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

Hi Jan,

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/commands/df/df01.sh | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index f74032c962e5..6b20f21d0d74 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -103,6 +103,11 @@ df_check()

>  	grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
>  	if [ $? -ne 0 ]; then
> +		echo "total: ${total}, used: ${used}"
> +		echo "df saved output:"
I wonder why you didn't use tst_res TINFO? It'd be more readable as the output
can be quite long...
> +		cat output
> +		echo "df output:"
> +		$@

Kind regards,
Petr

>  		return 1
>  	fi
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
