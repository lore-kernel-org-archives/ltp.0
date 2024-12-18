Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CDCE77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 17:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDA723ED5D5
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:37:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7854E3ECA9F
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 18:37:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD4CC6406B7
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 18:37:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E000F21153;
 Wed, 18 Dec 2024 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734543447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9mk+hpE5/EUR7wEl4YmcoX8Q/2XQ7Gn+d6JKH5C5So=;
 b=Ila8LBjC3fcFS3X6vkcbKITwXhSfdlTgU+Z8BRM+Kir0fVtwNABBlO0lWWizPXxZgXX+pp
 xFT+Dag/cEBkHPnnSyy7mEiqEs2m5k7koiHhTZGk5wiDmbzzoRNh4+Ix5d01q7osSbWvMq
 u/DdJwanQdqq57d+5ydc6gaFghpkYe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734543447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9mk+hpE5/EUR7wEl4YmcoX8Q/2XQ7Gn+d6JKH5C5So=;
 b=JccsqkafPqBtqqlPvlI5107Rg24aZUXorTInFJJ4frGDdv0MlHugWpidOZPtpqfeBswxfh
 C3Y06gHksJi9O+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734543446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9mk+hpE5/EUR7wEl4YmcoX8Q/2XQ7Gn+d6JKH5C5So=;
 b=oH0USYbDjfy4t/gl5QkQEp1pCfGkSSV2jPh1n8d2yLtVezcPqfla/ItGLjDWGTW1OoZ0Zv
 mF2hNP1N5QpG2OV9Ih8ksskDtAlbjL8vcNDUecJ4GmY2jIZffNsuNvXUqD8M+Fol0euSKI
 PseoMQllVZITNVtYzCgBFoiczCOmmIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734543446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9mk+hpE5/EUR7wEl4YmcoX8Q/2XQ7Gn+d6JKH5C5So=;
 b=C8lZAcKA6uPD9RrmjmHzCilaU7sPpti+ZQoNzE4/gHHlMbiGIYY50Jiks2jH3KH5yyegpj
 P0HiJmGPb7uPXsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1130132EA;
 Wed, 18 Dec 2024 17:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pr8XLlYIY2fRXgAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 18 Dec 2024 17:37:26 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Dec 2024 18:37:26 +0100
Message-ID: <12583012.O9o76ZdvQC@thinkpad>
In-Reply-To: <20241217145041.44600-1-pvorel@suse.cz>
References: <20241217145041.44600-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ip_tests.sh: Iprove grep count
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

Hi Petr,

On Tuesday, December 17, 2024 3:50:40 PM CET Petr Vorel wrote:
> Some systems have already defined another route with src 127.0.0.1,
> therefore more exact pattern is needed.
> 
> Also 1) escape '.' (dot) in regex 2) use '-q' instead of redirecting
> stdout to /dev/null.
> 
> Reported-by: Petr Cervinka <pcervinka@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both the patches.

> ---
>  testcases/network/iproute/ip_tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index ee9768073f..0b1d5a85e6 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -179,7 +179,7 @@ test5()
>  $ip4_addr via 127.0.0.1 dev lo
>  	EOF
>  
> -	ip route show | grep "$ip4_addr via 127.0.0.1 dev lo" > tst_ip.out 2>&1
> +	ip route show | grep "$ip4_addr via 127\.0\.0\.1 dev lo" > tst_ip\.out 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_res TFAIL "'ip route show' command failed"
>  		return
> @@ -195,7 +195,7 @@ $ip4_addr via 127.0.0.1 dev lo
>  
>  	ROD ip route del $ip4_addr via 127.0.0.1
>  
> -	ip route show | grep 127.0.0.1 > /dev/null
> +	ip route show | grep -q "$ip4_addr via 127\.0\.0\.1 dev lo"
>  	if [ $? -eq 0 ]; then
>  		tst_res TFAIL "route not deleted"
>  		return
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
