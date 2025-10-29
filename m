Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA93CCF9E9
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 09:55:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5DF03C5556
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 10:55:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 721F33C291D
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 10:55:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BDACC200A10
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 10:55:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2418C20554;
 Wed, 29 Oct 2025 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761731710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMaKxlN2+mHlRneWvLAL42WHd3oqneHhwwC2C5Qts2U=;
 b=pl1Ara4ZeY940MavPzxUWl9cPrG4mWi27daudy7lTOr4zIZNM0jcIU96B6hK6bd/Pnotm2
 ADFVIvuMnou2cOADFCiAmTKxYT6Orx2vLEFPwXiRTog5+Nri+UsbXlG2LIircv7lqk/xCY
 PHiGd3jCVfWjZgta+73dbsZO07Fh/nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761731710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMaKxlN2+mHlRneWvLAL42WHd3oqneHhwwC2C5Qts2U=;
 b=nVS9nMMch1WPAeNRiU96K1Xs+ESPuFiiNujODp/XcSYLLhMQuogkAlRJlsgv1fDEq97smu
 SMOo8VuAiJuzkBCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761731709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMaKxlN2+mHlRneWvLAL42WHd3oqneHhwwC2C5Qts2U=;
 b=ydKYGH02AciPrHPrgFtutshlk7eSrrWDmd/dStfDf6TAXiz4T/t1qDDgcAIJEw03BUCVzJ
 4dXdRuMnME5x1r9NlbftfOgTlsevo/6nDnJQqeAX+XOKNATUqE02PbZ1Tkv8Bx0JvLBUOu
 CZ92a5AVEsslxO1k2GI7nmON9FFIc38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761731709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMaKxlN2+mHlRneWvLAL42WHd3oqneHhwwC2C5Qts2U=;
 b=lRA72IeWwSfyjH/ET9dZDsVlqDEcdkzFYSIQWRcneNA25zJPJfj1SVdRh4Ex9s3P60r4p8
 5BglBXT9fYM+GQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 045761396A;
 Wed, 29 Oct 2025 09:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vagIOnzkAWlmHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 29 Oct 2025 09:55:08 +0000
Date: Wed, 29 Oct 2025 10:54:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aQHkSPsLyx4O_VXk@rei>
References: <20251022095740.8747-1-mdoucha@suse.cz>
 <20251022095740.8747-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251022095740.8747-2-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ioctl_sg01: Print buffer contents on failure
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

Hi!
> +static void dump_hex(const char *str, size_t size)
> +{
> +	size_t i;
> +
> +	for (; size && !str[size - 1]; size--)
> +		;
> +
> +	for (i = 0; i < size; i++) {
> +		if (i && (i % 32) == 0)
> +			printf("\n");
> +		else if (i && (i % 4) == 0)
> +			printf(" ");
> +
> +		printf("%02x", (unsigned int)str[i]);
> +	}
> +
> +	printf("\n");
> +}
> +
>  static void setup(void)
>  {
>  	const char *devpath = find_generic_scsi_device(O_RDONLY, 1);
> @@ -135,6 +154,7 @@ static void run(void)
>  
>  	for (i = 0; i < 100; i++) {
>  		TEST(ioctl(devfd, SG_IO, &query));
> +		buffer[BUF_SIZE] = '\0';
>  
>  		if (TST_RET != 0 && TST_RET != -1)
>  			tst_brk(TBROK|TTERRNO, "Invalid ioctl() return value");
> @@ -143,6 +163,8 @@ static void run(void)
>  		for (j = 0; j < BUF_SIZE; j++) {
>  			if (buffer[j]) {
>  				tst_res(TFAIL, "Kernel memory leaked");
> +				tst_res(TINFO, "Buffer contents: %s", buffer);

Any reason why we don't use tst_res_hexd() instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
