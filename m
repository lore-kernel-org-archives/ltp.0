Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD413CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725264070; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=90j8W9Zg7pddJGCGb0fM+SadGAhMk1FiVU35rWfUcuQ=;
 b=ZGYgXcQPRmEPKPEFgmyVre1kps4GH18+X2ErVGPg7aQLIJ8FkZqWnx4k36B1yWUaCD+f5
 mVLW2U/GHp7NWnA01iI+K+Ahl/uc7CGnS5O48COVNAGn6nlbn3lOil1YbT4kqIU/vf40Eub
 g79rT3ezvWXKO/SJyceAF/O41dUUb3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD2AF3C326D
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 10:01:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567A03C0CA7
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:00:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96C5D20EB42
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:00:46 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86fa3dea99so218727266b.2
 for <ltp@lists.linux.it>; Mon, 02 Sep 2024 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725264046; x=1725868846; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hyz1aZDxmHyEcwqHe8saeEhixYIoCD6qAPu2qKnZY78=;
 b=G0j8kMA1cZJ/ujLhl7u6mxEeFDRbNOnNX7G4cfCXqbZ7PntIGrNLd8KtUyP0Q/Glog
 Jkhhlz/O5h7lRKZJi7ylEQVOWTJEXShCwU1HqNaTIbrhII0pWMDRpoPjsl54Ye1zstIp
 I+MA5wuLzV/KpesaYJqYEwAu5ptV8YmxcanJfPnT2z4amc1EFYLfqi4ewxb4lpJvUeYq
 e7ZYkgc6OHfW+4FwpMSARQYenvUJVCBd+zrw4QdtwtsUKu7Hxex3s7dU8YVWnlUPr5Tu
 fCyxi+fMv9HNDl52KPrrtq7pofVnxUJNwzBV9WUOzrex5CQ0QtMpFkyA1U1/lmK4OGel
 XVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725264046; x=1725868846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyz1aZDxmHyEcwqHe8saeEhixYIoCD6qAPu2qKnZY78=;
 b=d68M9Ye+jfuAKzwYD7Z39+72/YBC1L7/h41vN4l/StYdo6um53+kD14DrtJKO2Wtuw
 /aaOnborxfLnWcDivxitZTSIpjnIHD/hR2GHzm/vX5gBIKmQ/h3tpf9B9MhCwUR+PHqk
 0yO9u5oe3HAaa9dQ4IZYpPKOdftrcrPnj6g8wR5skjtX6JxBzXLOcY5aPrMoChYpAGGn
 130Q9K1jbdvr16bzmLZAKd8yt09UOe8s0OiRoMcHaAOFU0nz5oSsqi4ABBYLj3m8S1A0
 NHFz/jXl6hwIJ4S6yW0mPJKGV1SAcbgOAYZup4OK5ZdXBGkTDkGImUW0ip25iesYKUSq
 YsTg==
X-Gm-Message-State: AOJu0YyotEq6AkTUYnDA0vLwBN6Od8cypjkRillX2Fdy3LpglYy/nleZ
 OTtk3dAvewxh2GYNSRdZNhAmnd/G5tRKk+tfNbdXuv+asHz4KBaA+s0ha3NcGsXDxcd8AFUgjnc
 =
X-Google-Smtp-Source: AGHT+IGEgpuPpPJSVkjQVWK0KSWEKc+2larCO89f0kwCdQWYKj/O1BePKpbT9ZtsVTP4dPKego0rIw==
X-Received: by 2002:a05:6402:2554:b0:5c0:ad36:284e with SMTP id
 4fb4d7f45d1cf-5c21ed3e9admr13342775a12.12.1725264045743; 
 Mon, 02 Sep 2024 01:00:45 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226c731a7sm4834192a12.26.2024.09.02.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 01:00:45 -0700 (PDT)
Date: Mon, 2 Sep 2024 04:00:39 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZtVwp4i6tuwDN7sJ@wegao>
References: <20240902062738.267190-1-pvorel@suse.cz> <ZtVgcX/C4bDYIjsa@wegao>
 <20240902071615.GA279460@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240902071615.GA279460@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] isofs.sh: Use nobody user
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

On Mon, Sep 02, 2024 at 09:16:15AM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> > > +TEST_USER='nobody'
> > > +
> > > +setup()
> > > +{
> > > +	TEST_GROUP="$(id -g -n $TEST_USER)"
> > > +	[ "$TEST_GROUP" ] || TEST_GROUP="$TEST_USER"
> > If $TEST_GROUP can not be found then this case will failed unless we create new group.
> > My suggestion is remove above line totally or we start create group for nobody user.
> 
> That check is a fallback if 'id' is not installed but there is requested
> nobody:nobody or nobody/nogroup group set by IDcheck.sh or manually.
Thanks for your explaination. Then no question from my side.

Acked-by: Wei Gao <wegao@suse.com>

> 
> But sure, I can delete it if we expect id to be installed. I just did not want
> to require 'id' for this test when there can be a workaround.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
