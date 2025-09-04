Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AEACA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756970443; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=kTOdjddO+dedv2Z8LPuFDWhVHsLNRinPalZa8iXTDPQ=;
 b=n1SSaJKJDoE7wt9HciqEimeOa6fl2rmxSlFzlfdQBOVYUL0vY9q0JudDkxdYGR3CDPc7b
 AbirquW8ZMjSHiriVTFOL6+cTF4LSFTf6lPrauvrNWVYblTSoJ/eBBFf4rvMl9N07dW0/BB
 LJw2OTd67EBRoScLSiVf4AN3NCNMSqA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F38C3CD3DA
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 09:20:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9E03CCC97
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 09:20:22 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB2466001A3
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 09:20:21 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b04163fe08dso115628166b.3
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756970421; x=1757575221; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9CkwE0yl+DmhL59xsNNF/QxlVBqchnYVJM54K1rsBQ=;
 b=cjp++JwiMRC2jXCvv+n/PPBsxnTv0gM3qNv7VGruuFPB8yTirEUB+KNHzqFj2ieBgh
 QrFJpqrQv3h3TEUKJHutYzS0dlEcZLP6hG1Z4VOxVXzD12QBZe7fs9ESx4PAm1PjAA20
 rvB8yeKFhMiU8C8mWl59vzMBOp1+t4UYjlV8+HP79BkKYay05HFhFMydD7Qdtv5cboe4
 x2lGBO0FSy+aUIupV1WgERCwQ2+22xhjCjv2L7dOtvTWVI+BxB8iM79y2wAgO3NOEQsW
 H+U9jYvcJZZFY4TbTjreNGQD2FiRiccWf+o2dS80/99hPxQM7lMTv43Tw36cSuaE1wN0
 xN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756970421; x=1757575221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9CkwE0yl+DmhL59xsNNF/QxlVBqchnYVJM54K1rsBQ=;
 b=Gk5v8B9QPcFc/HH+XdDaNyzRpnJ0/6Z2iSnz9Pvbsl5cDaYsIYqNmeJPS3eAApIOtL
 RJ2pR7SfKxLdZ1IurMnoZDvHCl+xc6iGY+CDSuCAwdazT6Vl7P9ti+Wl+8Iw4jhURGAS
 q6Jnj9K2tyc0/WVOVSuaMhKPQpJFW5UNEjequxp0GLt77HCHWfD0CGnXWHRIudLDkuu+
 KUZxTIPQbDkTmALktJA1JVefzLoNsKNRRytQazjwjAR/P0R0wUkBcT8fAa9AFi6V1bYB
 XM7L6tdEqgORp7LXMnukfOiZjJBkCtRaSILu8fI09GgTtxmP8ktOTQqkY3kEiJFyte0H
 +GzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfmIjXqbu4UXf3qI7I/CvKWGkMYl3WtIJ0UXtG5WshAOXvufe5uTOB2IydouzZWZKbMYo=@lists.linux.it
X-Gm-Message-State: AOJu0YyHtF771AWAwf7UxDFKc7TfR4YZW25Xu6Zjg7daolggmagA5dIK
 Y/O5d5El+Ec/VcopdlwyD0oxoelan+HrPfRTQwt8WB32ocOQC4YMumXHHt7e+gyRggg=
X-Gm-Gg: ASbGnctwwA/l4t3yyyU7Y6vbSiNZLaKszyClS7o3GTDj43raZqwKVti5AO95YMMVyQP
 Woeksp2V0Jc4zfBJrGfsczioTPFAHDBZGpmyHKOVxMwf7EW0O7J5u23cpjT2SCRM/atzqvpbIP8
 nNclwG5j+GIjaWjyb5rKAgBrlsyM3cprou7/UD2uK12BlG3voMjvoIJ+0F/9LsYfHddjQT0bBfa
 jgsEZf9GyFY6soUCt0+OltK+qqoyumbdetfrYjlITXRXIqqidxMaSWH7eLR5iORVjRLadlgG4Ue
 imNnKiGjdpg/QZNK5HR1t6H7Qw7ZI9dWd2Ocu93o5nQ5ZrUwPyJBDvaAtyNBG9U27whZQC2FfbU
 29xgtECRG0jYcM10qPooFKfQ+3DepDMIAX1sakdahpXtAVEh0l3A0dLJui2t+jnG77g7eP3oM6u
 48DhWzLA==
X-Google-Smtp-Source: AGHT+IEE432J+0rmKP1EJD92ZW9FWVoLyaSM+5Y4FDGrTonnNp4WZ8veQ2w4Xxylw0pm+prLRBZLlQ==
X-Received: by 2002:a17:906:4786:b0:afe:e7f1:28a2 with SMTP id
 a640c23a62f3a-b01d8c7835emr1862219366b.23.1756970421155; 
 Thu, 04 Sep 2025 00:20:21 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041cef6b4dsm1029013566b.65.2025.09.04.00.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 00:20:20 -0700 (PDT)
Message-ID: <874824b0-bdd8-44e5-8e4c-89e4277be17e@suse.com>
Date: Thu, 4 Sep 2025 09:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20250904064126.125661-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20250904064126.125661-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: synchronize with kickoff flag to
 reduce skew
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

Hi!

Tested-by: Andrea Cervesato <andrea.cervesato@suse.com>

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
