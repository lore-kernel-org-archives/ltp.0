Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F3C5CFC1
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786445051; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WmueKh8rBr081jbH/jFib8LNnQgUobk32W/B3QL8+aQ=;
 b=SU79/yEYZk0GmVSuDdm0HQuhCRezZE6N2d3+a9LS6oEvGJs2hpyMnZG+Gd3PFnaj7/dgO
 7aNRkUIirooVz2z7nFlAHhGxWF0ngaMqmGHrGsdWKvbYsaaGhGIV4lK6dPcZRFk3ocPhQBy
 7e3LvSswBgqV1AjPSnS22YdN90VULjs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FDA73CE309
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 12:44:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5F7B3CC018
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:43:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18F9C1400042
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:43:51 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so25172215e9.3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786445030; x=1787049830; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3SE3NfShdUkmclR4GLtLC7cD+Ry3vPHBoWPVhjX5Dwg=;
 b=WSqtIaPvhSW5RqznSNWEOL+EF+CLXyP/gbwBcs8CREMj7cc3IHigJtoHYMHeTjc08D
 wxitFqQ/jh+DEItCppJMZdCfREsH2WiFKAujr7YAE8RJnxzifrrHks+Cxc3avHjgrJSy
 ob4YsAd3x/h31X9ILpkKxS0anLbLHvOS3TCpPIZa6U7Klzk9pSJJ2XBBB3zRtOAILrJV
 y8tTkYLvsap6L7z8ZL0Kyz39XcavfGEZjSPGqCJA5EYxIAAr3oZ+/mqDMHBis+QQtPIU
 zySwvqKnRqMUkQVGTqNcs31384g+W5afUK6GOiu3Pn7xvEN8pFRGPwDP84s6AJP3cNDy
 2oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445030; x=1787049830;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3SE3NfShdUkmclR4GLtLC7cD+Ry3vPHBoWPVhjX5Dwg=;
 b=iQIf+T6wxd9pVDxMpfD48m/zWm0iGNkV+kNrt9WLXbHRYMIy4OSu7lOvOQWPqYXAu/
 4wxfCnLm703G3fZtFn2HVJ7I1W+QAYS7vIJ2k5detSsa9HtVykWsA1qlx52yPWllGdce
 rPOlFhtFdkrTX4fEEwwo3+7r+auBnYGO1htKT1GkntnGxieSPPTT2TkMpbPQkYV2S3OL
 ixDV+eFcWdxwAilNM39PLRpUouXF/3Jte5GjTgXa5hjQWNRN7CzXZPYHmKrVtjhs+FyD
 MQKKxoZtCjBPrArgxKafSTvsXMdLdjGcxRewIBMgy0zJ7Q7hk1EEWfeB3/XAERFrhxIS
 l/OQ==
X-Gm-Message-State: AOJu0Yx7YIycvWH7rSaaV+TP2ouB4TZ5uUidTAmiHhqFCZ6UaS3n6MtP
 ba26KeGNUSoBZM5MK13Kv/DyJn/EBc+13H+hsaO0d00wV5qk3UtvXK7VJRYyf8jstag=
X-Gm-Gg: AR+sD11yueKGMNlhpovnppxtwMSlyjy/0SA2HvY25PyJEUEABXXHRETOHN9uOvJNAWF
 nfbbazghhskFjzEQrTAY9BJYkUIzJkqsyKh4KuIy/6zM1awaJpgX67cFjE1qGMa7K3x6IGzXNoT
 edhogjqM34nV6BqZ54JUji06mX/MQgELjqCf0k3Gw3RpE1OPDSOKSAvJ0QJV2bYIwi9WBGWxxC7
 a2WB5NJINRpB2gtzJpC8qNRYahRsw8Ce7ni3YKNsix3gWpm/xILTlO1hLcEPOf4hreYuBgl8N46
 DrjE9bZv7bYycqw8l36denB7SDxatBDE2cdiMzGlQVoCCf0nwbjqYEW1RwFAk/a8H1yfwZAAyli
 Tj6unfSRbvQTyTufmAjvTR8HlqZUzgeFfDUVgWS6SY9nocJ2+TB/xS7fAsNurvQfQ/dM3uEWaOb
 daR0nfTV6HmUdQE1PHiHnEcjKUkwCZs6v4MP/fSKYVUxSSlZNRikkr1H8bvmQNd0I770mo/g==
X-Received: by 2002:a05:600c:8b85:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49978444633mr42898545e9.9.1786445030411; 
 Tue, 11 Aug 2026 03:43:50 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49978840189sm26399105e9.0.2026.08.11.03.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 03:43:50 -0700 (PDT)
Message-ID: <6a7afce6.5dfca4bd.1ceced.5111@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
Date: Tue, 11 Aug 2026 10:43:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_stress: survive OOM by targeting the
 stressors
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

@Li we should revive this one

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
