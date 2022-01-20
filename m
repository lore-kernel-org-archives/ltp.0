Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951DCC433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 15:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72E4B3C07B8
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 16:08:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39EF23C07B8
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 16:07:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 711E31000DE4
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 16:07:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7C731F388;
 Thu, 20 Jan 2022 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642691270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHMI5vsaO+ZBuoistrFb88joHBUh5nHekBmx2sLN5+s=;
 b=ZmaYmtpz79PsGqfq72cvu+/UkPPVyEfD+ro2jaeTYGcuJi2UpZglqWSj5fCiP/x6qe9az7
 ZFu502QmjPltmIu+aOcBvYndXpN2oEC8Xe4O6+A4xxXEMfJBoxQQTL8yMewKvM4dW/8rTv
 5eRglqZ0ywW+Hwym2mjbfjaJb2LbQBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642691270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHMI5vsaO+ZBuoistrFb88joHBUh5nHekBmx2sLN5+s=;
 b=tFzX3Hv+JcxGAiLf5QUQ9qMLZA4bHK1oOwCJVKcev7GDAPPxl5APVTGdsgWipzrgPm2rWE
 jOu0N6qfBWqvGfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B16D13BD2;
 Thu, 20 Jan 2022 15:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K76LJMZ66WFDMQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Jan 2022 15:07:50 +0000
Message-ID: <42f56f81-327b-b3e1-0c45-05df73c9f9a5@suse.cz>
Date: Thu, 20 Jan 2022 16:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220120150421.26639-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
Acked-by: Martin Doucha <mdoucha@suse.cz>

On 20. 01. 22 16:04, Andrea Cervesato wrote:
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  runtest/ltp-aiodio.part4 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> index fc1e1d479..8c10f67fb 100644
> --- a/runtest/ltp-aiodio.part4
> +++ b/runtest/ltp-aiodio.part4
> @@ -62,7 +62,7 @@ DIT002 dio_truncate
>  #Running read_checkzero
>  #gread_checkzero
>  #Running dio_read
> -DOR000 dio_read -n 1 -i 100
> -DOR001 dio_read -n 10 -i 30
> -DOR002 dio_read -n 20 -i 15
> -DOR003 dio_read -n 100 -i 4
> +DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 5M
> +DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 5M
> +DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 5M
> +DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 5M


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
