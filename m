Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B380ECAC598
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758107654; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=qJA3nJdWV3P6F1e1CqsmCAC+mSoEhDRHgrn48kMVw7Y=;
 b=eYgmbCoN0dKif2ffRAs1ID6H64+XUWQN8FmMEB0VjAjuKshRs8Er1ogzJtb4TMqJBsKNw
 Gm107fBdyvBSkg++MxqWSMqPUC4G5LJ8dEIz8fwWf18nRMWTzJ0RLJGI/1bsImLxlyxPLb6
 TVMm9yUplOJVlwGcS8nDmqB9XzlRuHM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18F443CDC26
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 13:14:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D35B3CDC1C
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:13:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 716CD6002B1
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:13:44 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0787fa12e2so928038966b.2
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758107624; x=1758712424; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHoUXcrsOOPqgtjwjMRPIWMJM7fnygUrlvMAmwtgbfE=;
 b=hAMFhu6CuaIh9sPHFOGSEyaXp8nGynINVbX2m0W8BA8smY6YifRovzAndEaB+OTPB+
 M52zvQlxUYOcu8exEdN2c9GNnREsOMRJB9HNFQkDFscCOkwNk4YrbfBcf4cgsm0/FLmv
 QJ6PoIxOh3YTyQlEvXI2vyohW7OepyUMVCZzdHHMlVH1HnuiRi8/vmqD/gqAVydnjYLt
 Ncm0Tl8Xx5/4eDNm9ux798JtIeR42PDWrqJ7cQTJQrHCUe927zyGDxjHDpk8J5EDRLB8
 +GXHsJNJDsPD01sEQDLjdOAcK6E30sQXNf0D1Pv8T/+j+Ra6knt7i1TrHN9xmm2C0zSv
 Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758107624; x=1758712424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SHoUXcrsOOPqgtjwjMRPIWMJM7fnygUrlvMAmwtgbfE=;
 b=Vwj1bbROTRzORth6e+n/WAfYulC9yfSK8KTvG2HmWdCQCGw6KEjoQafnADH6EHBZDW
 Efu1icyf37f69t0XZ4VXzzwfanT3FaaVaZxXZsB2n+hHHV6tSwS/oACoi2UwzYDZQfYX
 M3I3bMiKbgM+psfZ2kzSXkriho5QCLQXjgYETlZVo1bCqlVR+SHKgbhi4yzIa4TJt3lo
 clCED9z4hZPJ3yO2LrgL0axh7bn3/M8ECEMuxK9PBnIl9HZwNj5J3PSlPD/MvrgKDycL
 h05XMiBZA8Jnxu4XThzpGV5aFqP25YUH7u0Tw5kFvpoqirs6r3QTlKqJsy7fMcTZAOoc
 twLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeGEPJ1dzUsoAKRseN+cJqiYi+tCgIRbOASY7Ko2nb9cUEAXzEG+UVuiOGU3G6a93usgU=@lists.linux.it
X-Gm-Message-State: AOJu0YyIBmIvdyHnPgeIy9RF0NOi1F0/vjLKgf3JBTBQt+jqfSmx3kxy
 USeoSUoX8HDGp21VXR4KCCn82trKlfTgnVnsW4jBFJU2QUs8IyBSewo7d6f4JqOm9C8=
X-Gm-Gg: ASbGncumf4JRchUkDwrZkLvqKGzk+UwI2fu/dBr3AT6ILfQjEKkCwchEWKTgu67fp2i
 vmQ7JZF3lA3Kde6JXRU4U0r6BwCuwVwSXLtOh2dKeYFRRjjA24isR55oz8TDJqGxjW65wCcOcWT
 2MwuoiVvZgus4SYienjGl2hiPY7nAGDwDCUQIL/EuBESTQ1Tr4C2PHxrUuUKrTOuBOY2tpN35fx
 n+uJTDgxT7nfQ8GM+EUKyfYtualJDD9wFbdxgZqomQX5+XS1vIxqTy31o7PqgYIQFOMYQTIPWsX
 u+KoZYzLZd8cKme1rC8vuSl5SrrtujFuZolLHvwqY8I9Kix/f3v8xhX3MIsu0g7xPCMCPcknzi/
 3VOkZeVx/i85WfL/QAY5sQggmd+4j662I7CzY5YkA+bI=
X-Google-Smtp-Source: AGHT+IF+8trudJCZP+TQlsCOnDFVBkbHoq0yZ/ZOu3xoIQ+W4rwXTwV+1ekLJ6qyhcyz9qZuYw9sQw==
X-Received: by 2002:a17:907:6d11:b0:b07:cf04:8a43 with SMTP id
 a640c23a62f3a-b1bb7d41abemr213994466b.41.1758107623797; 
 Wed, 17 Sep 2025 04:13:43 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07cd14268fsm1092187566b.3.2025.09.17.04.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:13:43 -0700 (PDT)
Message-ID: <63129ef7-ce59-43a7-aaf3-52ed154c8fcb@suse.com>
Date: Wed, 17 Sep 2025 13:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Martin Cermak <mcermak@redhat.com>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <20250917103717.GB336745@pevik>
Content-Language: en-US
In-Reply-To: <20250917103717.GB336745@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/17/25 12:37 PM, Petr Vorel wrote:
> LTP_QUIET is supposed to suppress certain types of test output
> messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
> help us keep our test logs briefer, while still keeping the
> information we need in the logs.

It totally makes sense to me and I also would like to see this feature 
merged. Thanks for sending the patch.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
