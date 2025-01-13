Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DE4E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 05:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736747899; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=PUG02Bs3grtaIIVPmQorOg9a/+8m9IE7YUj4Ymxc2rA=;
 b=I9LRA2KlpmEekbyjk92HxEwdKofYhejxzucBYKx5sqQqavrI8fqlr8gcOhjcsHQGFY0Xe
 +0z16R0iGup43aW9kzdtTxhTcQCnarXxpG+mBkUgUnEZuJmrv+/WKWWbE6sfbTSryF2PaJU
 qMbwpkR3uq/VU/80Ws9LQ71Va2OgNfg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50163C7705
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 06:58:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092EF3C0799
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 06:57:57 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7F8EF142D500
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 06:57:55 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so1970997f8f.1
 for <ltp@lists.linux.it>; Sun, 12 Jan 2025 21:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736747875; x=1737352675; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7FPqUgcgZKi7PEMkhtK2JULn0C+y4Xr+En4HTKIRdSo=;
 b=T7KnVJMiNPgKC+cN9eJ878PdHYkEft8bO3tf8EAoCRkM5FVtnr1O9V44RGf7ZdjTWw
 6QROlHB60lTthVbRF7dC4KP4XCtd3Cl4BpmYK3OJI58xAYNT1cwdC6OA+I7MaedIfVIa
 CbY1n0VMLnGuhY3msqgKRsInP1yYcgnocotzyMGhbQ/yco1dWSmsdjjbampfPeho3FGS
 ge9FngEwWd4nw9CR8SfTL6sSjJhgiPIh+tK08rd3TLkbdc+MPKQ6gkJh0g+ic/jv+yRc
 U2ya8/hwI+h8PJPTRM7AKSADi561YHUbCYcrToDCJ1mBLZVvc3xq8rdKfhQqNfLQbDy0
 cLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736747875; x=1737352675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FPqUgcgZKi7PEMkhtK2JULn0C+y4Xr+En4HTKIRdSo=;
 b=hXhMq+NTa6oN7d2pZ4nylBT/axzZo3ZrU2GSw/E7pjcGiFcOFIFVTvcCLoPSkiIjML
 K1RveLyDkQnyo81mX4MqrviSv1Z4Aj8S/vpdIZGatSYX2tRiUciKVvyKmg9orTv9Z8Vt
 faOTwvBLiRCAAStcFb/+QMf6guyUWJjlxMLJ8e80iHgueCm9Lo1eBu1sx91O5wwA6hGq
 qYcQ/z+Ulq6qu3BAIOdyO5EJiBIMw5JeSHhom1HjgOL1QDYBcCt3jIbbcknfIdqv7olQ
 WpHMTbo5I8HPP8dE9T2cC1GbGAEGhRagA67VA4UDieCoZuKC/V4o+TNMyACCUGO2lxEz
 EKDA==
X-Gm-Message-State: AOJu0Yz6lOVBNuJKn+OQfm+ab2nqQOAsrMJX91CQ9++CiNzwCUzrz9IB
 JsQkr+tbk30LHuI+OntbR3sevQik3lR4QA9fD+R6syS/q6xDDf63mzS6dth4G4z6ThS1ZUruTbU
 =
X-Gm-Gg: ASbGncvMKowzlZ9sLzoEOSVqhyXEMlJEHtjbNzrRkB8fMmGd4hRReCT0sTY/TFYNJ+d
 gubbcKtaLDrbmE4Os1RRyhsXJdxfqUbkhxfAyjy+5qAclQn9dZfEfaOSRFywsaD9JVnTjp/dFsA
 DTDAymwL/xq6jWbIFzQgg7/uxa2aiwefGjGSpw3xWem7Sofi+6bdODTcocNxhwXaOnfmxorJWvP
 cZg5eHJs1rA+57vopIiTcc6W+VWhsGbMsG9FsmpWA==
X-Google-Smtp-Source: AGHT+IEjMyKE01y9i8kk+exESw3r39ksMHqmyKd4LNGNBtdO2uDN4Z9evkl2n4/hbKPdM+BTA7WRHg==
X-Received: by 2002:a05:6000:1f85:b0:386:4a0c:fe17 with SMTP id
 ffacd0b85a97d-38a872e9105mr16522213f8f.27.1736747874742; 
 Sun, 12 Jan 2025 21:57:54 -0800 (PST)
