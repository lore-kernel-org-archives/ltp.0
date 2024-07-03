Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6385C2BD09
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719998589; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=2hLg2Vme/aHoGs4aK+//wSCr4M3SdkzCBYnxRk0GmRA=;
 b=GtkDr2YKt38mOg2t3zCzzyO5LQ04qL2saGDPob0HcpFfMXRzQq0xBV+51iZbTum/+wk2u
 N5wZJXLLwkALvIlRs7M8a9e0T8AuuTUM+DBTZUdnwYdpAuf/i7uanWGHvs9k1NpOcsQbDtz
 VxDfdvboyztukGc5klmYQTLMI15JQC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C2243D3DAE
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 11:23:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED66E3D0798
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 11:22:46 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5D38257329
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 11:22:40 +0200 (CEST)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ee794ec046so14180431fa.2
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719998560; x=1720603360; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLQNDZFMVGjsjvfM6vOMLzdVnOK+g2P4aYg9LcSRCEA=;
 b=McOd7GJ+t4gKmffenYvGpxN20hwPuK1uFeCMjKtCJbAO5Ds74PflxVfQr3snfzwvvI
 A86IpPRSy3gSLd9vzSzVeloGenYQVmU15orLXQbPw9N8IwG2+Ur6RXyQswPeNiaa8nXz
 rRdx6l+UGd1E+v1AMDhv5tOWEUYpHZQTA3xvZHS1/NMONtEQzGOiN3Jlf+lXduuc9jBZ
 bp1AfHMYSPIFgCoIrOQIQ6VPkz77gGnhJVu/Q3bnt6oyIblLnlCulEl8gM2TzBb9H9Mx
 l9mpTuKgxN6sD+bIPoHyzrZk5uTrCLocn+G5yDxh7LpjE/fMqJsWbd8z3oET34TesLpq
 LTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719998560; x=1720603360;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nLQNDZFMVGjsjvfM6vOMLzdVnOK+g2P4aYg9LcSRCEA=;
 b=byUfT5i0p2hewuob/q75FdZMMI0HndB6atRbSwUtrOFAoquWCGRiAFK4X1oJFhztrC
 +HulI2HIftblI2nN+N6Il6gxcJGwVyVDOciwJiRnCdMPw/EAGnBNcqQbMT8O+4N9RqzD
 d5um2pYyu8ez5On+R4+0uJ59bVilnQiaWuQK4us/5hHGxRKOgAk8pymsJcDM232juUKw
 evtMp0JzSuSQqXbS1Wcw/amuooQZt48SEijc7HBtCyDc1b1MreOBzxlb8CaLo5CMyzWL
 QG83A4Ww94LuyLxWUYRbxBJ8ZaXiy7wT7QoJEsCOkDBMKqAIDWSJGgBPpWkAbjg6F9kS
 enJQ==
X-Gm-Message-State: AOJu0Yy5RPah1VoYZCSg4HbuIT7gXfbeCEZGVrC7/cjk8d+bJS9XjuzP
 TYrD1+/Q0t2itcl7IanCVP0wWjnQMzA/OW/PopSvSRaMTgqNHXSI9sGBxORzVL8=
X-Google-Smtp-Source: AGHT+IFVDBSayqJX7DMkqRWQbPAC9Y6shXS7aHyn/3KRIdMwIjytK9WwbLu7Y7PvbwnCK53bFPM4Xg==
X-Received: by 2002:a05:651c:54a:b0:2ee:4ccf:ca4f with SMTP id
 38308e7fff4ca-2ee5e3c3a6bmr84892201fa.31.1719998559096; 
 Wed, 03 Jul 2024 02:22:39 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.47])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15694e1sm98829405ad.224.2024.07.03.02.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 02:22:38 -0700 (PDT)
Message-ID: <22a9bf1a-28a7-47d7-8b48-c3546fe277c9@suse.com>
Date: Wed, 3 Jul 2024 11:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-8-58e9af649a72@suse.com>
 <CAEemH2ekjHU_wuyr7ThWbbs8NYZ8+8hUB-KLVP-tG=V2NWAT5Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2ekjHU_wuyr7ThWbbs8NYZ8+8hUB-KLVP-tG=V2NWAT5Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/10] Add landlock04 test
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

Hi Li,

thanks for catching it. I had to install exfat in my VM in order to test it.
Indeed, I think exfat doesn't support char/block/sock devices, since its 
focus is mainly SD cards and USB drives.

We can easily skip that specific FS from the test, as I already done for 
vfat.

Andrea

On 7/3/24 10:20, Li Wang wrote:
>
> I got some failures when this test was performed with exfat FS, but 
> haven't figured out the reason, FYI:
>
> # uname -r
> 6.9.6-200.fc40.aarch64
>
> # LTP_SINGLE_FS_TYPE=exfat ./landlock04
> ...
> tst_test.c:1694: TINFO: === Testing on exfat ===
> tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra 
> opts=''
> tst_test.c:1120: TINFO: Mounting /dev/loop0 to 
> /tmp/LTP_lantEvE2G/sandbox fstyp=exfat flags=0
> landlock_common.h:30: TINFO: Landlock ABI v4
> landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_CHAR
> landlock_tester.h:237: TINFO: Test normal or special files creation
> landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: 
> EPERM (1)
> landlock_tester.h:120: TINFO: Test binary execution
> landlock_tester.h:131: TPASS: execve(FILE_EXEC, args, NULL) : EACCES (13)
> landlock_tester.h:146: TINFO: Test writing file
> landlock_tester.h:151: TPASS: open(FILE_WRITE, O_WRONLY, PERM_MODE) : 
> EACCES (13)
> landlock_tester.h:159: TINFO: Test reading file
> ...
> tst_test.c:1694: TINFO: === Testing on exfat ===
> tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra 
> opts=''
> tst_test.c:1120: TINFO: Mounting /dev/loop0 to 
> /tmp/LTP_lantEvE2G/sandbox fstyp=exfat flags=0
> landlock_common.h:30: TINFO: Landlock ABI v4
> landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_BLOCK
> landlock_tester.h:237: TINFO: Test normal or special files creation
> landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: 
> EPERM (1)
> ...
> tst_test.c:1694: TINFO: === Testing on exfat ===
> tst_test.c:1106: TINFO: Formatting /dev/loop0 with exfat opts='' extra 
> opts=''
> tst_test.c:1120: TINFO: Mounting /dev/loop0 to 
> /tmp/LTP_lantEvE2G/sandbox fstyp=exfat flags=0
> landlock_common.h:30: TINFO: Landlock ABI v4
> landlock04.c:98: TINFO: Testing LANDLOCK_ACCESS_FS_MAKE_SOCK
> landlock_tester.h:237: TINFO: Test normal or special files creation
> landlock_tester.h:240: TFAIL: mknod(path, type | 0400, dev) failed: 
> EPERM (1)
> ...
>
>
> Regard,
> Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
