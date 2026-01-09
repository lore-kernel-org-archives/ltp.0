Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4057DD232E3
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 06:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767939109; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EfHI2RZS6pG/PNM6vEn+QNs1WtjVatlaFt5NOZs/DLU=;
 b=I6oo7A2gUyCwyxMojg8l6i2oY5IFFhOR2ZkaBlxyFtYhR44HAUKgyTiT8X1xDmaKkBCHJ
 JpHp11uA2CFFFsrQ/2LLL66eSaZXxLWZwIj9eVNtQauz52ZVslPY1WbpifLIpheH9Jwa+7j
 Rv+mPs0yd5jxokd9+YZkIEt2L80qMso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936733C6B25
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:11:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755473C4D7D
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:11:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA3AC6008D0
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:11:26 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso41779545e9.0
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767939086; x=1768543886; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1qjoqEAbgP4ub+9DcwAvHULhwEIF+pvIt7VWCTg4pN4=;
 b=L66hkiWtzDD5FMhKPWTgmjp61si/DPBjxShsWu5u6js0UOELpCjjmrkRB2xUgde5nV
 F1YZHi/O2Zgnbp1NmX9pFHKPoKHQQJ48wqmw5nH194SR6vrXfTZiHIBpyZ0dSDou/5Gz
 0tyVHDCzuYT5KzhDDipSomK2cNqV0fyyTlbZx72kvX4G+2v0fF/d4wt9CPclE2VajS5L
 8+ExKAeGbVTfWnQwigRHiE1noCfpXWy5zssFZaa1lLYmNKY7d4JDLr/lVEwz+bRracLl
 QDOQlBcxMtMdM5et9Lydje12Bw3BTDLsjLN3t9XmafIOBizqOqaCKiwchxfn6lA3dDod
 TLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767939086; x=1768543886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qjoqEAbgP4ub+9DcwAvHULhwEIF+pvIt7VWCTg4pN4=;
 b=GelQcyzOn5GWziyA3Xx9yOHAHO/klWFdK3gvuoLMOR3yVsBraclLiKgLyCgkZ26ERQ
 KvQU6MIyNa4W4kFjxP2vcvktfRJhmAd16O7ImW6lFHImLTP9tO5bm1jd0Zfzz9Hj8F4Q
 tCE0u+P6NnNGseb+JaBDO7wpYloyLMama/Pxp81OT+YXs/JE4UsRf4wedYFcUPvMve6w
 ncugqW59sfDHB8fgcZ4HQwm3rm2tyxOpoYxHnHZmx/izKw9cRSafIG3sRxU3g08FQF53
 AZxUlpQw4zvEJu7c9FcTMo0sN9gb3hJV1DsV5LUEZGZxh3M19Lt7nn1X990ZI2ABqS8l
 3qeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgQlumeuRbT9XtC1eOSMWRhQnjj/SBVndD1GOKowduOr1x+o2AIP9U5SfrRzW2zeeHgoo=@lists.linux.it
X-Gm-Message-State: AOJu0YyDXp+UA/9vVKWNs2rIxZhCEmIGr2x09B0hUr688cuAUGsQVL+p
 nsHYmOwreD4eQjs78wlPQ6yq4BKMoqxGSQJTubwVRSICbXhjIz2JKEa/eaC9F6ntzQ==
X-Gm-Gg: AY/fxX6zNWEA6PG4kxVAmrqL7LKEtESzt4/jQNN0vPfihJaZBJ+Vup51B1OKZ/bnGD9
 YsSGtrwKz5XxSXsKlRPaksCqTWk7KLxS4N3/QPGiilUkzNNmWu83cc3mDk5fryTAkyVwDzoMMjF
 Vcs+RN5UidBweNhFO888cc7XT8ifUQxANPy8s6rHHT7YbJQF/9SAeTTO5rtUIiibVVV76DAQhJR
 OX3Srz7Ve14uTaatV9iT7pMdPqDdSPHaW7LVNy5z9ctn4WmJcRLYXmXolmdvYbEnvISqpUYbCdZ
 ZHGMjkax+1jRMdadpdtDinh0y512izhtbuKrWow3ZebIKX8mtu5OYgsDB2ZJg/HGKfD0uCuYIOC
 5B6SxY7R+jep47I1O8YDTgYjmWW1bp/GT5anUogYSrmKqsxIm9p/snI5f6y2iCnCmd+CdR3P+Ms
 H+jygtpR1l7+ivLT4vG1mzGZxLk2DD
X-Google-Smtp-Source: AGHT+IHe4yrdTU8MQjKcihp+QbZnx7AXoAj8PlqjVSeqs9reRA9h3DbZJqfeMgN3DXMMPo4wwdytJQ==
X-Received: by 2002:a05:600c:3e8e:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47d84b18596mr95105495e9.10.1767939086152; 
 Thu, 08 Jan 2026 22:11:26 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695956sm195372425e9.6.2026.01.08.22.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:11:25 -0800 (PST)
Date: Fri, 9 Jan 2026 06:11:24 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aWCcDA33CsbS6T2-@autotest-wegao.qe.prg2.suse.org>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com> <aVzdrAgv9qdxZSt_@yuki.lan>
 <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
 <20260107080957.GD727950@pevik> <20260107082727.GE727950@pevik>
 <aV4ujjfb7JBB2zaQ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV4ujjfb7JBB2zaQ@yuki.lan>
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

On Wed, Jan 07, 2026 at 10:59:42AM +0100, Cyril Hrubis wrote:
> Hi!
> > 1) tst_brk for not checked command at the end.
> > 2) tst_brk for NULL otherwise we get segfault. Maybe check also for empty
> > command before attempting to do anything else.
> 
> Technically the empty command will end up in the tst_brk() at the end,
> so I would add only the NULL check.
> 
> > index bf92e6cc92..cf67c2a9f0 100644
> > --- lib/tst_test.c
> > +++ lib/tst_test.c
> > @@ -1379,12 +1379,16 @@ bool tst_cmd_present(const char *cmd)
> >  {
> >  	struct tst_cmd *pcmd = tst_test->needs_cmds;
> >  
> > +	if (!cmd || cmd[0] == '\0')
> > +		tst_brk(TBROK, "Invalid cmd");
> > +
> >  	while (pcmd->cmd) {
> >  		if (!strcmp(pcmd->cmd, cmd))
> >  			return pcmd->present;
> >  
> >  		pcmd++;
> >  	}
> > +	tst_brk(TBROK, "'%s' not checked", cmd);
> >  	return false;
> >  }
> >  
> > 
> > 3) Shouldn't we use tst_brk_() to point to the code in the test instead of
> > tst_brk()? If yes, we probably want to have tst_cmd_present_() as library
> > internal (static, with const char *file, const int lineno parameters) which
> > calls tst_brk_() and tst_cmd_present() as public (the only with signature in
> > header).
> 
> I do not think that this is that important to have, the
> tst_cmd_present() calls are going to be quite rare and hence easy to
> locate in the sources.

Thanks @Petr @Cyril, will send next patchset.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
