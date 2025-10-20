Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6228CCCD195
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 01:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760923502; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=W+wWGn4Yu/njI/cI52WP7OJlqtR53AX7ywLZGJPu8Pk=;
 b=ZaxAGuWLXHq+bfijQQzRgQCNbOhpd0jTIk19bPfIq2Etb5mUDpolhyzUYJrNYOnG2YH2X
 mkgnHT2/0uRFxLn14IvJgQOnbBxLxBqp2sulREr7tZ9pWHyFx6YEvtQGXrV3RDISBnlpfQo
 VT+z9gJYxkn9Mdfh0jYcfMB7+Gcn998=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 017953CEF0C
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 03:25:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE00A3CA99B
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:24:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59ADB200911
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:24:41 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso34476245e9.0
 for <ltp@lists.linux.it>; Sun, 19 Oct 2025 18:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760923481; x=1761528281; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KEaLdklCRttcCveycMUSRvE3/INK70II2JsVmmZB1a0=;
 b=eVfE+akITJwPYf6lohXFFy3j2oM2JthdMOJI0L8DtSyz2AgtvNytf4F5147cZ8dVpN
 z6h+OC6+nab4ZGPGzCwzHbcn3CnV33O3KbbCrtJEUp3wjoU0d1dk8m62EtcezAGrJrle
 vpeuy4wNtA8dbwOhUsXzBzkraltFVAQoGs29uE+pWXq8wVseufxBFulh4et9j/JPPVgv
 w2l2DdENLmHiUxsToDf1asv4KFgyZ5U0X+gMh3vi8F0K3lgIYPW912aV+VeYa3uBRJxy
 QepabA18XOKmVi+tNg+icD7y5sKGO2G35X+peywdOfV61t3IHRKwsPmTq/SgKDRuMa95
 kJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760923481; x=1761528281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEaLdklCRttcCveycMUSRvE3/INK70II2JsVmmZB1a0=;
 b=X7GwgtkCCaIub3wznJ0GExJVfgWSXJHEr3hxRBe3BEvsigd3hsTWpGmlTD+hRU++sm
 dept6BNgKt5Qte7CBDvezOXrZ4rp87twrXYxyErs4HQQ5NT9BGrrR4FiyBFVvCSydscY
 TUqenMWCSGOIXsV8xrUhmvIEt5UzfKgaS3AevQ+iD6YEm5Bv+6XLYbxL8gncX11PCkwb
 /skGrkWHhJAfveujsDxFCB9SlSV/2qZSN00VHDGozyBdzgONLucR0aPfZCmZRAl//jeP
 K4NP8ql0P+LQYvyleQyGS7nABAZCGFjwxvAvWhfbEsewwoTOo4lLlEynbw6nlqdeYCnP
 f3LA==
X-Gm-Message-State: AOJu0Yy8Zh4VYOOEMBzBkn9XUHMwyO8DOxAluoqYpmIqrpIHyQrB7s+q
 H3Oi79aieNPASoTIEsdT9fMZJcmXzZU1z72+6JTnJ5lgtIcBYSHYJG/1tN6ytGDi0A==
X-Gm-Gg: ASbGnctha2MHics2b/bZfBMpUu2vJ955tYlz1CIN0BM4hxhif0fO5ktkjPRGiv1wTCt
 GMH6CuxuSiIRZLlrKFlfCAZQNKuz2WsqijL780EMB4P959UIqFYnrOhnB0v7f96llfKczqnQcYE
 1nxYM8TWQfwTUgPTi77aEIjMUI6/O0K62/TS189WF6t8Evf2O+O4TYrit0oJ8xD7tdoD14cN1b3
 aXF36p2jkdSuAoEIEeMmZjPoPDhtcKYshG4H6AIcF6vnu3HB8BHTGdgPI7HnkbWRGlGAu5ah0OW
 x6eQLScWDMk0HlRyWOFUU/YFCf+rizsJcFlebxapxvbPWNMTTL6Hpm94oOeErf8m2wczWsxxOO4
 e3nqpsYsauwkbtlbV/T6f+4cWf1ipSBa0u60anCbUbyaSLuqq56ipyT3O9RY009Npjnj+pUwBiY
 U=
X-Google-Smtp-Source: AGHT+IFp9cQi7IL8DYH4DUtU4AjPJZm0cIBcjxmkYMtjyDTwdxCe64MLhhJ73rrxGj94QussoRaawQ==
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-47117903f96mr85906055e9.25.1760923480704; 
 Sun, 19 Oct 2025 18:24:40 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cd49aa4sm100877505e9.2.2025.10.19.18.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 18:24:40 -0700 (PDT)
Date: Mon, 20 Oct 2025 01:24:39 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPWPV1opibF4--yR@localhost>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
 <20251017153746.GC339521@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017153746.GC339521@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

On Fri, Oct 17, 2025 at 05:37:46PM +0200, Petr Vorel wrote:
> Wei,
> 
> ..
> > +/**
> > + * struct tst_cmd - Provides details about a command struct needed by LTP test.
> > + * @cmd: The name of the command.
> > + * @optional: A flag indicating if the command is optional.
> > + * @present: A flag indicating if the command was found at runtime. This is an output
> > + * parameter, set by the LTP library during the test setup.
> > + */
> > +struct tst_cmd {
> > +	const char *cmd;
> > +	unsigned int optional:1;
> Any change you would modify one of lib/newlib_tests/tst_needs_cmds*.c
> to use tst_cmd->optional?
Good idea, will add test for this new parameter.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
