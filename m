Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A01C98315
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 05:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768800883; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XC84Yvr866UddxX6r5T9SlHk/MLcUvZdjXwK3va8Krw=;
 b=Z9c2PKWfMkqyCm8JoFaenG2F9v3BglhM1DpNdLMOv9xrtetFVxvfLlXEX7Oxj0XI/nEK6
 WKsnYUuMI40Km5Brixz38h1Dnvt9DY4Nm8KjATINWxDp8tKvz0HUXd3d+RiNNj6i8+AqJu+
 v/N1+dhBnsYuM3dUIhFT/PFI8pX39og=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BC3E3C6CF0
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 06:34:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8BFB3C2123
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 06:34:20 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2E3C910008F7
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 06:34:20 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3256798f8f.3
 for <ltp@lists.linux.it>; Sun, 18 Jan 2026 21:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768800859; x=1769405659; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RcZR/wusbCCIeYflLSySXp5xPVONx1hPvUimw49FluQ=;
 b=NLI9QLXOWHwwI07dkIcazlE/4JWXO0RzMngKmcWXJNu3K3CVw4nLL76L/nIZ+iZLRV
 xmMP32I56V6KWp2A7a51cMLHn9/FWmKFQPXISnxdOhlG0WVYUVOPemLCiKw0mRqMZYUl
 tLn7zCIaSQ17ytAGG9X5jY4DtDYxo03t946PdAWUr36FIaLggLH8Tfndgoz+GZPSTDYb
 D0Q9Yg7yb05VpYAu0up0owiRvMB6rrcZ3xZT5JrC5gSiO0PTgr2O9YR+yd0xK9JjGmSA
 2qHQ5JPP++mezNisaUyof9cLIfXlrCV/vwTynC3WSAZXcvsG/2LnC1hD9ea4yahX9yKq
 e7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768800859; x=1769405659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcZR/wusbCCIeYflLSySXp5xPVONx1hPvUimw49FluQ=;
 b=k3rDek2EVRQzmIU7G0kHW11C2OsAgXpCxuYDbo7zaCmBGm5pPP7HfkCMsweyRrBjKs
 cimifEo8aHSyhJPhUf1BF+KLjjdOBMjPYl+CTWC7cG3/qZd4OctYGB+ORzpaVXPcEhC9
 kowN91DQpl62HfDWHJmPPBqA0/wwscRemqgc3OCf99Y6HDcfVEmXeOOiTpPegnu6W/fJ
 DzVLKyhpWNc8A8P6RcK6pdnmeankALbrFimMMT+vaolCjocD6kxyPKeZ6IF3gsakNgsZ
 H68jdJMw1os1sShAozG8zI/Z2NXFbhdhD3Gw5KOdp7FuZFM2zL7fu4SNGNq40NbDeSpG
 WJRg==
X-Gm-Message-State: AOJu0YzTGwzeB01Hf95jyJ6kIzNSzl+tDM8Qi3DOLUIQ+e+Ah4C3N6DY
 8lczGUhFmAcRZ9BUXnVarHhCvgSrtRoV7YkwRKh2Fk+TFdaMMg+jHTGFrrAwfDATPg==
X-Gm-Gg: AY/fxX60s4uyyKLHBlOXNvmWjCQ7aHJTkptFNnEXJEABlTuWhHSk8SY23vpU7agTLuj
 VElDvXyGyzkn7GkvSm2JQTGDKR6mR32F9cODIIsBI/x1P+PB0sU3MMEFVxe840avU8CeFVt+87z
 Vc+wb8tqDdiQW36hfBRQZV1WyXkzLtYHhoyZiD/BE479AoAWMQMNS1dCbQ3/EE2llQDY3UlgjiN
 nGCsk64d0tjbdu7X9ql4yV2q0R8RBvXvDTPmCaXGhQqblf9ufKnx54dxqRkmDbH5ZQ7Twh35H/c
 5SlwFQNpm8/AU6+vN/uxVS9RNhF1APwHVBSi3ZKJShc7uw1Aq4JX55x1TFE9JYe3OXiLMoXEaIz
 lNwOzk+XNv0Rrziskc0HKiGzhcmTIBDbAz08tIDcVTrlXc4qU6AsKXAAVjCosDw1FjK1FAI26Qn
 8xon5VU1h3rhomY5SXfEfbN7MU5XlS
X-Received: by 2002:a05:6000:2506:b0:430:f7ae:af3e with SMTP id
 ffacd0b85a97d-43569bbafbfmr12111212f8f.32.1768800859516; 
 Sun, 18 Jan 2026 21:34:19 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6cdsm21846825f8f.31.2026.01.18.21.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 21:34:19 -0800 (PST)
Date: Mon, 19 Jan 2026 05:34:17 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aW3CWarQjleohiw3@autotest-wegao.qe.prg2.suse.org>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-4-wegao@suse.com>
 <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
 <aWuLke3rmststr0n@autotest-wegao.qe.prg2.suse.org>
 <CAEemH2f2s+LyRk_viTEhra989Ko5aeeHEUM5vULopyZE0bMvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f2s+LyRk_viTEhra989Ko5aeeHEUM5vULopyZE0bMvVw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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

On Mon, Jan 19, 2026 at 11:00:07AM +0800, Li Wang wrote:
> Wei Gao <wegao@suse.com> wrote:
> 
> 
> >
> > > Can we just reuse the 'tst_test->needs_cmds.present' result?
> > >
> > You cannot access tst_test->needs_cmds.present directly as if it were a
> > single variable,
> > because needs_cmds is an array (a list) of structures. To get the status
> > of a specific command
> > like "parted", you must iterate through that list to find the entry
> > matching that name.
> >
> 
> So how about using:  tst_test->needs_cmds[0].present?
Yes, i think direct indexing is more efficient, but helper function is more readable 
and extensible(If someone add more entry into .needs_cmds it possible break the
test case).
I would like to get more feedback on this topic before next patch. @Petr @Cyril ?
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
