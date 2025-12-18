Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC8D6ACEE
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766059285; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Z7QGBJuKMIW4ikaj/SY/+sDrAxJdj5HTo1U+iLu6wBo=;
 b=GTAE36E3vDwJYKeLDeZUVAUhcfDfxUX0EasRpmpxDtwmnK/f37+VEtyRRzyTuGQ3xz4nn
 dL/uTy0jDEdnBOHo0kq9WW4Na4749Qj6xyTqwpvk5H2DigTg/TurMW9icgZgS0onzOFpacW
 it63J7L+RxsP8LLl5uJ5FmZDXjHiODs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42F173D04CC
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:01:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705343CB780
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:01:01 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C77941A00A5A
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:00:54 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so86931266b.1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766059254; x=1766664054; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Jtqo3yF7AoQ/e5UNxZfxFu+4XZy04Rw//Q1L+fU2oU=;
 b=QBoyG1668S/s9PzrJb3OwzsJbIfEOwiEcFh6ZIKhe66GYEFdjQK8mnkGyUolH1TefE
 3uVNtsLPTCBi6u3reWRji8XmXCJnYC5nU4LNZMt2U/E/dF4Lw01NzGKDk2Pdo+H3UqfY
 pv6+mMVCV4zkHyE+UOlqYnXMokr5s4D8p74d7IpB6MXLwUWClnnfopSCrkMLb0Bkdm14
 Fp1Q5F955+dfFdfKyPLYWHEcbVM/HrtD3xRPmTQCIzjCaStg4hKtgeWvlLmkb7r2S6+1
 EqAhht3kNfDui5jKzGUsTFhZnVWGFr1FAs5UMU44cz3/vLG7ETN4LRAMrOIl/XrYsWJp
 rifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766059254; x=1766664054;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Jtqo3yF7AoQ/e5UNxZfxFu+4XZy04Rw//Q1L+fU2oU=;
 b=NHxdjmM8ujZKgFU3PLtSCL3iv1VR5TVRL5KG31IawKnphwFjbh9ZbnPJvSy2m+ilVG
 CtC/l/31mV1Z8gbvPuQdJJ1wJ1Da+BQoCTfq+6eizCMPieODYeyRsebGCU4lUeWve6d3
 +ju1EuAEIyKrUxrBYSgx0tYUUFMAYO2J2QMADg9AJg6VLpqdDcIFa3qDc4iPDzFc76UQ
 lu8SWGiJkCO4cvjdS1iOKVeWiMAKftvF+SMDrepLW9jxVfBEmBzAA+baQoQkn/mAqrPj
 Bx5rJVIyU9PbyZv8zwwqStYDA0O2rWQ7Hud/h0Okk7dV9DHAgpnZvH7QumWjPrIohB1g
 WsHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXaFeN/gUBqFDP4IfwMEgMlFIWuYvThnD6KsZnlq1kboBrbWM4sKcMaTrGOzuBlBRo3MI=@lists.linux.it
X-Gm-Message-State: AOJu0YzdkE0ld2IzNoLcjSoXACW9RfqVqUi58PiXefF6RqIh3uX5pX8d
 8DBCYr70cTjlvpqO+8REDtoZvwMDiNvOvDZ774GAjfnff42SoKJ+KV5VHCAhvv0Foqw=
X-Gm-Gg: AY/fxX4c75Xed8OXWLCjg3/KTa2L+ZPyow+a7K3+3IVzT+PvVT95d0BQn8ki0Ms/RPb
 B2PuzNTlm+QcvwTHtInkfBZoNIh14VUFWMX0+ir30wTbOktgj8aP5Mev85536qhHE6gmpxm5v7t
 JN152X0PFgr6nZoMSs1N8MuzxVWkqxTP2qyieVoCwlRNjheoGr+V6NRfGEsZO0WPQ+H/BwltJVy
 fzj9mW45/YQXKLI8wNMp3o6HLrPpWVgHh+fbcDrVSJqLNKM7E0wcgxP+8fU1aj8IbIL8wRfi1eB
 QGmR8qPgiZAY8HHWIi+NtlOwSci2umx6dlxonhGLLhQSf6teO7b1PCAXqKE8c4793ejSn/WoVLg
 KR9IC1FzpV6ns3gjUbr51SfOPp/7HjIyFi599AC5oJn+o5k6jr96eCnGkt3//CpKSmTd1OCzJjD
 L7re29Jfqi+zgoyGw=
X-Google-Smtp-Source: AGHT+IHzk5pqYiD+4+k+K4HkxvirC0xcH3phGz8wwOvfiPV3p+EQt58veuuunLwgVEmzJrqa/DzSqw==
X-Received: by 2002:a17:906:9f91:b0:b73:a2ce:540f with SMTP id
 a640c23a62f3a-b7d236944a1mr2270459466b.17.1766059253993; 
 Thu, 18 Dec 2025 04:00:53 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80234a2d1dsm204649766b.52.2025.12.18.04.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:00:53 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:00:53 +0100
Message-Id: <DF1BR8ITX6TZ.1MY7W2QUT0WH5@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251014145020.178840-1-pvorel@suse.cz>
 <20251014145020.178840-2-pvorel@suse.cz>
In-Reply-To: <20251014145020.178840-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Convert Shell API doc to RST
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

Hi!

In general ok, but we need to keep 80 chars width of the lines.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
