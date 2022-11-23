Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04359C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 12:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AB953CCA02
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 13:26:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47C633C84AC
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 13:25:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 171501A005E9
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 13:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669206348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxFZqOzciwUm8bB/1JhRzQ3XYeSu/zxvLBQJLhu5SMw=;
 b=NcC+0pbIiURnGssFKRBT0URMpRp3M0YpOQhA54zg5Z5aikVzdnKq4hh7fRgtEfCdfwIsNy
 sxwRVZTyBQUHf9IqFMSuc7XdWhHTPPcV3tS7e5lGlUz3XvWPTdwSVugHdalWQhUpblWfz0
 Y8KV3tDD6dPNkfg+fzkXsWyOO0no1GM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-lzLwnbCzNuGstvGoCb50Yg-1; Wed, 23 Nov 2022 07:25:46 -0500
X-MC-Unique: lzLwnbCzNuGstvGoCb50Yg-1
Received: by mail-wr1-f72.google.com with SMTP id
 o8-20020adfba08000000b00241e80f08e0so814409wrg.12
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 04:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxFZqOzciwUm8bB/1JhRzQ3XYeSu/zxvLBQJLhu5SMw=;
 b=V437jsm3IFY8i1yBgk+SwsndVzWveOwX4C61/OTAxg6slkuSJhPzghqvmF3IW+e3zO
 YP/eZwgwwYQ7DoaoD7A7W+R6iSeWwm5F225hWkzxvIElq2mkhENtdg/1ODOOMx379QYv
 JGkRWDwfCqXcvLvsG02fj/U6lQgNZEvlbSRiF0xwxbna0pF7Ybd4Fq709R4QOZFgTUAL
 O5H/99plS5ZTMsXSeLfrKfabPtKeFrqViOdD76qISCxgny4sVotUhoa/frBdqR+efPKp
 illPu7sL/2GAGRe34Daq6SP4E+3Jk3kQ3LxnDZOMmAcnZKqLPKxikdxSH2sNLfLWv8D4
 5W4g==
X-Gm-Message-State: ANoB5pmpzm4yOYl24ROAgtQu2unxgWigqzIEAvjOXEcNmp6HR6M2On5l
 hbF7IUY1nyPPNG6XqqETHEDOdBVgnveA5601bqbau9J2v3ZzR8n1a0yloLjhG4CRWs3GAxhkKMj
 GITEHRBE2DdJQ7m8lxC3UQ0ElzqQ=
X-Received: by 2002:a5d:6183:0:b0:241:d386:f6d4 with SMTP id
 j3-20020a5d6183000000b00241d386f6d4mr6630308wru.707.1669206344948; 
 Wed, 23 Nov 2022 04:25:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5s4e+nUJZPk0tUwgDrWZAhzdLRBRmf1UWGpQm/f6SfHfAbA0/9J5RTvo7jZlCPbGPHuGjgZx9wzMrQ78hWy8Q=
X-Received: by 2002:a5d:6183:0:b0:241:d386:f6d4 with SMTP id
 j3-20020a5d6183000000b00241d386f6d4mr6630281wru.707.1669206344444; Wed, 23
 Nov 2022 04:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20221123115546.786-1-pvorel@suse.cz>
In-Reply-To: <20221123115546.786-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Nov 2022 20:25:33 +0800
Message-ID: <CAEemH2f=TTMPYHR8u3Bub4C7zWijf=9Fi1bkjFO1rYgFDdQZsg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Zirong Lang <zlang@redhat.com>,
 Murphy Zhou <xzhou@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove fs-bench
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0153108271=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0153108271==
Content-Type: multipart/alternative; boundary="00000000000037cc9d05ee2263f1"

--00000000000037cc9d05ee2263f1
Content-Type: text/plain; charset="UTF-8"

I rarely touch the FS bench test, cc'ing my fs-colleagues
in case they have some opinions on this.

On Wed, Nov 23, 2022 at 7:55 PM Petr Vorel <pvorel@suse.cz> wrote:

