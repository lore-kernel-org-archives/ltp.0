Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82751EE14A0
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 15:53:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9247E3CC404
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 17:53:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108523C89B6
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 17:53:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 452C9608A95
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 17:53:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2264B20292;
 Wed,  6 Sep 2023 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694015604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//mRBoHRFL2T2NyAvjoZ+20ErQKp5QDbYxbTrg+zdCk=;
 b=wHN64eyJdGLZs4VzKQ998u/rs6ksJ3E68fXgOyu8TEtUq8LcL5PJYdo2X9BdCEuQ42h1Cd
 rLnup0GV4JuiqsQQHm4FN6lO14aVo5zMoLzOacLGhizjdhKpzWkdRu0lLyRMROqWgdNybr
 o0Ea7wxRogQ6q369DCbGFvS1WIeFhmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694015604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//mRBoHRFL2T2NyAvjoZ+20ErQKp5QDbYxbTrg+zdCk=;
 b=DdBeFvaskHNeKeDUvt6J+jN6eRtqN/crbR36CYRTDjkOR+zgw6/u75GsgiaW4PfeRpTZTQ
 4UsFXHT8cnI82wDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E4931333E;
 Wed,  6 Sep 2023 15:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k7eOAnSg+GQXbwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 06 Sep 2023 15:53:24 +0000
Message-ID: <a53eb49e-d10f-f67b-2ec1-54fa6fa19d5b@suse.cz>
Date: Wed, 6 Sep 2023 17:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230905115608.31192-1-mkittler@suse.de>
 <20230905115608.31192-3-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230905115608.31192-3-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Use correct binary operand in ioctl02.c
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

On 05. 09. 23 13:56, Marius Kittler wrote:
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl02.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index 65a00821c..999128ed8 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -282,7 +282,7 @@ static int chk_tty_parms(void)
>   
>   	if (!
>   	    (termio.c_lflag
> -	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
> +	     & (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {

The long list of flags looks suspiciously like the check should be != 
instead of &. And since it matches the flags passed to ioctl(TCSETA), 
it'd be better to use a different variable for ioctl(TCGETA) and compare 
the two variables instead of checking long hardcoded lists of flags.

>   		tst_res(TINFO, "lflag has incorrect value. %o",
>   			 termio.c_lflag);
>   		flag++;
> @@ -290,14 +290,14 @@ static int chk_tty_parms(void)
>   
>   	if (!
>   	    (termio.c_iflag
> -	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
> +	     & (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
>   		 | IXOFF))) {
>   		tst_res(TINFO, "iflag has incorrect value. %o",
>   			 termio.c_iflag);
>   		flag++;
>   	}
>   
> -	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
> +	if (!(termio.c_oflag & (OPOST | OLCUC | ONLCR | ONOCR))) {
>   		tst_res(TINFO, "oflag has incorrect value. %o",
>   			 termio.c_oflag);
>   		flag++;

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
