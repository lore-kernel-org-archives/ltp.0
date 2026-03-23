Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437EFC72C5
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774250830; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=04htk8kyv6apMZA0oK14+6VJRGQDAkgdFD0HUIJ6PJk=;
 b=n6ax/3uDAO9m24nZwq2rR0Yt6H5JDCWmtB2rwuBX38It4FjffdB68/3CjQYpvf1xTB4ll
 TCM4lSAydNvqerJdQ9RUyLIYuf9WDZVmjM3hZND0A1fyHCsv+maNy/HR5Bps6Cppcm0jZZt
 mp+p3wt60VMm6WnGsJdGOjbjQur43Hs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5A5C3E2266
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:27:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 808D53E1452
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:26:45 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 010BB600755
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:26:44 +0100 (CET)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so1822993a12.2
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 00:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774250803; cv=none;
 d=google.com; s=arc-20240605;
 b=KshT9UiwGf60GR7Pa/QuA3+b6Vo9sFQ90WrwMZMzd1wGNk/In5gZUu++Yd4hfQ2MSm
 o1XAHnFz7JAB7ya0yGCVMLt7dBiOb2OSwLOGblxa6SoyFmqvfDg0/+u3236yJvzSkz6d
 O3G4TCR1uPffCWafslgn13xtdwhVdlrA1w+0sNFvR2PkheW+def0BUvKlfIj3McKPOZ6
 YagFpgQGARmowyeqVERZ7dUejpMmW/tcObMU6FvEb18jLOcxTZ1ud7FAPLPR4E79rSDg
 /iaEnp+9SoPTazIwx8HfMUpz0VNDyLt2ESmNWObKo7b/TlcEmcR56XqAQdqZF1P2nQ27
 agmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B8HoSTfNfE54ah5zb+LjAkJossDzwozKIcx3o/j6kIU=;
 fh=cmR4S6Ly0xc3yKBvbQzAzwuxrXJZLhA//6ubmxpeQ5A=;
 b=GPAW36Ww4kCyJQLU4asgXPoPe4OrrUzxq3t9pH6lcDxMSFE0bKtg2IqofKsttkznUz
 452fuHTBJqOpm0ococ6kqz6hSlfB0u/16Anwui8r0sG0fwF8C1vFh5X0OdpkWshAVPue
 WdPovwtQtggnugrGZaMo+BAXNc6c/cUwyOvxoCpw3SQrGBDgJyUFNIFk+iAGnZ25fvXk
 ubS1OccvkYvhnlBjGirScNtb0Prbact7V8A4e2SFM7MliXWVj2icS/oY2ZaxOOG0la/b
 WhLeWVuiFA6VonXzauzlIedvJu3f3D4VkSMbYjnlxhov9/0AfML989C6SS/akpIOL5jI
 5tjg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774250803; x=1774855603; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B8HoSTfNfE54ah5zb+LjAkJossDzwozKIcx3o/j6kIU=;
 b=r3INNhmLNPASYwuUiYmZ2HrCKYgPciGnHZyklq6tNtoQATvRDtiJxYmPeAdF5Fj2tp
 X4I/t1QFyPqAcB9dXOISzG4GVA3r5rXQjBJFHlqGWEaegp1cBQqPp+0OPqpTF/V9uchU
 GfDe29S734ryPujXl9VnUJyhsUKxc+dZETb5ofFZCcIbKqp0a3eRZqJXvonQ+7qct+/T
 0WfN62TxsFGFttlKNUkKJYfOiSqiUkzSYsqpmvsbcnqyKP6unpToQ969SFshF1/Efxcp
 103RL8Abd7o9YrEmoSkU9DrMBxQNYGWRWNTd8dfwcF8J70int8131kmQCmkEJoUzuMq9
 LXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774250803; x=1774855603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8HoSTfNfE54ah5zb+LjAkJossDzwozKIcx3o/j6kIU=;
 b=f4gGjwRKXZXrT9AQPwuqrnZdSSnUpU5Akaa1kEIQpjH3aoZRptCQF8zYu+rPp9t2H9
 3UgmPpZxrfdSW6tdQK6nopYmdDBZNZ53d0up32Z98yh6eZEGaQ/I/+ZkKkhurvby0RYO
 EK0ACQH4Ri/km+cJlD/y9YU7u3Ga3HrZZz8TN6E+alwQznsJ571z6f6LCRoemzE3DlhC
 bR2Kf/W0sie3cmWp9K7YSvsBqoj7S348a5liz5pKu3+LT4f3FJX1iZbzZM6a/JYQebAM
 5Fkj4asBAQPIpOf6H64rkC1Nm8zLbKYh8DppSPWBgPTCjkIuwYXTSIWEE5G8SFuvB2QH
 xYrg==
