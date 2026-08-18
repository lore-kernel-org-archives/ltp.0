Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD1C5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787075086; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OA7uKUlYnE9DqesbU4YCOwLlWQ1I5/B70UZdgbNK5Cc=;
 b=Z78s/r9Td6tT5X0BdKeSf2MlfSRzpHnPy1ogtb0l7TshLPwnrUpissQui7bvYSjTQTqk6
 wuYABkTe5rYr70mOS1UN0mIkuTiIEofcjg+lkYbB3XOD8IBbdIyu8cNvMzeaxEWPbE+nvkX
 7fMrZRMBELaZWgqAznxnOnG3Tagi7+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FDAC3CD046
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 19:44:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4BA73CB035
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:44:25 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA16F2001D2
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:44:24 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49557167508so1269695e9.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787075064; x=1787679864; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IEz9MQbwfvmBZ/vn9rJIPnBQrn1qEhdnAGZmRz+VyIM=;
 b=JRVGiAnly4+NYAFvLl9dxuC95G4KFtIvTEtqleFmvZXuNjoeeYbjYr7uOmIlcPWkF9
 IYebYh/+UIvCWJo0mSl4BHTQAsROA/Rpff/G4nQ/ADbuUmadJOVJ/4DjwuuHqzTzKFSG
 cCrtIStufhbtik2L1IBJwdGuJenwBnr2TViS4fukYpYCwuEbFIAN5SGQVt5nE+NSp0D5
 ReL25jkyvXwt7jP3pSx8ClYCxA09GSRWRhavEOMJyXQ7viI/5oyvU2Z3XHV39kfyx0Tw
 6Z/qIxXteXGXltL0G4PrZpoYK/LWf5yRMLQk+y48jIbxwgB3HnrZ2Z9j7G4eQonH9IoQ
 lXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075064; x=1787679864;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IEz9MQbwfvmBZ/vn9rJIPnBQrn1qEhdnAGZmRz+VyIM=;
 b=BYeF1rrGkt7yNnn4RXFeeUDU5/AZ5o6fQnQA6SvA/mmVC6sj1q+hMjHDt/U/jB3fxL
 SnzsZ4Jeyqz09Hd5FV+96Z3UHPMjbcUkQN9lvMNcaJ5mljwuRWCPmCcIkcwKyS0+9DdB
 4pLaR/vzCufr6cpSHhYDQ/dP4zA7NQb+wRFf3wYSYnHclnI74S/ePxvlmVrEcUOOYIgr
 DOm6L68Qz9P3SjwA+RKAL2WcP6xiMkd42iuxk/l+N3vSQVG9fYxxB0HQIEYy+FFhYM0d
 YrNtGKVzAuH7iCclBtOcHyp8DgIFJhzAnjdNpp/3cTR29REp8L94JaegGsDDREBMa59x
 X28g==
X-Gm-Message-State: AOJu0YxX6MFUJQVsyIUQQNLIMypXx7w2VCQh192ejIfPk8W9gstJ3pb9
 Bf/IMTKC711gn9pxxV6xGtEVsbnU3kiqxtbxDyQkPddth4Dl6dXvFnEdVf6018iArZs=
X-Gm-Gg: AR+sD11wWb/tXo4oi/8vymrj60CH/rfYZ9sdyaKIjxmLxSu2cv/zlUgwu1Eq58gd7uX
 rmeJvAWuNzdqyLFoHIW5OULfa4TayPdyaP1XCpBYmtm8+mK5Ff9bft0u2Puoa/DzbikuFLVDiv3
 B7RudP6d4mkJgAZeDTM8VVkNhV6Ldjta6zbq4ieUkSR8jmbrfjEqcu6vGOvLLF+zX8Z6mKo62ph
 OeH3rnts+/70FzGezE2W+AmJ1fQSl8/m8BVhhwzG/0Sfe28BdBsFnLMguYT4We4vT7n2XGsRcTE
 sEdhmpQ/Wo/qVgluuoeLApDVpsRypIGcVuLf/JPovEXhLQJA6CuB4G1AuWR6s9qdEwHR+4TXF1j
 0z3mguHJ3r5GRW5S0H44oZ8R9rFRgXBuZDaNbWVovMyuDHGnuzwGt1/GFKcJmKdMBE9wUdsnoCb
 80GZTYYUKio5S2PomhxaciO3KahztfUbgMDSNQ9uoztNWqZwXI5eY35VR7lU9dDBJK3/rIJJxJB
 POastBQYg==
X-Received: by 2002:a05:600c:8a1b:10b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499a68512ccmr75836625e9.4.1787075064111; 
 Tue, 18 Aug 2026 10:44:24 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960988c6sm277099875e9.0.2026.08.18.10.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 10:44:23 -0700 (PDT)
Message-ID: <38b59d36-8853-4d7b-8ca4-5a6f72667d2a@suse.com>
Date: Tue, 18 Aug 2026 19:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <an3Y03mKBzue5w2s@yuki.lan>
 <6a846568.bf927062.274a72.c3f7@mx.google.com> <aoRo8tGffK4KkdaT@yuki.lan>
Content-Language: en-US
In-Reply-To: <aoRo8tGffK4KkdaT@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Andrea,

Thanks for the review and suggesting alternative approach.

> Hi!
>> This is the problem with POSIX systems.. I would suggest to keep them
>> and simply ignore them if running on Linux. Do we have a mechanism for that
>> or we should do it at runner level?
> 
> I guess that we can simply #ifndef __linux__ these.
>

If we agree on this, I can send revised patch as suggested for all the
tests under conformance/interfaces/timer_[delete|getoverrun|gettime|
settime]/speculative/


--- 
a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ 
b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -19,6 +19,11 @@

  int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv 
PTS_ATTRIBUTE_UNUSED)
  {
+#ifdef __linux__
+       printf("Linux does not implement this optional behavior\n");
+       return PTS_UNSUPPORTED;
+#else
         timer_t tid;
         int tval = BOGUSTIMERID;
         tid = (timer_t) & tval;
@@ -37,4 +42,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char 
**argv PTS_ATTRIBUTE_UNUSED)

         printf("timer_delete() did not return -1\n");
         return PTS_PASS;
+#endif


--
Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
