Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B721D29C2A
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768828853; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kY1U0rehu0PTdf/3R/0fcvqTjADaUmyvqGO3ldm7+bg=;
 b=iu5/jDAxvF4T7FTbAeqGgzxbuwJqcze4xHsZO2J0XhT2B3UBM9m5g6aY5k0h+X4h+eNNK
 C8yZoANV9zKQDbnY9yjVj6RWtyyz5VyEzb100+6wU/sa3eNCFFqBNrjLMRq0o4oP1qcr9Tn
 x79kDj1Uf1pEe/lnUBdrPDmWHykZqWI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC3F73C98ED
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 14:20:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C3453C61A8
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 14:20:29 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9EAF3140006A
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 14:20:28 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3687466f8f.3
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768828828; x=1769433628; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8ZJB9RoWmTssadqw4zwjJDkx0MheJ2sfBgvPUoobWE=;
 b=N0TA2bGtBon5ggbANTo3SH5nNIJ7bsRHwnB/fOslb0U+V55STrlxyuETiVQyqgT+U7
 pH8E8mHdepKIo4YWIjiJcP4OY5cxdRER5Hz7cleBYFdMPABnsyvdVzZieQiTAX4FooUp
 QXjnhhfVasj6yPb8fHsJ0dzbBhjkexuto0pzESxZadUSlWfOev0k1IE5lRAx+Iv/GVm7
 0NKc/p+wbBCdRPZuGz3ZAQdKH3Hlf9GwGGh2wof5Nx3y1pbfuymatHLYmI7Xy20Oebnh
 IWMOj/hp+E0m0fNDrWV9j43OVY5PLVp5Vzp/5NvmNkJOyw5rrard/xapSV2GUGtsaqdS
 pQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768828828; x=1769433628;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8ZJB9RoWmTssadqw4zwjJDkx0MheJ2sfBgvPUoobWE=;
 b=J8S4P1FoLVcF5+/Xw562HvZRZEXeQhZ8n4CcsmjjnW7VVS16AvewdsDLGkb1tVkjON
 dxge2QjVmO4gcQ1TX7MIaaoMgnVrqafa0r2oVtqzwUUDhKPxLXxRK8h4SoQu/8547f8L
 Un2SG2Y0bvAFxuu/TRI39TtFkNGEECXiLVucsUFijwZAN8lTPvRyegdt9JsHbdhUWlKK
 9ht5ow83UiEECg9eO9GqcW6t3QmoKPD8hFTHcss4hZ3mVqzfmq5Sz5WZAO+68MCLBWEa
 IMRXDeiP/PpLSMFnba9rtO8U3a0EezQDDz7fnZpCHz+CA4/uDNuScWaIpYwOP+7Chfve
 YyHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/JayPvARCCIhM8sM4mhGglVaRp4twFDKegvteAhwitRlt+yFBrONfJVjKCknEfDgZt2Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwR0ZMr7lUtobiy0Y7uDpjyJYTYMHYM5l+Om7zyOOvHwoICzSpt
 0FVpe4Vnwdl+aw9iIF4m1L2nfub3sptwEHdbVtGq/UbHWzgQPKdGCmK8R/LmDrpzfMI=
X-Gm-Gg: AZuq6aIy3Rsk037GoI7oSnnYqjjXfaVH6k2SuS8UkTReaSfHEMOGKXtIP70XFfMHuD4
 NBFXgaH6yks6tzca7S7WP2LkCrsS1nrtvespit7gw3rHn3aRnYjGH2nZDbnZmVV80LCbKNuTcwe
 HxXc6H3v0XvsflivHphFjLF3qGsMBuyd9w12VHdMHswnMBWACDA7EBdijNbKglTX+9bPY2cHtEx
 McpnhMY4X9JhnQV/SCQ6+e8n7aOcHsekK/sPMlvCnLcd7XgtBftWPfY5cdwSLorPm+7bfam6th0
 +Myyh0mMAKSirH9QUCAcd6q5UbdPr9PfdLn+uguTftbpKDItlZcNFz67IJLY1PBPqcDy7sOjnLy
 XWvW0xXY7jr4DtvTMARlDj9/44Gfvi9xTkHrWiUFcytd/do2K44mIGHVFBUv1NoJhI2b+jWitWR
 Xg7xvkYC1yio7imUEeu//GxWBeY0TavWBKzUt8MDWUvRyN/cQ+edvHFfM5JRu3INj6h3e7/8Zhg
 sJD
X-Received: by 2002:a5d:64e9:0:b0:432:5bf9:cf22 with SMTP id
 ffacd0b85a97d-435699709f8mr15581580f8f.3.1768828827921; 
 Mon, 19 Jan 2026 05:20:27 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf33sm23887120f8f.25.2026.01.19.05.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 05:20:27 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 19 Jan 2026 14:20:26 +0100
Message-Id: <DFSLHKV3EDAP.3TBQI2S9THZ64@suse.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260119085129.165080-1-piotr.kubaj@intel.com>
In-Reply-To: <20260119085129.165080-1-piotr.kubaj@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] thermal: add new test group
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
Cc: tomasz.ossowski@intel.com, helena.anna.dubel@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

There are a few issues with this code. We need to clean it up
before proceeding with the proper review. In LTP we have a strict policy
when it comes to writing new tests and that can be read in the following
links:

https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html
https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html
https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html

Documentation is away from being perfect, but it needs to be read before
proceeding, since some technical aspects are covered only in there and
inside some of our reviews, especially the ones from maintainers with
the highest expertise (@Cyril, @Petr and @Li in particular).

A few points below:

* run `make check` locally inside the test folder and verify errors
  inside the test code

* run github CI by pushing your commits inside a forked LTP project.
  The patch is not passing in any of our tested platforms (I'm sorry if
  CI report is not working in patchwork yet, but that has been fixed
  today)

* please verify that all you need has not been implemented inside the
  LTP library already. For instance, we already have `tst_ncpus()` and
  _SC_NPROCESSORS_ONLN is not needed

* please avoid as much as possible unsafe memory operations over strings.
  we dont really want to use strcpy(), strcat(), etc. In most of the
  cases, snprint() and asprintf() are the right choice

* why using regexp for something as easy as finding a substring inside a
  string, without any particular substring rule over data?

In general, we need to create a code that is working as good as possible,
since debugging test failures can be really complex inside kernel. Test
has to provide very little friction with the kernel in order to reduce
test maintenance.

Let's start from this, we will continue the review when these points are
first achieved.

Kind regards,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
