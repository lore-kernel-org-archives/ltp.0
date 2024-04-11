Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367FCC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 20:56:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C4353CF858
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 22:56:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 708463CF7E1
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 22:56:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B34FA60008B
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 22:56:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 471165D54F;
 Thu, 11 Apr 2024 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712868971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j102xMdsrb5grD4SMrd+sgA3FbKYK4eBYkVI9DXlmIc=;
 b=az0U24TiWP5wVEU3Jv690ERnBtq54k8igKssgT7b+9I49K3CBQNWnT6ZYgzOV0YPxL9IFf
 ftL+yTO6HZQJIlZiLo7WvtG2dp1Eie/jGM6gAaNCP1snK+CNoRImZ3j+RCPNHlvoiJw2mY
 /vCstpqXy0A5cDn6+RBK0WkFZywRk4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712868971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j102xMdsrb5grD4SMrd+sgA3FbKYK4eBYkVI9DXlmIc=;
 b=XK1C48ft/nEVd1DNKyVZjq/Hio0JhBxUPFm1HQ4e0EANoxO2hw3siK5LkmukCNwsasbaqB
 2vM5qlGCE+xAvfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712868971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j102xMdsrb5grD4SMrd+sgA3FbKYK4eBYkVI9DXlmIc=;
 b=az0U24TiWP5wVEU3Jv690ERnBtq54k8igKssgT7b+9I49K3CBQNWnT6ZYgzOV0YPxL9IFf
 ftL+yTO6HZQJIlZiLo7WvtG2dp1Eie/jGM6gAaNCP1snK+CNoRImZ3j+RCPNHlvoiJw2mY
 /vCstpqXy0A5cDn6+RBK0WkFZywRk4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712868971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j102xMdsrb5grD4SMrd+sgA3FbKYK4eBYkVI9DXlmIc=;
 b=XK1C48ft/nEVd1DNKyVZjq/Hio0JhBxUPFm1HQ4e0EANoxO2hw3siK5LkmukCNwsasbaqB
 2vM5qlGCE+xAvfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0553313685;
 Thu, 11 Apr 2024 20:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id msWOOmpOGGYOPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 20:56:10 +0000
Date: Thu, 11 Apr 2024 22:56:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240411205609.GC368229@pevik>
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-30-pvorel@suse.cz> <ZhgJo2DJW4QjFFfd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhgJo2DJW4QjFFfd@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 29/31] lib: Remove -C option and self_exec.c
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> >  static void parse_opts(int argc, char *argv[])
> >  {
> >  	unsigned int i, topts_len = count_options();
> > @@ -704,15 +698,6 @@ static void parse_opts(int argc, char *argv[])
> >  			else
> >  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
> >  		break;
> > -		case 'V':
> > -			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
> > -			exit(0);
> > -		break;

> This should stay.

Thanks for catching -V. I wonder myself why I removed it.

So far 2 changes, fixes are in remove-UCLINUX.rebased.fixes in my LTP fork:

https://github.com/pevik/ltp/commits/remove-UCLINUX.rebased.fixes/

Kind regards,
Petr

> > -		case 'C':
> > -#ifdef UCLINUX
> > -			child_args = optarg;
> > -#endif
> > -		break;
> >  		default:
> >  			parse_topt(topts_len, opt, optarg);
> >  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
