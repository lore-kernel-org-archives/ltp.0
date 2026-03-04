Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BA8EB7EAC
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772616026; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=hYJjxL5F7LhKOU8UZm2l0F1m+1R+MMVXhlomsFEGg1A=;
 b=A03v8oAeXeVv9giSGEoOnCJGissB4mGJbGVNeVseeIIc3Vnyf5GkTUrt+SvK+eahvWyK6
 GNv7tO5mm8TUqWjyre5sx7hRmiYTVQqHJcDC/fQgd/kBdQIMLPA1SAYHhjpKOb9k9Ze4TOO
 wwjjKid1w5xwy9hAjazvKBnWnj41sOA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F3363DAD36
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:20:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB1143CB27C
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:20:03 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20A2D1400C64
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:20:02 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439aeed8a5bso3642482f8f.3
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772616002; x=1773220802; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ322FUUHIHZekRehL98JyKdmPlbKQxfGHntQtbK7dg=;
 b=atdMYSZYhKnaAgW1SS3PORyM9Kwfpn+T74rs+EOX/jdCnuvoqjBVysHXFGn5MuvbGd
 5EUuNFlXe+Yx8oVNRp3ctZmjbeG/r41vlObA1GdThEjH38cBTLhNFlAMo4JnMr+mUCcp
 Xpti+a0F03myznoOULRtdPJ+9AnHH/MlA6FpSq9LDzgnTI4KwU933KFwGTX6z+X+oEi3
 Jczq8wFrDMUNRC0bhe7R06UbUoPJZZ4uZ1CC42drTPEKdHx2S8T4tFaOxBfe1Lu7cg7o
 eXSWk7yNRRTWEKYsQsi6Mc75B9p9PeV+B8KxV+TxihccUkixTsANtEnSK4cq+kCmXRCC
 ADOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772616002; x=1773220802;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJ322FUUHIHZekRehL98JyKdmPlbKQxfGHntQtbK7dg=;
 b=NkcNMKRIXDgNng8VaRzEC4Owr+1fd/cSTVbsHk1cxI05E/fMnLDvTsm/dSzVjnQCpI
 D0NakEgp4CvB+4onbSii8ZqVCy0w5Z7mAaBcPQPtPcO6zEG1ofA61mXyMSk1xTsMtsxk
 TTuelpSmDh6KxJVjqQlQBV/GYyhtKmrKf0Ba95Wfhxv4wujGyCxUEfKtD9SpwkaICHX7
 7OdWPDwe61mJYK2Cc3iCCqVrNIIBQTGrJg8JDRVGtuw27VsW1Kw39gqbBMjYPyhjD30o
 WhfnwhpTx8T4JBxf1VmW8RH7oR/KtPUYW9eRPeS73pqIQ33Ehmul4bDHtk4G1/CzVran
 gT7w==
X-Gm-Message-State: AOJu0YxoOS6my+zZtF6hdu6jKlLiJyORBBxI758GLGqpRJGtGg8ZGffb
 TbuJPTceR53F7hIujsVNjHt2yfbrh5nb5BgcSA6/RtfM1J2E+Detv8MOHio6XP0KFzy97oquEj6
 mNrQrklY=
X-Gm-Gg: ATEYQzyE9bDYtFHIyuRN7DEODV2T+N0PiD+640BQOSivkZQfxieONgVu7zhXlyQCpaM
 7uvPRYAgGkmRtZ8k91ygeaQqTfy5oIgdyj45sVZbkEsXavmJY/BgsSNqysMwGVShpB3oAJd4pQH
 r21SvOUn4EwZeIwr4nvcikaYeOMMNasjYY7BYeFEAOaYk4IMVEkVTQEJXSGPI1D+xZHOHWLAOh8
 NGb0yI7wgt76CPCDBXvDNNe57iajoAcsrYiQIG+IeDmFSIpNvewtd79UGpgOggPLUkaWu3r4D3S
 C5pp4qoTW92KiJcuycQpM2jSXH+N1eoB6I7WMCsnBHmPKKKSUjmCr86NxOzEyDru3iqTzY3r5im
 FAOS8Oe0+K/nyKgVPJEN4RENTGVDFN3tlLXeXjn7GpgftCk1zjOC+yyVok24vCpBJT0Bnpln5zL
 1WdR99JQpoceHuIlmRSYTwd4qTpBk8S6h4X0ZwCZOx0p/wESGU7+q9ILFcDrX6UYIQA8Uvdoi44
 dQ0iU5pjwEJ6CegGDhnKT+7eeuIf6YDUB0=
X-Received: by 2002:a5d:5d85:0:b0:439:b6d6:71a with SMTP id
 ffacd0b85a97d-439c8024aa2mr2553038f8f.51.1772616001736; 
 Wed, 04 Mar 2026 01:20:01 -0800 (PST)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm21788828f8f.36.2026.03.04.01.20.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:20:00 -0800 (PST)
Message-ID: <69a7f940.5d0a0220.27e3ef.38eb@mx.google.com>
To: "Li Wang via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260304034034.59303-1-liwang@redhat.com>
Date: Wed, 04 Mar 2026 09:19:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Extend -D flag to support multiple
 debug levels
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> +
> +Suppress all debug logs if no '-D' flag passed (by default behavoir).
                                                                  ^
								   behavior

The rest looks fine:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
