Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D7DE9E2FD
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770814252; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3e+SO1cCtPb4YDlT0gYHaBUwFqsqv7f67EE6g6SCGY8=;
 b=eN33EmUo1eYh2JHHXGCGxKU5q1ccqT3C5bs5MWKZDVqbWA38hVxJZdYjroBaYzg3Alp95
 //qO2rGXCVx9YGdtWzOCWbROHvyFlqoASC9t13876czK7q037Q9qg+XACwEMjeY82BOZAcu
 eYc3E1w7PF1ZjtxGoSbAnydQALmEcaY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5E6C3CE4FE
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 232753CE229
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:50:28 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC7A2600931
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:50:23 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43590777e22so3259459f8f.3
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 04:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770814223; x=1771419023; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MT0kWGHy9ACsh4ZHbtzpvhXL/jqAPGC36M6tDd3j6sI=;
 b=M3HsC8ca0R+UMCyjbmq7yi/sdgZxT9I05rZ/sNSOGIexn7YnLOhUdpPKZT5eOC2oFi
 TGBPUX0wlgF5owHmt9fzZ6aOe52aONL2zAkq2lRhHJvRFYRzdfMcBL9z4mPDeOnhgTQn
 YfefEA3qtfy527JF8LcauTBu35vuq/fWGaRwDYzFaEeodOXb1kACCq4zSLaE84sLGaRe
 QPQM/K07UeixQaJt9CMQtv8adY3FL6xx2/xHb53JsfHB654Wy3ig1rCpMwHjxXyC7/us
 Dsa+WhYABxUksLdqw8cxv6BLue8oCuza/U0yY4pDtI2/m0yfqU+rvkibeSyUGeXRn4ZI
 PTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770814223; x=1771419023;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MT0kWGHy9ACsh4ZHbtzpvhXL/jqAPGC36M6tDd3j6sI=;
 b=UUOXyP35UMR9P2aus0alJj3lhcmK6MlCdquUnqdOucdMz+ho5L2VvkObr8osernvii
 E1W9BJ9SjVaLukX9bR3GdT0HOy3xHKaPCjtQub1IVPgEGuTratfQHxaX0H2+9uxuR6J6
 rQWumiAKKtiqVWtcFMp+UxA/QOKZQil2Pj6dUetOL5hRs8UT6RVzD4xTeIrwE0U6Onrc
 5yQWsTYp8bD0XY7Itomn9CwzfQHdbnTJT/i2+7zT5pwDw7Z+CF6H+dyfZbINOFFcIR64
 uAm/pPycilv4DASI95qmKcxckpxU1VD606SVtMGTvsK97eAtel8LpBwGr3w6k3ADAVJr
 sktg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgb8fhgsOlaL668DnJQXl/1OoVhcV3Nf911H/k5mbW4V0JeDf4hNPkzulqz/CX+WFZvJU=@lists.linux.it
X-Gm-Message-State: AOJu0YyKzBCADrdnQ7UB5EYKvox+OB8bmqNjKZ87m/us3p6gRzzFje8+
 etet/uUkt0uJOdWLucZ2isT6Ua9ggSb6Jc5Ey9voV/SCzjvfcvyD54/V1c2KcuvpKUUuM8qxfYW
 1xYNyZXs=
X-Gm-Gg: AZuq6aJNV74p51XX86tYpI7pH1lv1Ii9MxrE2pT5mNMDSvspS5r+gucR/nTMFsh6SHo
 a6oqDX7GzTD7XPJ9KlR7Olrkz8W2AOGuR+IEE4eeB27OGKI8Jq8AleaDZrvE9EDQKRaZLN/+jGm
 mHidi1EE+ltIai7GvMys1CNC2HZ8klhsAUu8QVbaFK2Xl8rSd54rQm9k2lsWMfbe2wLQMtnLkQA
 wECn554QEe0jnUiAs9RzqdYlgPVpgAgMaN2tXYDrtOMKQCl3ujg10bOtLrFXkXj0+AfJSjpreij
 m/Gj8xb/WhNnaUCXoqboLsUKbshns8Y1WbV9yBWu6m7666G8AoQPJP/gLM3NohyScYajHmW9CCC
 6JqsAqKu1YEFq+PmYtfJdzbTLHmTlY703Wv39R4fgH6IjMiz4OWUl1+KnpBljXQT+zJr8RBrkXC
 oFTJHQ+q1LbgBjBVLx4CmYzoXOiIw=
X-Received: by 2002:a05:6000:2c02:b0:437:719d:a754 with SMTP id
 ffacd0b85a97d-43782cafdaemr3964517f8f.47.1770814222815; 
 Wed, 11 Feb 2026 04:50:22 -0800 (PST)
Received: from localhost ([37.162.249.193]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm5360021f8f.6.2026.02.11.04.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 04:50:22 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 13:50:20 +0100
Message-Id: <DGC5929U93ZZ.MPNXJWSC5I9L@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Martin Doucha"
 <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260203125029.15413-1-mdoucha@suse.cz>
 <20260203125029.15413-3-mdoucha@suse.cz>
 <DGC57EJ5ML0P.1QXZU4BD77ITM@suse.com>
In-Reply-To: <DGC57EJ5ML0P.1QXZU4BD77ITM@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix/aio_cancel: Use setup helper
 functions in tests 5 and 7
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Feb 11, 2026 at 1:48 PM CET, Andrea Cervesato wrote:
> Hi!
>
> LGTM
>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

My error, this message for the 1/3. Please ignore.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
