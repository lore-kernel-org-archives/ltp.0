Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9862DC433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 13:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBB233CA963
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:09:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04FE13C9C87
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:09:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 752B11A0091C
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:09:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D601D21B87;
 Tue, 10 May 2022 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652188143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JN/IM7m4g8QfqSeNr6cEMVaLU04dsQRqpWTOsS1VJoI=;
 b=MK3CmIC6XR8K6ND1VMtTJC16hHTlNhyYeHB30DOQDNDM41WaRa+s92HhFB8s/B4Z6wVJJS
 rK+DxF6Pc2elrQZ1G+UJkBAkg61ES4Kv+qOoypwKI/Ds5HOIPJJlHxuC7IEYrbECgGnjwh
 RadnegNJEIgMyxZkK+JtgACJoB/epAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652188143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JN/IM7m4g8QfqSeNr6cEMVaLU04dsQRqpWTOsS1VJoI=;
 b=XiQrfEStM1+psKOJQD0Jn9QWMhy9/HRhU9FN54iC9OhXKQxQ4+cftD+0+DTPfSlXynB8so
 OwwuV63MDg9r6VAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB3C613AC1;
 Tue, 10 May 2022 13:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H3xVLO9jemJDHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 10 May 2022 13:09:03 +0000
Date: Tue, 10 May 2022 15:08:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ynpjzif7cbxS5GX/@rei>
References: <20220510065104.1199-1-pvorel@suse.cz>
 <20220510065104.1199-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220510065104.1199-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] netns: Rewrite to use tst_net.sh
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +# Communication type between kernel and user space for basic setup: enabling and
> +# assigning IP addresses to the virtual ethernet devices. (Uses 'ip' command for
> +# netlink and 'ifconfig' for ioctl.)
> +# (netlink|ioctl)
> +COMM_TYPE="netlink"
> +
> +do_cleanup=
> +
> +netns_parse_args()
> +{
> +	case $1 in
> +	e) NS_EXEC="ns_exec" ;;
> +	I) COMM_TYPE="ioctl"; tst_require_cmds ifconfig ;;
> +	esac
> +}
> +
> +netns_usage()
> +{
> +	echo "usage: $0 [ -e ] [ -t ]"
                                  ^
				  -I
> +	echo "OPTIONS"
> +	echo "-e use ns_exec instead of ip"
> +	echo "-I test ioctl (with ifconfig) instead of netlink (with ip)"
> +}

Otherwise it looks like a nice cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
