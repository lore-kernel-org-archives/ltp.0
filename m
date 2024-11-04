Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05466D1119A
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730685479; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NAg3UVwuKKq2NozjqfKfp9Ef876ZEJGsUCLqtLVa9es=;
 b=MoH4L7TjGQx9oD9QzKH6kuzlvthhqYwht5Opdrguo80Z5a8PAErLMfYwApKfCIyiUWTvt
 b7npvpx8eaHZg1a7HMlln4/q31LnuXZBriPuiXE+FjJpHFpERw21o8c9m3siWxksaon4pxp
 xj1jfO/DBty88VJKvXBvcBvWsgyG/2o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6BBB3CFE82
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 02:57:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C0D3CFB14
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 02:57:39 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7196322D291
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 02:57:37 +0100 (CET)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so6549381e87.3
 for <ltp@lists.linux.it>; Sun, 03 Nov 2024 17:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730685456; x=1731290256; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dD4bn/bbfMF52SGT6c4M0R1s9gMzKlx0gks7gt1zmMs=;
 b=U8FkdOOZD41sMHyXpUeyzsPMuoQ6bvc98M9oiWACi0JpXO06MYxW7FKsZy0OOEJM/J
 E1arp+YkiCTVGwfrRelcDzZHr0xA2zSY4QOpZ6ml3W0SDAtD8KqAnaFPdmxbxBWx0cJy
 qdlT+KwnTmFupGk9d776kg9lDtaqdhc3L1KKoOwTIud/uCMhEhybGog0IPUfGut85ybF
 ccAKja9m9Y2lXAkpNeBzAALv7Z46s/eYKCwiG4+nnN3lKXwK4tydDw3T1Fj93QQI/kyf
 PdepDimvRx4SMIe7hTb7zYsEiz8IC7Z60wtjVQPtPrehQKRBaOmzXwiigJij4hsvMBKH
 nuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730685456; x=1731290256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD4bn/bbfMF52SGT6c4M0R1s9gMzKlx0gks7gt1zmMs=;
 b=GSgu8SRaMYvj4OmVCb4fvM0gh6DtaXzdZLh/FUK2M6tdYyKCWJNWdDZyJ4UFr4z4DP
 SGSC1y0bwI/LD+M8hkUpx76hVi4XfDQ2Qdn68zgw6etR4z+KDx8HR/+2fPki7M288rOP
 B2LzN6/cP+IuK7AVVxNePyf+w7/OnKv9zt2nd33eaM+CmFlzccXsS0Yxmeprke4FGrmX
 fozsxaBT4rxSs5c+VWpo89qyxJ7PbWbWPabWdxp2q2+EWtmMYqkMAxtbiJdCdYZx5rL/
 AVGQKODtVykycEE22Mgbqc8+9BOmpFu4m1IbchOeg5kXLYUshVjJqE/lYApMAc+QsD1h
 bxog==
X-Gm-Message-State: AOJu0YyrzLHW8ytxHf+6ACaxa8tUQsu0DtKMseFcVpzYIJhFVZwzIzK0
 U6SoM1vNDPciERBYZlknlOtMUc4IkwbbvcPmfYpmw6f1PnM/s/BL92AVA3EfxA==
X-Google-Smtp-Source: AGHT+IEIG/NvpuhHqvXLeTHRiJJ3v8SGz8MYANBopR41LWXm9O90IGj8EhYSMj7RB0OFibSOBs3vmg==
X-Received: by 2002:a05:6512:1087:b0:539:936c:9845 with SMTP id
 2adb3069b0e04-53d65e0b4afmr7193713e87.37.1730685456412; 
 Sun, 03 Nov 2024 17:57:36 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a59a8sm51774755ad.130.2024.11.03.17.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 17:57:35 -0800 (PST)
Date: Sun, 3 Nov 2024 20:57:31 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZygqC8ekLwXy0CSi@wegao>
References: <20241101165354.1296773-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101165354.1296773-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tcp_cmds: Remove ftp01.sh test,
 binary data files
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

