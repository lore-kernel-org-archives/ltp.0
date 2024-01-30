Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4A4C48285
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EE0C3CF97F
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:29:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9269C3CE103
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:29:19 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 40E091401109
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:29:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2AE0D1F84A;
 Tue, 30 Jan 2024 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jas7kYgyklbglxYew3ATA3eyhr9CEULtJf931RX4Doo=;
 b=3JZDf5MgQOw7NobOSpOcHACQYZLHZkbcfHZGQZkPKTwLGHW/r+6yeg93bpODTNl1Ma9jtI
 bkvLceH4sL9diSDxN6CSh6iAjiX7xOd/Z0hbE7AfEIe4GoovK1RsixhfE3KuCBkhtNFXpa
 VPWeaAjpZISvBhAYiIu2xFZU79xeFxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jas7kYgyklbglxYew3ATA3eyhr9CEULtJf931RX4Doo=;
 b=LnHdaj1iQWGMHtmmYdUetCgRgwyAfC/xLKwsKgdoOR7OwB7SSHvJaR4745jl6ooHeISy6s
 chN2k1O65ZuaFyCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jas7kYgyklbglxYew3ATA3eyhr9CEULtJf931RX4Doo=;
 b=3JZDf5MgQOw7NobOSpOcHACQYZLHZkbcfHZGQZkPKTwLGHW/r+6yeg93bpODTNl1Ma9jtI
 bkvLceH4sL9diSDxN6CSh6iAjiX7xOd/Z0hbE7AfEIe4GoovK1RsixhfE3KuCBkhtNFXpa
 VPWeaAjpZISvBhAYiIu2xFZU79xeFxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jas7kYgyklbglxYew3ATA3eyhr9CEULtJf931RX4Doo=;
 b=LnHdaj1iQWGMHtmmYdUetCgRgwyAfC/xLKwsKgdoOR7OwB7SSHvJaR4745jl6ooHeISy6s
 chN2k1O65ZuaFyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E20113A66;
 Tue, 30 Jan 2024 12:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Or0dB53ruGV+TwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 30 Jan 2024 12:29:17 +0000
Message-ID: <179d3e55-0d75-4bcd-852b-7046c143b193@suse.cz>
Date: Tue, 30 Jan 2024 13:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20231031160918.17845-1-pvorel@suse.cz>
 <20231031160918.17845-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20231031160918.17845-2-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest/net.nfs: Rename test names
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
I agree with the general idea but I think this version is a bit too 
verbose. How about something like this?

nfs01_v30_ip4u nfs01.sh -v 3 -t udp
nfs01_v30_ip4t nfs01.sh -v 3 -t tcp
nfs01_v40_ip4t nfs01.sh -v 4 -t tcp
nfs01_v41_ip4t nfs01.sh -v 4.1 -t tcp
nfs01_v42_ip4t nfs01.sh -v 4.2 -t tcp
nfs01_v30_ip6u nfs01.sh -6 -v 3 -t udp
nfs01_v30_ip6t nfs01.sh -6 -v 3 -t tcp
nfs01_v40_ip6t nfs01.sh -6 -v 4 -t tcp
nfs01_v41_ip6t nfs01.sh -6 -v 4.1 -t tcp
nfs01_v42_ip6t nfs01.sh -6 -v 4.2 -t tcp

nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
nfs06_vall_ip4t nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t 
"tcp,tcp,tcp,tcp,tcp,tcp"
nfs06_v4x_ip6t nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t 
"tcp,tcp,tcp,tcp,tcp,tcp"


