Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3919BC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736940124; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Z3svCOrk1EimZd8JiqBwFk+IZCwnIZ3A1ULNMS33dzM=;
 b=d6MkduBb31hsuf3ByAs9PbdTTKLaSv2Ah0uPJON3KdcGyOpNlE+dIzZh+VSHXl9Wx7VoK
 F54xfl849SoFvFPc0iglE4EA9bTfQizfxsR+qUXNEzoQHviUq+pj/LV5jKusKKQ0Bpq8SKn
 jITibGCwXjBDE9ibVtIK5HLjhLPtzI4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3203C7B7C
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:22:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 054F53C7A70
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:21:43 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9C1A6278C2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:21:42 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso46867135e9.3
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 03:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736940102; x=1737544902; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8DF/ywklwtcpIw0eigTBRmbM5HT/ehNGzFH0y98OKk=;
 b=EWQiuf2ju2BXSbAUiKBpFbLnwxVEFDlDWNPmeXt7OH6ubMxnNySWwIPVTAjckK2Wk6
 SMZTusdcYbZmHVDEiuZdSOOE7fOQpIQyeMAUS+ueKjKnpOerfU/r34iANbh99RooR44v
 Lb3lldZM4hg2fDhajMXcMIoUPVLTscaweDCFnSVQ+C3nUDDruCqx8ER/YIVy8+37EDr8
 kZLYId++gOM8W2waUpYBbFFwHYsi4X1q0wGQqI556iGD/IZK1mlQ1zlnxd44MakfeAv3
 FB2SP7XZVHaEypms7/dpvC5H212DFTtZJkmAQs8t/8Q9eRJrnY6JOZnoMvmt4l7trHcL
 sNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736940102; x=1737544902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8DF/ywklwtcpIw0eigTBRmbM5HT/ehNGzFH0y98OKk=;
 b=Gk4Hru5FzSceBCAt215wOfpstPmLImYIpnZjzec0R9rXXp9ZKucSFPL9Bj/egMZrO2
 3gSpJIhD1ryAxOJfhiiHo/ifl2zTBkMajz9hpAtKfnVViTSazNJ2Y8nfS5A73KH7Ou3F
 neZeRW1WYAjxPs0ILlATHz9KLqPpu1OtEXWxrzzq5P965hzjcwHtLGboyZgw9mNaTTUa
 GCJLJ3pxnT8xie9jVk97IK0nHoC/Aw/w+sJE/HhP5KD/UL5lUCPik5kH6RNey/UvHV4/
 9OBpMBQ5OsE3cwOAPIMAknKNaKLIBs45XI+jK9KbuX40tBuInPmA6DTFAOecOWSP1i/Q
 +avA==
X-Gm-Message-State: AOJu0YzQ+utDAMotchqV7TneSZ3MuZNjgY2QIKqyozGCKwNS8wFnCJjf
 WmWaAKKneM2ON77ew5y5KWcxPw0OTSIN9ZyXVxOUiaGXTnzjmctN3BBUN5upjP8=
X-Gm-Gg: ASbGncstRzQ73FdFXdNo/4M2FMtY3FhKuub0SFSl4ifAHfTaUO9ZpTqPzVhf869qXQh
 CUQzpO74mzlmmyAXuANNXylDKuJkX6DUZ/FkKv/2owwwJg79WX/OyiyHZ6RVv75+vJpWJEjdp0P
 8FCdsHk77A1cgYNBrUcN0VHC2QkF/AHX7ku4b0N24ug5y56mDbGXfFRqY3UrKcwlFRlfAF5PiAE
 qOj7EJON6nGARTOASt89hBxXRz5iWygxk7oQEwB7dpl/XHXghGE4t/2tFskEooVJ6yOl+woEtuS
 en31ZmCF5b7yOHUHy6u8SRwLXoaLkscNRQcRTRh8+3ZKm6/jdRmmBOKZAEiPm/g7XfFIM6XbsKO
 6jjJRYE3jXTEyNMCmV/k=
X-Google-Smtp-Source: AGHT+IE+7diokcc49AlN1EbzRs/Tw/A0Y541JlpbGy/7uAkTYq/qtSG7pHIYxPX6/uQ3YvCp1PquyA==
X-Received: by 2002:a05:600c:5122:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-436e26ddee5mr138616365e9.22.1736940102350; 
 Wed, 15 Jan 2025 03:21:42 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499884sm19961545e9.5.2025.01.15.03.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 03:21:41 -0800 (PST)
Message-ID: <50b8bec8-c367-44e9-bbad-90b574952b2d@suse.com>
Date: Wed, 15 Jan 2025 12:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250115-maintainers_check-v1-1-1d2546c26d69@suse.com>
 <Z4eZ22PEIUi0mYxw@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z4eZ22PEIUi0mYxw@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Ignore files paths change during make check
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

Pushed! thanks

Andrea

On 1/15/25 12:19, Cyril Hrubis wrote:
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
