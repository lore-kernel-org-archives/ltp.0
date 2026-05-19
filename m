Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C11CD4F57
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779180988; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=bmKv8iyGuv+FAIy9wU9KZMMsv8xIRqLhpu6X1hTf7cs=;
 b=ck3RuEpTzrz+unP7CUauiwQtntimS13SFyMFGSZ9bZrYOQ6ofJtD+0x3UKdgjyw0lQ+xP
 3Y1FjrADBn/RRVSOhsW6Kds5KK9Zfa7f6Mb0oXK6as7Y8FePEUtb/cr+lIX6mEHq+eILAq+
 Q64rC0sK8FgkieKPQZ9a+hFMqN2r+54=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 055F73C6EDD
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:56:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F076D3C0848
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:56:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7024E1A00148
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:56:05 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so615992f8f.0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779180965; x=1779785765; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KEp0r3qvWa2yUEFxN8axLY92Vf9j0XTukFegBf04ETQ=;
 b=d9vtvDQhKWTl8tX+e0npi7rnxTF5hwjtJQ55vB21g/8M4qWGr02Wu/NITN5NcSejnl
 pC5QeOp1hOXk2SRZXN+JXAE75I2RWDbcqzv9wxBaKxIrty31SwvpQZSpG29hxD27lTah
 2JW2vUV3l7caH4W6audKAVnP2ofgx5RG3c6wXZKUfPo2mRUwhkY6SZOR51yLqmj9JM7T
 0e68Ze1TGvWmNd5F/KbDklldSvjrUPRDIG+W56dyqkGfFljJC8g2BuXLapM4hy/UDjbQ
 QIIUSdrq6HD1nXFSDEDxX7m5xsp8Y4FE1ulMtMBzvMFacKUzS7Sgbz1nnjm4Q+NhIRzO
 Dd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180965; x=1779785765;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEp0r3qvWa2yUEFxN8axLY92Vf9j0XTukFegBf04ETQ=;
 b=mpFJjz8R45vhrrdc+a1BERlmeWRxqutzwofQdnSuJsoJcXgwbv8OuKrfYExaryd9SH
 dHKY3ijiq0PdjtxuXPtmPsoFmEUvwbCTA3zhXkHKQ3yI5ZrwdEkLUVkfFapjKuu3FLyj
 pXFFJYpVH99kWnYQiV2xSOFl/5cXBcD9yyPohN442Q/7Zt+JQPRynYIG1Ff7fEwDwwU1
 H3nhqaynNCv3UbJ+V16Iw1duSQ/HrfeTcwPZnk3/amPM6jOfj6c3lKgwRzEr9eQeY9ym
 9mNVT95If8I9GG88OQQXcS/c1LxU+8ENte7DHihXSJ2GUfrSfqKeTEYPQeUvGaWtH1Z+
 ycOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9J+Dn1aJn6dSeXbx0gmsu2z6TOmF9gTPU05wKOMuJChrXDpkowFzviDQ5GM9i51NWzbAY=@lists.linux.it
X-Gm-Message-State: AOJu0Yz6Z3gYEX2vl3weHRbtB8uD3WA/KMYS+ODHzKNqjLWSmbRWv4hr
 sI6BqcWlSrPrqutYprj/8kb1/10Ip5w7T/o2b0/TLDuN4q0yfO+EV/gQoAQVFkX1X8U=
X-Gm-Gg: Acq92OHuHvNCNoFw/A6TV2we0xHv2Pmml0kauZQMiOBvytc2bWPj8Z/vaeaWakie0DT
 GvEnRwPxb/jOgT63KNrl1QFtHspwpRXRNup35g8zjEGMntX1YMm5Y+7stkB2vRJAPGxcTgue4LR
 KXnalR0aaukq+EEPNvfAvwBuoH0LKXIyTJumVQMI7ZzPXVAGZQz3fZDR+ai4ZfRBhV5R8SI/ZrR
 ebiQ1lEO23rVFqgUFytehyw1L4+skTKNr8lLiFiLHWW2x5NnTKhl9EPfwSTvC3WwoHvQ1kegrbO
 K1TTxMiqokTWeRuFAXDSCPNbQ3C4Hno9UKARauHAWcVCs00Kxc3yzrwzspdcVFm8s3iV8lhL3ZP
 hoKt74wXkVxzi5KCNoE2INwcqoH78cxtCh0vFG/3KLAvxultmwp4e6yg5RQ/jEw1Y7gRCnw19xy
 7mqHWc2ACyj8DtIdNLoqB2oG+YwToP9HjxEMuovhvz8iIpdWWOsq4A90pLOWCaNyhfiZXbfIKq
X-Received: by 2002:a05:6000:400f:b0:456:15fa:9eba with SMTP id
 ffacd0b85a97d-45e5c5a56f7mr28790839f8f.43.1779180964756; 
 Tue, 19 May 2026 01:56:04 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e7c22d8b7sm14893466f8f.6.2026.05.19.01.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:56:04 -0700 (PDT)
Message-ID: <6a0c25a4.a8d7227c.15d3fa.10da@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260513162256.3968-1-linuxtestproject.agent@gmail.com>
Date: Tue, 19 May 2026 08:56:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: Pass git root
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Petr,
> 
> On Wed, 13 May 2026, Petr Vorel wrote:
> > checkpatch: Pass git root
> 
> > -CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f
> > +CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f  --root $(abs_top_srcdir)
> 
> Note: there is a double space between `-f` and `--root`; consider collapsing
> to a single space for consistency.
> 

Can you please fix this before merging the patch?
Otherwise LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
