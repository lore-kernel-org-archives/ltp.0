Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7B6C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722602391; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=gF/SjiMcAJ3xnsqevX5hIa+WZ7TU7wq0P4C587k6r4o=;
 b=Wm4q61KMTLHnLvnLVBWcgOQI00Azes+E8HRJK+zxz0g3dTMjNr3VfoKLsFywvYi4WzFGB
 b/oPcvYr+hxpU57W1VfczzJgnf23LrLEmtUSoVcAqqFwIGQGEv1/BVnr2ejwYs8gISYgaG1
 V2/c7pGtZYM9LVt+LA60UZZID3+Q2fU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27E6A3D1F6E
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 14:39:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C1873D1F66
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 14:39:27 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13FB1207A17
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 14:39:27 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso4711631f8f.1
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722602366; x=1723207166; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LicsRBiTrDZEUaqs+uAgRRZC5dsDH5Jwv+49HH2Joo=;
 b=KqCphPQF6ZjIJPljD7zRhAOgc9nFBEIdWwsxAGE1KBTXrbIaYPZTurKe0lQopn+z2d
 SrbUu/F7qTl2pjzoX1lm8vmkpC9Y6/PaN3Hj0v2XOLLklrGUrc/QM6sjnVyOlUo73r3h
 ZkSY9P8jk1G19HITwzVOG4DZ0t/P7zGbxXw805fNt+vTy2EF5sq0qH5zBh+sCD06mFhJ
 t/XbpjoSZOPfxy5oCBX38ZFt6+a1UwfWfatQjYBkC6IC2Iit2KeG8Z44DPzDRow0qCbv
 r45N5ASHCLOTv/G0urrZUZ2kbB05d+frUX0nWSUWZbyYQFYYZNbKmyG6JXPjuZvFEJhl
 H75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722602366; x=1723207166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LicsRBiTrDZEUaqs+uAgRRZC5dsDH5Jwv+49HH2Joo=;
 b=w4qQ6zLRVZ3ah6ZuFZfa0m6mMSwB1xfdk+bBJ3fp0hYpJKrO6DKErST3fOpW5Sd3VM
 kYlaVhWDGza1ydOdfzog0+KWY97gAZQ81xRJhg32tlMA46JdqeK5v/o9gmyLUxuPr+kb
 thRlFUcQYa6TMoDDcE75hzuhPPDud23L3PgLAOC9HVLtP5UN4F+6qGqgjsWJn0+0Dm5E
 +wt82pXSPUqjShLjW5g7sHOsTbevuOcyVbpP9xQxrSuTEeZBzW1TdthXHA6qswMgJp89
 n/ApNnMMLgMKgTOVRr/TT0RcztIrUx3KPLsjL1jXFFrsM4GsEmnApfk/ToPX3KT4EHhc
 dtBg==
X-Gm-Message-State: AOJu0Yw+Jvn2aoaSjBLzwc6WBNTzIaCED+ydMPnjODOWMecFlJlLukUv
 +VkGGO3tsohfN0Ars0NvekVo6TM52vQKC37/DQfnCv1RCp3fTSfvt7GhIRkVl44=
X-Google-Smtp-Source: AGHT+IGd+Xg71XHadni5ahV/6iFtWynbjMcwHWj5lLQWg6bBwvHwmRKQ1ZaQkQzFHSjWiDI+u/2NjQ==
X-Received: by 2002:a5d:568f:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-36bbc131530mr2055800f8f.37.1722602365825; 
 Fri, 02 Aug 2024 05:39:25 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01ee25sm1883380f8f.53.2024.08.02.05.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 05:39:25 -0700 (PDT)
Message-ID: <15874a9a-bab3-4d7c-a4a2-5836bd103dac@suse.com>
Date: Fri, 2 Aug 2024 14:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240801-mseal-v3-0-874f149dce87@suse.com>
 <20240801-mseal-v3-2-874f149dce87@suse.com> <Zquhj9dG14XOhdcx@rei>
Content-Language: en-US
In-Reply-To: <Zquhj9dG14XOhdcx@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add mseal01 test
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

On 8/1/24 16:54, Cyril Hrubis wrote:
> Hi!
> This one looks good, but misses a runtest entry.
>
> With runtest entry added (for the whole patchset):
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Pushed with runtest entry.

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