Received: from wegao1 ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c7aesm11499508f8f.53.2025.01.12.21.57.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 21:57:54 -0800 (PST)
Date: Mon, 13 Jan 2025 00:57:48 -0500
To: ltp@lists.linux.it
Message-ID: <Z4SrXDhrl24vVk6F@wegao1>
References: <20250113055231.5908-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113055231.5908-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jan 13, 2025 at 12:52:31AM -0500, Wei Gao wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  configure.ac                               |   1 +
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/ioctl/.gitignore |   1 +
>  testcases/kernel/syscalls/ioctl/ioctl10.c  | 175 +++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl10.c

The test report error when i check tw in my env(wrong dev_minor number). I guess is kernel issue?

susetest:~/ltp # uname -r
6.12.8-2-default
susetest:~/ltp # cat /etc/os-release
NAME="openSUSE Tumbleweed"
# VERSION="20250109"
ID="opensuse-tumbleweed"
ID_LIKE="opensuse suse"
VERSION_ID="20250109"
PRETTY_NAME="openSUSE Tumbleweed"
ANSI_COLOR="0;32"
# CPE 2.3 format, boo#1217921
CPE_NAME="cpe:2.3:o:opensuse:tumbleweed:20250109:*:*:*:*:*:*:*"
#CPE 2.2 format
#CPE_NAME="cpe:/o:opensuse:tumbleweed:20250109"
BUG_REPORT_URL="https://bugzilla.opensuse.org"
SUPPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://www.opensuse.org"
DOCUMENTATION_URL="https://en.opensuse.org/Portal:Tumbleweed"
LOGO="distributor-logo-Tumbleweed"

tst_test.c:1893: TINFO: LTP version: 20240524-413-g96a255983
tst_test.c:1897: TINFO: Tested kernel: 6.12.8-2-default #1 SMP PREEMPT_DYNAMIC Mon Jan  6 06:45:37 UTC 2025 (90b0f5b) x86_64
tst_test.c:1730: TINFO: Timeout per run is 0h 00m 30s
line=00400000-00431000 r-xp 00000000 00:30 14632                              /root/ioctl09

ioctl09.c:100: TPASS: parse_maps_file(path_buf, "*", &entry) passed
ID of containing device:  [0,15]
ioctl09.c:120: TPASS: ioctl(fd, PROCMAP_QUERY, &q) passed
ioctl09.c:122: TPASS: q.query_addr == entry.vm_start (4194304)
ioctl09.c:123: TPASS: q.query_flags == 0 (0)
ioctl09.c:124: TPASS: q.vma_flags == entry.vm_flags (5)
ioctl09.c:125: TPASS: q.vma_start == entry.vm_start (4194304)
ioctl09.c:126: TPASS: q.vma_end == entry.vm_end (4395008)
ioctl09.c:127: TPASS: q.vma_page_size == getpagesize() (4096)
ioctl09.c:128: TPASS: q.vma_offset == entry.vm_pgoff (0)
ioctl09.c:129: TPASS: q.inode == entry.vm_inode (14632)
ioctl09.c:130: TPASS: q.dev_major == entry.vm_major (0)
ioctl09.c:131: TFAIL: q.dev_minor (35) != entry.vm_minor (48)  <<<<<<<<<<<<<<<<<<<<<<<<
ioctl09.c:139: TPASS: ioctl(fd, PROCMAP_QUERY, &q) : ENOENT (2)
ioctl09.c:147: TPASS: ioctl(fd, PROCMAP_QUERY, &q) passed
line=00400000-00431000 r-xp 00000000 00:30 14632                              /root/ioctl09

ioctl09.c:151: TPASS: parse_maps_file("/proc/self/maps", "*r-?p *", &entry) passed
ioctl09.c:157: TPASS: ioctl(fd, PROCMAP_QUERY, &q) : ENOENT (2)
line=00400000-00431000 r-xp 00000000 00:30 14632                              /root/ioctl09

ioctl09.c:166: TPASS: parse_maps_file("/proc/self/maps", pattern, &entry) passed
ioctl09.c:175: TPASS: ioctl(fd, PROCMAP_QUERY, &q) passed
ioctl09.c:176: TPASS: q.vma_name_size == strlen(process_name) + 1 (14)
ioctl09.c:177: TPASS: (char *)q.vma_name_addr == process_name (/root/ioctl09)

stat /root/ioctl09
  File: /root/ioctl09
  Size: 873728          Blocks: 1712       IO Block: 4096   regular file
Device: 0,48  <<<<<<  Inode: 14632       Links: 1
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2025-01-12 22:29:01.378310333 -0500
Modify: 2025-01-12 22:28:58.043307554 -0500
Change: 2025-01-12 22:28:58.043307554 -0500
 Birth: 2025-01-12 21:37:52.621841127 -0500


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
