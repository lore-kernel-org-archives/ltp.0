Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E39AEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:16:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B24CE3CDC91
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:16:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6F0F3C0123
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:16:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F1D21A00A45
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:16:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EEAE022C83;
 Thu, 20 Jul 2023 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689866163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRwepXkZ+fsXeYMidMK5MLu4LxRT7sLaYSzjhDxuEZs=;
 b=XQy5kqWjdza5SUfwYcdB1RuMJiwbCflUlVkmCq4InfNVWO6Yak2LkhsASiXWN6BHPuuGRm
 JwMf9RlN6M/TPGrgyWs90Dow4OlyrwxSBtTOYysR/KSvSe8evOmX8K5J6Ckm+FAHl+N3xC
 CEWrUuI/Ur2n/6yumDVMqKz28gsSito=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689866163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRwepXkZ+fsXeYMidMK5MLu4LxRT7sLaYSzjhDxuEZs=;
 b=YddqNDI+inLXpkW3Ei3xW1e4ol7ruquz0RcdXsFu5r/miPOBxNKDDeMQcVFHcvJlFM8p5Z
 lI5wwkKAfV85uECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D12C7133DD;
 Thu, 20 Jul 2023 15:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fkMtMrNPuWQEEQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Jul 2023 15:16:03 +0000
Message-ID: <86c5849a-50a2-f3b2-fad5-86ecdf73310e@suse.cz>
Date: Thu, 20 Jul 2023 17:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230720150206.1338520-1-pvorel@suse.cz>
 <20230720150206.1338520-2-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230720150206.1338520-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] tst_lockdown: Check other lockdown
 configuration
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 20. 07. 23 17:02, Petr Vorel wrote:
> Originally we checked only CONFIG_EFI_SECURE_BOOT_LOCK_DOWN=y
> (non-mainline patch from 2017 [1]. Various distros (older releases) use
> other newer non-mainline patch [2] (originally from Fedora 32), which with
> CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT=y forces lockdown, when in secure boot.
> 
> [1] https://lore.kernel.org/lkml/149141204578.30815.1929675368430800975.stgit@warthog.procyon.org.uk/
> [2] https://lore.kernel.org/lkml/150842483945.7923.12778302394414653081.stgit@warthog.procyon.org.uk/
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   lib/tst_lockdown.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 26a57b6a1..f91bc919d 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -47,18 +47,21 @@ int tst_lockdown_enabled(void)
>   {
>   	char line[BUFSIZ];
>   	FILE *file;
> +	char flag;
>   
>   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
> -		char flag;
> -
> +		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
>   		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
> -
> -		/* SecureBoot enabled could mean integrity lockdown */
>   		if (flag == 'y' && tst_secureboot_enabled() > 0)
>   			return 1;
>   
>   		tst_res(TINFO, "Unable to determine system lockdown state");
>   		return 0;
> +	} else {

There should be no "else" branch here. The code above should look like this:

int flag;
flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
if (flag && tst_secureboot_enabled() > 0)
	return 1;

> +		/* SecureBoot forces lockdown (non-mainline version) */
> +		flag = tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT");
> +		if (flag == 'y' && tst_secureboot_enabled() > 0)
> +			return 1;
>   	}
>   
>   	file = SAFE_FOPEN(PATH_LOCKDOWN, "r");

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
