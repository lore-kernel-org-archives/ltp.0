Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F238EC02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737469968; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=r+kC1c9rCRyvc8czXuqqnNWU40b69eTWh3f2XmzUB9M=;
 b=KnqOV/qbns3bUHIdCS5x3B1qiimTCLUbrXjn0Oe54ATZ80wOb2Ic60dGeDyx52jSHsqVL
 1R6vFxQx5lBJrE6dHxhdxmW+LzRwhqOpTwD+j5HiXRaW+wuZAX0dNiooTbRWbrNPuIgnOEb
 aY4/TBBrx+An72GDNy4wsKslGTfDovQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 680CE3C2877
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 15:32:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9BCF3C0294
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 15:32:25 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 338361BB9FFD
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 15:32:25 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so63014625e9.0
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737469944; x=1738074744; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0xuH8mZyY9PdH7o9X5sFxvgSHpKYblkBnUq+oR4JHqg=;
 b=cVVz91HzLp0nGYdnoYL5ivp0cgPlhHPtG31bX3GsuPVPupOp1b4bn7aVweuPjEA89v
 thQ8KBt6tRWl36zjChopuGToIDlEI2hx8wOpGh+EEJJScjmyvslDKpiW18R+glpvdLxz
 6qufZsEYtv5R1HpIp2oV1fwYby1suSNlk4NdW2PfR1uu6+TVObgOP+LzUZhuNJ2/NsiY
 dkmta3FKTZ+5j4gNdz5pPDVe73mrFFBlDykQ79ZemhWw4rIZq0CjeP1JZjrg+xi4eZ57
 YztPBFgBuNMRhMbUS/5kzs+4x7wKvrf31ZODzv2RIPzNjD05G1Aj3vapZa4CKrkdL5KX
 Ev4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469944; x=1738074744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0xuH8mZyY9PdH7o9X5sFxvgSHpKYblkBnUq+oR4JHqg=;
 b=XD0FPZ+lFqk4vDX9tFywLw0TYfI2HQtQfcF05ocZD+uWAfWnATCXlRs83Yt3Tnj7AZ
 7/mS2eLZ1LSZ0uQLj0h/T0tof6CWoK+7Hf95X8y0fb73uZiziXpurCPM70M7d9reg/gi
 xyEHeeIEfqva7+c+GrbyQLTFkk88uE6BsPgsfrdEtusjlmpWurgnp+VuajvFKISJt60I
 9u/CyOgv/EGwb/kgxyMJt6PHNMhhexzd77b1g/TEyeslyVqnfUUMl33vbXlUtBUAo9gm
 mGJGefTs7kFLFQgRCL6cA/M+TEVTAQxPGTGmIwlh/HoZDjq9K1ns9wIjcs9oz1HS0cwI
 Icbg==
X-Gm-Message-State: AOJu0YxP7yClyH9Op3sKTeHfh8nAGHXDEcdkum0HeqDQQQFGhznKIkRh
 onTtOdBFvdngjVDmlo7Q/T5RphwROjuc2ccGCDA4U0mDlwaucuIMuHGOHuAxmAktJAO14y3lyHm
 2zP57FQ==
X-Gm-Gg: ASbGncsQWSBp42OgViLodZkCVqCCZFyGNOaJWH17QyaUOTnfkqz0iNFFvumdCXeY9Cy
 JANlMSoonqs6ysdKsyPFMaenui4uZ6F4xCvz56Nihp8q1drOiyrPnHLlGI4bOUVCrHt5PYqF7ne
 oCn8drNMh50NMLwFnUOJxy/fFm1VPiPGdxxZAqTuZI0rg2dnIhxNdHcfXmGP0TP03W7qvjfZ2ka
 UBQqJ19EBfx70kS49g4bGunhwIPWkBExYVickcakbj9cJUh/xgaBpt40UFiDJBRWib3ervj60NJ
 kxeiDLhExyfs9xJTKI/EngX2XPDWrZkKDT44yk7qp1SrtahC6ZiN
X-Google-Smtp-Source: AGHT+IEMPltoBwugVXjtWEA7135wqWNJsL6hS/hN6vFJHitipSkq0OKVcxLnTFKvxMlC8IHgTJYpJQ==
X-Received: by 2002:a05:600c:4ed4:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-438913c5d53mr162902835e9.6.1737469944267; 
 Tue, 21 Jan 2025 06:32:24 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c617sm242794205e9.37.2025.01.21.06.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 06:32:23 -0800 (PST)
Message-ID: <a3ad7e02-b9ec-4e16-b915-9d1711f6acf6@suse.com>
Date: Tue, 21 Jan 2025 15:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250121123444.5380-1-chrubis@suse.cz>
 <20250121123444.5380-2-chrubis@suse.cz>
 <79aba4cf-e564-4cde-8433-d292b31616e4@suse.com> <Z4-um3Qazl2NjZh1@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z4-um3Qazl2NjZh1@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] scripts: Add simple script for calculating
 timeouts
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sure I can do that

On 1/21/25 15:26, Cyril Hrubis wrote:
> Hi!
>> I like the general idea, a couple of comments on the python code.
> Feel free to push the script with the changes you suggested, you are the
> python expert here after all.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
