Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A98CF6BE4
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767766624; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=y3iC/E+A6SNW9PigISf5w0wKi5sw4Qnfg3CtqDCv0dw=;
 b=XQBPHdeIxFCn+fBK41Fn3VMJoAHoPXkd2xX3UuKnFkoufC9J9TqqYWZQGOZfQZWYdTHW+
 1sDkALitlOOEIlwrwqVKknlAWh4J378buZ4jMCDovaiGs4ZS8GFTfDhgyGMtoxQMJqcDF/3
 0Q/b5C1eMKwVgjEVxmuQO9/+0s37qXk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 851653C2CC4
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 07:17:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E51363C2CC0
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 07:16:42 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2527860005A
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 07:16:42 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so18449755e9.1
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 22:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767766601; x=1768371401; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5YtkF5Dcb/ytwBHlptfECMpCqpxrg8X3lebWy1u8XIU=;
 b=SV2sc8qNsgTnIFfgcw7VuS3ORSfe15ZYxVzgoWcjWeN/k4Y88LFfCQpnEKivkAfsJr
 nrhT61X2JlkO/+GH1eiZSbPQLHQV4QXMmGSCYiqfDCeBNLqHagzuYPK6UplFrCr46OcC
 yvbiCpUdsgMg2Z6V4JCX3sC16rScpta3kHW7S8kbs77FDi+uubr/Gki2uRPoccTUhsvR
 qpPOUtKuUAbMpy0+Oj/wRNxG3bscsA+Jj9ZrL9+vNGWmLSyY/YuhufdnP9811IyhA4po
 evYLNoWRtJzTieBbadz4TdiXJvr71KSRTO4lOmbH17CUiqw9ua+XoSzcirOSyHQzTgyi
 70nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767766601; x=1768371401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YtkF5Dcb/ytwBHlptfECMpCqpxrg8X3lebWy1u8XIU=;
 b=kXVAzVEaOl9yjEWO1z6unljxguZKKPvCYnipFuinPdkgS/tU+CCXHgqgzr6tlvPErd
 RsJ71rKVP9Syz6ump908QDkwSU/xJUaISxmtRK2PdJDGTaf2J4XaV/5ulgzNSOBGX3Rl
 ehafRONNW7oC2l4zg9oc8srUCAXYZxAB09PnKGXFA6xigwnq2W5Ul6M61NK5qKAYBWoT
 cGXVqyWdjj287hwPKNcOkwYm9oStNmioF/HAW2KMB4w+B6X1gGHZBm/U3SbdpHY/3pGH
 z0JYZCzrXN1MtMJr8exchNsIgyECjkK/bqA2EngcV/36UoJ1qxsOwqxVXJhJsCOL2+Fn
 wtQA==
X-Gm-Message-State: AOJu0Yz0iNrOVySPri0EyqPRDBIh46zVuhahyz0jrNGydOHV/jYIc2Sj
 9idleK9dk+Ml3N1VS+8vsjHETSaVPZwQM7oodoxRcAsI+HzBEwXQrLRyo7bKXitLnQ==
X-Gm-Gg: AY/fxX4DMJsFMqESHfgLDYaGBcbixaEOgGni5SJAFhLt3HMxC8YQGRI4Bya+BWAbiWu
 8RuLkb90LWZbyoolXvXchmyf6KuGf5N5iwkc5ec1wpcLjB+5wA417I/hIeIUZOMVbkzbArVSJ0l
 S6H22fe8KN4M0RM1IR54t+pmUoPyM8hrfsA+OGu2apAglYze2R+0Mk71XrMjRhPNeOFwKQUistC
 Lm3NAupNsULC+cPFgsoWHIwHrah6dTQbJvjXdlz0+7uUj+7gmrNMmNkTEzDKKaqaaHP3MzwABrx
 aS4CqNP+HaiOgW8xNLmlVtG874pRvmB+K9aW8Od4MHCn6Yn336+9iHQ+nAbkMWMsfp9n/gTA91s
 bogW/iDOTkFtS+GyG+SC4d/iHirFhPNSZzNtqc2Lwe+AjKW4euhOfaRI+AA03ETpAM4cNDdy+M4
 RNExu1U30w+W+l5MJ4IWEAqYVkQHJY
X-Google-Smtp-Source: AGHT+IGkEl1xp+9MdO7LLmteigh/3LEwyAbTFfpw1DXEpaqTSz8h8RJT+GzcIcxaI/g+ipReuv+nRw==
X-Received: by 2002:a05:600c:c4a5:b0:477:95a0:fe95 with SMTP id
 5b1f17b1804b1-47d84b347ebmr12252915e9.24.1767766601500; 
 Tue, 06 Jan 2026 22:16:41 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f418538sm77841515e9.5.2026.01.06.22.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 22:16:41 -0800 (PST)
Date: Wed, 7 Jan 2026 06:16:39 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com> <aVzdrAgv9qdxZSt_@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aVzdrAgv9qdxZSt_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 06, 2026 at 11:02:20AM +0100, Cyril Hrubis wrote:
> Hi!
> >  /*
> >   * Validates exit status of child processes
> >   */
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 42a54621e..67553f65d 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
> >  	return tst_dev_fs_type();
> >  }
> >  
> > +bool tst_cmd_present(const char *cmd)
> > +{
> > +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> > +
> > +	while (pcmd->cmd) {
> > +		if (!strcmp(pcmd->cmd, cmd))
> > +			return pcmd->present;
> > +
> > +		pcmd++;
> > +	}
> > +	return false;
> 
> For a third time, when we get here we asked for something that haven't
> been tested for so we should tst_brk() here!
> 
I think you may have missed my earlier explanation of why we should avoid using tst_brk() here.
https://lore.kernel.org/ltp/aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org/

> > +}
> > +
> >  static void do_setup(int argc, char *argv[])
> >  {
> >  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> > -- 
> > 2.52.0
> > 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