On 31. 10. 23 17:09, Petr Vorel wrote:
> Test names weren't obvious, rename to be more descriptive.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   runtest/net.nfs | 188 ++++++++++++++++++++++++------------------------
>   1 file changed, 94 insertions(+), 94 deletions(-)
> 
> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 15a960017..7556ed4fc 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -2,107 +2,107 @@
>   #
>   # PLEASE READ THE README FILE network/README.md BEFORE RUNNING THESE.
>   #
> -nfs3_01 nfs01.sh -v 3 -t udp
> -nfs3t_01 nfs01.sh -v 3 -t tcp
> -nfs4_01 nfs01.sh -v 4 -t tcp
> -nfs41_01 nfs01.sh -v 4.1 -t tcp
> -nfs42_01 nfs01.sh -v 4.2 -t tcp
> -nfs3_ipv6_01 nfs01.sh -6 -v 3 -t udp
> -nfs3t_ipv6_01 nfs01.sh -6 -v 3 -t tcp
> -nfs4_ipv6_01 nfs01.sh -6 -v 4 -t tcp
> -nfs41_ipv6_01 nfs01.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_01 nfs01.sh -6 -v 4.2 -t tcp
> +nfs01.sh_v3_ipv4_udp nfs01.sh -v 3 -t udp
> +nfs01.sh_v3_ipv4_tcp nfs01.sh -v 3 -t tcp
> +nfs01.sh_v4_ipv4_tcp nfs01.sh -v 4 -t tcp
> +nfs01.sh_v4.1_ipv4_tcp nfs01.sh -v 4.1 -t tcp
> +nfs01.sh_v4.2_ipv4_tcp nfs01.sh -v 4.2 -t tcp
> +nfs01.sh_v3_ipv6_udp nfs01.sh -6 -v 3 -t udp
> +nfs01.sh_v3_ipv6_tcp nfs01.sh -6 -v 3 -t tcp
> +nfs01.sh_v4_ipv6_tcp nfs01.sh -6 -v 4 -t tcp
> +nfs01.sh_v4.1_ipv6_tcp nfs01.sh -6 -v 4.1 -t tcp
> +nfs01.sh_v4.2_ipv6_tcp nfs01.sh -6 -v 4.2 -t tcp
>   
> -nfs3_02 nfs02.sh -v 3 -t udp
> -nfs3t_02 nfs02.sh -v 3 -t tcp
> -nfs4_02 nfs02.sh -v 4 -t tcp
> -nfs41_02 nfs02.sh -v 4.1 -t tcp
> -nfs42_02 nfs02.sh -v 4.2 -t tcp
> -nfs3_ipv6_02 nfs02.sh -6 -v 3 -t udp
> -nfs3t_ipv6_02 nfs02.sh -6 -v 3 -t tcp
> -nfs4_ipv6_02 nfs02.sh -6 -v 4 -t tcp
> -nfs41_ipv6_02 nfs02.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_02 nfs02.sh -6 -v 4.2 -t tcp
> +nfs02.sh_v3_ipv4_udp nfs02.sh -v 3 -t udp
> +nfs02.sh_v3_ipv4_tcp nfs02.sh -v 3 -t tcp
> +nfs02.sh_v4_ipv4_tcp nfs02.sh -v 4 -t tcp
> +nfs02.sh_v4.1_ipv4_tcp nfs02.sh -v 4.1 -t tcp
> +nfs02.sh_v4.2_ipv4_tcp nfs02.sh -v 4.2 -t tcp
> +nfs02.sh_v3_ipv6_udp nfs02.sh -6 -v 3 -t udp
> +nfs02.sh_v3_ipv6_tcp nfs02.sh -6 -v 3 -t tcp
> +nfs02.sh_v4_ipv6_tcp nfs02.sh -6 -v 4 -t tcp
> +nfs02.sh_v4.1_ipv6_tcp nfs02.sh -6 -v 4.1 -t tcp
> +nfs02.sh_v4.2_ipv6_tcp nfs02.sh -6 -v 4.2 -t tcp
>   
> -nfs3_03 nfs03.sh -v 3 -t udp
> -nfs3t_03 nfs03.sh -v 3 -t tcp
> -nfs4_03 nfs03.sh -v 4 -t tcp
> -nfs41_03 nfs03.sh -v 4.1 -t tcp
> -nfs42_03 nfs03.sh -v 4.2 -t tcp
> -nfs3_ipv6_03 nfs03.sh -6 -v 3 -t udp
> -nfs3t_ipv6_03 nfs03.sh -6 -v 3 -t tcp
> -nfs4_ipv6_03 nfs03.sh -6 -v 4 -t tcp
> -nfs41_ipv6_03 nfs03.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_03 nfs03.sh -6 -v 4.2 -t tcp
> +nfs03.sh_v3_ipv4_udp nfs03.sh -v 3 -t udp
> +nfs03.sh_v3_ipv4_tcp nfs03.sh -v 3 -t tcp
> +nfs03.sh_v4_ipv4_tcp nfs03.sh -v 4 -t tcp
> +nfs03.sh_v4.1_ipv4_tcp nfs03.sh -v 4.1 -t tcp
> +nfs03.sh_v4.2_ipv4_tcp nfs03.sh -v 4.2 -t tcp
> +nfs03.sh_v3_ipv6_udp nfs03.sh -6 -v 3 -t udp
> +nfs03.sh_v3_ipv6_tcp nfs03.sh -6 -v 3 -t tcp
> +nfs03.sh_v4_ipv6_tcp nfs03.sh -6 -v 4 -t tcp
> +nfs03.sh_v4.1_ipv6_tcp nfs03.sh -6 -v 4.1 -t tcp
> +nfs03.sh_v4.2_ipv6_tcp nfs03.sh -6 -v 4.2 -t tcp
>   
> -nfs3_04 nfs04.sh -v 3 -t udp
> -nfs3t_04 nfs04.sh -v 3 -t tcp
> -nfs4_04 nfs04.sh -v 4 -t tcp
> -nfs41_04 nfs04.sh -v 4.1 -t tcp
> -nfs42_04 nfs04.sh -v 4.2 -t tcp
> -nfs3_ipv6_04 nfs04.sh -6 -v 3 -t udp
> -nfs3t_ipv6_04 nfs04.sh -6 -v 3 -t tcp
> -nfs4_ipv6_04 nfs04.sh -6 -v 4 -t tcp
> -nfs41_ipv6_04 nfs04.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_04 nfs04.sh -6 -v 4.2 -t tcp
> +nfs04.sh_v3_ipv4_udp nfs04.sh -v 3 -t udp
> +nfs04.sh_v3_ipv4_tcp nfs04.sh -v 3 -t tcp
> +nfs04.sh_v4_ipv4_tcp nfs04.sh -v 4 -t tcp
> +nfs04.sh_v4.1_ipv4_tcp nfs04.sh -v 4.1 -t tcp
> +nfs04.sh_v4.2_ipv4_tcp nfs04.sh -v 4.2 -t tcp
> +nfs04.sh_v3_ipv6_udp nfs04.sh -6 -v 3 -t udp
> +nfs04.sh_v3_ipv6_tcp nfs04.sh -6 -v 3 -t tcp
> +nfs04.sh_v4_ipv6_tcp nfs04.sh -6 -v 4 -t tcp
> +nfs04.sh_v4.1_ipv6_tcp nfs04.sh -6 -v 4.1 -t tcp
> +nfs04.sh_v4.2_ipv6_tcp nfs04.sh -6 -v 4.2 -t tcp
>   
> -nfs3_05 nfs05.sh -v 3 -t udp
> -nfs3t_05 nfs05.sh -v 3 -t tcp
> -nfs4_05 nfs05.sh -v 4 -t tcp
> -nfs41_05 nfs05.sh -v 4.1 -t tcp
> -nfs42_05 nfs05.sh -v 4.2 -t tcp
> -nfs3_ipv6_05 nfs05.sh -6 -v 3 -t udp
> -nfs3t_ipv6_05 nfs05.sh -6 -v 3 -t tcp
> -nfs4_ipv6_05 nfs05.sh -6 -v 4 -t tcp
> -nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
> +nfs05.sh_v3_ipv4_udp nfs05.sh -v 3 -t udp
> +nfs05.sh_v3_ipv4_tcp nfs05.sh -v 3 -t tcp
> +nfs05.sh_v4_ipv4_tcp nfs05.sh -v 4 -t tcp
> +nfs05.sh_v4.1_ipv4_tcp nfs05.sh -v 4.1 -t tcp
> +nfs05.sh_v4.2_ipv4_tcp nfs05.sh -v 4.2 -t tcp
> +nfs05.sh_v3_ipv6_udp nfs05.sh -6 -v 3 -t udp
> +nfs05.sh_v3_ipv6_tcp nfs05.sh -6 -v 3 -t tcp
> +nfs05.sh_v4_ipv6_tcp nfs05.sh -6 -v 4 -t tcp
> +nfs05.sh_v4.1_ipv6_tcp nfs05.sh -6 -v 4.1 -t tcp
> +nfs05.sh_v4.2_ipv6_tcp nfs05.sh -6 -v 4.2 -t tcp
>   
> -nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> -nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> -nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> +nfs06.sh_v3_v4_ipv4_tcp_udp  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> +nfs06.sh_vall_ipv4tcp nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> +nfs06.sh_v4*_ipv6_tcp nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
>   
> -nfs3_07 nfs07.sh -v 3 -t udp
> -nfs3t_07 nfs07.sh -v 3 -t tcp
> -nfs4_07 nfs07.sh -v 4 -t tcp
> -nfs41_07 nfs07.sh -v 4.1 -t tcp
> -nfs42_07 nfs07.sh -v 4.2 -t tcp
> -nfs3_ipv6_07 nfs07.sh -6 -v 3 -t udp
> -nfs3t_ipv6_07 nfs07.sh -6 -v 3 -t tcp
> -nfs4_ipv6_07 nfs07.sh -6 -v 4 -t tcp
> -nfs41_ipv6_07 nfs07.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_07 nfs07.sh -6 -v 4.2 -t tcp
> +nfs07.sh_v3_ipv4_udp nfs07.sh -v 3 -t udp
> +nfs07.sh_v3_ipv4_tcp nfs07.sh -v 3 -t tcp
> +nfs07.sh_v4_ipv4_tcp nfs07.sh -v 4 -t tcp
> +nfs07.sh_v4.1_ipv4_tcp nfs07.sh -v 4.1 -t tcp
> +nfs07.sh_v4.2_ipv4_tcp nfs07.sh -v 4.2 -t tcp
> +nfs07.sh_v3_ipv6_udp nfs07.sh -6 -v 3 -t udp
> +nfs07.sh_v3_ipv6_tcp nfs07.sh -6 -v 3 -t tcp
> +nfs07.sh_v4_ipv6_tcp nfs07.sh -6 -v 4 -t tcp
> +nfs07.sh_v4.1_ipv6_tcp nfs07.sh -6 -v 4.1 -t tcp
> +nfs07.sh_v4.2_ipv6_tcp nfs07.sh -6 -v 4.2 -t tcp
>   
> -nfs3_08 nfs08.sh -v 3 -t udp
> -nfs3t_08 nfs08.sh -v 3 -t tcp
> -nfs4_08 nfs08.sh -v 4 -t tcp
> -nfs41_08 nfs08.sh -v 4.1 -t tcp
> -nfs42_08 nfs08.sh -v 4.2 -t tcp
> -nfs3_ipv6_08 nfs08.sh -6 -v 3 -t udp
> -nfs3t_ipv6_08 nfs08.sh -6 -v 3 -t tcp
> -nfs4_ipv6_08 nfs08.sh -6 -v 4 -t tcp
> -nfs41_ipv6_08 nfs08.sh -6 -v 4.1 -t tcp
> -nfs42_ipv6_08 nfs08.sh -6 -v 4.2 -t tcp
> +nfs08.sh_v3_ipv4_udp nfs08.sh -v 3 -t udp
> +nfs08.sh_v3_ipv4_tcp nfs08.sh -v 3 -t tcp
> +nfs08.sh_v4_ipv4_tcp nfs08.sh -v 4 -t tcp
> +nfs08.sh_v4.1_ipv4_tcp nfs08.sh -v 4.1 -t tcp
> +nfs08.sh_v4.2_ipv4_tcp nfs08.sh -v 4.2 -t tcp
> +nfs08.sh_v3_ipv6_udp nfs08.sh -6 -v 3 -t udp
> +nfs08.sh_v3_ipv6_tcp nfs08.sh -6 -v 3 -t tcp
> +nfs08.sh_v4_ipv6_tcp nfs08.sh -6 -v 4 -t tcp
> +nfs08.sh_v4.1_ipv6_tcp nfs08.sh -6 -v 4.1 -t tcp
> +nfs08.sh_v4.2_ipv6_tcp nfs08.sh -6 -v 4.2 -t tcp
>   
> -nfslock3_01 nfslock01.sh -v 3 -t udp
> -nfslock3t_01 nfslock01.sh -v 3 -t tcp
> -nfslock4_01 nfslock01.sh -v 4 -t tcp
> -nfslock41_01 nfslock01.sh -v 4.1 -t tcp
> -nfslock42_01 nfslock01.sh -v 4.2 -t tcp
> -nfslock3_ipv6_01 nfslock01.sh -6 -v 3 -t udp
> -nfslock3t_ipv6_01 nfslock01.sh -6 -v 3 -t tcp
> -nfslock4_ipv6_01 nfslock01.sh -6 -v 4 -t tcp
> -nfslock41_ipv6_01 nfslock01.sh -6 -v 4.1 -t tcp
> -nfslock42_ipv6_01 nfslock01.sh -6 -v 4.2 -t tcp
> +nfslock01.sh_v3_ipv4_udp nfslock01.sh -v 3 -t udp
> +nfslock01.sh_v3_ipv4_tcp nfslock01.sh -v 3 -t tcp
> +nfslock01.sh_v4_ipv4_tcp nfslock01.sh -v 4 -t tcp
> +nfslock01.sh_v4.1_ipv4_tcp nfslock01.sh -v 4.1 -t tcp
> +nfslock01.sh_v4.2_ipv4_tcp nfslock01.sh -v 4.2 -t tcp
> +nfslock01.sh_v3_ipv6_udp nfslock01.sh -6 -v 3 -t udp
> +nfslock01.sh_v3_ipv6_tcp nfslock01.sh -6 -v 3 -t tcp
> +nfslock01.sh_v4_ipv6_tcp nfslock01.sh -6 -v 4 -t tcp
> +nfslock01.sh_v4.1_ipv6_tcp nfslock01.sh -6 -v 4.1 -t tcp
> +nfslock01.sh_v4.2_ipv6_tcp nfslock01.sh -6 -v 4.2 -t tcp
>   
> -nfsstat3_01 nfsstat01.sh
> +nfsstat3.sh nfsstat01.sh
>   
> -nfsx3 fsx.sh -v 3 -t udp
> -nfsx3t fsx.sh -v 3 -t tcp
> -nfsx4 fsx.sh -v 4 -t tcp
> -nfsx41 fsx.sh -v 4.1 -t tcp
> -nfsx42 fsx.sh -v 4.2 -t tcp
> -nfsx3_ipv6 fsx.sh -6 -v 3 -t udp
> -nfsx3t_ipv6 fsx.sh -6 -v 3 -t tcp
> -nfsx4_ipv6 fsx.sh -6 -v 4 -t tcp
> -nfsx41_ipv6 fsx.sh -6 -v 4.1 -t tcp
> -nfsx42_ipv6 fsx.sh -6 -v 4.2 -t tcp
> +fsx.sh_v3_ipv4_udp fsx.sh -v 3 -t udp
> +fsx.sh_v3_ipv4_tcp fsx.sh -v 3 -t tcp
> +fsx.sh_v4_ipv4_tcp fsx.sh -v 4 -t tcp
> +fsx.sh_v4.1_ipv4_tcp fsx.sh -v 4.1 -t tcp
> +fsx.sh_v4.2_ipv4_tcp fsx.sh -v 4.2 -t tcp
> +fsx.sh_v3_ipv6_udp fsx.sh -6 -v 3 -t udp
> +fsx.sh_v3_ipv6_tcp fsx.sh -6 -v 3 -t tcp
> +fsx.sh_v4_ipv6_tcp fsx.sh -6 -v 4 -t tcp
> +fsx.sh_v4.1_ipv6_tcp fsx.sh -6 -v 4.1 -t tcp
> +fsx.sh_v4.2_ipv6_tcp fsx.sh -6 -v 4.2 -t tcp

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
