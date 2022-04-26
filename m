Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6395C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 11:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1673CA38C
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 13:03:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0901B3C9660
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 13:03:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 241F4680E4B
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 13:03:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 457191F388;
 Tue, 26 Apr 2022 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650971009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a+c5cev4w6SNe2JKBSdJhnJVEx1y0URiQjCFwM/0LY=;
 b=O3yK/gX4E7v6f4LRZEifGW/f4b3XJAjTfC4oO/Texv2vD70GM75SDd4cjkykBZX2/X+wHT
 1PkN3JZdlYbVmQWc1eCMTaJxrzKmJuyqcRXdxNYqwggNnZiTWIz1AwznRRillIYuUdNhN5
 6vBB46dCvANtegdJlZ8twTAwDHs3PRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650971009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a+c5cev4w6SNe2JKBSdJhnJVEx1y0URiQjCFwM/0LY=;
 b=dGMWPkNusf09xtF5MPcZkD+WG96RhQl0baIlS9dt3U1mpRUEoPFRXJE2N5eqffYwnkhBgL
 7hqA/6WKtOl4uVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3377113AD5;
 Tue, 26 Apr 2022 11:03:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 23CYC4HRZ2J3ZgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 26 Apr 2022 11:03:29 +0000
Message-ID: <630fbde9-45f7-3a8d-15e0-1ac94c45ece1@suse.cz>
Date: Tue, 26 Apr 2022 13:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-3-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220422144141.16848-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] doc: Update library API doc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
small nit below, otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 22. 04. 22 16:41, Petr Vorel wrote:
> about conditional expansion for TST_{SETUP,CLEANUP}.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> * New in v2
> 
>  doc/library-api-writing-guidelines.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
> index e75c838a15..9e926e9713 100644
> --- a/doc/library-api-writing-guidelines.txt
> +++ b/doc/library-api-writing-guidelines.txt
> @@ -61,3 +61,23 @@ API source code is in 'tst_test.sh', 'tst_security.sh' and 'tst_net.sh'
>  
>  Changes in the shell API should not introduce uncommon dependencies
>  (use basic commands installed everywhere by default).
> +
> +3.1 Shell libraries
> +~~~~~~~~~~~~~~~~~~~
> +
> +Besides shell API libraries in 'testcases/lib' it's worth to put common code
> +for particular tests into shell library. The filename should end '_lib.sh',
> +they should load 'tst_test.sh' or 'tst_net.sh'.

Better wording:
Aside from shell API libraries in 'testcases/lib', it's worth putting
common code for a group of tests into a shell library. The filename
should end with '_lib.sh' and the library should load 'tst_test.sh' or
'tst_net.sh'.

> +
> +Shell libraries should have conditional expansion for 'TST_SETUP' or 'TST_CLEANUP',
> +to avoid surprises when test specific setup/cleanup function is redefined by
> +shell library.
> +
> +[source,sh]
> +-------------------------------------------------------------------------------
> +# ipsec_lib.sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
> +. tst_test.sh
> +...
> +-------------------------------------------------------------------------------


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
