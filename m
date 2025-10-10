Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD70CCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760077999; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PrnCfrrCEyb2uaOcDnyI5SiiyqouIlG2gu3wgASao2I=;
 b=SPD+dyfBbUjULwRN2cHGl9YrkEwgeKO5+c8+7njF6dYdkxFF0djNYOKRxITBOa6OF3RkO
 z1CjPg8qKd03U+wOl5A/LDPwzgJH0ofPof15SZpeDvjAGtkauJWc3dT0Q7uIg3Sijei4Nal
 jIgNYSNbRKqR1InolIn1m5WYp9atiy0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2163CD1C1
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:33:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D48A93CD1C1
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:32:57 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 270F0600BC3
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:32:57 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso830115f8f.2
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760077976; x=1760682776; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SDAisZwPAm8TjuGsrCDjl8x5vLzcKFsf2Yrac+QIRIY=;
 b=TRsLzQc20WV9y54jsFEMBWaX8zgcquM+93LeNR74H6gCRmKgKiIhcp2/QgQmggKH/b
 EAvg6iB84kJnbQgbQQEw0RIJylUYYHzP/jxmQHZzP4HWeB9qC15kVYeAw6nxRLXdynoa
 CMt/YA/os55ap+ykMEbJ2XJYvM9wlnqE8EF68+Sex2F4O01Z07AAT1H36j4pBuVeZOyh
 iyjYYKpgQhSZjjWvP893bEtf/tqlnF4x6Ih3MVSzcY5VJizWl4XSsKMdPKMnEhH2Qd2Q
 oZZ+0MoaVeWUrcRdXBPN3KHHwiuSiS4FqoX+YBWpgor67VPtlvyX+kz3jMybljAmRxMX
 yVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077976; x=1760682776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDAisZwPAm8TjuGsrCDjl8x5vLzcKFsf2Yrac+QIRIY=;
 b=xLW+Ya94EIpP0UwUplR5DH/tJZQNH4DESkCvoToeeI7zDi2ZVF1fLG1UEPAowZvzMU
 jxjxbUzwQ/gc1fCQpCL2UCbrGoc7p1QHi60uhwQGZ0uXUExx9HrM1wEUw0fBKkA5N+oV
 hMCvZPl7UGr18Jk+9tgUdr9shymzj66FOhM7IcqcccnbNqdLOznBJDaWTQLpUwcnlIWM
 YUNXOPtIIEIdTp/NgGuxexVRHDQJ8FjZy3hDe+GOs3gDWrbZSb9Z5erYLLG1gk5m7M9K
 ZL7uWtcdhXo+WiHXbr/7DXDi8R/XAENHIl2PfwsKHyECkshLbmFGsvF242MTgH/PiQKg
 qJYQ==
X-Gm-Message-State: AOJu0Yz93Ea/nua/KHOyj9LRDF8fGZ0AZ8RcRv5oEM3KmvxSJ9jcPnqC
 hzLo3LaUz0sEGZpQ9bvlEPbODdwvQz/4Wyk1d4OJ9go4SgHNyBMaobmFdnP5rc9NlSqfRQrwDHX
 DF3A=
X-Gm-Gg: ASbGncsXxaZlDt1rl4rhrwRzLtvldoXCEOc9cFTxxKxJFpeTZU8lTRol5h+r/f/QMCH
 98BL8bjI+IUWXmwYQhkmRbKCguYm4o4OVLOwHl3ZrOhuHX+bhog12kJE84CIGH+sdne8nNqnkgz
 tKlBoQTsHOxHkVW7UrjGJN9li9PBI0bP4oSd7K0SFsQ319+fcJTdXpQzeCrtKiEpugywGt1mNjn
 Z3C4770SqilBRqBJLudOB2ZY37ElCapIJe5Mj0UuMcjqAIS0GRZtAJmsv1Oa0E0hAzf8yXQkrz6
 IxHMCywlO3rF8ExSkJjNXQUX8Ti6MPcvoOUabGUA4KJv8lMzpc+Eisls5R039lnqFlVwLy7uxuW
 rF8m3Un+k39isqwrnCvUvDKFTwYcmqQ==
X-Google-Smtp-Source: AGHT+IGrMSwa+QvFvvCY5RS2fUFBVXJ560rcAA5vIhciWUBFAXtoyoH8f47rLeo6glP3v1u1tXf2SQ==
X-Received: by 2002:a05:6000:22c5:b0:411:3c14:3a8b with SMTP id
 ffacd0b85a97d-4266e8dd041mr7123662f8f.61.1760077976431; 
 Thu, 09 Oct 2025 23:32:56 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e83e1sm2581079f8f.51.2025.10.09.23.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:32:56 -0700 (PDT)
Date: Fri, 10 Oct 2025 06:32:54 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aOiolrvYBP-shA8Q@localhost>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250928232708.24007-1-wegao@suse.com>
 <20250928232708.24007-2-wegao@suse.com>
 <20250930133623.GB238065@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250930133623.GB238065@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: Add support option for .needs_cmds
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

On Tue, Sep 30, 2025 at 03:36:23PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +++ b/include/tst_cmd.h
> > @@ -16,6 +16,12 @@ enum tst_cmd_flags {
> >  	TST_CMD_TCONF_ON_MISSING = 2,
> >  };
> 
> > +struct tst_cmd {
> > +	const char *cmd;
> > +	unsigned int optional:1;
> > +	unsigned int present:1;
> 
> Maybe s/present/available/ ?
This is suggested by Cyril Hrubis during v1 review.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
