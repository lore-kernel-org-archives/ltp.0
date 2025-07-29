Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92C1C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753781940; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=FKsnIVgIjRcGAQoaGp8tKIxDaIQYLtazMgH/1Aq+un4=;
 b=Am1oG/mE3o7ktwn/hCn+wAgadj4PIniDaz9wlBAndgyAkvdU5tuq5CJ1QgTwJYNlVAah6
 RTKh98TVOJwKzq88fKvg8cYcLPBL0uvATjh810Nma6MMIregly/yaJf5R5qsQsVB8UR06s0
 8NDx/eOPtjeuCyJQNBQswOExY9ar2Do=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41ABB3CA1ED
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 11:39:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15D443C06E9
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 11:38:39 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15FFE600BF5
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 11:38:39 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so2981743f8f.3
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753781918; x=1754386718; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DN6R+GZocAECpVUj2ZFMBdZp5Ct3vK8bFJZGI3Sy2fc=;
 b=g6P4E2M9f/OwA8Wq1VoSt34ofAffg98uL+N7U8CeNjmn7eMOm33q3Nso1t9y+tRAQ2
 G6lMRyI/5xT3+XK/ZAUu9qadRJ8L8vrJWvJi+63xfJL5viDDW7zBLcVHE1FJT5hzG7CH
 SfGXP4AV0irMI9VVE7geJwUdNE3V3y6xjG0MQAtXnoNm92KF8i9vT9g+mbfawXRe0Gj1
 SL5tGgUPQ1KUTj1Uy0fJbfMfG9+73erG7Fgz8RYz7de9vnb8FJweCD9tk7MSQpqZ4ePd
 tJrtA2QTSi3sd+BR51jjkfGhJGnQmDwYBPi3CLs2KUqMXUpPura8OO5LX+avYNKadAUY
 tHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753781918; x=1754386718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DN6R+GZocAECpVUj2ZFMBdZp5Ct3vK8bFJZGI3Sy2fc=;
 b=UUJ8DgWKvMJUsccLQJcakxArVZDwO2jJy94lxWeK3wJmRq3ePpH0d8VRPYQp2Gzuhv
 2VBRYqKqFogEa9ACNn27G2d82wGyg3EoOuCWtmWhNvtJhris24MEZyYm3+AHEtzo3MWy
 TRdMtWOgim1BPreDLvVzZPVzmRFyCTPVXQlOlg1U7E62LWath6Gj3/M/oC/ZI4xqTUXb
 H+UgM6eaTw9LpagMeqo4NfMxbNvtFM7nBR7BhNq+yauovWSDpYx4kmGXJq+MbhuZfN0I
 ir4c7WBLLL25YdPYi7BJ0nRJGjRyCffNBrmu7rE80xYfpFfWoUQrUR2YhFSSfLATyBAp
 vawg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQoa81oHpTyNwYNDGjr3YDwSyNgCfl54kB0o0OEOwV1dQNBup7esnSi4CIDZY527kdrGk=@lists.linux.it
X-Gm-Message-State: AOJu0YyvYAoUneCWJgBs2Ap8xhAAqbMjjZPIAViiwLZPXLzAuBTsA9Cr
 x2Alqg4g5dfifOxyonDgwslvHT0WZ+XYjnKtKo5fm7KYgZnqK+6LmFFmasd4PIWcFns=
X-Gm-Gg: ASbGncvoWvQFO41R3GWZJ1fytekg+ixB+N+0oCYK84xLgw187R94LwSM75aAn4kRcAt
 zJfa5YdaoHUuSxd6zaFxWwrGWrVPXnmxEY+dV6O9N1oRwSeJr7+qkfQcE3LitAwBbHvWJFEsZKw
 LayD/cXhokrIAvJwiodjeJan/5R2iTAyANw04BX5wYI05U/m1b7KvvqbQPMXEM/CuLzOvRD+Ir8
 f/NaB+JuqERyeKTzYHrgk9ES/YD7GMMcUIpV9HpQYQjmyLdwPAHZG8bQ6b8nzkFJzKr3GJOvKg3
 P+kCmrif7J/qaUB3oXwptRZfRXnYCv1lKdsOePL290mBBfQUprdxcrKCUU/f7CoW0YcBTXUy81V
 cBkmXu3qsl06UuU3Rs15ZwHOx6OXDGl5b22omAbjd8r+s
X-Google-Smtp-Source: AGHT+IFCE9t+pH8WCJ2bIbY1rPdZE1Vo/uZb0z3KP72QE30fFUY5Pk113m7Ow4UrlQk9XPpnX5ZhUQ==
X-Received: by 2002:a05:6000:11cb:b0:3b7:810f:6caf with SMTP id
 ffacd0b85a97d-3b7810f80ebmr5927978f8f.32.1753781918452; 
 Tue, 29 Jul 2025 02:38:38 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.178.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b420e8fa373sm1014921a12.7.2025.07.29.02.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 02:38:37 -0700 (PDT)
Message-ID: <b851b9b7-a512-4a92-8d0b-a6800ff6bb33@suse.com>
Date: Tue, 29 Jul 2025 11:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad> <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik>
Content-Language: en-US
In-Reply-To: <20250729084720.GA13357@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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


On 7/29/25 10:47 AM, Petr Vorel wrote:
> Well, all tests (ioctl_pidfd01.c, this ioctl_pidfd01.c, mount08.c) are testing
> with TST_EXP_FAIL_ARR(), i.e. negative tests.  Wouldn't be better to just expect
> a different errno? At least this is what I suggested to mount08.c [1].

Probably that works only for specific SELinux configurations and not for 
all of them. We can't consider the test to always fail with EACCESS if 
SELinux is enabled.

Also, we are testing ioctl() syscall and not SELinux interaction with 
the faulty file descriptors: that would happen with any other test as well.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
