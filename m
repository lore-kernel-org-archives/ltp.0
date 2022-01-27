Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF2C433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 12:44:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A5E23C972E
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 13:44:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 161C63C4EC5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 13:44:04 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED1AA140074B
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 13:44:03 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A41AD9F7D2;
 Thu, 27 Jan 2022 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1643287442; bh=jKb1XkbUaCDaDyzIFNrFBpaFEZLKBgtWDhMeZgKx9sU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=KPhjqgXsrtYOWBGT2U6w1CpgpOzpVzOsj/HO8EOhooF4XULgZ6DJWJzLB4Hf9CTN9
 Yz32BES5KIAu4RaNvarwSBeSrmV+cI8PY1ydCB0iSbcMow5CXvsZ7NMvwpuz7P+Qrc
 ni45FSYkf1CAalRYSv6c/Mxl8jjwOEFvY8foPlOs=
Message-ID: <bc201166-e761-d23a-fa77-14f8552c0b13@jv-coder.de>
Date: Thu, 27 Jan 2022 13:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <YfJ6fIbFvN7rD0SR@pevik>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YfJ6fIbFvN7rD0SR@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] HOST_{CFLAGS,LDFLAGS} definition
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
sorry for the resend, forgot the mailing list

Am 1/27/2022 um 11:57 AM schrieb Petr Vorel:
> Hi,
> 
> not sure what I do wrong, but due evaluation in include/mk/config.mk.in:
> 
> ifeq ($(strip $(HOST_CFLAGS)),)
> HOST_CFLAGS := $(CFLAGS)
> endif
> 
> ifeq ($(strip $(HOST_LDFLAGS)),)
> HOST_LDFLAGS := $(LDFLAGS)
> endif
> 
> HOST_CFLAGS and HOST_LDFLAGS must be defined for make (not for configure).
> Of course exporting variables works.
> 
> Also whole point of previous code was to have a default, but that's wrong.
> On some embedded platforms it fails as without properly defined HOST_CFLAGS it
> can inherit flags which aren't usable for host (e.g. -mlongcalls
> -mauto-litpools) and whole compilation fails.

Having the default is required for native builds.
The only problem I see with this is that empty HOST_CFLAGS passed
through the environment is not possible using the current
implementation. It is however possible passing en empte HOST_CFLAGS as
make parameter:

Makefile:
CFLAGS := cflags

ifeq ($(strip $(HOST_CFLAGS)),)
HOST_CFLAGS := $(CFLAGS)
endif

all:
	@echo "Value of HOST_CFLAGS: '${HOST_CFLAGS}'"


$ make
Value of HOST_CFLAGS: 'cflags'

$ make HOST_CFLAGS=host
Value of HOST_CFLAGS: 'host'

$ make HOST_CFLAGS=
Value of HOST_CFLAGS: ''


> IMHO we should change it to (i.e. not inherit anything):
> 
> HOST_CFLAGS := $(HOST_CFLAGS)
> HOST_LDFLAGS := $(HOST_LDFLAGS)
> 
> HOST_CFLAGS += $(WLDFLAGS)
> HOST_LDFLAGS += $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
> 
This wouldn't have any effect if HOST_CFLAGS is passed as parameter to
make and would be even worse than the current solution, if HOST_CFLAGS
is passed on the shell. You do not want any default switches, that are
not absolutely necessary, otherwise you can have the same problem as
before: Incompatibility with the host compiler.

Maybe we should learn from the kernel here. It doesn't have a
HOST_CFLAGS, just a HOSTCC. If you want to add CFLAGS for the host, you
just append it to the HOSTCC.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
