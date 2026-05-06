Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441BECD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778058799; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=scBNpL1Uj2NNlQ9w0GlEkSYlTzyhCheWidqrpdEPGwI=;
 b=DQStcl107OiHW2C7DBOjMCM1Xkn0zeG8NcpwSEY27aiVC2iR5XrfL6XD+T+dqpDok6RRn
 vfkYrH5UmPPHDeHeDc84DyayVdPPzWQGlGoqyw79VO/cWrgT09/OvdOazOctTPP9C6Zqu2Q
 R1JFUVFaT9QZyIqyPPb+uds9t7GQmMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8F653E6150
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:13:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C29923E24AB
 for <ltp@lists.linux.it>; Wed,  6 May 2026 11:12:55 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D98921A00911
 for <ltp@lists.linux.it>; Wed,  6 May 2026 11:12:54 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1605275f8f.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778058774; x=1778663574; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+aTL9gJZ/b++Viw8NO6Himl8do2VX1eCutpQc8He+4=;
 b=XgGEacu0OS9NGs7tqpJkwUNwvukOe48Dk9/T0PLn6gW60ELUXxLWuI4So9boUk1+lj
 6wkrpHYDBuT4ut7E8Qaam1sloGYpVSCMMU9Vnsx1g1wIQbGxeeF1JjyjahuwfkLwUn4g
 kDDdmUSjvslz4FMg6w8uiu6VDpXaKE5TqGFGqwgaiBB1Fsd5oF4EknFyPgGAZqpE4rK8
 zzHt+HEwuoVEN13fNnIXTLUeeihUbNR9Tzq0lTwzmjrhgil/SqnMRmff1EXFU3oVVbDs
 oL1cVYjghsEytsoj7NmpRk6NWxgHwi5u5XSUkRS7w05D2/UJx1XF1XKQDMr61Vfl1hDb
 1flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778058774; x=1778663574;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+aTL9gJZ/b++Viw8NO6Himl8do2VX1eCutpQc8He+4=;
 b=XHA+Jo+19H9N1UIFufVZdR/6b3dpFkY24gs2Z1Ja3GQD1MXj7J+DL9ylYGs0eCNaRu
 T+8wt0zV13yIE6Of6bZp6pOU0u9NWNuUkfON4mHGQW9BZuJbqIJEWaNsz19yNzuqmr5n
 NtNN/FQSZYZE7b6AKAlI+EbpVmaYN8ODa5O1qlxOQJWhmVvb1fucdkxDKESOVkSEPuZQ
 scVIuzO7C4paUhcJRk+17pdpPhOBP/afhiULTSm4QiIqgd4ydMyNlPPjGR1ndRdXGp5b
 bEaGPBt6Wx4oepA/mo2sTF0DhzJ/9pSMynG9RBk1moj5O36IsVYsfgXJB8Vnal29acAU
 xlhw==
X-Gm-Message-State: AOJu0Yx9eJ6lFI94WVEfEY92LYOnVl9wNQ4ZK2IID4wF7ilwWNdcpGCC
 K4Le1YEQmhtkqvB2pZajK/6og9q9qU7tD7CDd24Q6IpZsVa7L7HoTD70k2ALzuhmxDESEyKyBbf
 s5y0Z6bjVsQ==
X-Gm-Gg: AeBDievlOTOSAHmaJ2VKrdlfVHJ2EMDedjzIF0xyAK/lhmcFUnuybljfuEd+cMdB37Z
 JBNa+/Gos+9GUXaE3AM7Og2Othl1Wg6qba8x/KQWTSPak9oiYFi19H2WLOT+jYLCs4Wv5rLUz9O
 W9NK1eG4pOR6aCZW9gUanUhwJll1/lARafXumuHj4Fb8eiDJB8o2v1CO8IZrRaRzaywEvIYlKOE
 gw0+qDzMFCmJcQapl9vZ44h0JEyCNnepjHl7JI6QOydUsBiUAQB/w96OGA0aKgHCGdIV1LfARs1
 wDzsOEcHlOn3NAZqDD17qeInA4nfCYoZVM7YDHytcRPLYQ/36U98XiUHWclUMWkQGxKg0egf6Or
 xBS1EMvoaQlu1LjeFbyKZZ3vBzBzkID7zTdTLo/YT5zCDnoMbfo+IKQWNXXTOnkA+vAdDK2IORS
 OH6T/+8bo5PGpe3mI7uTrZMjgcNUZnZ9i+RKCW/RE03FT9TgQcfmTjzMXxtuFl4CNrNrRPSwJBW
 WmfOc5u14n0on6DqsEktK3QR+POq5SdsXi0jKGAL+/Os/WvsZkKDF3NuZR1wR00SgWnVYwQwEGW
 9Mf8mQreTDk3
X-Received: by 2002:a05:6000:2995:20b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-4515b05738bmr3195198f8f.7.1778058774249; 
 Wed, 06 May 2026 02:12:54 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm11632946f8f.25.2026.05.06.02.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 02:12:54 -0700 (PDT)
Message-ID: <69fb0616.df0a0220.22cc2d.40d2@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260429121129.21911-1-mdoucha@suse.cz>
Date: Wed, 06 May 2026 09:12:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] icmp_rate_limit01: Fix rate limit change on older
 kernels
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> The icmp_msgs_burst sysfile was added to non-root namespaces in kernel
> v6.12. Older kernels allow changing the value only from the root
> namespace. Set the global limit first, then change the test namespace
> limit as well if needed.
> 
> Fixes: 3c4c712f1f9b ("cve: icmp_rate_limit: set icmp_msgs_burst within network namespace")
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/cve/icmp_rate_limit01.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
> index 5193c5dfd..37bc71cb8 100644
> --- a/testcases/cve/icmp_rate_limit01.c
> +++ b/testcases/cve/icmp_rate_limit01.c
> @@ -62,7 +62,12 @@ static void setup(void)
>  	/* Do NOT close this FD, or both interfaces will be destroyed */
>  	childns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
>  
> -	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
> +	/*
> +	 * Set namespace local rate limit if needed. The global limit might
> +	 * be ignored otherwise.
> +	 */
> +	if (!access("/proc/sys/net/ipv4/icmp_msgs_burst", F_OK))
> +		SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
>  
>  	/* Configure child namespace */
>  	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
> @@ -257,6 +262,7 @@ static struct tst_test test = {
>  	},
>  	.save_restore = (const struct tst_path_val[]) {
>  		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
> +		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},

Shouldn't we use TST_SR_SKIP_MISSING here instead of TBROK?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
