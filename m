Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C28CC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785507845; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LJh405zSytwdVLfEdV8YRpWekomTK8EzvpEkodC17OI=;
 b=MH5n1HXebYAGw950lQXJjpzdMrFin+W68FlqwKfo5B8LLovWoFosQ4ifwclul6FDqiPkY
 rDnR3Am/vg2tjNga1eLjxUXnroKgR8mdozGx6qHs8GbWCF4LkFbFFn7q9kyQH8ShOAu51Hv
 0C9GWNU3btzc9p6LCxv1fBmYIsqJ26k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C7563E7604
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 16:24:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D7353E4A86
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:23:45 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46511200AE7
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:23:45 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1105373f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785507825; x=1786112625; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/R7C8kprnzqI+wJ4/RCHXWxeL0rrPJZxpJBXBPfQsNM=;
 b=QOtm66p+C7pLZj76OW1xaNo9gGB0qbPuwxQgf5iSasBmE5E1gHlkr+wvd5uxr9hhkO
 MRMpgjM2hAsXrDN+71ljp3Gu5xZi/WTfabTFZ2D5aI45eB8mDx9Ta10fYXyoivVhZLca
 15gcis9zXDpTCuH3RSbyiSrSP37du/gbPlIl5yf/QQv/GsFHbX6GDdBGc5S44nmUBL+y
 /cwrqnqLMAtZEqYXDShMLexUjapZkVXO4L7O54YIt+c6Pj+ood4DCnmn49Si87Aw6LiM
 hhIsUrapkzgQcmgA2/bYXL47rc18Sxk7lY6qoqvWq1FfwOzF+iQZ9tfLkPwWxT06kMzK
 sNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785507825; x=1786112625;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/R7C8kprnzqI+wJ4/RCHXWxeL0rrPJZxpJBXBPfQsNM=;
 b=e2qw5Mj/qTV2izp/lW3TarWf9ZNB8+wocKvy8FYELmxRdhGpnmy6hsqcZBNnxy8sPV
 REGHk9B80QmAWyCtSq10HCNk4IyXbgmshK5lHgIQbe3xi803IlHHDbCSrH/IT0nrwq4W
 rgwXe8TsZk/OjO9ThMYs2LlFiVVpH00Ew8sv8aSfSxmffa+cy530+S25MhAlRqaIqXBO
 PNH/4EDzE0id/RM/3Qn2pRiIJZANlJ44jdkgjYG9IG99d8L6P1AR7YVFcmx5CvhwBhvB
 AMZaaQFRebhdlad6MWI7TYBiS1+Mf9y7/nbc1lqfCwCYDqIPsVz3ouS5IDul4zmb1mM7
 bizQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0vMTi6E6Budc//bdJAjA8tF1BeChk6secW8kgDbMWuReDdN+ksHS3Vj41GZqhhx9bqRg=@lists.linux.it
X-Gm-Message-State: AOJu0YyJKS+UTmHyVkub9SQ/eif3a7uNmdMFmYOS2YX4AXCbkwBuWAx1
 2I+ZszqvgKYUfYvXFtea4SqPnEvk+b4UGUugNq2qL3Nxcgz65GLDUGdReEuseD48njgCIEKsq4N
 Hq609a+PoaQ==
X-Gm-Gg: AR+sD12s0yv0+GnF5iuoLctc23KC3K8bLQp5aZAOSJiY/m5Ok+2Rdf+JS3/vQhNAsz6
 j9PTIT/lWK1yN0xDytNckdaNXz8NJXffUc1n3WFjpILHUvOjg/djEC2Y32oRoX6GCYg0jJMHlvU
 8AUvmIqowYAmrComV/h3RJxzxEQB1+DuYZVimbt2du0MuI/s0cgzYnDnAg7WPpzFFprdvGyVIwQ
 TF8OTg7pxxxPO0sD7Wpzn/rrhDPIydO56bPQy31dkrBIL1uN5hOePHJDIWw91l06Y1GIVHGNG8A
 iIQApW36UblYx0DWRAnW71DDNDdgeSEnEMpYrshmNG7HMDYUgmkLYem3X1mpgBi0QthaVueXbXK
 KSrOPCMFuX3Vx5179SUaNmp99S/kPPGEpYwmFxcI3U6O9rTkPkZzhsi4yqJ905Z4G7wofjYqswY
 yEJ1Y0Tr8c8meO2CHH8+MM7zndNrcqXVfH4h4bpSkpiL61L31b1GlxJrjcSvjlH27P7XuzETjfq
 pRoL6beVB1nQXv9WXfxX4PfkA4UAcZlhib7ww==
X-Received: by 2002:a05:6000:2c10:b0:47f:7e7d:eb0 with SMTP id
 ffacd0b85a97d-47fd2adc45cmr5227716f8f.19.1785507824614; 
 Fri, 31 Jul 2026 07:23:44 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cf404sm5619032f8f.1.2026.07.31.07.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:23:44 -0700 (PDT)
Message-ID: <6a6caff0.b2781ae3.2522d9.b460@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <a5b34850-108e-4219-ba1a-410f416c5a70@suse.cz>
Date: Fri, 31 Jul 2026 14:23:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: reproducer for cve-2026-64600
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,
> I've test tested this reproducer on affected kernel v6.4 both with and 
> without the pressure threads. The version with pressure threads 
> commented out was actually 3 times faster in reproducing the race. I 
> recommend removing the pressure threads entirely.

It seems correct, I will remove it.

> Please move this test before perf_event_open03. No new tests should be 
> added below the memory leak comment unless those tests also cause memory 
> leaks.

+1

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