On Fri, Nov 01, 2024 at 05:53:54PM +0100, Petr Vorel wrote:
> FTP login tests were removed in 6282e55b5d, as out of scope of
> of kernel testing. ftp01.sh is FTP server unit test, which is also not
> relevant for kernel testing, thus removing.
> 
> Remove also binary data files bin.sm, bin.med, bin.lg, bin.jmb which are
> not needed any more.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> CI: https://github.com/pevik/ltp/actions/runs/11633078452
> 
> NOTE: The rest of the FTP tests in testcases/network/stress/ftp/ are
> downloading and sending a large amount of data over TCP and are checking
> that the data arrives the same at the other end. That is some sort of
> kernel testing, thus test kept. But better would be to migrate them to
> use LTP custom C code:
> 
> https://github.com/linux-test-project/ltp/issues/1207
> 

Reviewed-by: Wei Gao <wegao@suse.com>

>  runtest/net.tcp_cmds                    |  1 -
>  testcases/network/Makefile              |  1 -
>  testcases/network/generate.sh           | 26 ---------
>  testcases/network/tcp_cmds/Makefile     |  8 +--
>  testcases/network/tcp_cmds/Makefile.inc |  2 +-
>  testcases/network/tcp_cmds/ftp/Makefile | 30 ----------
>  testcases/network/tcp_cmds/ftp/ftp01.sh | 75 -------------------------
>  7 files changed, 3 insertions(+), 140 deletions(-)
>  delete mode 100644 testcases/network/tcp_cmds/ftp/Makefile
>  delete mode 100755 testcases/network/tcp_cmds/ftp/ftp01.sh
> 
> diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
> index 248c7371d1..aba02fb30a 100644
> --- a/runtest/net.tcp_cmds
> +++ b/runtest/net.tcp_cmds
> @@ -5,7 +5,6 @@
>  ipneigh01_arp ipneigh01.sh -c arp
>  ipneigh01_ip ipneigh01.sh -c ip
>  arping01 arping01.sh
> -ftp ftp01.sh
>  netstat netstat01.sh
>  ping01 ping01.sh
>  ping02 ping02.sh
> diff --git a/testcases/network/Makefile b/testcases/network/Makefile
> index ccc9083961..05d7f95fd8 100644
> --- a/testcases/network/Makefile
> +++ b/testcases/network/Makefile
> @@ -14,7 +14,6 @@ CLEAN_TARGETS		+= $(DIR)
>  INSTALL_DIR		:= testcases/bin
>  
>  INSTALL_TARGETS		:= $(addprefix $(DIR)/ascii.,sm med lg jmb)
> -INSTALL_TARGETS		+= $(addprefix $(DIR)/bin.,sm med lg jmb)
>  
>  RM			+= -r
>  
> diff --git a/testcases/network/generate.sh b/testcases/network/generate.sh
> index 939f792cce..af48f77381 100755
> --- a/testcases/network/generate.sh
> +++ b/testcases/network/generate.sh
> @@ -51,29 +51,3 @@ fi
>  "$make_file" "$medium_file" $medium_size
>  "$make_file" "$large_file" $large_size
>  "$make_file" "$jumbo_file" $jumbo_size
> -
> -if [ ! -e "bin.sm" ] ; then
> -	cnt=0
> -	while [ $cnt -lt 5 ] ; do
> -		gzip -1 -c -n ascii.sm >> "bin.sm"
> -		cnt=$(($cnt + 1))
> -	done
> -fi
> -
> -genfile() {
> -	local input="$1" output="$2"
> -	local cnt=19
> -
> -	[ -e "$output" ] && return $?
> -
> -	while [ $cnt -ge 0 ] ; do
> -		cat "$input" >> "$output"
> -		cnt=$(($cnt-1))
> -	done
> -}
> -
> -genfile bin.sm bin.med
> -genfile bin.med bin.lg
> -genfile bin.lg bin.jmb
> -
> -chmod 666 bin.*
> diff --git a/testcases/network/tcp_cmds/Makefile b/testcases/network/tcp_cmds/Makefile
> index 2d0f076741..ba8b879efd 100644
> --- a/testcases/network/tcp_cmds/Makefile
> +++ b/testcases/network/tcp_cmds/Makefile
> @@ -7,13 +7,9 @@ top_srcdir		?= ../../..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> -ifneq ($(WITH_EXPECT),yes)
> -FILTER_OUT_SUBDIRS	:= ftp
> -endif
> +INSTALL_DEPS		:= ../datafiles/ascii.sm
>  
> -INSTALL_DEPS		:= ../datafiles/bin.sm
> -
> -../datafiles/bin.sm:
> +../datafiles/ascii.sm:
>  	$(MAKE) -C .. -f "$(abs_srcdir)/../Makefile" generate
>  
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/network/tcp_cmds/Makefile.inc b/testcases/network/tcp_cmds/Makefile.inc
> index 114141b2cd..0ca5ec0e39 100644
> --- a/testcases/network/tcp_cmds/Makefile.inc
> +++ b/testcases/network/tcp_cmds/Makefile.inc
> @@ -22,7 +22,7 @@
>  
>  GENERATE_FILE_DIR	:= ../..
>  
> -MAKE_DEPS		:= $(GENERATE_FILE_DIR)/datafiles/bin.sm
> +MAKE_DEPS		:= $(GENERATE_FILE_DIR)/datafiles/ascii.sm
>  
>  $(MAKE_DEPS):
>  	$(MAKE) -C $(GENERATE_FILE_DIR) \
> diff --git a/testcases/network/tcp_cmds/ftp/Makefile b/testcases/network/tcp_cmds/ftp/Makefile
> deleted file mode 100644
> index 35022f8b9a..0000000000
> --- a/testcases/network/tcp_cmds/ftp/Makefile
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#
> -#    network/tcp_cmds/ftp testcases Makefile.
> -#
> -#    Copyright (C) 2009, Cisco Systems Inc.
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -# Ngie Cooper, September 2009
> -#
> -
> -top_srcdir		?= ../../../..
> -
> -include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> -
> -INSTALL_TARGETS		:= ftp*
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
> deleted file mode 100755
> index 53d1eec53a..0000000000
> --- a/testcases/network/tcp_cmds/ftp/ftp01.sh
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2022 Akihiko Odaki <akihiko.odaki@daynix.com>
> -# Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
> -# Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
> -
> -TST_TESTFUNC=do_test
> -TST_CNT=4
> -TST_NEEDS_CMDS='awk ftp'
> -TST_NEEDS_TMPDIR=1
> -
> -RUSER="${RUSER:-root}"
> -RHOST="${RHOST:-localhost}"
> -
> -do_test()
> -{
> -    case $1 in
> -    1) test_get binary;;
> -    2) test_get ascii;;
> -    3) test_put binary;;
> -    4) test_put ascii;;
> -    esac
> -}
> -
> -list_files()
> -{
> -    case $1 in
> -    ascii) echo 'ascii.sm ascii.med ascii.lg ascii.jmb';;
> -    binary) echo 'bin.sm bin.med bin.lg bin.jmb';;
> -    esac
> -}
> -
> -test_get()
> -{
> -    local file sum1 sum2
> -
> -    for file in $(list_files $1); do
> -        {
> -            echo user $RUSER $PASSWD
> -            echo $1
> -            echo cd $TST_NET_DATAROOT
> -            echo get $file
> -            echo quit
> -        } | ftp -nv $RHOST
> -
> -        sum1="$(ls -l $file | awk '{print $5}')"
> -        sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
> -        rm -f $file
> -        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
> -    done
> -}
> -
> -test_put()
> -{
> -    local file sum1 sum2
> -
> -    for file in $(list_files $1); do
> -        {
> -            echo user $RUSER $PASSWD
> -            echo lcd $TST_NET_DATAROOT
> -            echo $1
> -            echo cd $TST_TMPDIR
> -            echo put $file
> -            echo quit
> -        } | ftp -nv $RHOST
> -
> -        sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
> -        sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
> -        tst_rhost_run -c "rm -f $TST_TMPDIR/$file"
> -        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
> -    done
> -}
> -
> -. tst_net.sh
> -tst_run
> -- 
> 2.45.2
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