X-Gm-Message-State: AOJu0YyR8oqZlwtXWe4o28hTKWhmKQk0NN6f6FoKDo7S6t/AJkTJjfbK
 pFNmF3tvyFhEfNUYfQkeMuS59RDJ6aOovTUgak6lfgCKdFAZvgEDOVJkcSP7xflgZowa4D/DkT2
 zbZCdLQ55uaYaIoH0gm0Xby0hd+1EgE+OR9r8yNbtLf0XYdQSDKDjVRR3Gec=
X-Gm-Gg: ATEYQzxVshD/twzpyDDD1wQWMu+pMN+gtXK+qUN25GpqqZ8FnB5XAILDT9pQQnlm72j
 QtE9jVFSfBIPrzZf9q3YlryuBjF6is0rlpYYLm5hLrIvP6vvYq2uTc5b7O8ppcZHpLauiBt6gMZ
 wgaDwh6io/CujBW1VXgQr1wn02fSNKaQfQHzqVvXreRjB3Yg8MdqWqrElMaT0UvyHpbqX6MjVZD
 woGTqQ94OSgA1/kwvmznY74MUhffQmmyksXHf60oKTPylB1HAN4s3oBv2E7lrTReBIRJlraBh7q
 yZp9lT1WX8Hte/f/SbgiQPn+unRsvUvAU3T/IQ==
X-Received: by 2002:a05:6a20:7fa7:b0:398:bbd6:80b9 with SMTP id
 adf61e73a8af0-39bcea5a1f4mr10377321637.23.1774250802808; Mon, 23 Mar 2026
 00:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260320075733.936817-1-wakel@google.com>
 <69bd0c05.050a0220.271ac6.1276@mx.google.com>
In-Reply-To: <69bd0c05.050a0220.271ac6.1276@mx.google.com>
Date: Mon, 23 Mar 2026 15:26:06 +0800
X-Gm-Features: AaiRm50E8GwWiScL1313i1ER8_XlSQll1eKdIt8aY2veLNZAQCaZ5biq0bJ5Rbg
Message-ID: <CAOcRiAF3gkD8QDr2L7g7DXpUwUurYDh7k-vBMmw=um5AdnuNMw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/file_attr01: Allow EOPNOTSUPP when
 attributes is NULL
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Wake,
>
> > The syscalls file_getattr and file_setattr may return EOPNOTSUPP
> > instead of EFAULT when the ufattr argument is NULL, specifically on
> > filesystems that do not support extended attributes (e.g., tmpfs when
> > CONFIG_TMPFS_XATTR is disabled).
>
> Patch is technically correct but EOPNOTSUPP should not be tested int this way,
> since we are not checking the underlying kernel configuration. For instance,
> we might have xattr support, but getting EOPNOTSUPP and have a TPASS. This
> would be a kernel bug hidden by the test structure.
>
> In other circumstances (if xattr was our testing goal) we might have used
> .needs_kconfig, but in this case we should use a different approach:
>
> - we verify at runtime that our kernel supports xattr via tst_kconfig_check()
> - if kernel doesn't support xattr, we expect EOPNOTSUPP. Otherwise, EFAULT
>
> In this way we make sure that syscalls are raising the proper error according
> to the kernel configuration.
>
> WDYT?
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

Hi Andrea,

Thanks for the quick review and the detailed feedback.

I agree with your assessment that allowing EOPNOTSUPP unconditionally
could potentially mask a kernel bug if xattr support is present but
returns the wrong error. That's definitely something we should avoid.

Your suggested approach using tst_kconfig_check() at runtime to verify
kernel xattr support is much more robust and is the correct way to
handle this. It ensures the syscalls raise the proper error based on
the configuration.

I will revise the patch (v2) to implement this logic:

*   Check xattr support via tst_kconfig_check().
*   If xattr is not supported, expect EOPNOTSUPP.
*   Otherwise, expect EFAULT.

I'll send it out shortly.

Thanks again,


-- 
Best Regards,
Wake Liu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
