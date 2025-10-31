Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4A9CCF9EB
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761892453; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xR2rLbCqyzOmToCibif6rzgrtimBOZUEF3uMGSa3azc=;
 b=qccpxqEYmNEKlpXdCmAKovcC831Ox4nq9zCfK8fClkOEuB09EW0uy9j/ILmfiB6gmzJVi
 djppMRLzD49tgjDqe4T52vjPWNabAgbq7BqaXUAYoCnM8l3jbeuakcvulhgkAvXApFgLtnA
 tVyzGdOJTOlcq5J01AVsr8vUYws1MFw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 300F73CC85D
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 07:34:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EA9F3CC1EF
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 07:33:51 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 643DC200C92
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 07:33:50 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429a0d1c31aso1278445f8f.1
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761892430; x=1762497230; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ADhqY2bwftN8TtgTxBBy0JwE0hAMi0vW53A4109lFVU=;
 b=fpw6M2VJh0cmY8Ul2DWO2+uKCwmvWv+hJ7CouEC9WbgAIgrY/BelSISF3TKEJaUT0Z
 QcrTV+xnfsTfEN1Xw8YZa3MZBHkLnJXb2nWtjPbQPH8YYjqkJdB/mQWtnTGP9Uz6AiUr
 Sa3al5vjtM6H2IsrBkhzP9BBmWiFX3CVfHayeR2up406RtGpBhaO97V52Cu7cu3auXHp
 qcU1ZFgz/4vnLrGnNFBMmo6EB5pkfpTdzsrEbI7+kfPKp3bumnbPyC2CfJKh24257Dal
 6wdptkJ9eGsC+ecmQ1WZw/KIX/Zu2vUb7OcRK9AHZ2FSuh+puKwPKU7VSW4ABk/HVSoi
 gB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761892430; x=1762497230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADhqY2bwftN8TtgTxBBy0JwE0hAMi0vW53A4109lFVU=;
 b=Mmb1zOhvAArbFKsol6QNynghObN7FlCFagzka4m6SMQtn/ugSlV2SgsBKuAcXaQpsu
 IHeGaSqFiqCgc9EC4zct4e6HjPR25vEKyqS9I+8ePNFl0IKJDlJWq7YgPwTyMo9p4KEp
 dvhuW07VmcxvPyaPT5zbiQINwJx58G7XbmqLhJZna0TD7PAY/m7myO7eZOYeZDKRablH
 c4//Zah4w/bpY2mOp9+YUabr3XIYMNkzxCjkJfPEEhvfS9XTruI8aWOBdU7+jPL1fEmT
 HzC833j9wOOfL6mT+7ehdKCgVZZudzEP1Z8o3rwWpxEmUqIqOwNkHHFRpIyeh5gcc53d
 oJJw==
X-Gm-Message-State: AOJu0YwR6WOCulVYkr4xlnZN9dTQnpXTv2if9pOKV/BJnuTQiBxS0bDu
 CkxH0WBZN4Wkgg1XEb7RhCCTovVEXzDQypwMXGbaYPyS4b4xkC/uCRRWADrZCGJsd4vrrTR6J/Q
 TFNI=
X-Gm-Gg: ASbGncvBphtDhN1kDkrKqCxUmTd7+uZBnZ62ZT3KSTWprenCWCuPe/OdUwfHPU3EPnv
 M9WvH05fGMU0Lw0uxEJFkSezO+gX49tKwa+l4sKe1nelL0wt06FEoR9UWMEswNzxn1slFU9lXZ0
 tBP2WcT03N0YFgPKDbCbPO9WGE1H59BNwdj6rhf5vMLFaXFMo6z/+lHHrWMSm4M4EsM0BCe1lun
 z/OjPhsdwAg1+r1GKz1g6rcjOyB99XutgFo1hscBNGn8Hh9+IG4OBdhSyP8lLzt4QVwJTBEKKji
 4buHQ+dId05gzPVKoSyQJ0I7vHTXpjCRLUDDci2UOVpiE/jbpeWXObP/XqnFIhtwrJvESs7OhAq
 Kzz+ihtVEcL16lqN8qRS5HV1oggOlrfVhkzwYQ5BJIF0nb3WzN7s2eQH4qoUP8oWmvYKda4I/cR
 Zrc4JxKSxQlOl5q3K3Mw==
X-Google-Smtp-Source: AGHT+IE4/koCMi6EX+xh7AerPnA8wgeOF/3gbrHnlpKucJrHq3dP5w8+1SykOjsZgbVre1KU2wtzUA==
X-Received: by 2002:adf:e193:0:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-429bcda2109mr2210154f8f.27.1761892429565; 
 Thu, 30 Oct 2025 23:33:49 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114ca0csm1941543f8f.21.2025.10.30.23.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 23:33:49 -0700 (PDT)
Date: Fri, 31 Oct 2025 06:33:47 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQRYS25XIjU6TfNY@autotest-wegao.qe.prg2.suse.org>
References: <20250529105156.2564268-1-wegao@suse.com>
 <20250924084223.20597-1-wegao@suse.com>
 <20251030201734.GC753947@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251030201734.GC753947@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_filesystems01.c: Add test for .filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 30, 2025 at 09:17:34PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +	.needs_cmds = (const char *[]) {
> > +		"tune2fs",
> > +		"dumpe2fs",
> If you don't add packages required in these 2 binaries into scripts in ci/ it
> will not be tested in GitHub Actions.
> 
> See
> https://github.com/linux-test-project/ltp/actions/runs/17971580970/job/51115261638:
> 2025-09-24T09:00:56.9304198Z tst_cmd.c:268: TCONF: Couldn't find 'tune2fs' in $PATH
> 
> Alpine: e2fsprogs-extra
> Debian, openSUSE, Fedora (hopefully): e2fsprogs
when i add following diff another CI error triggered on alpine, it
seems /dev/not mounted.
further check.

diff --git a/ci/alpine.sh b/ci/alpine.sh
index f3a1bf528..254f4aaec 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -25,7 +25,6 @@ apk add \
        musl-dev \
        numactl-dev \
        openssl-dev \
-       e2fsprogs-extra \
        pkgconfig

https://github.com/coolgw/ltp/actions/runs/18960845023/job/54148138737

2025-10-31T02:50:14.5257746Z runtest TINFO: * shell/tst_format_device.sh
2025-10-31T02:50:14.5260052Z tst_format_device 1 TINFO: Running: tst_format_device.sh
2025-10-31T02:50:14.5268691Z tst_format_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
2025-10-31T02:50:14.5329045Z tst_format_device 1 TINFO: Using /tmp/LTP_tst_format_device.XXXXOajpgN as tmpdir (UNKNOWN filesystem)
2025-10-31T02:50:14.5352954Z tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
2025-10-31T02:50:14.5491591Z tst_format_device 1 TINFO: Formatting ext2 with opts='-b 1024 /dev/loop0 5m'
2025-10-31T02:50:14.5555250Z tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
2025-10-31T02:50:14.5571366Z tst_format_device 1 TPASS: device formatted
2025-10-31T02:50:14.5594507Z df: /dev/loop0: can't find mount point  <<
2025-10-31T02:50:14.5598211Z tst_format_device 2 TFAIL: df /dev/loop0 | grep -q /dev failed unexpectedly
2025-10-31T02:50:14.6127085Z tst_format_device 3 TINFO: AppArmor enabled, this may affect test results
2025-10-31T02:50:14.6128036Z tst_format_device 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
2025-10-31T02:50:14.6128824Z tst_format_device 3 TINFO: loaded AppArmor profiles: none

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
