Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99727F3382D
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773740744; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JsJlRJe8QOQHJK1LRgRYe9sQY5YBiEO3PXM1krNH/dY=;
 b=bb3u6ODlN4VFUzQ365gbN2rj6ucmiej9lrZtff+g0wxymOSsu1p+/hy6JIWqimrf5Lxa2
 3zrD4QOEhg6jII5idl2Qw3XnGsGPzBlarzhiAqPUzbhl7T7mcjVKXMPb4EicilQaKtaVP5i
 +6PF+DnFWoGacCJidC5CcC5ObgxM6PM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E0C93E2B79
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:45:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0443C3CDD00
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:45:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2BA47600B45
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773740717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2+KXZV72EU4iQX2N1ovZ04bNwSuXExqp7yoab9/K4s=;
 b=AV7cqqL6QMlNM+YHnIrJVU9Wp4f7y1Fqw+9Qm71d0Lf7tUJ71Iyq1nDI5KHeNot07F16PB
 OaeqGyO3A+u0cOnGPnyqccc0Hw0bAkFfiQj7BkVrbU/H3Y/S6TiP37kPUbYPXgn1/xLMvo
 E/+hUDauftEfmYwYoFifUEbSZinN0nI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-aK8lJspTOBOGOpfznip5cw-1; Tue, 17 Mar 2026 05:45:13 -0400
X-MC-Unique: aK8lJspTOBOGOpfznip5cw-1
X-Mimecast-MFC-AGG-ID: aK8lJspTOBOGOpfznip5cw_1773740712
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0565d77a6so24727945ad.2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 02:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740712; x=1774345512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2+KXZV72EU4iQX2N1ovZ04bNwSuXExqp7yoab9/K4s=;
 b=oQW+JcCTfKk7osHDfeZ4VRPVhZJB7MnmyZoXgasToZbjBug2mrFO865sqyLBWVwRW5
 XKRHVQzyQ64dSoHHL6QnifoveXbofiP4q0tre85ZyLB4D0YudS+nze7y0BGUHmbkLNug
 743NZwf7w8lRUx+DjflPrjRVFcsdU2fhH19nNmCOyno7Oa3vEbFQgpv6beQz1rJLRJKm
 giknnRSvc/1MwYZ6RFiZXQdsZ5fk5gRWAawJ6qcIiOweLohGQB4m2tCyZi/w4GL0ZJYI
 GsnpUC8VuVDTEjFcF6Z3mmZYqowFt/uQ3Jo85QTiwa+7J1itnZbt6svZCOHAq3JCcw0K
 Pdww==
X-Gm-Message-State: AOJu0YxUau6fVlp7aqPRmQjeNZip4SuZfkvTqKYMYXEZze6tZke8iBdI
 XyuCJZ/BZaSSJJmrEWrXeZOJq48RfRC2r9U/4kDLG5hb5/gN40GRjKz0zGmrr6sYeLxivjHpn0E
 6rj3kiwr6yoImOpEQYzeyLgzE3WFUkBynCjLcgZmXX4ZU+6fck30UFMcEwXiy
X-Gm-Gg: ATEYQzzu5HCPsWxbFvNYydpLkIvzFeKtirlgWiJ/PLLNhiM6KK2ciidvpMWXhuM6aBl
 +5CUYtMYbnSI0cRsUj51vvSQFuGrS4uHY/BxWIw7p8GZJgO7nb087pwU6cvC+wKD+p1a0hVYyTN
 xzjy+rv4jWFSi5+anwQxNDAH0MARxSCgO4EIK+t+TIDepiBI/xfPxq4TCs8WI1yTO+//GjdUJOQ
 ogHMCujQWARlPW9L3dETG6X4x+L5QlV+uVDD2DF4JMRNcjMBZnclt3Aacjn7JVrRD66NwJZoPDL
 HkrDORubHFAb0hr5KZo2TtVmEODbeDZE5r+ah7g1AENzTujb6pgHG/IgoB6cl/+dalLlBGUVQS+
 r73NFN117+DPyf9xo9w==
X-Received: by 2002:a17:902:db09:b0:2b0:673a:7c85 with SMTP id
 d9443c01a7336-2b0673a823emr17007735ad.37.1773740710966; 
 Tue, 17 Mar 2026 02:45:10 -0700 (PDT)
X-Received: by 2002:a17:902:db09:b0:2b0:673a:7c85 with SMTP id
 d9443c01a7336-2b0673a823emr17007455ad.37.1773740710529; 
 Tue, 17 Mar 2026 02:45:10 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0659a90fesm19610275ad.45.2026.03.17.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:45:09 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:45:08 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abkipKy5lNex10Fu@redhat.com>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-5-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260313142600.243939-5-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lo3F1G7gOopkI-qCFLkkWl2jNokA67pabhCkw_rGhj8_1773740712
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 4/6] run_shell_tcnt: Add test count also for
 test_all
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 13, 2026 at 03:25:58PM +0100, Petr Vorel wrote:
> tst_test.sh shell API has TST_CNT=1 also for tests which are using only
> $TST_TESTFUNC without $TST_CNT, i.e. when running only a single
> function. Follow this approach. This will be reused in the following
> commit.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

This is nice work!

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
