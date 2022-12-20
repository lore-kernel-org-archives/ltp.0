Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84374C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 11:31:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CF6F3CBAA6
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 12:31:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C7FD3CBA4A
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 12:31:03 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FA791A0089D
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 12:31:03 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id y16so11457712wrm.2
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 03:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sMwUSf1Knb6nO4bysNgzYaFBQA7EasRnKhUYLd1XbEQ=;
 b=Jcpc3hZzkyHw5jaqVN47B0kjh4rqlicCTCrpr07kX6NaUE6jPH7AoK60UaNkNqXqUs
 LllcbTD5PzG8by9NSc7YKGlpHOQw8qdlaeYOfVK6BO/KyrMI+XDkqbk8i5YB3mrgmMZq
 W5S5NHfk5S2gEbKTuXhe3DKkKiVjjr+Sha7Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMwUSf1Knb6nO4bysNgzYaFBQA7EasRnKhUYLd1XbEQ=;
 b=Nj3ni+Q5zNRbLp9jc2Qx3aju5yKE5hVfEscKN8vNBTXfzb8A0ZrYjeFxp1e51FVsto
 iEfPO2RgOHt0reMNh9TxWG8shVt5cBDiXzFJvI6L9fom4v52OTOLxuqwTG+p3nzmowbl
 bTsbqFcyD3gD1DHbkFgqul6ORw8h9zmMZCCRkygYGDTRrLNy5LLaGNrEwbTUAlZ7ZNVK
 Khr0TwAef/mhhP9Blr9QzDr4NxOPpFtHTIZVPISfeiWoILc/UkhmIYArF66EUsDjy79Z
 0ooociKIDoZkzDUfgiJdo9uXNPJya8udEC26+X3RzUrsEKaJi2l5ijoMCkrpligUqcQX
 sZQg==
X-Gm-Message-State: AFqh2krSOu73ay0ZRE5x8tBPlOZ6nl72P0GQToyeOlmtwachqqlQvlnb
 BQmJUzVZtkJGPx9emhtIasiufQ==
X-Google-Smtp-Source: AMrXdXuaKYOykd9B24i860gLYModl8UbQ7MT5f1ldWklDuX3LN+enBcNgVEKYaGResr19+Osyzycig==
X-Received: by 2002:adf:fa45:0:b0:24a:9b90:b621 with SMTP id
 y5-20020adffa45000000b0024a9b90b621mr1050663wrr.30.1671535862767; 
 Tue, 20 Dec 2022 03:31:02 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1273:dbb7:632c:a9de?
 ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
 by smtp.gmail.com with ESMTPSA id
 c16-20020adffb50000000b002365254ea42sm12564688wrs.1.2022.12.20.03.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 03:31:02 -0800 (PST)
Message-ID: <80e0855f950ff8d2d6b68f5c2d81a91c9942ace8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
Date: Tue, 20 Dec 2022 11:31:01 +0000
In-Reply-To: <Y6GaNcnDTAEGaAh9@pevik>
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-2-pvorel@suse.cz>
 <CAASaF6yUfeCS_MnTiYR1v291d=A0xzijDRJqz1SgGORvnCEXbg@mail.gmail.com>
 <CAEemH2d=kNwrAmrvy21Si4wF9H0qqg_Zkq=12S9ZC=11MQKFSw@mail.gmail.com>
 <Y6GaNcnDTAEGaAh9@pevik>
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] doc: State the minimal kernel version
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
 Khem Raj <raj.khem@gmail.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2022-12-20 at 12:19 +0100, Petr Vorel wrote:
> > On Mon, Dec 19, 2022 at 5:52 PM Jan Stancek <jstancek@redhat.com>
> > wrote:
> 
> > > On Fri, Dec 16, 2022 at 10:46 AM Petr Vorel <pvorel@suse.cz>
> > > wrote:
> 
> > > > Because the tested version does not automatically mean the
> > > > minimal
> > > > supported.
> 
> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > > Hi all,
> 
> > > > I'm sorry to bother you, many of you concentrate on current
> > > > mainline (or
> > > > supported stable) instead of digging into history. But you
> > > > might know
> > > > about somebody who still cares about 3.x. Although not many of
> > > > these
> > > > people would try to run recent LTP on these old versions, but
> > > > we never
> > > > know.
> 
> > > > I started with 3.0 as that was the result of the old
> > > > discussions over
> > > > ML.  I'm perfectly ok, if we raise it to 3.10, which is tested.
> > > > I guess after CentOS 7 EOL we should raise support even higher.
> 
> > > I'd be fine with raising it to 3.10, that still covers CentOS7
> > > for now.
> > > (3.10 will be 10 years old in couple months)
> 
> 
> > +1 that's exactly!
> 
> OK, is anybody against raising the support to 3.10?
> 
> If not, I can change it:
> 
> -Minimal supported (although untested) kernel version is 3.0.
> +Minimal supported kernel version is 3.10.

Fine with me FWIW.

Cheers,

Richard

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