> fs-bench is horribly broken and there does not seem to be a lot of value
> in keeping it.
>
> Closes: https://github.com/linux-test-project/ltp/issues/994
>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/fs/fs-bench/.gitignore       |   3 -
>  testcases/kernel/fs/fs-bench/Makefile         |  41 ------
>  testcases/kernel/fs/fs-bench/README           |  45 ------
>  testcases/kernel/fs/fs-bench/boxmuler.c       |  28 ----
>  testcases/kernel/fs/fs-bench/create-files.c   | 119 ---------------
>  testcases/kernel/fs/fs-bench/fs-bench-test.sh |  50 -------
>  .../kernel/fs/fs-bench/fs-bench-test2.sh      |  63 --------
>  testcases/kernel/fs/fs-bench/modaltr.sh       | 124 ----------------
>  .../fs/fs-bench/random-access-del-create.c    | 136 ------------------
>  testcases/kernel/fs/fs-bench/random-access.c  |  92 ------------
>  .../kernel/fs/fs-bench/random-del-create.c    | 134 -----------------
>  11 files changed, 835 deletions(-)
>  delete mode 100644 testcases/kernel/fs/fs-bench/.gitignore
>  delete mode 100644 testcases/kernel/fs/fs-bench/Makefile
>  delete mode 100644 testcases/kernel/fs/fs-bench/README
>  delete mode 100644 testcases/kernel/fs/fs-bench/boxmuler.c
>  delete mode 100644 testcases/kernel/fs/fs-bench/create-files.c
>  delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh
>  delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>  delete mode 100755 testcases/kernel/fs/fs-bench/modaltr.sh
>  delete mode 100644 testcases/kernel/fs/fs-bench/random-access-del-create.c
>  delete mode 100644 testcases/kernel/fs/fs-bench/random-access.c
>  delete mode 100644 testcases/kernel/fs/fs-bench/random-del-create.c
>
> diff --git a/testcases/kernel/fs/fs-bench/.gitignore
> b/testcases/kernel/fs/fs-bench/.gitignore
> deleted file mode 100644
> index 5824a4002..000000000
> --- a/testcases/kernel/fs/fs-bench/.gitignore
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/create-files
> -/random-access
> -/random-access-del-create
> diff --git a/testcases/kernel/fs/fs-bench/Makefile
> b/testcases/kernel/fs/fs-bench/Makefile
> deleted file mode 100644
> index bc570f7eb..000000000
> --- a/testcases/kernel/fs/fs-bench/Makefile
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#
> -#    kernel/fs/fs-bench testcases Makefile.
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
> -#    You should have received a copy of the GNU General Public License
> along
> -#    with this program; if not, write to the Free Software Foundation,
> Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -# Ngie Cooper, July 2009
> -#
> -
> -top_srcdir                     ?= ../../../..
> -
> -include $(top_srcdir)/include/mk/env_pre.mk
> -
> -INSTALL_TARGETS                        := modaltr.sh fs-bench-test.sh
> fs-bench-test2.sh
> -
> -LDLIBS                         += -lm
> -
> -create-files: boxmuler.o create-files.o
> -
> -random-access-del-create: boxmuler.o random-access-del-create.o
> -
> -MAKE_TARGETS                   := create-files random-access\
> -                                  random-access-del-create
> -
> -dist: clean
> -       (cd $(abs_srcdir); tar zcvf fs-bench.tar.gz $(abs_srcdir))
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/fs-bench/README
> b/testcases/kernel/fs/fs-bench/README
> deleted file mode 100644
> index 20d49a951..000000000
> --- a/testcases/kernel/fs/fs-bench/README
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -Programs for File system stress test.
> -
> -All of programs are distributed under GPL 2 license
> -by Hironobu SUZUKI <hironobu@h2np.net>
> -
> -HOW TO TEST
> -------------
> -
> -1: Type "make"
> -
> -       # cd
> -       # tar zxvf fs-bench.tar.gz
> -       # cd fs-bench
> -       # make
> -
> -2: Change directory to terget file system and do-it!
> -       (I always use one-HDD/one-partition for fs stress test.)
> -
> -       # mount -t jfs /dev/hdc1 /jfs
> -       # cd /jfs
> -       # ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/jfs-test
> -
> -
> -NOTE
> ------
> -
> -The size of files that are created for stress test is not fixed.  The
> -file size are determined by probabilistic algorithm, box-muler
> -algorithm.
> -
> -number
> -of files
> -  ^
> -  |       ****
> -  |      *    *
> -  |     *      *
> -  |    *        *
> -  |  **          **
> -  |**              **
> -  +-------------------> file size
> -  min               max
> -
> -
> -------
> -$Id: README,v 1.1 2004/11/18 20:23:05 robbiew Exp $
> diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c
> b/testcases/kernel/fs/fs-bench/boxmuler.c
> deleted file mode 100644
> index e923a1617..000000000
> --- a/testcases/kernel/fs/fs-bench/boxmuler.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -#include <math.h>
> -#include <stdlib.h>
> -
> -#define M_2PI (M_PI*2)
> -
> -int box_muler(int min, int max)
> -{
> -       double u1, u2, z;
> -       int i;
> -       int ave;
> -       int range;
> -       int ZZ;
> -       if (min >= max) {
> -               return (-1);
> -       }
> -       range = max - min;
> -       ave = range / 2;
> -       for (i = 0; i < 10; i++) {
> -               u1 = ((double)(random() % 1000000)) / 1000000;
> -               u2 = ((double)(random() % 1000000)) / 1000000;
> -               z = sqrt(-2.0 * log(u1)) * cos(M_2PI * u2);
> -               ZZ = min + (ave + (z * (ave / 4)));
> -               if (ZZ >= min && ZZ < max) {
> -                       return (ZZ);
> -               }
> -       }
> -       return (-1);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/create-files.c
> b/testcases/kernel/fs/fs-bench/create-files.c
> deleted file mode 100644
> index c6cba6f69..000000000
> --- a/testcases/kernel/fs/fs-bench/create-files.c
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -/* create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -
> -#define MAXN 4096
> -
> -#define MAXFSIZE 1024 * 192
> -
> -char wbuf[MAXFSIZE];
> -static int filecount = 0;
> -
> -void makedir(char *dir1);
> -void changedir(char *dir);
> -void create_file(char *filename);
> -
> -extern int box_muler(int, int);
> -
> -int startc = 0;
> -int main(int ac, char *av[])
> -{
> -       int i = 0;
> -       int j = 0;
> -       int k = 0;
> -       int l = 0;
> -       char dir1[MAXN];
> -       char dir2[MAXN];
> -       char dir3[MAXN];
> -       char filename[MAXN];
> -       time_t t;
> -       int maxfiles = 0xFFFFFF;
> -       int createfiles = 0;
> -
> -       if (ac > 1) {
> -               sscanf(av[1], "%x", &maxfiles);
> -               if (maxfiles == 0) {
> -                       printf("maxfile argument error (0 value)\n");
> -                       exit(1);
> -               }
> -       }
> -       time(&t);
> -       srandom((unsigned int)getpid() ^
> -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
> -       printf("Create files\n");
> -       for (i = 0; i < 0xFF; i++) {
> -               sprintf(dir1, "%2.2x", i);
> -               makedir(dir1);
> -               changedir(dir1);
> -               for (j = 0; j < 0xFF; j++) {
> -                       sprintf(dir2, "%2.2x", j);
> -                       makedir(dir2);
> -                       changedir(dir2);
> -                       for (k = 0; k < 0xFF; k++) {
> -                               sprintf(dir3, "%2.2x", k);
> -                               makedir(dir3);
> -                               changedir(dir3);
> -                               for (l = 0; l < 0xFF; l++) {
> -                                       sprintf(filename, "%s%s%s%2.2x",
> dir1,
> -                                               dir2, dir3, l);
> -                                       create_file(filename);
> -                                       if (maxfiles < createfiles++) {
> -                                               goto end;
> -                                       }
> -                               }
> -                               changedir("../");
> -                       }
> -                       changedir("../");
> -               }
> -               changedir("../");
> -       }
> -end:
> -       fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -       printf("Done\n");
> -       return 0;
> -}
> -
> -int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
> -
> -void makedir(char *dir1)
> -{
> -       if (mkdir(dir1, S_IRWXU) < 0) {
> -               perror(dir1);
> -               exit(1);
> -       }
> -}
> -
> -void changedir(char *dir)
> -{
> -       if (chdir(dir) < 0) {
> -               perror(dir);
> -               exit(1);
> -       }
> -}
> -
> -void create_file(char *filename)
> -{
> -       int fd;
> -       int randomsize;
> -       if ((fd = creat(filename, S_IRWXU)) < 0) {
> -               fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -               perror(filename);
> -               exit(1);
> -       }
> -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -               randomsize = MAXFSIZE;
> -       }
> -       if (write(fd, wbuf, randomsize) < 0) {
> -               fprintf(stderr, "\nTotal create files: %d\n", filecount);
> -               perror(filename);
> -               exit(1);
> -       }
> -       filecount++;
> -       close(fd);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
> b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
> deleted file mode 100755
> index c2ca767f0..000000000
> --- a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#! /bin/bash
> -
> -echo "## Start Test"
> -date
> -if [ -d ./00 ] ; then
> -    echo -n "Clear old files..."
> -    /bin/rm -fr ./00 >& /dev/null
> -    echo "done"
> -fi
> -STARTT=`date +%s`
> -echo $STARTT
> -echo ""
> -echo "## Create files "
> -time ~/fs-bench/cr
> -
> -echo ""
> -echo "## tar all "
> -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'|
> awk -F'/' '{print $4;}'`
> -
> -echo ""
> -echo "## Change owner"
> -time chown -R $USER  ./00
> -
> -echo ""
> -echo "## random access"
> -time ~/fs-bench/ra  $MAXFILE
> -
> -echo ""
> -echo "## Change mode "
> -time chmod -R go+rw  ./00
> -
> -echo ""
> -echo "## Random delete and create"
> -time ~/fs-bench/radc  $MAXFILE
> -
> -echo ""
> -echo "## Change mode again"
> -time chmod -R go-rw  ./00
> -
> -echo ""
> -echo "## Remove all files and directories"
> -time /bin/rm -fr ./00
> -echo ""
> -echo "## Finish test"
> -ENDT=`date +%s`
> -echo $ENDT
> -date
> -
> -echo -n 'TOTAL(seconds): '
> -expr $ENDT - $STARTT
> diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
> b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
> deleted file mode 100755
> index 25c67afe0..000000000
> --- a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -#! /bin/bash
> -
> -echo "## Start Test"
> -date
> -date +%s
> -if [ -d ./00 ] ; then
> -/bin/rm -fr ./00 >& /dev/null
> -fi
> -STARTT=`date +%s`
> -echo $STARTT
> -
> -echo ""
> -echo "## Create files "
> -time ~/fs-bench/cr
> -
> -echo ""
> -echo "## tar all "
> -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'|
> awk -F'/' '{print $4;}'`
> -HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
> -
> -echo ""
> -echo "## Remove all files and directories"
> -/bin/rm -fr ./00 >& /dev/null
> -
> -echo ""
> -echo "## Create half files"
> -echo create half files
> -time ~/fs-bench/cr  $HALFFILE
> -
> -echo ""
> -echo "## Change owner"
> -time chown -R $USER  ./00
> -
> -echo ""
> -echo "## random access"
> -time ~/fs-bench/ra  $HALFFILE
> -
> -
> -echo ""
> -echo "## Change mode "
> -time chmod -R go+rw  ./00
> -
> -echo ""
> -echo "## Random delete and create"
> -time ~/fs-bench/radc  $HALFFILE
> -
> -echo ""
> -echo "## Change mode again"
> -time chmod -R go-rw  ./00
> -
> -echo ""
> -echo "## Remove all files and directories"
> -time /bin/rm -fr ./00
> -
> -echo ""
> -echo "## Finish test"
> -date
> -ENDT=`date +%s`
> -echo $ENDT
> -echo -n 'TOTAL(seconds): '
> -expr $ENDT - $STARTT
> -
> -
> diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh
> b/testcases/kernel/fs/fs-bench/modaltr.sh
> deleted file mode 100755
> index e44c17f13..000000000
> --- a/testcases/kernel/fs/fs-bench/modaltr.sh
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -#!/bin/sh
> -#To run this script the following is necessary
> -# 1.kernel should mtd support as module.
> -# 2.kernel should hsve jffs2 support as module.
> -# 3.kernel should have loopback device support .
> -# 4.you should have fs-bench utility (
> http://h2np.net/tools/fs-bench-0.2.tar.gz)
> -# 5.results will be copied to /tmp/log and /tmp/log1 files
> -
> -#DESCRIPTION: This testscript creates a jffs2 file system type and tests
> the filesystem test
> -#and places the log in the log directory.The file system test actually
> creates a tree of large
> -#directories and performs the delete and random delete operations as per
> the filesystem stress
> -#algorithim and gives a report of real time ,user time,system time taken
> to perform the file
> -#operations.
> -
> -#script created  G.BANU PRAKASH (mailto:prakash.banu@wipro.com).
> -#
> -#   This program is free software;  you can redistribute it and/or modify
> -#   it under the terms of the GNU General Public License as published by
> -#   the Free Software Foundation; either version 2 of the License, or
> -#   (at your option) any later version.
> -#
> -#   This program is distributed in the hope that it will be useful,
> -#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> -#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> -#   the GNU General Public License for more details.
> -#
> -#   You should have received a copy of the GNU General Public License
> -#   along with this program;  if not, write to the Free Software
> -#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> -#
> -
> -MTD_RAM=mtdram
> -MTD_BLOCK=mtdblock
> -JFFS2=jffs2
> -LOOP=loop
> -MTD_BLKDEVS=mtd_blkdevs
> -ZLIB_DEFLATE=zlib_deflate
> -ZLIB_INFLATE=zlib_inflate
> -MTD_CORE=mtdcore
> -MOUNT_DIR=/mnt
> -LOG_DIR=/tmp/log
> -LOG_DIR1=/tmp/log1
> -HOME_DIR=/home
> -BLOCK_DIR=/dev/mtdblock
> -export PATH=$PATH:/sbin
> -       if [ $(id -ru) -ne 0 ];
> -then
> -       echo "must be root to run this"
> -       exit
> -fi
> -
> -
> -
> -lsmod |grep $MTD_RAM
> -
> -       if [ $? -ne 0 ];
> -then
> -       echo "inserting mtd ram and its dependencies"
> -fi
> -modprobe $MTD_RAM  total_size=32768 erase_size=256
> -       if [ $? -ne 0 ];
> -then
> -       echo "check wheather MTD -mtdram is been compiled in the kernel"
> -fi
> -lsmod |grep $MTD_BLOCK
> -       if [ $? -ne 0 ]; then
> -       echo "inserting mtdblock  and its dependencies"
> -fi
> -modprobe $MTD_BLOCK
> -       if [ $? -ne 0 ]; then
> -       echo "check wheather mtdblock is been compiled in the kernel"
> -fi
> -
> -lsmod |grep $JFFS2
> -       if [ $? -ne 0 ]; then
> -       echo "inserting jffs2  and its dependencies"
> -fi
> -modprobe $JFFS2
> -       if [ $? -ne 0 ]; then
> -       echo "check wheather jffs2 is been compiled in the kernel"
> -fi
> -
> -lsmod |grep $LOOP
> -       if [ $? -ne 0 ]; then
> -       echo "inserting loopback device module"
> -fi
> -modprobe $LOOP
> -       if [ $? -ne 0 ]; then
> -       echo "check wheather loopback device option is been compiled in
> the kernel"
> -fi
> -mkdir -p $BLOCK_DIR
> -mknod $BLOCK_DIR/0 b 31 0 >/dev/null 2>&1
> -mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
> -mount|grep $JFFS2
> -       if [ $? -eq 0 ]; then
> - echo "jffs2 mounted sucessfully"
> -       else
> - echo "mount unsucessfull"
> -fi
> -cd $MOUNT_DIR
> -echo "This is will take long time "
> -./test.sh    >log 2>&1
> -./test2.sh    >log1 2>&1
> -
> -mv log   $LOG_DIR
> -mv log1  $LOG_DIR1
> -cd $HOME_DIR
> -
> -
> -#cleanup
> -echo "unmounting $MOUNT_DIR "
> -umount $MOUNT_DIR
> -echo "removing the modules inserted"
> -rmmod  $MTD_BLOCK
> -rmmod  $MTD_BLKDEVS
> -rmmod  $LOOP
> -rmmod  $JFFS2
> -rmmod  $ZLIB_DEFLATE
> -rmmod  $ZLIB_INFLATE
> -rmmod  $MTD_RAM
> -rmmod  $MTD_CORE
> -rm -rf /dev/mtdblock
> -echo "TEST COMPLETE"
> -echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1  "
> diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c
> b/testcases/kernel/fs/fs-bench/random-access-del-create.c
> deleted file mode 100644
> index 1878fd78b..000000000
> --- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -/* random-del-create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -#define MAXNUM 0x100000
> -
> -#define  MAXERROR 1024
> -
> -extern int box_muler(int, int);
> -extern void create_or_delete(char *);
> -
> -int delete_file(char *filename);
> -int create_file(char *filename);
> -
> -int cfilecount = 0;
> -int dfilecount = 0;
> -int errorcount = 0;
> -
> -int main(int ac, char **av)
> -{
> -       int r;
> -       char fname[1024];
> -       time_t t;
> -       int i;
> -       int m;
> -
> -       if (ac != 2) {
> -               printf("%s hex-style-filename \n", av[0]);
> -               printf("ex) %s 00022300\n", av[0]);
> -               exit(1);
> -       }
> -       sscanf(av[1], "%x", &m);
> -       if (m < 1 || m > MAXNUM) {
> -               printf("out of size %d\n", m);
> -               exit(1);
> -       }
> -
> -       time(&t);
> -       srandom((unsigned int)getpid() ^
> -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -       /* 00/00/00/00 */
> -       for (i = 0; i < m; i++) {
> -               r = random() % m;
> -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -                       ((r >> 16) & 0xFF),
> -                       ((r >> 8) & 0xFF),
> -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -               create_or_delete(fname);
> -       }
> -       fprintf(stderr, "Total create files: %d\n", cfilecount);
> -       fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -       fprintf(stderr, "Total error       : %d\n", errorcount);
> -       exit(0);
> -}
> -
> -#define MAXFSIZE (192*1024)
> -#define AVEFSIZE (MAXFSIZE/2)
> -#define POOLDISKSPACE (AVEFSIZE*128)
> -
> -static int disk_space_pool = 0;
> -void create_or_delete(char *fname)
> -{
> -       int r;
> -
> -       r = (random() & 1);
> -       if (r && disk_space_pool > POOLDISKSPACE) {
> -               /* create */
> -               create_file(fname);
> -       } else {
> -               delete_file(fname);
> -       }
> -       if ((errorcount > dfilecount || errorcount > cfilecount)
> -           && (errorcount > MAXERROR)) {
> -               fprintf(stderr, "too much error -- stop\n");
> -               fprintf(stderr, "Total create files: %d\n", cfilecount);
> -               fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -               fprintf(stderr, "Total error       : %d\n", errorcount);
> -               exit(1);
> -       }
> -}
> -
> -int create_file(char *filename)
> -{
> -       int fd;
> -       int randomsize;
> -       char wbuf[MAXFSIZE];
> -       if ((fd = creat(filename, S_IRWXU)) < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -               randomsize = MAXFSIZE;
> -       }
> -       if (write(fd, wbuf, randomsize) < 0) {
> -               errorcount++;
> -               close(fd);
> -               return (-1);
> -       }
> -       cfilecount++;
> -       disk_space_pool -= randomsize;
> -       close(fd);
> -
> -       return 0;
> -}
> -
> -#include <sys/stat.h>
> -#include <unistd.h>
> -
> -int delete_file(char *filename)
> -{
> -       struct stat buf;
> -       int st;
> -       st = stat(filename, &buf);
> -       if (st < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       disk_space_pool += buf.st_size;
> -       if (unlink(filename) < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       dfilecount++;
> -
> -       return 0;
> -}
> diff --git a/testcases/kernel/fs/fs-bench/random-access.c
> b/testcases/kernel/fs/fs-bench/random-access.c
> deleted file mode 100644
> index c2f32b86e..000000000
> --- a/testcases/kernel/fs/fs-bench/random-access.c
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -/* random-access.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -#include <stdio.h>
> -#include <errno.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -static int openlog[2] = { 0, 0 };
> -
> -#define MAXNUM 0x100000
> -
> -void open_read_close(char *fname);
> -
> -int nullfd;
> -
> -int main(int ac, char **av)
> -{
> -       int r;
> -       char fname[1024];
> -       time_t t;
> -       int i;
> -       int m;
> -
> -       if (ac != 2) {
> -               printf("%s hex-style-filename \n", av[0]);
> -               printf("ex) %s 00022300\n", av[0]);
> -               exit(1);
> -       }
> -       sscanf(av[1], "%x", &m);
> -       if (m < 1 || m > MAXNUM) {
> -               printf("out of size %d\n", m);
> -               exit(1);
> -       }
> -
> -       time(&t);
> -       srandom((unsigned int)getpid() ^
> -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -       if ((nullfd = open("/dev/null", O_WRONLY)) < 0) {
> -               perror("/dev/null");
> -               exit(1);
> -       }
> -
> -       /* 00/00/00/00 */
> -       for (i = 0; i < m; i++) {
> -               r = random() % m;
> -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -                       ((r >> 16) & 0xFF),
> -                       ((r >> 8) & 0xFF),
> -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -               open_read_close(fname);
> -       }
> -       close(nullfd);
> -       printf("Success:\t%d\nFail:\t%d\n", openlog[SUCCESS],
> openlog[FAIL]);
> -       exit(0);
> -}
> -
> -#define BUFS 8192
> -void open_read_close(char *fname)
> -{
> -       int fd;
> -       char buf[BUFS];
> -       int c;
> -
> -       if ((fd = open(fname, O_RDONLY)) < 0) {
> -               openlog[FAIL]++;
> -               close(fd);
> -               return;
> -       }
> -       openlog[SUCCESS]++;
> -       while ((c = read(fd, buf, BUFS)) > 0) {
> -               if (write(nullfd, buf, c) < 0) {
> -                       perror("/dev/null");
> -                       printf("Opened\t %d\nUnopend:\t%d\n",
> openlog[SUCCESS],
> -                              openlog[FAIL]);
> -                       exit(1);
> -               }
> -       }
> -       if (c < 0) {
> -               perror(fname);
> -               printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
> -                      openlog[FAIL]);
> -               exit(1);
> -       }
> -       close(fd);
> -}
> diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c
> b/testcases/kernel/fs/fs-bench/random-del-create.c
> deleted file mode 100644
> index 345031f28..000000000
> --- a/testcases/kernel/fs/fs-bench/random-del-create.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -/* random-del-create.c (GPL)*/
> -/* Hironobu SUZUKI <hironobu@h2np.net> */
> -
> -#include <stdio.h>
> -#include <sys/stat.h>
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#define FAIL 0
> -#define SUCCESS 1
> -
> -static int openlog[2] = { 0, 0 };
> -
> -#define MAXNUM 0x100000
> -
> -#define  MAXERROR 1024
> -
> -extern int box_muler(int, int);
> -extern void create_or_delete(char *);
> -
> -int cfilecount = 0;
> -int dfilecount = 0;
> -int errorcount = 0;
> -
> -int main(int ac, char **av)
> -{
> -       int r;
> -       char fname[1024];
> -       time_t t;
> -       int i;
> -       int m;
> -
> -       if (ac != 2) {
> -               printf("%s hex-style-filename \n", av[0]);
> -               printf("ex) %s 00022300\n", av[0]);
> -               exit(1);
> -       }
> -       sscanf(av[1], "%x", &m);
> -       if (m < 1 || m > MAXNUM) {
> -               printf("out of size %d\n", m);
> -               exit(1);
> -       }
> -
> -       time(&t);
> -       srandom((unsigned int)getpid() ^
> -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
> -
> -       /* 00/00/00/00 */
> -       for (i = 0; i < m; i++) {
> -               r = random() % m;
> -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
> -                       ((r >> 16) & 0xFF),
> -                       ((r >> 8) & 0xFF),
> -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
> -               create_or_delete(fname);
> -       }
> -       fprintf(stderr, "Total create files: %d\n", cfilecount);
> -       fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -       fprintf(stderr, "Total error       : %d\n", errorcount);
> -       exit(0);
> -}
> -
> -#define MAXFSIZE (192*1024)
> -#define AVEFSIZE (MAXFSIZE/2)
> -#define POOLDISKSPACE (AVEFSIZE*128)
> -
> -static int disk_space_pool = 0;
> -void create_or_delete(char *fname)
> -{
> -       int r;
> -       int fsize;
> -
> -       r = (random() & 1);
> -       if (r && disk_space_pool > POOLDISKSPACE) {
> -               /* create */
> -               create_file(fname);
> -       } else {
> -               delete_file(fname);
> -       }
> -       if ((errorcount > dfilecount || errorcount > cfilecount)
> -           && (errorcount > MAXERROR)) {
> -               fprintf(stderr, "too much error -- stop\n");
> -               fprintf(stderr, "Total create files: %d\n", cfilecount);
> -               fprintf(stderr, "Total delete files: %d\n", dfilecount);
> -               fprintf(stderr, "Total error       : %d\n", errorcount);
> -               exit(1);
> -       }
> -}
> -
> -int create_file(char *filename)
> -{
> -       int fd;
> -       int randomsize;
> -       char wbuf[MAXFSIZE];
> -       if ((fd = creat(filename, S_IRWXU)) < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
> -               randomsize = MAXFSIZE;
> -       }
> -       if (write(fd, wbuf, randomsize) < 0) {
> -               errorcount++;
> -               close(fd);
> -               return (-1);
> -       }
> -       cfilecount++;
> -       disk_space_pool -= randomsize;
> -       close(fd);
> -       return 0;
> -}
> -
> -#include <sys/stat.h>
> -#include <unistd.h>
> -
> -int delete_file(char *filename)
> -{
> -       struct stat buf;
> -       int st;
> -       st = stat(filename, &buf);
> -       if (st < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       disk_space_pool += buf.st_size;
> -       if (unlink(filename) < 0) {
> -               errorcount++;
> -               return (-1);
> -       }
> -       dfilecount++;
> -       return 0;
> -}
> --
> 2.38.1
>
>

-- 
Regards,
Li Wang

--00000000000037cc9d05ee2263f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">I rarely touch the FS bench test, cc&#39;ing my fs-colleagues=
</div><div class=3D"gmail_default" style=3D"font-size:small">in case they h=
ave some opinions on this.</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 23, 2022 at 7:55 PM Petr Vorel =
&lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">fs-be=
nch is horribly broken and there does not seem to be a lot of value<br>
in keeping it.<br>
<br>
Closes: <a href=3D"https://github.com/linux-test-project/ltp/issues/994" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/linux-test-project/lt=
p/issues/994</a><br>
<br>
Suggested-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt;<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/fs/fs-bench/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 -<br>
=C2=A0testcases/kernel/fs/fs-bench/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 41 ------<br>
=C2=A0testcases/kernel/fs/fs-bench/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 45 ------<br>
=C2=A0testcases/kernel/fs/fs-bench/boxmuler.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 28 ----<br>
=C2=A0testcases/kernel/fs/fs-bench/create-files.c=C2=A0 =C2=A0| 119 -------=
--------<br>
=C2=A0testcases/kernel/fs/fs-bench/fs-bench-test.sh |=C2=A0 50 -------<br>
=C2=A0.../kernel/fs/fs-bench/fs-bench-test2.sh=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
63 --------<br>
=C2=A0testcases/kernel/fs/fs-bench/modaltr.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
24 ----------------<br>
=C2=A0.../fs/fs-bench/random-access-del-create.c=C2=A0 =C2=A0 | 136 -------=
-----------<br>
=C2=A0testcases/kernel/fs/fs-bench/random-access.c=C2=A0 |=C2=A0 92 -------=
-----<br>
=C2=A0.../kernel/fs/fs-bench/random-del-create.c=C2=A0 =C2=A0 | 134 -------=
----------<br>
=C2=A011 files changed, 835 deletions(-)<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/.gitignore<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/Makefile<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/README<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/boxmuler.c<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/create-files.c<br>
=C2=A0delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh<br>
=C2=A0delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh<br>
=C2=A0delete mode 100755 testcases/kernel/fs/fs-bench/modaltr.sh<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/random-access-del-cre=
ate.c<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/random-access.c<br>
=C2=A0delete mode 100644 testcases/kernel/fs/fs-bench/random-del-create.c<b=
r>
<br>
diff --git a/testcases/kernel/fs/fs-bench/.gitignore b/testcases/kernel/fs/=
fs-bench/.gitignore<br>
deleted file mode 100644<br>
index 5824a4002..000000000<br>
--- a/testcases/kernel/fs/fs-bench/.gitignore<br>
+++ /dev/null<br>
@@ -1,3 +0,0 @@<br>
-/create-files<br>
-/random-access<br>
-/random-access-del-create<br>
diff --git a/testcases/kernel/fs/fs-bench/Makefile b/testcases/kernel/fs/fs=
-bench/Makefile<br>
deleted file mode 100644<br>
index bc570f7eb..000000000<br>
--- a/testcases/kernel/fs/fs-bench/Makefile<br>
+++ /dev/null<br>
@@ -1,41 +0,0 @@<br>
-#<br>
-#=C2=A0 =C2=A0 kernel/fs/fs-bench testcases Makefile.<br>
-#<br>
-#=C2=A0 =C2=A0 Copyright (C) 2009, Cisco Systems Inc.<br>
-#<br>
-#=C2=A0 =C2=A0 This program is free software; you can redistribute it and/=
or modify<br>
-#=C2=A0 =C2=A0 it under the terms of the GNU General Public License as pub=
lished by<br>
-#=C2=A0 =C2=A0 the Free Software Foundation; either version 2 of the Licen=
se, or<br>
-#=C2=A0 =C2=A0 (at your option) any later version.<br>
-#<br>
-#=C2=A0 =C2=A0 This program is distributed in the hope that it will be use=
ful,<br>
-#=C2=A0 =C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty=
 of<br>
-#=C2=A0 =C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 =
See the<br>
-#=C2=A0 =C2=A0 GNU General Public License for more details.<br>
-#<br>
-#=C2=A0 =C2=A0 You should have received a copy of the GNU General Public L=
icense along<br>
-#=C2=A0 =C2=A0 with this program; if not, write to the Free Software Found=
ation, Inc.,<br>
-#=C2=A0 =C2=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
<br>
-#<br>
-# Ngie Cooper, July 2009<br>
-#<br>
-<br>
-top_srcdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0?=3D ../../../..<br>
-<br>
-include $(top_srcdir)/include/mk/<a href=3D"http://env_pre.mk" rel=3D"nore=
ferrer" target=3D"_blank">env_pre.mk</a><br>
-<br>
-INSTALL_TARGETS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 :=3D modaltr.sh fs-bench-test.sh fs-bench-test2.sh=
<br>
-<br>
-LDLIBS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0+=3D -lm<br>
-<br>
-create-files: boxmuler.o create-files.o<br>
-<br>
-random-access-del-create: boxmuler.o random-access-del-create.o<br>
-<br>
-MAKE_TARGETS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0:=3D create-files random-access\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 random-access-del-create<br>
-<br>
-dist: clean<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0(cd $(abs_srcdir); tar zcvf fs-bench.tar.gz $(a=
bs_srcdir))<br>
-<br>
-include $(top_srcdir)/include/mk/<a href=3D"http://generic_leaf_target.mk"=
 rel=3D"noreferrer" target=3D"_blank">generic_leaf_target.mk</a><br>
diff --git a/testcases/kernel/fs/fs-bench/README b/testcases/kernel/fs/fs-b=
ench/README<br>
deleted file mode 100644<br>
index 20d49a951..000000000<br>
--- a/testcases/kernel/fs/fs-bench/README<br>
+++ /dev/null<br>
@@ -1,45 +0,0 @@<br>
-Programs for File system stress test.<br>
-<br>
-All of programs are distributed under GPL 2 license<br>
-by Hironobu SUZUKI &lt;<a href=3D"mailto:hironobu@h2np.net" target=3D"_bla=
nk">hironobu@h2np.net</a>&gt;<br>
-<br>
-HOW TO TEST<br>
-------------<br>
-<br>
-1: Type &quot;make&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# cd<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# tar zxvf fs-bench.tar.gz<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# cd fs-bench<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# make<br>
-<br>
-2: Change directory to terget file system and do-it!<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0(I always use one-HDD/one-partition for fs stre=
ss test.)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# mount -t jfs /dev/hdc1 /jfs<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# cd /jfs<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# ~/fs-bench/test.sh 2&gt;&amp;1 | tee ~/fs-ben=
ch/jfs-test<br>
-<br>
-<br>
-NOTE<br>
------<br>
-<br>
-The size of files that are created for stress test is not fixed.=C2=A0 The=
<br>
-file size are determined by probabilistic algorithm, box-muler<br>
-algorithm.<br>
-<br>
-number<br>
-of files<br>
-=C2=A0 ^<br>
-=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0****<br>
-=C2=A0 |=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 *<br>
-=C2=A0 |=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 |=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 |=C2=A0 **=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **<br>
-=C2=A0 |**=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **<br>
-=C2=A0 +-------------------&gt; file size<br>
-=C2=A0 min=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max<br>
-<br>
-<br>
-------<br>
-$Id: README,v 1.1 2004/11/18 20:23:05 robbiew Exp $<br>
diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c b/testcases/kernel/fs/=
fs-bench/boxmuler.c<br>
deleted file mode 100644<br>
index e923a1617..000000000<br>
--- a/testcases/kernel/fs/fs-bench/boxmuler.c<br>
+++ /dev/null<br>
@@ -1,28 +0,0 @@<br>
-#include &lt;math.h&gt;<br>
-#include &lt;stdlib.h&gt;<br>
-<br>
-#define M_2PI (M_PI*2)<br>
-<br>
-int box_muler(int min, int max)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0double u1, u2, z;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ave;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int range;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ZZ;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (min &gt;=3D max) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0range =3D max - min;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ave =3D range / 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 10; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u1 =3D ((double)(ra=
ndom() % 1000000)) / 1000000;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u2 =3D ((double)(ra=
ndom() % 1000000)) / 1000000;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0z =3D sqrt(-2.0 * l=
og(u1)) * cos(M_2PI * u2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ZZ =3D min + (ave +=
 (z * (ave / 4)));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ZZ &gt;=3D min =
&amp;&amp; ZZ &lt; max) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return (ZZ);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-}<br>
diff --git a/testcases/kernel/fs/fs-bench/create-files.c b/testcases/kernel=
/fs/fs-bench/create-files.c<br>
deleted file mode 100644<br>
index c6cba6f69..000000000<br>
--- a/testcases/kernel/fs/fs-bench/create-files.c<br>
+++ /dev/null<br>
@@ -1,119 +0,0 @@<br>
-/* create.c (GPL)*/<br>
-/* Hironobu SUZUKI &lt;<a href=3D"mailto:hironobu@h2np.net" target=3D"_bla=
nk">hironobu@h2np.net</a>&gt; */<br>
-#include &lt;stdio.h&gt;<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-#include &lt;time.h&gt;<br>
-#include &lt;stdlib.h&gt;<br>
-<br>
-#define MAXN 4096<br>
-<br>
-#define MAXFSIZE 1024 * 192<br>
-<br>
-char wbuf[MAXFSIZE];<br>
-static int filecount =3D 0;<br>
-<br>
-void makedir(char *dir1);<br>
-void changedir(char *dir);<br>
-void create_file(char *filename);<br>
-<br>
-extern int box_muler(int, int);<br>
-<br>
-int startc =3D 0;<br>
-int main(int ac, char *av[])<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int j =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int k =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int l =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char dir1[MAXN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char dir2[MAXN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char dir3[MAXN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char filename[MAXN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time_t t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int maxfiles =3D 0xFFFFFF;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int createfiles =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ac &gt; 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sscanf(av[1], &quot=
;%x&quot;, &amp;maxfiles);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (maxfiles =3D=3D=
 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;maxfile argument error (0 value)\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time(&amp;t);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0srandom((unsigned int)getpid() ^<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((unsigned int)t &=
lt;&lt; 16) | (unsigned int)t &gt;&gt; 16));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Create files\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 0xFF; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(dir1, &quot=
;%2.2x&quot;, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0makedir(dir1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changedir(dir1);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt=
; 0xFF; j++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sprintf(dir2, &quot;%2.2x&quot;, j);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0makedir(dir2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0changedir(dir2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (k =3D 0; k &lt; 0xFF; k++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(dir3, &quot;%2.2x&quot;, k);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0makedir(dir3);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changedir(dir3);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (l =3D 0; l &lt; 0xFF; l++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(f=
ilename, &quot;%s%s%s%2.2x&quot;, dir1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dir2, dir3, l);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_fi=
le(filename);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (maxfi=
les &lt; createfiles++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto end;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changedir(&quot;../&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0changedir(&quot;../&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changedir(&quot;../=
&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-end:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;\nTotal create files: %d\=
n&quot;, filecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Done\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-int showchar[] =3D { 124, 47, 45, 92, 124, 47, 45, 92 };<br>
-<br>
-void makedir(char *dir1)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mkdir(dir1, S_IRWXU) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(dir1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void changedir(char *dir)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (chdir(dir) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void create_file(char *filename)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int randomsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fd =3D creat(filename, S_IRWXU)) &lt; 0) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;\nTotal create files: %d\n&quot;, filecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(filename);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((randomsize =3D box_muler(0, MAXFSIZE)) &lt=
; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0randomsize =3D MAXF=
SIZE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (write(fd, wbuf, randomsize) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;\nTotal create files: %d\n&quot;, filecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(filename);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0filecount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-}<br>
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh b/testcases/kern=
el/fs/fs-bench/fs-bench-test.sh<br>
deleted file mode 100755<br>
index c2ca767f0..000000000<br>
--- a/testcases/kernel/fs/fs-bench/fs-bench-test.sh<br>
+++ /dev/null<br>
@@ -1,50 +0,0 @@<br>
-#! /bin/bash<br>
-<br>
-echo &quot;## Start Test&quot;<br>
-date<br>
-if [ -d ./00 ] ; then<br>
-=C2=A0 =C2=A0 echo -n &quot;Clear old files...&quot;<br>
-=C2=A0 =C2=A0 /bin/rm -fr ./00 &gt;&amp; /dev/null<br>
-=C2=A0 =C2=A0 echo &quot;done&quot;<br>
-fi<br>
-STARTT=3D`date +%s`<br>
-echo $STARTT<br>
-echo &quot;&quot;<br>
-echo &quot;## Create files &quot;<br>
-time ~/fs-bench/cr<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## tar all &quot;<br>
-MAXFILE=3D`tar cBf - 00 | tar tvBf - 2&gt;&amp;1 | tail -n 1 | awk &#39;{p=
rint $6;}&#39;| awk -F&#39;/&#39; &#39;{print $4;}&#39;`<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change owner&quot;<br>
-time chown -R $USER=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## random access&quot;<br>
-time ~/fs-bench/ra=C2=A0 $MAXFILE<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change mode &quot;<br>
-time chmod -R go+rw=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Random delete and create&quot;<br>
-time ~/fs-bench/radc=C2=A0 $MAXFILE<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change mode again&quot;<br>
-time chmod -R go-rw=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Remove all files and directories&quot;<br>
-time /bin/rm -fr ./00<br>
-echo &quot;&quot;<br>
-echo &quot;## Finish test&quot;<br>
-ENDT=3D`date +%s`<br>
-echo $ENDT<br>
-date<br>
-<br>
-echo -n &#39;TOTAL(seconds): &#39;<br>
-expr $ENDT - $STARTT<br>
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh b/testcases/ker=
nel/fs/fs-bench/fs-bench-test2.sh<br>
deleted file mode 100755<br>
index 25c67afe0..000000000<br>
--- a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh<br>
+++ /dev/null<br>
@@ -1,63 +0,0 @@<br>
-#! /bin/bash<br>
-<br>
-echo &quot;## Start Test&quot;<br>
-date<br>
-date +%s<br>
-if [ -d ./00 ] ; then<br>
-/bin/rm -fr ./00 &gt;&amp; /dev/null<br>
-fi<br>
-STARTT=3D`date +%s`<br>
-echo $STARTT<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Create files &quot;<br>
-time ~/fs-bench/cr<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## tar all &quot;<br>
-MAXFILE=3D`tar cBf - 00 | tar tvBf - 2&gt;&amp;1 | tail -n 1 | awk &#39;{p=
rint $6;}&#39;| awk -F&#39;/&#39; &#39;{print $4;}&#39;`<br>
-HALFFILE=3D`echo &quot;obase=3DF;ibase=3DF;$MAXFILE/2&quot; | bc`<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Remove all files and directories&quot;<br>
-/bin/rm -fr ./00 &gt;&amp; /dev/null<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Create half files&quot;<br>
-echo create half files<br>
-time ~/fs-bench/cr=C2=A0 $HALFFILE<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change owner&quot;<br>
-time chown -R $USER=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## random access&quot;<br>
-time ~/fs-bench/ra=C2=A0 $HALFFILE<br>
-<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change mode &quot;<br>
-time chmod -R go+rw=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Random delete and create&quot;<br>
-time ~/fs-bench/radc=C2=A0 $HALFFILE<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Change mode again&quot;<br>
-time chmod -R go-rw=C2=A0 ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Remove all files and directories&quot;<br>
-time /bin/rm -fr ./00<br>
-<br>
-echo &quot;&quot;<br>
-echo &quot;## Finish test&quot;<br>
-date<br>
-ENDT=3D`date +%s`<br>
-echo $ENDT<br>
-echo -n &#39;TOTAL(seconds): &#39;<br>
-expr $ENDT - $STARTT<br>
-<br>
-<br>
diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/=
fs-bench/modaltr.sh<br>
deleted file mode 100755<br>
index e44c17f13..000000000<br>
--- a/testcases/kernel/fs/fs-bench/modaltr.sh<br>
+++ /dev/null<br>
@@ -1,124 +0,0 @@<br>
-#!/bin/sh<br>
-#To run this script the following is necessary<br>
-# 1.kernel should mtd support as module.<br>
-# 2.kernel should hsve jffs2 support as module.<br>
-# 3.kernel should have loopback device support .<br>
-# 4.you should have fs-bench utility (<a href=3D"http://h2np.net/tools/fs-=
bench-0.2.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://h2np.net/tool=
s/fs-bench-0.2.tar.gz</a>)<br>
-# 5.results will be copied to /tmp/log and /tmp/log1 files<br>
-<br>
-#DESCRIPTION: This testscript creates a jffs2 file system type and tests t=
he filesystem test<br>
-#and places the log in the log directory.The file system test actually cre=
ates a tree of large<br>
-#directories and performs the delete and random delete operations as per t=
he filesystem stress<br>
-#algorithim and gives a report of real time ,user time,system time taken t=
o perform the file<br>
-#operations.<br>
-<br>
-#script created=C2=A0 G.BANU PRAKASH (mailto:<a href=3D"mailto:prakash.ban=
u@wipro.com" target=3D"_blank">prakash.banu@wipro.com</a>).<br>
-#<br>
-#=C2=A0 =C2=A0This program is free software;=C2=A0 you can redistribute it=
 and/or modify<br>
-#=C2=A0 =C2=A0it under the terms of the GNU General Public License as publ=
ished by<br>
-#=C2=A0 =C2=A0the Free Software Foundation; either version 2 of the Licens=
e, or<br>
-#=C2=A0 =C2=A0(at your option) any later version.<br>
-#<br>
-#=C2=A0 =C2=A0This program is distributed in the hope that it will be usef=
ul,<br>
-#=C2=A0 =C2=A0but WITHOUT ANY WARRANTY;=C2=A0 without even the implied war=
ranty of<br>
-#=C2=A0 =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee<br>
-#=C2=A0 =C2=A0the GNU General Public License for more details.<br>
-#<br>
-#=C2=A0 =C2=A0You should have received a copy of the GNU General Public Li=
cense<br>
-#=C2=A0 =C2=A0along with this program;=C2=A0 if not, write to the Free Sof=
tware<br>
-#=C2=A0 =C2=A0Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA<br>
-#<br>
-<br>
-MTD_RAM=3Dmtdram<br>
-MTD_BLOCK=3Dmtdblock<br>
-JFFS2=3Djffs2<br>
-LOOP=3Dloop<br>
-MTD_BLKDEVS=3Dmtd_blkdevs<br>
-ZLIB_DEFLATE=3Dzlib_deflate<br>
-ZLIB_INFLATE=3Dzlib_inflate<br>
-MTD_CORE=3Dmtdcore<br>
-MOUNT_DIR=3D/mnt<br>
-LOG_DIR=3D/tmp/log<br>
-LOG_DIR1=3D/tmp/log1<br>
-HOME_DIR=3D/home<br>
-BLOCK_DIR=3D/dev/mtdblock<br>
-export PATH=3D$PATH:/sbin<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $(id -ru) -ne 0 ];<br>
-then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;must be root to run this&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit<br>
-fi<br>
-<br>
-<br>
-<br>
-lsmod |grep $MTD_RAM<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ];<br>
-then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;inserting mtd ram and its dependenci=
es&quot;<br>
-fi<br>
-modprobe $MTD_RAM=C2=A0 total_size=3D32768 erase_size=3D256<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ];<br>
-then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;check wheather MTD -mtdram is been c=
ompiled in the kernel&quot;<br>
-fi<br>
-lsmod |grep $MTD_BLOCK<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;inserting mtdblock=C2=A0 and its dep=
endencies&quot;<br>
-fi<br>
-modprobe $MTD_BLOCK<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;check wheather mtdblock is been comp=
iled in the kernel&quot;<br>
-fi<br>
-<br>
-lsmod |grep $JFFS2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;inserting jffs2=C2=A0 and its depend=
encies&quot;<br>
-fi<br>
-modprobe $JFFS2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;check wheather jffs2 is been compile=
d in the kernel&quot;<br>
-fi<br>
-<br>
-lsmod |grep $LOOP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;inserting loopback device module&quo=
t;<br>
-fi<br>
-modprobe $LOOP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;check wheather loopback device optio=
n is been compiled in the kernel&quot;<br>
-fi<br>
-mkdir -p $BLOCK_DIR<br>
-mknod $BLOCK_DIR/0 b 31 0 &gt;/dev/null 2&gt;&amp;1<br>
-mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR<br>
-mount|grep $JFFS2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 0 ]; then<br>
- echo &quot;jffs2 mounted sucessfully&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
- echo &quot;mount unsucessfull&quot;<br>
-fi<br>
-cd $MOUNT_DIR<br>
-echo &quot;This is will take long time &quot;<br>
-./test.sh=C2=A0 =C2=A0 &gt;log 2&gt;&amp;1<br>
-./test2.sh=C2=A0 =C2=A0 &gt;log1 2&gt;&amp;1<br>
-<br>
-mv log=C2=A0 =C2=A0$LOG_DIR<br>
-mv log1=C2=A0 $LOG_DIR1<br>
-cd $HOME_DIR<br>
-<br>
-<br>
-#cleanup<br>
-echo &quot;unmounting $MOUNT_DIR &quot;<br>
-umount $MOUNT_DIR<br>
-echo &quot;removing the modules inserted&quot;<br>
-rmmod=C2=A0 $MTD_BLOCK<br>
-rmmod=C2=A0 $MTD_BLKDEVS<br>
-rmmod=C2=A0 $LOOP<br>
-rmmod=C2=A0 $JFFS2<br>
-rmmod=C2=A0 $ZLIB_DEFLATE<br>
-rmmod=C2=A0 $ZLIB_INFLATE<br>
-rmmod=C2=A0 $MTD_RAM<br>
-rmmod=C2=A0 $MTD_CORE<br>
-rm -rf /dev/mtdblock<br>
-echo &quot;TEST COMPLETE&quot;<br>
-echo &quot;RESULTS LOGGED IN FILE=C2=A0 /tmp/log and /tmp/log1=C2=A0 &quot=
;<br>
diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c b/test=
cases/kernel/fs/fs-bench/random-access-del-create.c<br>
deleted file mode 100644<br>
index 1878fd78b..000000000<br>
--- a/testcases/kernel/fs/fs-bench/random-access-del-create.c<br>
+++ /dev/null<br>
@@ -1,136 +0,0 @@<br>
-/* random-del-create.c (GPL)*/<br>
-/* Hironobu SUZUKI &lt;<a href=3D"mailto:hironobu@h2np.net" target=3D"_bla=
nk">hironobu@h2np.net</a>&gt; */<br>
-<br>
-#include &lt;stdio.h&gt;<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-#include &lt;time.h&gt;<br>
-#include &lt;stdlib.h&gt;<br>
-#define FAIL 0<br>
-#define SUCCESS 1<br>
-<br>
-#define MAXNUM 0x100000<br>
-<br>
-#define=C2=A0 MAXERROR 1024<br>
-<br>
-extern int box_muler(int, int);<br>
-extern void create_or_delete(char *);<br>
-<br>
-int delete_file(char *filename);<br>
-int create_file(char *filename);<br>
-<br>
-int cfilecount =3D 0;<br>
-int dfilecount =3D 0;<br>
-int errorcount =3D 0;<br>
-<br>
-int main(int ac, char **av)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char fname[1024];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time_t t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int m;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ac !=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s hex=
-style-filename \n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;ex) %s=
 00022300\n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sscanf(av[1], &quot;%x&quot;, &amp;m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (m &lt; 1 || m &gt; MAXNUM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;out of=
 size %d\n&quot;, m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time(&amp;t);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0srandom((unsigned int)getpid() ^<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((unsigned int)t &=
lt;&lt; 16) | (unsigned int)t &gt;&gt; 16));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 00/00/00/00 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; m; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D random() % m;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(fname, &quo=
t;00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 8) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF), ((r &gt;&gt; 8) &amp; 0xFF), (r &am=
p; 0xFF));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_or_delete(fn=
ame);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total create files: %d\n&=
quot;, cfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total delete files: %d\n&=
quot;, dfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total error=C2=A0 =C2=A0 =
=C2=A0 =C2=A0: %d\n&quot;, errorcount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
-}<br>
-<br>
-#define MAXFSIZE (192*1024)<br>
-#define AVEFSIZE (MAXFSIZE/2)<br>
-#define POOLDISKSPACE (AVEFSIZE*128)<br>
-<br>
-static int disk_space_pool =3D 0;<br>
-void create_or_delete(char *fname)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D (random() &amp; 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &amp;&amp; disk_space_pool &gt; POOLDISKS=
PACE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* create */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_file(fname);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete_file(fname);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((errorcount &gt; dfilecount || errorcount &=
gt; cfilecount)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; (errorcount &gt; MAXER=
ROR)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;too much error -- stop\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total create files: %d\n&quot;, cfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total delete files: %d\n&quot;, dfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total error=C2=A0 =C2=A0 =C2=A0 =C2=A0: %d\n&quot;, errorcount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-int create_file(char *filename)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int randomsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char wbuf[MAXFSIZE];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fd =3D creat(filename, S_IRWXU)) &lt; 0) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((randomsize =3D box_muler(0, MAXFSIZE)) &lt=
; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0randomsize =3D MAXF=
SIZE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (write(fd, wbuf, randomsize) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cfilecount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disk_space_pool -=3D randomsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-<br>
-int delete_file(char *filename)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat buf;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int st;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0st =3D stat(filename, &amp;buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (st &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disk_space_pool +=3D buf.st_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlink(filename) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dfilecount++;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
diff --git a/testcases/kernel/fs/fs-bench/random-access.c b/testcases/kerne=
l/fs/fs-bench/random-access.c<br>
deleted file mode 100644<br>
index c2f32b86e..000000000<br>
--- a/testcases/kernel/fs/fs-bench/random-access.c<br>
+++ /dev/null<br>
@@ -1,92 +0,0 @@<br>
-/* random-access.c (GPL)*/<br>
-/* Hironobu SUZUKI &lt;<a href=3D"mailto:hironobu@h2np.net" target=3D"_bla=
nk">hironobu@h2np.net</a>&gt; */<br>
-#include &lt;stdio.h&gt;<br>
-#include &lt;errno.h&gt;<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-#include &lt;time.h&gt;<br>
-#include &lt;stdlib.h&gt;<br>
-#define FAIL 0<br>
-#define SUCCESS 1<br>
-<br>
-static int openlog[2] =3D { 0, 0 };<br>
-<br>
-#define MAXNUM 0x100000<br>
-<br>
-void open_read_close(char *fname);<br>
-<br>
-int nullfd;<br>
-<br>
-int main(int ac, char **av)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char fname[1024];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time_t t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int m;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ac !=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s hex=
-style-filename \n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;ex) %s=
 00022300\n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sscanf(av[1], &quot;%x&quot;, &amp;m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (m &lt; 1 || m &gt; MAXNUM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;out of=
 size %d\n&quot;, m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time(&amp;t);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0srandom((unsigned int)getpid() ^<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((unsigned int)t &=
lt;&lt; 16) | (unsigned int)t &gt;&gt; 16));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((nullfd =3D open(&quot;/dev/null&quot;, O_W=
RONLY)) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;/dev/n=
ull&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 00/00/00/00 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; m; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D random() % m;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(fname, &quo=
t;00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 8) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF), ((r &gt;&gt; 8) &amp; 0xFF), (r &am=
p; 0xFF));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open_read_close(fna=
me);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0close(nullfd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Success:\t%d\nFail:\t%d\n&quot;, o=
penlog[SUCCESS], openlog[FAIL]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
-}<br>
-<br>
-#define BUFS 8192<br>
-void open_read_close(char *fname)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[BUFS];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int c;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fd =3D open(fname, O_RDONLY)) &lt; 0) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openlog[FAIL]++;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0openlog[SUCCESS]++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((c =3D read(fd, buf, BUFS)) &gt; 0) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write(nullfd, b=
uf, c) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0perror(&quot;/dev/null&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;Opened\t %d\nUnopend:\t%d\n&quot;, openlog[SUCCESS],=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openlog[FAIL]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (c &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(fname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Opened=
\t %d\nUnopend:\t%d\n&quot;, openlog[SUCCESS],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 openlog[FAIL]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-}<br>
diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c b/testcases/k=
ernel/fs/fs-bench/random-del-create.c<br>
deleted file mode 100644<br>
index 345031f28..000000000<br>
--- a/testcases/kernel/fs/fs-bench/random-del-create.c<br>
+++ /dev/null<br>
@@ -1,134 +0,0 @@<br>
-/* random-del-create.c (GPL)*/<br>
-/* Hironobu SUZUKI &lt;<a href=3D"mailto:hironobu@h2np.net" target=3D"_bla=
nk">hironobu@h2np.net</a>&gt; */<br>
-<br>
-#include &lt;stdio.h&gt;<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
-#include &lt;fcntl.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-#include &lt;time.h&gt;<br>
-#include &lt;stdlib.h&gt;<br>
-#define FAIL 0<br>
-#define SUCCESS 1<br>
-<br>
-static int openlog[2] =3D { 0, 0 };<br>
-<br>
-#define MAXNUM 0x100000<br>
-<br>
-#define=C2=A0 MAXERROR 1024<br>
-<br>
-extern int box_muler(int, int);<br>
-extern void create_or_delete(char *);<br>
-<br>
-int cfilecount =3D 0;<br>
-int dfilecount =3D 0;<br>
-int errorcount =3D 0;<br>
-<br>
-int main(int ac, char **av)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char fname[1024];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time_t t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int m;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ac !=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s hex=
-style-filename \n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;ex) %s=
 00022300\n&quot;, av[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sscanf(av[1], &quot;%x&quot;, &amp;m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (m &lt; 1 || m &gt; MAXNUM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;out of=
 size %d\n&quot;, m);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0time(&amp;t);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0srandom((unsigned int)getpid() ^<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((unsigned int)t &=
lt;&lt; 16) | (unsigned int)t &gt;&gt; 16));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 00/00/00/00 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; m; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D random() % m;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(fname, &quo=
t;00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 8) &amp; 0xFF),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0((r &gt;&gt; 16) &amp; 0xFF), ((r &gt;&gt; 8) &amp; 0xFF), (r &am=
p; 0xFF));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_or_delete(fn=
ame);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total create files: %d\n&=
quot;, cfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total delete files: %d\n&=
quot;, dfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Total error=C2=A0 =C2=A0 =
=C2=A0 =C2=A0: %d\n&quot;, errorcount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
-}<br>
-<br>
-#define MAXFSIZE (192*1024)<br>
-#define AVEFSIZE (MAXFSIZE/2)<br>
-#define POOLDISKSPACE (AVEFSIZE*128)<br>
-<br>
-static int disk_space_pool =3D 0;<br>
-void create_or_delete(char *fname)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fsize;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D (random() &amp; 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &amp;&amp; disk_space_pool &gt; POOLDISKS=
PACE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* create */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_file(fname);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete_file(fname);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((errorcount &gt; dfilecount || errorcount &=
gt; cfilecount)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; (errorcount &gt; MAXER=
ROR)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;too much error -- stop\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total create files: %d\n&quot;, cfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total delete files: %d\n&quot;, dfilecount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Total error=C2=A0 =C2=A0 =C2=A0 =C2=A0: %d\n&quot;, errorcount);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-int create_file(char *filename)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int randomsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char wbuf[MAXFSIZE];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fd =3D creat(filename, S_IRWXU)) &lt; 0) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((randomsize =3D box_muler(0, MAXFSIZE)) &lt=
; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0randomsize =3D MAXF=
SIZE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (write(fd, wbuf, randomsize) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cfilecount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disk_space_pool -=3D randomsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-#include &lt;sys/stat.h&gt;<br>
-#include &lt;unistd.h&gt;<br>
-<br>
-int delete_file(char *filename)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat buf;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int st;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0st =3D stat(filename, &amp;buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (st &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disk_space_pool +=3D buf.st_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlink(filename) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errorcount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dfilecount++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-- <br>
2.38.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--00000000000037cc9d05ee2263f1--


--===============0153108271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0153108271==--

