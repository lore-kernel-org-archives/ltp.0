Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF87C48BF8
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708610069; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZW2jkVy8RF1UOe+BRelYiuEsCeB2C9fspfedHGdqdf8=;
 b=lBClMI6on4UkAk1P3L5+njOJx1QaSqFaD7704Nf5Oi1fA8up4+qZxb3vfi/WvHchSgte8
 r8Qgh9PnxkMyFl/DZ6gUs9A7DEkcDU389SL9EwCWyrZnhNaRzH0AAmiiCTOBqyf/KEV6xP5
 XXv3QBs2Eu3N4zK1ohP9sHneIQ8kzjA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DD53D0084
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 14:54:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C5D33CEFB9
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:54:07 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51CDD10085F3
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:54:06 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d28468666so1298457f8f.0
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 05:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708610046; x=1709214846; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JJOxMliItX+x8cCfdTk+GObYT0ecM+aDnz7HHiPiesk=;
 b=UZ9yIukETMkWxIUiH49BT4WBx7EFJ9yj/jbSP9RNpwvO12TA0rmjQOo5krADfh3D58
 PzPKh6E6fN21lv4z8f5rgvQv4s8YM33peBGK2vkLeLvkveuPUIqifcG3kR8oE8m709sh
 MxNRY46DneZ+4uuRQTOEOpWfLxLFp5hysXQNBBx3HpskV80JCGaMP/VhBU2jys5MbvFS
 +x0hdNI8Wbg1triVcMPt1/Q04R9WzPJNUP2tB3I+c9G7b7/C4iVIYOkaRfmiMz4I3zMJ
 MQfVKtrZPpe0In4sDzPOlqj4YezYpPNg5Al9iIXYA7GW8cGaYbtCXbH+LwN9IJUqb9Hh
 v2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610046; x=1709214846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJOxMliItX+x8cCfdTk+GObYT0ecM+aDnz7HHiPiesk=;
 b=VgAnKsir28HT9CFXGN6hY43zgB15+YK/yIBTonyCIphEIm76MN/vbW03SSRLP/imlc
 KU/go1hXEmh5CueU2mik6/20ROKnrXKbBd6hfsgizIDplmbH9IrnFJZiW0ej407gkgkA
 TjcVtxiHwmENlvTr75TM3UY0aIIXuamsePzHiubGQy9bVbIhmY19cEnAToW7SX01eY+x
 YVufY+sDw6gz4tIrPS0Y/qC0MWZ4QdaEooeOPCDzJAviTJMSn6lGcH9o9tuApqg+X9Sv
 FAA1o5ZkhxISHGLOWdrXN1k2v/dC2wgbeY3EXkHCgUFw5RDxZTNn5Iw+DMc66jANx04D
 sjFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULy7Dsky9OF9DesAMuJmlGKxZ/gFQkdUrNzCKAvR6p0fx7HXqZXMWcJWNx7PZDtvX+fkpzkabLZHWMvl/HmJxLQys=
X-Gm-Message-State: AOJu0YwPWqKK/bnbKtWnsFwYXbr18KWF6PyQ92j2IaNvmd38lDZLrAFY
 K+BcqG3N2K2UqI7u5WUgM5ML10M6rcG408ln9/ZlncbJJwXzCI0MrQb+KCa/SA==
X-Google-Smtp-Source: AGHT+IGMWaVB41d65OaF0EC7tP4xUTrR5KtWYVwnM9qGtATNm0XdpyqSK9ahQeacwIDPcGm9rQLL/w==
X-Received: by 2002:a05:6000:10c6:b0:33d:7d88:bd3e with SMTP id
 b6-20020a05600010c600b0033d7d88bd3emr3429379wrx.43.1708610045768; 
 Thu, 22 Feb 2024 05:54:05 -0800 (PST)
Received: from wegao.166.144.58 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a05600016c500b0033d60cba289sm11532972wrf.68.2024.02.22.05.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:54:05 -0800 (PST)
Date: Thu, 22 Feb 2024 08:53:58 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZddR9k/Rk66XabBM@wegao.166.144.58>
References: <20231204002623.17302-1-wegao@suse.com>
 <20240219134845.22171-1-wegao@suse.com>
 <20240220091837.GA1088847@pevik> <ZdW1UDq17nHx0eE2@wegao>
 <20240221161907.GA1266903@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240221161907.GA1266903@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test.c: Set system default umaks to 0022
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 21, 2024 at 05:19:07PM +0100, Petr Vorel wrote:
> Hi all,
> 
> > On Tue, Feb 20, 2024 at 10:18:37AM +0100, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > >  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> 
> > > > +	umask(0022);
> 
> > > I don't think this is a good idea. Changing umask() in the library can influent
> > > tests. Could you please instead add umask(0) (to reset umask) on the tests which
> > > need it? The way it's done in open07.c.
> 
> First I thought that modifying umask (either with umask(0022) or just reset with
> umask(0)) is not a good idea, but now I'm not sure:
> 
> 1) We have quite a few tests, which will needs it:
> NEW API tests:
> $ git grep '^\s*umask(0' $(git grep -l tst_test.h) | wc -l
> 15
> 
> All tests:
> $ git grep '^\s*umask(0' testcases/ | wc -l
> 34
> 
> And for sure some other, which will fail when too restrictive umask is set.
> 
> Wouldn't be better to have it in the library? Hopefully fewer tests would be
> influenced this setup (and would need to set different umask()).
> 
> > cgroup_core01.c and statx07.c can use umask(0) in tests and i have updated the patch.
> 
> > But chdir01 will still failed on vfat and exfat. Like following error msg:
> > chdir01.c:100: TFAIL: nobody: chdir("subdir") returned unexpected value -1: EACCES (13)
> 
> FYI test fails on vfat and ntfs when umask is 0077 (because override file and
> directory permissions) (other filesystems are ok).
> 
> > The reason is umask(0) should set before mount /dev/loop0 to /tmp/xxx/mntpoint, otherwise you 
> > have no chance modify permission of file. What's your suggestion?
> 
> > susetest:/tmp/LTP_chd5JtblL/mntpoint # mount | grep loop0
> > /dev/loop0 on /tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> > /dev/loop0 on /var/tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> 
> 2) tests, which set .mount_device = 1 and have more restrictive umask will not
> work. Workaround would be to not use it and mount manually in the setup().
> Or, reset umask with umask(0).
> 
> WDYT?

Currently i only need fix one case chdir01 so i will try to do workaround(mount mount manually in setup).
If new fail happen in future then i suppose we need consider do umask in lib.

Thanks for your comments.

> 
> Kind regards,
> Petr
> 
> > susetest:/tmp/LTP_chd5JtblL # chmod 777 mntpoint <<<< 
> > susetest:/tmp/LTP_chd5JtblL # ll
> > total 307216
> > drwx------ 4 root root     16384 Dec 31  1969 mntpoint  <<<<<<<< group and other has no any permission even try chmod
> > -rw------- 1 root root 314572800 Feb 19 04:51 test_dev.img
> 
> > susetest:/tmp/LTP_chd5JtblL/mntpoint # touch aa
> > susetest:/tmp/LTP_chd5JtblL/mntpoint # ll
> > total 16
> > -rwx------ 1 root root    0a
> > drwx------ 2 root root 8192 Feb 19 04:50 keep_out
> > drwx------ 2 root root 8192 Feb 19 04:50 subdir
> > -rwx------ 1 root root    0 Feb 19 04:50 testfile <<<<<<
> 
> > Thanks.
> 
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
