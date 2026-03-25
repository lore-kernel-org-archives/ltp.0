Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7FCFEA838
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774429640; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MmmNkAm1ZBtxaNmqek0Fvw1up6rzTgCnbKEsULZuTL0=;
 b=c/ejZpJLS2vcZnqUwmLU3SDIwIAwpGibVzNVsx6tPGXzdpc4j8BNATetTGCZgrcA9hdaN
 jIAS1jVRllHBmBiBsPu8a6odVOPLAtl0ZAlMHPI8DNnvZX3o4TThOog0/eFyNCWGGeJSY0p
 v4KzEacxM3B+yaRYDBhwRD7tJLUsBZg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C09E93E2248
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:07:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E7C3C536F
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:06:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29B2F601DA8
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774429615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SL0uEJNqoKDNuEtwFeqne+hsfnKs5vFXKKLOQa9Fmg=;
 b=UQ0YWt5Zb2dzOo2kxI0GJVl1uO7Ip+7y9CG3B3Fm1B0B/H/1OlEq/yjuQJO0R3bZTRq8t2
 fYt4OSd4Nm9JE42fl+WkQz5a1TkEGiTTdwivR5fy9k5KHmW/U4kj/Fv9tMO+gAF97PTmVd
 Immck6gmPqHgrhNvMTOR5dkMW7gvocE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-phPiDepVMruBglfX8PNy-A-1; Wed, 25 Mar 2026 05:06:52 -0400
X-MC-Unique: phPiDepVMruBglfX8PNy-A-1
X-Mimecast-MFC-AGG-ID: phPiDepVMruBglfX8PNy-A_1774429612
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso5184376f8f.1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 02:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774429611; x=1775034411;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1SL0uEJNqoKDNuEtwFeqne+hsfnKs5vFXKKLOQa9Fmg=;
 b=nmoRxwjcAGLyNlN82Uw1ljXMkGJVSk8F/LY9SIEMHiLPU60pLuAyD3HyD/oS6CbJKD
 35qIi9bqi5EuBK3efWr6sYFxzpqck++xiasW9M3jiY+cSIueWkOhnpTn9iDxnaVAi3Ik
 C3LT8bKOMCeHbdo4Kg5MRyPJhraAxvw0D+d7Hp7MB52LtcHvFVAtpPzvP3LQQ4W6Qy49
 r+3lkZPkN1SkntMPC3B4nEd8irxbP3yo2E924ZTU6kw+QfoD+xrg7ERY2bfptFu9/+kJ
 KPkc5y/T41rUEca49MWetwsiBxf2ac7OJYvehCdb281nXoM5HviPxYjIwaEuaaa1vUGK
 mcuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgrw6NPWKhYk9fCiZXOwtmH7x5sbGYMQRx9M9rj+qy9sQhIz+/q7pRbHcqcOmQ52n84mI=@lists.linux.it
X-Gm-Message-State: AOJu0YxHtMcW+c+zrTm2Pv4nzLI5gvkjJLA6Qy/8fxXwrwlY2vBP7aVK
 zddIxRs4e98fYrKPiZqZc4zhr5jRzOVt1j3KnUY9J5IDfzA61bRON4vQgXd8u5D51eKyyyIW+N+
 5q6SyaffjY0thIKCkZKM3kJchMd3qDRUfqDOwgS3oyUBVKU7vXbRL
X-Gm-Gg: ATEYQzzgDwc6WIiV+fE/qyiKtLBNd1W4E69MfKZum0hnx3yNQTwrGChBn5tmE8r0TwJ
 +fL0qm2GuW9UxvnHGjpMJqNp9baYyWtH1gw/V06CP5JtjsRtPh6ypiaLUqnQ/snLGx6b/zO+Ipz
 oFPTaSQMGkVqLergpkXaffzD2uJiOlMtWFmFttV+EN1/KZ+yVk89ysPx935G/TYWKdEbpDKRCly
 gJee4rSI9mFBcnYfZl/kI624Sx7yDrDiQ+qIo0Vje0L1M6OsyynNgxMqleaO/H0Ux8qm+L4V/hQ
 WDiDgmyPZyOItRpnw+fVfRovl1x9l9Hi4H8di18g8rITsoNByCm5FO+N4HLF442LVzY7Ogk2RdY
 w0e75xv9B8SfXfSAs/8/FHeMy9TG/5zGclg==
X-Received: by 2002:a05:6000:4212:b0:43b:4d25:95ac with SMTP id
 ffacd0b85a97d-43b8896d8f6mr3781225f8f.1.1774429611542; 
 Wed, 25 Mar 2026 02:06:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4212:b0:43b:4d25:95ac with SMTP id
 ffacd0b85a97d-43b8896d8f6mr3781171f8f.1.1774429610995; 
 Wed, 25 Mar 2026 02:06:50 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b86fbb195sm9172232f8f.14.2026.03.25.02.06.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:06:50 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:06:48 +0100
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPygY7v9HQ7bR-VahvqNH_I-NCJBCAN_WFP3hSs-O5U_1774429612
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Tue  2026-03-24  15:09 , Martin Cermak wrote:
> On  Tue  2026-03-24  14:18 , Cyril Hrubis wrote:
> > Hi!
> > > LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> > > help valgrind to use LTP for testing. It discards the actual content of
> > > the messages printed by the test (removes everything after printing
> > > TINFO/TPASS/TFAIL/...  flag).
> > > 
> > > Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> > > TINFO, and TDEBUG messages. Therefore LTP_REPRODUCIBLE_OUTPUT=1 is not
> > > needed any more.
> > 
> > I do not think so. We still have things like pids and timestamps in
> > TPASS/TFAIL messages that needs to be removed in order for the output to
> > be reproducible.
> 
> From Valgrind persp, seems like we could drop it at the first
> glance.  But let me confirm that based on a thorough check.

My quick guess above was wrong.  We do need
LTP_REPRODUCIBLE_OUTPUT for Valgrind testing.
Please keep it.

Thank-you,
Martin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
