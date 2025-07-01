Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63208C8302F
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751368561; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=EKWLxa/P50BZZfvpigfmd3a22Onu+87D+u6SveLLyHs=;
 b=l80GJloISCZxha6G3y8O3lc0sz5ocrG2qgMGh+hD4q/0PuJERMEnx2tDHxG9Ctj/i8Bc4
 O1m3v52F0/cekIJh3Gl+aCsh7e/wex5VxmzD2LXyb5C8TYVm8/6PqqSyF8d/P5P9hTDhydq
 dutEjNWqAlxu+BWjgWzDR3EtZqqCUfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 785E83C75C9
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 13:16:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FB03C6E4E
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:15:39 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A6016200912
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:15:37 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso37966595e9.1
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751368537; x=1751973337; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fClVh5GrutU0MzIHzm5BUy55dU67mAlC7l2kklm956U=;
 b=Lp0aAVekHPEPzDO00RAQv7Zv42ymlkLcE80pNKuabWeXf4K/ANrblTV0NsAxvWr89Q
 SoNL717dS8bdHPqXUxw4bwyhOXmA0zCNw93JEJq5hixs9T4nxG6zA9BCcCTTqU3u94Hd
 Uil3XccIQVtQnd6PV/2kN1f4dJfUmxl8Xu9dOPC2J/LMViUsvwQGLF/SjJoALaSTsRdh
 kkrACDmoKfgAce24UNZHkRkhmdDzW1VAQMqX+Bl6f0dIKXVJiU6t8aANpe2as72FO7ut
 bV9SuHsEwmc4A/YP2vD2WTn1wDho0Qb9ngZM4aojkR1vWn9cljxhL7f/qLAaLNk21G2i
 XvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751368537; x=1751973337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fClVh5GrutU0MzIHzm5BUy55dU67mAlC7l2kklm956U=;
 b=Kt0FZe1z5gFXGFoB3gRASrXAOK4+TD3loNaJFr5Sbn4b6BEzjolSPRcs9a0wdSAIGE
 w0C96lggBDftukXGH7Jm+XCPh4ez7NRGgWIE7hvda1ZyO2P2nKVrBrsZok0SjtjiCfur
 y8SOWTaORartDiCAFTD9smwvpGpXddzrp/azhGARde2E4SUQI3i0iRQuxgzwt8ZKtkwv
 4NEwAGWOBrzC7649hU/XAb1s4wVg9ZfH8FHXE3KnMwgSObBEv/Rct/wy5Ey3SP6l5ak8
 lBZrXFx+gnMsTSu32balbE3Da4OCn4AqdtuBHDZb7xdML46vbdI23yGipsjR7PFOiDAk
 SyNw==
X-Gm-Message-State: AOJu0YyJbJf8vIddKy+9BI/8foOytfFC7ts4QKjAIngTb78+QTITuhw1
 JFNgR759dqIq829zsTthV/RaoOE8E1ZuCpbBJZLrI9TXQZBtG5h/JjNMfnzL0ozp6lQ=
X-Gm-Gg: ASbGnct1B34MSjhbUTCO0JSBCcKEd8/dOpcH3yNYpLjwd1phjThrUkRs++7Sx6erHWj
 Qy27fS/WyEFCaicswjcQZSmSzLJtwuSko6xZHkmXazhA8NUU5OmLk4TVijOCoAcLR22o0Rp9eEb
 LKGnXFulOw9/hhygemfPnUztHXH2tWcxhhFlyDuDzj4RxUIdUUSbyoTIDBlB8VDYS4oVP1SPi+L
 Nx5uz86Eywriltj8Q6WYCCENv3AaGNthaW8l9v7RHVT0PktdwYKkI5WnYqZSQtMNmaIaLYc/Aqg
 wYwDtnlGD0lIDZU8Ayxc4ZrLfSuWRruEZi3uh8EqE/gLOwP4PnAjWKLrQcu19XiDzEvHJNxtkeP
 JLQ2quPIX5t1OLUpe2xPFrNH7s79BcwCPQHWmaSUCKMIQLT9m79DdMdO1Pf71Cq+Dp2RS+k7pWY
 RkZQzQnk6LqQBVAhMXfdMSUeEPIw==
X-Google-Smtp-Source: AGHT+IE59evrgIHggyggjNFt1jzh2Xpf6vY52MIhJw/h3c5bKvMQBVPa8v41kZlXLbkrQtaFaBRAzg==
X-Received: by 2002:a05:600c:b8d:b0:445:49e:796b with SMTP id
 5b1f17b1804b1-4539b91b159mr114533735e9.17.1751368536900; 
 Tue, 01 Jul 2025 04:15:36 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm12671772f8f.43.2025.07.01.04.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 04:15:36 -0700 (PDT)
Message-ID: <4df2c4de-46ee-48d0-b451-fc7f4f74eac8@suse.com>
Date: Tue, 1 Jul 2025 13:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <aF5u9ZBRzv-a18Mt@yuki.lan>
Content-Language: en-US
In-Reply-To: <aF5u9ZBRzv-a18Mt@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] ioctl_pidfd testing suite
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

On 6/27/25 12:14 PM, Cyril Hrubis wrote:
> I guess that we miss a test for the case where the processes are in the
> same pid namespace, e.g. process created by a plain old fork(). In that
> case calling the ioctl() before the the process was waited for would
> return the information I've mistakenly pointed out for the second test.

Sorry but I don't get this one. When we fork() a process and we check 
its exit code via ioctl(PIDFD_GET_INFO) __before__ the child has been 
reaped, we only need to check if mask is still having PIDFD_INFO_EXIT, 
because that's not available.The same for exit_code.

Am I missing something?

- Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
