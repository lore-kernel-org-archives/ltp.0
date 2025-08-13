Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD88AC87FCF
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 19:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007373C63E1
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 21:09:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004C53C0296
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 17:58:54 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D8FF20008B
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 17:58:54 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so5735080f8f.0
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755100733; x=1755705533; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
 b=YhI6qqpFAwET1315tqXLFki3Ofig7ofxMzuj/ovrYNanaa0hKrQEQjifhTUcWrKqVu
 pUHMvJLAZ5ua/Tom2iSUbzoZCM1Wq+f328ENnMQQ4s27DdhlMO9pWKwBCI9XgdOOtyxd
 UyZFMUXp+E0Ow/TMVR6BtI/yNGYl/erGQcnc0h7DYyrGMNUwetYAwoUl/H5CmcJph5a0
 PqwVtdP/ZL9VCQTlcZt6LYziF2KdOOLF46o/Lx2iLScrZsQzoLMNVaA9vsi/kB65xYtJ
 qAseWLb8PIErSduqMsPOXQw60dheF5mURgB+2gvsw9ememwSReQupE9aXpcrDLBWtCd1
 PAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755100733; x=1755705533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
 b=O2xsIsC6wntTOcuitrStgYHxfsi8t2UxhcRlUZWmsmrqU6HLRU0sfLBvJ6jNNCOB1Q
 D1aWiCT0JIaWcXpicaAF49bxRzRyVgu6Rler6INTeNWhC5opwUNbVEjUKoNthK9goa6j
 igybyi49Vp6Pbv79q+a7bWXOF7p0gH9TNOmuKU+aJriNUD+aQuUi+FOfzubwkofqo/5i
 olRvABKrNioCkA/1vztocakdSS0WX0qWgVlUocj/7N8PoaJTokNj/NIMJIktpU7G/J5B
 jtfTqHMAOw/hFV6ST4nVOTnSwXA0Wdnf8UpQc+Mf9f03e86BvdcVWOzJ/C+2bXDyJdyr
 EUzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Vji5ar23bQ7kOoaFEEhitY6cjdwsMNHTo4ifYbc/5zL0XNHrrYlsH3EswXXU+7yFCiQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzadtwulEdHFOnUjwItCkClO60V3uMK3kTAa7CpMDH6pYst6MiX
 EGB+oK7Wdg83chJTphxLvQSJLkIYPnIZU6MegmS2/Mwhn/+wu/KoUe6kW9PCEMW9Lvg=
X-Gm-Gg: ASbGnctq3bv3pHl4zQi70/c4Ljgleh9W28/2HprO/+sTpHpTvSgQpJ6i+Kjkqqqhs6V
 YQC/bwNkZbf1KXcGq6ty0xpMrljfsdieyXnTplhPwFDdZbViv378MMmlkJ+kCaGEWyzUvUhjRP2
 A9y59srzqPe7NE1plCT1ebPOgfmmevYkk8EmqN2L12zI/9SNmUlbG30keD0IlE8xfCTQ6WBuaiQ
 wOm9ZI/dEG9Yi9Pq3xSLA1SHi4eVsnXPX8DyHH3+kGBKAdY/mtQ6WxZbHjfcN3I9dmiQiA4zKcu
 AZ7M6IxKcmAR2LhdBK2OW0iK5MACK2TsAfRN31HEPdEW5MZFa1BMuC9kufxYENvfEP8f5e3X5Y2
 FLmbmK8Iv/2TYv9UbzCXIf2OIqsO/DvdzAq12wBNCvsM=
X-Google-Smtp-Source: AGHT+IFmDnHCSl5CKkyh/D1IvMDkhgbQzh6CQ86Hu6D5gyD/dtG5m2liXMYcw3pmw6tZ+PFrvCebxA==
X-Received: by 2002:a5d:5f95:0:b0:3b7:8dd7:55ad with SMTP id
 ffacd0b85a97d-3b917f14804mr2882432f8f.39.1755100733462; 
 Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3b91b05b28fsm1789186f8f.21.2025.08.13.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <aJy2OVhg4RUYbHHR@stanley.mountain>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 21:09:06 +0200
Subject: Re: [LTP] [PATCH 6.16 000/627] 6.16.1-rc1 review
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
Cc: Ian Rogers <irogers@google.com>, Jan Kara <jack@suse.cz>,
 Zhang Yi <yi.zhang@huawei.com>, qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hargar@microsoft.com, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joseph Qi <jiangqi903@gmail.com>,
 patches@kernelci.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>, rwarsow@gmx.de,
 pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 achill@achill.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 13, 2025 at 04:53:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> > Hi Greg,
> > 
> > > > 2)
> > > >
> > > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > > >
> > > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > > to disk space handling in the 64K page configuration on qemu-arm64.
> > > >
> > > > The issue is reproducible on multiple runs.
> > > >
> > > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > > >
> > > >   - fallocate04
> > > >   - fallocate05
> > > >   - fdatasync03
> > > >   - fsync01
> > > >   - fsync04
> > > >   - ioctl_fiemap01
> > > >   - swapoff01
> > > >   - swapoff02
> > > >   - swapon01
> > > >   - swapon02
> > > >   - swapon03
> > > >   - sync01
> > > >   - sync_file_range02
> > > >   - syncfs01
> > > >
> > > > Reproducibility:
> > > >  - 64K config above listed test fails
> > > >  - 4K config above listed test pass.
> > > >
> > > > Regression Analysis:
> > > > - New regression? yes
> > >
> > > Regression from 6.16?  Or just from 6.15.y?
> > 
> > Based on available data, the issue is not present in v6.16 or v6.15.
> > 
> > Anders, bisected this regression and found,
> > 
> >   ext4: correct the reserved credits for extent conversion
> >     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> > 
> > Report lore link,
> > 
> > https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)

Lol.

regards,
dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
