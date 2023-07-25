Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A16C001DE
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 11:02:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 221433CDBF9
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 13:02:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2165A3C8B63
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:01:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D8984600136
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:01:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34D701F895;
 Tue, 25 Jul 2023 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690282914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1V0/vZRept2EdzeYwgknn/bnsqCp1CNXqSm7Kfg2ks=;
 b=XjaRM3DDDFfAKCVJaVUOep2Y/3GRzYFDgVxxBLJxweRrwsi1UjPS6H9AjyicHP2mzS9Nc/
 PvouHb03ByD3aY9aTh1YFjV1KlY8a+2JwM+5kAVMBfBuaGOZ7SUP6HIKXMF9vvz1T11tqX
 XLWq36dIkAB7RbK9e0yDb/4QWsu/mOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690282914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1V0/vZRept2EdzeYwgknn/bnsqCp1CNXqSm7Kfg2ks=;
 b=OkOfDoKB5A7sM9t7GRQNfQAYOoGMYQTWupjAVOTPHZsTb2lTx5hAcaWmgMRzWBj+4XWOMK
 29wKa5BvrSOxgzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 175D213342;
 Tue, 25 Jul 2023 11:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XXEQBKKrv2QeDwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 25 Jul 2023 11:01:54 +0000
Message-ID: <d723784f-98cc-1eb2-08de-ed8d267414bd@suse.cz>
Date: Tue, 25 Jul 2023 13:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230721091515.1353371-1-pvorel@suse.cz>
 <20230721091515.1353371-2-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230721091515.1353371-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] tst_lockdown: Check other lockdown
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
small nit: there are two spaces after the first tst_kconfig_get(). 
Otherwise looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 21. 07. 23 11:15, Petr Vorel wrote:
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
>   lib/tst_lockdown.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 26a57b6a1..4ce4736c3 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -50,11 +50,10 @@ int tst_lockdown_enabled(void)
>   
>   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
>   		char flag;
> -
> -		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
> -
> -		/* SecureBoot enabled could mean integrity lockdown */
> -		if (flag == 'y' && tst_secureboot_enabled() > 0)
> +		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
> +		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN")  == 'y';
> +		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
> +		if (flag && tst_secureboot_enabled() > 0)
>   			return 1;
>   
>   		tst_res(TINFO, "Unable to determine system lockdown state");

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
