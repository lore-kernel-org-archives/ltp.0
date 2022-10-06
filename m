Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6844C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 08:28:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23D693CADF8
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 10:28:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE3BB3C0796
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 10:27:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2ABF8602076
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 10:27:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 505471F8E1;
 Thu,  6 Oct 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665044870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktVeAxIk1nbICcm3MIZ58KJzsUYeUHW9RO7Cp1r5us=;
 b=JI1fO/UlJbvR5fygrUkHLh+bROTjvIHXFFxtv76KVcrfAfbKlQx+kmpC7ZvlFA0FRQiYU0
 c2VUEe9gD0KcB0YQWDIu9DgKDPhkc2GiWx7soIlm+NrT/XmppeCXq+o18uJ5dSyW0mvmOD
 +8YD+JEwNUh/q3oVzIcorEzj9/GG7Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665044870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktVeAxIk1nbICcm3MIZ58KJzsUYeUHW9RO7Cp1r5us=;
 b=1iIDSFqnQTabQCc5UUppR4hxxKrrpLOv/WFM1kxWWLiN1SR986C9q93wzoxhEzUfVRnFGU
 dWn4QHD+3s3ml6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 362B813AC8;
 Thu,  6 Oct 2022 08:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yTE7DIaRPmMiNAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 06 Oct 2022 08:27:50 +0000
Message-ID: <46677216-f912-545f-389c-a7f386ce7614@suse.cz>
Date: Thu, 6 Oct 2022 10:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221005131529.15930-1-mdoucha@suse.cz> <Yz5knc+5gFFoPgdh@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yz5knc+5gFFoPgdh@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/creat09: Add reference to CVE 2021-4037
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 06. 10. 22 7:16, Petr Vorel wrote:
> How about this change:
> 
> diff --git runtest/cve runtest/cve
> index 9ab6dc282..6ad3f51fb 100644
> --- runtest/cve
> +++ runtest/cve
> @@ -55,7 +55,7 @@ cve-2018-1000001 realpath01
>   cve-2018-1000199 ptrace08
>   cve-2018-1000204 ioctl_sg01
>   cve-2018-12896 timer_settime03
> -cve-2018-13405 creat09
> +cve-2018-13405-cve-2021-4037 creat09
>   cve-2018-18445 bpf_prog04
>   cve-2018-18559 bind06
>   cve-2018-18955 userns08

I don't think we need to complicate the runfile name like this. As long 
as the CVE reference gets printed on failure and can be found via 
grepping the sources, it's good enough.

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
