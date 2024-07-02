Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F0BC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719926440; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=a1LWC44X3gT38BbGR+hfkn1IoXzQNHvodRLJU29T9yQ=;
 b=WiOIjNCbzOLaeJepwkoPg780I3KYYVuavCF0BLc9Q/bSjTDkJTpSmHiH7yjkWn9GOp5iV
 7C+1jY+JVdGOPSjrs1NwMOGi8LcHz7gIHzSZBQUOYjf2EPIHN2buNWeiUDv6IiwLAvnsAod
 OQkgHh/5s+O5h3sbv8xc2yNf3wko7lY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE40E3D3EC4
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:20:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C443D0F60
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:20:19 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C58C81400164
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:20:18 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ebeefb9a7fso47404061fa.0
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719926417; x=1720531217; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdmXPgg8sVsOWLsXRaGOVLy8Kx+t0GouYvM40vS6jIo=;
 b=JcmzuXd8BIKHsXwD0wYnnb92Owstp8TmcQGnm0UvS5GmI5fySxo2nMuW0HnnUSJ2uV
 r/NwkWbHGX1fw8bOozLGOqNVXwx2kjoj1HQX1cBDthtP/f3d8fEjuX4wX//Wr/UXgRic
 h1tqCGNuskyq2zUTRArgB+CAx89InKjlo/NKZtx4E7fxSKAghsVr9/I4s3HD2Bj6aMe4
 RdMxDTWpZ29HSBLAVO0z0dfCHNFF32da6ZyY6WaiUkfR6dOBI5pmIwePNeflfPd6zilM
 q7cgtwDn5JnjXk1tJCYkubPEjt5LsqiDt00o0UF8xrIvhGLTMALCUYX013ceU6Fe7AAl
 yqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719926417; x=1720531217;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DdmXPgg8sVsOWLsXRaGOVLy8Kx+t0GouYvM40vS6jIo=;
 b=uadPXYbMfjzz4MmaYPQwVluhNGFjrYmDfDQt6gDHVFRYpihSfp3TP0ATvZLmrz1ugw
 i1BJ0MsaIo6XICaL8qCLnB+Z6m2DjVF+1msQ5iyBPaphG+u4K0afNhZrhGAcilN72m3f
 A6b/KRINYvsXmF5OurWwWsnJZGWhFUHvwNolQ02wTVx/atjrUuHrdpb6mndnxm7fKDk/
 IvcFNUW7SuNamIQ1z2O9VqM56NncmwfmATZb0ylVb7F+NjNSMUYn3L3UjOec4O/n6b3U
 ofcdLe/g/FBAh3d55rPvujq/+vX0rVNNzwOR2j2FMwrH959E39jJsSqE3qPoL6QZS8Mw
 9WMg==
X-Gm-Message-State: AOJu0YwEeS2r4wpA9434FpV4bavofzS2QA5YGQVJHKwSi7UN0BDLN6XI
 JV4oJcDtvYtPs+8mq9iNizKZiv3h7D7d7HwLRLvC5bS+qKaYl9lYYPmKJaSfMJh+TGlWN299Gt5
 G1Mo=
X-Google-Smtp-Source: AGHT+IGj9+q3h0c4tPOR9VifYMpAAzqy87sk9Cx57gHdy65bX07c/CRt0NpC1ZM5FpIAcMUrNBBCXA==
X-Received: by 2002:a2e:96d4:0:b0:2ec:500c:b2de with SMTP id
 38308e7fff4ca-2ee5e38122dmr48053041fa.7.1719926416979; 
 Tue, 02 Jul 2024 06:20:16 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535cc8sm83493295ad.122.2024.07.02.06.20.14
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:20:16 -0700 (PDT)
Message-ID: <9001e402-ba37-4553-9d3c-192b2afa8113@suse.com>
Date: Tue, 2 Jul 2024 15:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 16th of July 09:00 UTC
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP 
meeting.
As previously discussed.

Next meeting will be on the 16th of July 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
