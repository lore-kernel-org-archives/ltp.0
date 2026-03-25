Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC8FEA83B
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774432923; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uCaXaHs5RrS92CK18DrBi3JPEQm1rX72ECbuwDYPsv0=;
 b=YQ+k5Vu2DtlwaJeR6Cdqv40GEY5Hem16mfzd7BxQtlPbjdPCcuVsXpkCJDIxu4El77mxH
 V3+wKOEkxDKKmDw/AcZtnj+S4S3vYTJPlwfTRwmuPB1y0wbBElQq+ByG8bvqAexLL7G7FCJ
 Q4PLxS4oOi0L1jAyxMMuxf92G8NPhCU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C2F13E2ADB
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 11:02:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EEEA3E1F8D
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:01:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B401F6003AB
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:01:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774432895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/gRUWvpiIDedHeebCmOqtzqbAsMOv/eAJHWLYaQIoA=;
 b=WD8Yl5eH6tHd/ZB1qd5vYaoVoTHcc1EshG1oiOMp+IPV0KPwK/pNKXyzgsmnPX35aDQmax
 tPkDgYJiSBoRtfMqXn6wSAQZWsPrullIoPUoWKp/1w/3vm/4x3sGsWVeVGrPQZhdz+M0PD
 GGPHpJhARINW0Qyhob1+J/zth57PE5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-unqzbcR-NIKb0ha4ymzgAw-1; Wed, 25 Mar 2026 06:01:34 -0400
X-MC-Unique: unqzbcR-NIKb0ha4ymzgAw-1
X-Mimecast-MFC-AGG-ID: unqzbcR-NIKb0ha4ymzgAw_1774432893
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b53023d60so4260372f8f.2
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 03:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432893; x=1775037693;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S/gRUWvpiIDedHeebCmOqtzqbAsMOv/eAJHWLYaQIoA=;
 b=UGSFnfw/rOjhJkMWaRoiEE5fuLJF+yRJqsVi+QgHIcyKj0ox9i33Du+zouEtmBEeb5
 3o6tXQo3YBdnMDOnSraghsEw08e2E0H02lIyuWoArEGIoapoWcy4rsEeW21xB1ZS0WrV
 PYJ0yJAidm5zuPDVVpqKVE4DcEvbC8dkakDiSZ9lHUZrVcPJks1btMJn+yfM6yZpJGV6
 Dhsv1NowjiAtr1wF1RMlNJCLkj319MCPfUWDDBKWUvN+291HgdZ6JQH+14+gqBfxQUvh
 zE2+/+OzKv0OkdMGOO4f7p2cUvXeQTrB3ZqCUvWrW+JGPnkZ3G/wti+lNDr8PrpLdJJV
 ASlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRSRIjYfNkPwbsqtHiYjHrWVNkZBKLnf2Y0Y+oi/SwZPY3kqkwQXl6+CSWmgw8ttJph9g=@lists.linux.it
X-Gm-Message-State: AOJu0Ywlk7c55qxMGFu4rIvHcBJmDnIpyblMyXv7icSaotwE5ugUGQLM
 Abou0Jam5kLNLeQwt8CoMSJFVDGsC4KrVwfqXu7lw4f+rfaLsLh7XtkD6vJTWBNtD89Mzcb8Ppj
 XsBIMoNIzTaFVCYauqxB3Vg7S2u7d9CpZ+W7dWEiN5kNbP2TYgX+r
X-Gm-Gg: ATEYQzy7kNyDhCAiaf6CJC98dxVKUH52jzsvT167JbNWS3eLrSBrnrTKSwRf8WiODH1
 CSSWUZb+IpuOTaBOBPWssVCsPfHH+ieLkzJLzKOSkv8CoFw3/mqJsUPmhjRsohxkebW+cUPSxyB
 IFe2gwBwHDv0IibhVEFC36DggFQ38UCjpOl8fhCCW+NecpNRtaS0A6T3j5Qj8EuROk+8r5mM/hS
 gIdjT5rlwS48R/m72VrAzsIGbIeB0qpX2ZbdbtOlwLh41KxsIJyKDMoDYhUE6zM/0vCKRaucO8V
 XKJYU6aHAcxWiwSoFwoft0l0LadM3fDq8Dtfaw1l2GMtKq9gvkf6oj4ksgj84arHlSKM+OU+lbN
 DPvTwoW1Jwoap56marcp/GA0/wb2tHlTZqg==
X-Received: by 2002:a05:600c:a4f:b0:485:3692:e8f7 with SMTP id
 5b1f17b1804b1-48716056602mr38814005e9.25.1774432892728; 
 Wed, 25 Mar 2026 03:01:32 -0700 (PDT)
X-Received: by 2002:a05:600c:a4f:b0:485:3692:e8f7 with SMTP id
 5b1f17b1804b1-48716056602mr38813495e9.25.1774432892088; 
 Wed, 25 Mar 2026 03:01:32 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871169384dsm129713515e9.1.2026.03.25.03.01.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:01:31 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:01:30 +0100
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260325100130.uiqyqehj5yzsdgua@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
 <acOs7mrlNceEtchW@yuki.lan>
 <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
 <acOxlitfqdMfAbZs@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <acOxlitfqdMfAbZs@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3GOcFu0uSNpXxM6BJSRNYu_XT-N4n99_5sgu3jKYm4o_1774432893
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

On  Wed  2026-03-25  10:57 , Cyril Hrubis wrote:
> Hi!
> > > > That sounds reasonable to me.  Which one would you prefer to
> > > > keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> > > > and dropping LTP_QUIET but no really strong preference on my
> > > > side.  Thoughts?
> > > 
> > > Maybe we can finally implement proper debug levels in LTP. E.g. hide
> > > TINFO and TWARN messages with debug level 0 and default to debug level
> > > 1. With debug level 2 we would show TDEBUG as well and with debug level
> > > 3 we would show TDEBUG messages for library too.
> > 
> > That would require running valgrind tests with something like
> > debug level -1 ;) because what LTP_REPRODUCIBLE_OUTPUT actually
> > does is that it hides testrun specific output like e.g. testrun
> > specific addresses, temporary file names etc.
> 
> The LTP_REPRODUCIBLE_OUTPUT would have to stay, but the LTP_QUITE would
> have been replaced by different debug levels.

That sounds like a good approach to me, yup.

m.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
