Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD9C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 18:36:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 763363CCA31
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 19:36:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 965B33C03AE
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 19:36:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7BF921A0069B
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 19:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669228556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rlg+Jv2swzYDqixc7f6UeHSfrURlYKndH5h4fjKkxXE=;
 b=jGw/VIX8Fnz/nmbL0qcQlrAg9ujIS08HLaf2sXRMjI22+/5wFjpQ0XxrRpA1zmnmuxBtOf
 cz07vOM+tE78rLv8AiD5O+xKT4HbKTCpyGxFPcyKkfVA9R82Pb7vpMuR/9oNwOL12ikCwz
 ZsiAFVJq1O9MPgaP2x+jxXSGdmVO3d0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-iDI9JwDVPFWToHEoYU8hrg-1; Wed, 23 Nov 2022 13:35:55 -0500
X-MC-Unique: iDI9JwDVPFWToHEoYU8hrg-1
Received: by mail-pj1-f72.google.com with SMTP id
 n4-20020a17090a2fc400b002132adb9485so1339608pjm.0
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 10:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rlg+Jv2swzYDqixc7f6UeHSfrURlYKndH5h4fjKkxXE=;
 b=22nwzmn5yh8L3fOjbe4X+Y1Cs6uaYN52zwqAhKo8rKi2uPGyuiUvGbooc3yGx8Geho
 lKotsjXskmaRoBZOj17ZOSLGlzntjvwNgSLvZQXzyfLs17Pg1zoE/TDpajnisxyuAR1m
 60mYL1J+5200zZcZFp3Sz88DXZSxS/K+I53Rjcxdh3WIUDjazRqoVHVbIdyop1km7wms
 Ql1WrouK5zOkVnlRL4bqU5EgqitlcoXBnsEoDy+t5bzxlUEhbylbutEzp07vYKP5yeP/
 JupBT8QkbTJNetjNeSSCoC/bzR90l0jyJ1Ty3yXqxOy+lLWAxldBFRzG0uZRW5gZamRq
 sK/w==
X-Gm-Message-State: ANoB5plMUVoruhqkCQAbRENsslcwqWt5sVV8PyxvVKIDoljd55h61hiQ
 lRzsSJufUGFmLFjpZFCs0TEyO4wfE96/8kEbMuGgIWbHKPZ7dT4Gg1rjzopyCkWtssw0+r0PuBA
 JsjgWaL4Lhkw=
X-Received: by 2002:a17:90a:2ec9:b0:213:fa78:6395 with SMTP id
 h9-20020a17090a2ec900b00213fa786395mr37116047pjs.107.1669228554007; 
 Wed, 23 Nov 2022 10:35:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7zAiuCglhjmHHQnBL2XSNvAWSbZHEgDwLaBzOW+1RSclxX05KOa6rilsFtYJNmzi9C+n5W6Q==
X-Received: by 2002:a17:90a:2ec9:b0:213:fa78:6395 with SMTP id
 h9-20020a17090a2ec900b00213fa786395mr37116005pjs.107.1669228553456; 
 Wed, 23 Nov 2022 10:35:53 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a170902e49400b001888a46e2d0sm7524395ple.162.2022.11.23.10.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 10:35:53 -0800 (PST)
Date: Thu, 24 Nov 2022 02:35:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221123183547.6hvdotidxmfjehqg@zlang-mailbox>
References: <20221123115546.786-1-pvorel@suse.cz>
 <CAEemH2f=TTMPYHR8u3Bub4C7zWijf=9Fi1bkjFO1rYgFDdQZsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEemH2f=TTMPYHR8u3Bub4C7zWijf=9Fi1bkjFO1rYgFDdQZsg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 23, 2022 at 08:25:33PM +0800, Li Wang wrote:
>    I rarely touch the FS bench test, cc'ing my fs-colleagues
>    in case they have some opinions on this.

Hi Li,

Our team never used this case, it's even not recommended in ltp/runtest/*,
so we didn't notice that either. We have other similar tests, not sure
what's special in this case. So there's not objection from me, if you'd
like to remove it as the reason in this patch commit log.

Thanks,
Zorro

>    On Wed, Nov 23, 2022 at 7:55 PM Petr Vorel <[1]pvorel@suse.cz> wrote:
> 
>      fs-bench is horribly broken and there does not seem to be a lot of
>      value
>      in keeping it.
>      Closes: [2]https://github.com/linux-test-project/ltp/issues/994
>      Suggested-by: Cyril Hrubis <[3]chrubis@suse.cz>
>      Signed-off-by: Petr Vorel <[4]pvorel@suse.cz>
>      ---
>       testcases/kernel/fs/fs-bench/.gitignore       |   3 -
>       testcases/kernel/fs/fs-bench/Makefile         |  41 ------
>       testcases/kernel/fs/fs-bench/README           |  45 ------
>       testcases/kernel/fs/fs-bench/boxmuler.c       |  28 ----
>       testcases/kernel/fs/fs-bench/create-files.c   | 119 ---------------
>       testcases/kernel/fs/fs-bench/fs-bench-test.sh |  50 -------
>       .../kernel/fs/fs-bench/fs-bench-test2.sh      |  63 --------
>       testcases/kernel/fs/fs-bench/modaltr.sh       | 124
>      ----------------
>       .../fs/fs-bench/random-access-del-create.c    | 136
>      ------------------
>       testcases/kernel/fs/fs-bench/random-access.c  |  92 ------------
>       .../kernel/fs/fs-bench/random-del-create.c    | 134
>      -----------------
>       11 files changed, 835 deletions(-)
>       delete mode 100644 testcases/kernel/fs/fs-bench/.gitignore
>       delete mode 100644 testcases/kernel/fs/fs-bench/Makefile
>       delete mode 100644 testcases/kernel/fs/fs-bench/README
>       delete mode 100644 testcases/kernel/fs/fs-bench/boxmuler.c
>       delete mode 100644 testcases/kernel/fs/fs-bench/create-files.c
>       delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh
>       delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>       delete mode 100755 testcases/kernel/fs/fs-bench/modaltr.sh
>       delete mode 100644
>      testcases/kernel/fs/fs-bench/random-access-del-create.c
>       delete mode 100644 testcases/kernel/fs/fs-bench/random-access.c
>       delete mode 100644 testcases/kernel/fs/fs-bench/random-del-create.c
>      diff --git a/testcases/kernel/fs/fs-bench/.gitignore
>      b/testcases/kernel/fs/fs-bench/.gitignore
>      deleted file mode 100644
>      index 5824a4002..000000000
>      --- a/testcases/kernel/fs/fs-bench/.gitignore
>      +++ /dev/null
>      @@ -1,3 +0,0 @@
>      -/create-files
>      -/random-access
>      -/random-access-del-create
>      diff --git a/testcases/kernel/fs/fs-bench/Makefile
>      b/testcases/kernel/fs/fs-bench/Makefile
>      deleted file mode 100644
>      index bc570f7eb..000000000
>      --- a/testcases/kernel/fs/fs-bench/Makefile
>      +++ /dev/null
>      @@ -1,41 +0,0 @@
>      -#
>      -#    kernel/fs/fs-bench testcases Makefile.
>      -#
>      -#    Copyright (C) 2009, Cisco Systems Inc.
>      -#
>      -#    This program is free software; you can redistribute it and/or
>      modify
>      -#    it under the terms of the GNU General Public License as
>      published by
>      -#    the Free Software Foundation; either version 2 of the License,
>      or
>      -#    (at your option) any later version.
>      -#
>      -#    This program is distributed in the hope that it will be
>      useful,
>      -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
>      -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>      -#    GNU General Public License for more details.
>      -#
>      -#    You should have received a copy of the GNU General Public
>      License along
>      -#    with this program; if not, write to the Free Software
>      Foundation, Inc.,
>      -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>      -#
>      -# Ngie Cooper, July 2009
>      -#
>      -
>      -top_srcdir                     ?= ../../../..
>      -
>      -include $(top_srcdir)/include/mk/[5]env_pre.mk
>      -
>      -INSTALL_TARGETS                        := modaltr.sh
>      fs-bench-test.sh fs-bench-test2.sh
>      -
>      -LDLIBS                         += -lm
>      -
>      -create-files: boxmuler.o create-files.o
>      -
>      -random-access-del-create: boxmuler.o random-access-del-create.o
>      -
>      -MAKE_TARGETS                   := create-files random-access\
>      -                                  random-access-del-create
>      -
>      -dist: clean
>      -       (cd $(abs_srcdir); tar zcvf fs-bench.tar.gz $(abs_srcdir))
>      -
>      -include $(top_srcdir)/include/mk/[6]generic_leaf_target.mk
>      diff --git a/testcases/kernel/fs/fs-bench/README
>      b/testcases/kernel/fs/fs-bench/README
>      deleted file mode 100644
>      index 20d49a951..000000000
>      --- a/testcases/kernel/fs/fs-bench/README
>      +++ /dev/null
>      @@ -1,45 +0,0 @@
>      -Programs for File system stress test.
>      -
>      -All of programs are distributed under GPL 2 license
>      -by Hironobu SUZUKI <[7]hironobu@h2np.net>
>      -
>      -HOW TO TEST
>      -------------
>      -
>      -1: Type "make"
>      -
>      -       # cd
>      -       # tar zxvf fs-bench.tar.gz
>      -       # cd fs-bench
>      -       # make
>      -
>      -2: Change directory to terget file system and do-it!
>      -       (I always use one-HDD/one-partition for fs stress test.)
>      -
>      -       # mount -t jfs /dev/hdc1 /jfs
>      -       # cd /jfs
>      -       # ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/jfs-test
>      -
>      -
>      -NOTE
>      ------
>      -
>      -The size of files that are created for stress test is not fixed.
>      The
>      -file size are determined by probabilistic algorithm, box-muler
>      -algorithm.
>      -
>      -number
>      -of files
>      -  ^
>      -  |       ****
>      -  |      *    *
>      -  |     *      *
>      -  |    *        *
>      -  |  **          **
>      -  |**              **
>      -  +-------------------> file size
>      -  min               max
>      -
>      -
>      -------
>      -$Id: README,v 1.1 2004/11/18 20:23:05 robbiew Exp $
>      diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c
>      b/testcases/kernel/fs/fs-bench/boxmuler.c
>      deleted file mode 100644
>      index e923a1617..000000000
>      --- a/testcases/kernel/fs/fs-bench/boxmuler.c
>      +++ /dev/null
>      @@ -1,28 +0,0 @@
>      -#include <math.h>
>      -#include <stdlib.h>
>      -
>      -#define M_2PI (M_PI*2)
>      -
>      -int box_muler(int min, int max)
>      -{
>      -       double u1, u2, z;
>      -       int i;
>      -       int ave;
>      -       int range;
>      -       int ZZ;
>      -       if (min >= max) {
>      -               return (-1);
>      -       }
>      -       range = max - min;
>      -       ave = range / 2;
>      -       for (i = 0; i < 10; i++) {
>      -               u1 = ((double)(random() % 1000000)) / 1000000;
>      -               u2 = ((double)(random() % 1000000)) / 1000000;
>      -               z = sqrt(-2.0 * log(u1)) * cos(M_2PI * u2);
>      -               ZZ = min + (ave + (z * (ave / 4)));
>      -               if (ZZ >= min && ZZ < max) {
>      -                       return (ZZ);
>      -               }
>      -       }
>      -       return (-1);
>      -}
>      diff --git a/testcases/kernel/fs/fs-bench/create-files.c
>      b/testcases/kernel/fs/fs-bench/create-files.c
>      deleted file mode 100644
>      index c6cba6f69..000000000
>      --- a/testcases/kernel/fs/fs-bench/create-files.c
>      +++ /dev/null
>      @@ -1,119 +0,0 @@
>      -/* create.c (GPL)*/
>      -/* Hironobu SUZUKI <[8]hironobu@h2np.net> */
>      -#include <stdio.h>
>      -#include <sys/stat.h>
>      -#include <sys/types.h>
>      -#include <fcntl.h>
>      -#include <unistd.h>
>      -#include <time.h>
>      -#include <stdlib.h>
>      -
>      -#define MAXN 4096
>      -
>      -#define MAXFSIZE 1024 * 192
>      -
>      -char wbuf[MAXFSIZE];
>      -static int filecount = 0;
>      -
>      -void makedir(char *dir1);
>      -void changedir(char *dir);
>      -void create_file(char *filename);
>      -
>      -extern int box_muler(int, int);
>      -
>      -int startc = 0;
>      -int main(int ac, char *av[])
>      -{
>      -       int i = 0;
>      -       int j = 0;
>      -       int k = 0;
>      -       int l = 0;
>      -       char dir1[MAXN];
>      -       char dir2[MAXN];
>      -       char dir3[MAXN];
>      -       char filename[MAXN];
>      -       time_t t;
>      -       int maxfiles = 0xFFFFFF;
>      -       int createfiles = 0;
>      -
>      -       if (ac > 1) {
>      -               sscanf(av[1], "%x", &maxfiles);
>      -               if (maxfiles == 0) {
>      -                       printf("maxfile argument error (0
>      value)\n");
>      -                       exit(1);
>      -               }
>      -       }
>      -       time(&t);
>      -       srandom((unsigned int)getpid() ^
>      -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
>      -       printf("Create files\n");
>      -       for (i = 0; i < 0xFF; i++) {
>      -               sprintf(dir1, "%2.2x", i);
>      -               makedir(dir1);
>      -               changedir(dir1);
>      -               for (j = 0; j < 0xFF; j++) {
>      -                       sprintf(dir2, "%2.2x", j);
>      -                       makedir(dir2);
>      -                       changedir(dir2);
>      -                       for (k = 0; k < 0xFF; k++) {
>      -                               sprintf(dir3, "%2.2x", k);
>      -                               makedir(dir3);
>      -                               changedir(dir3);
>      -                               for (l = 0; l < 0xFF; l++) {
>      -                                       sprintf(filename,
>      "%s%s%s%2.2x", dir1,
>      -                                               dir2, dir3, l);
>      -                                       create_file(filename);
>      -                                       if (maxfiles <
>      createfiles++) {
>      -                                               goto end;
>      -                                       }
>      -                               }
>      -                               changedir("../");
>      -                       }
>      -                       changedir("../");
>      -               }
>      -               changedir("../");
>      -       }
>      -end:
>      -       fprintf(stderr, "\nTotal create files: %d\n", filecount);
>      -       printf("Done\n");
>      -       return 0;
>      -}
>      -
>      -int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
>      -
>      -void makedir(char *dir1)
>      -{
>      -       if (mkdir(dir1, S_IRWXU) < 0) {
>      -               perror(dir1);
>      -               exit(1);
>      -       }
>      -}
>      -
>      -void changedir(char *dir)
>      -{
>      -       if (chdir(dir) < 0) {
>      -               perror(dir);
>      -               exit(1);
>      -       }
>      -}
>      -
>      -void create_file(char *filename)
>      -{
>      -       int fd;
>      -       int randomsize;
>      -       if ((fd = creat(filename, S_IRWXU)) < 0) {
>      -               fprintf(stderr, "\nTotal create files: %d\n",
>      filecount);
>      -               perror(filename);
>      -               exit(1);
>      -       }
>      -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
>      -               randomsize = MAXFSIZE;
>      -       }
>      -       if (write(fd, wbuf, randomsize) < 0) {
>      -               fprintf(stderr, "\nTotal create files: %d\n",
>      filecount);
>      -               perror(filename);
>      -               exit(1);
>      -       }
>      -       filecount++;
>      -       close(fd);
>      -}
>      diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
>      b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
>      deleted file mode 100755
>      index c2ca767f0..000000000
>      --- a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
>      +++ /dev/null
>      @@ -1,50 +0,0 @@
>      -#! /bin/bash
>      -
>      -echo "## Start Test"
>      -date
>      -if [ -d ./00 ] ; then
>      -    echo -n "Clear old files..."
>      -    /bin/rm -fr ./00 >& /dev/null
>      -    echo "done"
>      -fi
>      -STARTT=`date +%s`
>      -echo $STARTT
>      -echo ""
>      -echo "## Create files "
>      -time ~/fs-bench/cr
>      -
>      -echo ""
>      -echo "## tar all "
>      -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print
>      $6;}'| awk -F'/' '{print $4;}'`
>      -
>      -echo ""
>      -echo "## Change owner"
>      -time chown -R $USER  ./00
>      -
>      -echo ""
>      -echo "## random access"
>      -time ~/fs-bench/ra  $MAXFILE
>      -
>      -echo ""
>      -echo "## Change mode "
>      -time chmod -R go+rw  ./00
>      -
>      -echo ""
>      -echo "## Random delete and create"
>      -time ~/fs-bench/radc  $MAXFILE
>      -
>      -echo ""
>      -echo "## Change mode again"
>      -time chmod -R go-rw  ./00
>      -
>      -echo ""
>      -echo "## Remove all files and directories"
>      -time /bin/rm -fr ./00
>      -echo ""
>      -echo "## Finish test"
>      -ENDT=`date +%s`
>      -echo $ENDT
>      -date
>      -
>      -echo -n 'TOTAL(seconds): '
>      -expr $ENDT - $STARTT
>      diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>      b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>      deleted file mode 100755
>      index 25c67afe0..000000000
>      --- a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
>      +++ /dev/null
>      @@ -1,63 +0,0 @@
>      -#! /bin/bash
>      -
>      -echo "## Start Test"
>      -date
>      -date +%s
>      -if [ -d ./00 ] ; then
>      -/bin/rm -fr ./00 >& /dev/null
>      -fi
>      -STARTT=`date +%s`
>      -echo $STARTT
>      -
>      -echo ""
>      -echo "## Create files "
>      -time ~/fs-bench/cr
>      -
>      -echo ""
>      -echo "## tar all "
>      -MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print
>      $6;}'| awk -F'/' '{print $4;}'`
>      -HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
>      -
>      -echo ""
>      -echo "## Remove all files and directories"
>      -/bin/rm -fr ./00 >& /dev/null
>      -
>      -echo ""
>      -echo "## Create half files"
>      -echo create half files
>      -time ~/fs-bench/cr  $HALFFILE
>      -
>      -echo ""
>      -echo "## Change owner"
>      -time chown -R $USER  ./00
>      -
>      -echo ""
>      -echo "## random access"
>      -time ~/fs-bench/ra  $HALFFILE
>      -
>      -
>      -echo ""
>      -echo "## Change mode "
>      -time chmod -R go+rw  ./00
>      -
>      -echo ""
>      -echo "## Random delete and create"
>      -time ~/fs-bench/radc  $HALFFILE
>      -
>      -echo ""
>      -echo "## Change mode again"
>      -time chmod -R go-rw  ./00
>      -
>      -echo ""
>      -echo "## Remove all files and directories"
>      -time /bin/rm -fr ./00
>      -
>      -echo ""
>      -echo "## Finish test"
>      -date
>      -ENDT=`date +%s`
>      -echo $ENDT
>      -echo -n 'TOTAL(seconds): '
>      -expr $ENDT - $STARTT
>      -
>      -
>      diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh
>      b/testcases/kernel/fs/fs-bench/modaltr.sh
>      deleted file mode 100755
>      index e44c17f13..000000000
>      --- a/testcases/kernel/fs/fs-bench/modaltr.sh
>      +++ /dev/null
>      @@ -1,124 +0,0 @@
>      -#!/bin/sh
>      -#To run this script the following is necessary
>      -# 1.kernel should mtd support as module.
>      -# 2.kernel should hsve jffs2 support as module.
>      -# 3.kernel should have loopback device support .
>      -# 4.you should have fs-bench utility
>      ([9]http://h2np.net/tools/fs-bench-0.2.tar.gz)
>      -# 5.results will be copied to /tmp/log and /tmp/log1 files
>      -
>      -#DESCRIPTION: This testscript creates a jffs2 file system type and
>      tests the filesystem test
>      -#and places the log in the log directory.The file system test
>      actually creates a tree of large
>      -#directories and performs the delete and random delete operations
>      as per the filesystem stress
>      -#algorithim and gives a report of real time ,user time,system time
>      taken to perform the file
>      -#operations.
>      -
>      -#script created  G.BANU PRAKASH
>      (mailto:[10]prakash.banu@wipro.com).
>      -#
>      -#   This program is free software;  you can redistribute it and/or
>      modify
>      -#   it under the terms of the GNU General Public License as
>      published by
>      -#   the Free Software Foundation; either version 2 of the License,
>      or
>      -#   (at your option) any later version.
>      -#
>      -#   This program is distributed in the hope that it will be useful,
>      -#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>      -#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>      -#   the GNU General Public License for more details.
>      -#
>      -#   You should have received a copy of the GNU General Public
>      License
>      -#   along with this program;  if not, write to the Free Software
>      -#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>      02110-1301 USA
>      -#
>      -
>      -MTD_RAM=mtdram
>      -MTD_BLOCK=mtdblock
>      -JFFS2=jffs2
>      -LOOP=loop
>      -MTD_BLKDEVS=mtd_blkdevs
>      -ZLIB_DEFLATE=zlib_deflate
>      -ZLIB_INFLATE=zlib_inflate
>      -MTD_CORE=mtdcore
>      -MOUNT_DIR=/mnt
>      -LOG_DIR=/tmp/log
>      -LOG_DIR1=/tmp/log1
>      -HOME_DIR=/home
>      -BLOCK_DIR=/dev/mtdblock
>      -export PATH=$PATH:/sbin
>      -       if [ $(id -ru) -ne 0 ];
>      -then
>      -       echo "must be root to run this"
>      -       exit
>      -fi
>      -
>      -
>      -
>      -lsmod |grep $MTD_RAM
>      -
>      -       if [ $? -ne 0 ];
>      -then
>      -       echo "inserting mtd ram and its dependencies"
>      -fi
>      -modprobe $MTD_RAM  total_size=32768 erase_size=256
>      -       if [ $? -ne 0 ];
>      -then
>      -       echo "check wheather MTD -mtdram is been compiled in the
>      kernel"
>      -fi
>      -lsmod |grep $MTD_BLOCK
>      -       if [ $? -ne 0 ]; then
>      -       echo "inserting mtdblock  and its dependencies"
>      -fi
>      -modprobe $MTD_BLOCK
>      -       if [ $? -ne 0 ]; then
>      -       echo "check wheather mtdblock is been compiled in the
>      kernel"
>      -fi
>      -
>      -lsmod |grep $JFFS2
>      -       if [ $? -ne 0 ]; then
>      -       echo "inserting jffs2  and its dependencies"
>      -fi
>      -modprobe $JFFS2
>      -       if [ $? -ne 0 ]; then
>      -       echo "check wheather jffs2 is been compiled in the kernel"
>      -fi
>      -
>      -lsmod |grep $LOOP
>      -       if [ $? -ne 0 ]; then
>      -       echo "inserting loopback device module"
>      -fi
>      -modprobe $LOOP
>      -       if [ $? -ne 0 ]; then
>      -       echo "check wheather loopback device option is been compiled
>      in the kernel"
>      -fi
>      -mkdir -p $BLOCK_DIR
>      -mknod $BLOCK_DIR/0 b 31 0 >/dev/null 2>&1
>      -mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
>      -mount|grep $JFFS2
>      -       if [ $? -eq 0 ]; then
>      - echo "jffs2 mounted sucessfully"
>      -       else
>      - echo "mount unsucessfull"
>      -fi
>      -cd $MOUNT_DIR
>      -echo "This is will take long time "
>      -./test.sh    >log 2>&1
>      -./test2.sh    >log1 2>&1
>      -
>      -mv log   $LOG_DIR
>      -mv log1  $LOG_DIR1
>      -cd $HOME_DIR
>      -
>      -
>      -#cleanup
>      -echo "unmounting $MOUNT_DIR "
>      -umount $MOUNT_DIR
>      -echo "removing the modules inserted"
>      -rmmod  $MTD_BLOCK
>      -rmmod  $MTD_BLKDEVS
>      -rmmod  $LOOP
>      -rmmod  $JFFS2
>      -rmmod  $ZLIB_DEFLATE
>      -rmmod  $ZLIB_INFLATE
>      -rmmod  $MTD_RAM
>      -rmmod  $MTD_CORE
>      -rm -rf /dev/mtdblock
>      -echo "TEST COMPLETE"
>      -echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1  "
>      diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c
>      b/testcases/kernel/fs/fs-bench/random-access-del-create.c
>      deleted file mode 100644
>      index 1878fd78b..000000000
>      --- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
>      +++ /dev/null
>      @@ -1,136 +0,0 @@
>      -/* random-del-create.c (GPL)*/
>      -/* Hironobu SUZUKI <[11]hironobu@h2np.net> */
>      -
>      -#include <stdio.h>
>      -#include <sys/stat.h>
>      -#include <sys/types.h>
>      -#include <fcntl.h>
>      -#include <unistd.h>
>      -#include <time.h>
>      -#include <stdlib.h>
>      -#define FAIL 0
>      -#define SUCCESS 1
>      -
>      -#define MAXNUM 0x100000
>      -
>      -#define  MAXERROR 1024
>      -
>      -extern int box_muler(int, int);
>      -extern void create_or_delete(char *);
>      -
>      -int delete_file(char *filename);
>      -int create_file(char *filename);
>      -
>      -int cfilecount = 0;
>      -int dfilecount = 0;
>      -int errorcount = 0;
>      -
>      -int main(int ac, char **av)
>      -{
>      -       int r;
>      -       char fname[1024];
>      -       time_t t;
>      -       int i;
>      -       int m;
>      -
>      -       if (ac != 2) {
>      -               printf("%s hex-style-filename \n", av[0]);
>      -               printf("ex) %s 00022300\n", av[0]);
>      -               exit(1);
>      -       }
>      -       sscanf(av[1], "%x", &m);
>      -       if (m < 1 || m > MAXNUM) {
>      -               printf("out of size %d\n", m);
>      -               exit(1);
>      -       }
>      -
>      -       time(&t);
>      -       srandom((unsigned int)getpid() ^
>      -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
>      -
>      -       /* 00/00/00/00 */
>      -       for (i = 0; i < m; i++) {
>      -               r = random() % m;
>      -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
>      -                       ((r >> 16) & 0xFF),
>      -                       ((r >> 8) & 0xFF),
>      -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r &
>      0xFF));
>      -               create_or_delete(fname);
>      -       }
>      -       fprintf(stderr, "Total create files: %d\n", cfilecount);
>      -       fprintf(stderr, "Total delete files: %d\n", dfilecount);
>      -       fprintf(stderr, "Total error       : %d\n", errorcount);
>      -       exit(0);
>      -}
>      -
>      -#define MAXFSIZE (192*1024)
>      -#define AVEFSIZE (MAXFSIZE/2)
>      -#define POOLDISKSPACE (AVEFSIZE*128)
>      -
>      -static int disk_space_pool = 0;
>      -void create_or_delete(char *fname)
>      -{
>      -       int r;
>      -
>      -       r = (random() & 1);
>      -       if (r && disk_space_pool > POOLDISKSPACE) {
>      -               /* create */
>      -               create_file(fname);
>      -       } else {
>      -               delete_file(fname);
>      -       }
>      -       if ((errorcount > dfilecount || errorcount > cfilecount)
>      -           && (errorcount > MAXERROR)) {
>      -               fprintf(stderr, "too much error -- stop\n");
>      -               fprintf(stderr, "Total create files: %d\n",
>      cfilecount);
>      -               fprintf(stderr, "Total delete files: %d\n",
>      dfilecount);
>      -               fprintf(stderr, "Total error       : %d\n",
>      errorcount);
>      -               exit(1);
>      -       }
>      -}
>      -
>      -int create_file(char *filename)
>      -{
>      -       int fd;
>      -       int randomsize;
>      -       char wbuf[MAXFSIZE];
>      -       if ((fd = creat(filename, S_IRWXU)) < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
>      -               randomsize = MAXFSIZE;
>      -       }
>      -       if (write(fd, wbuf, randomsize) < 0) {
>      -               errorcount++;
>      -               close(fd);
>      -               return (-1);
>      -       }
>      -       cfilecount++;
>      -       disk_space_pool -= randomsize;
>      -       close(fd);
>      -
>      -       return 0;
>      -}
>      -
>      -#include <sys/stat.h>
>      -#include <unistd.h>
>      -
>      -int delete_file(char *filename)
>      -{
>      -       struct stat buf;
>      -       int st;
>      -       st = stat(filename, &buf);
>      -       if (st < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       disk_space_pool += buf.st_size;
>      -       if (unlink(filename) < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       dfilecount++;
>      -
>      -       return 0;
>      -}
>      diff --git a/testcases/kernel/fs/fs-bench/random-access.c
>      b/testcases/kernel/fs/fs-bench/random-access.c
>      deleted file mode 100644
>      index c2f32b86e..000000000
>      --- a/testcases/kernel/fs/fs-bench/random-access.c
>      +++ /dev/null
>      @@ -1,92 +0,0 @@
>      -/* random-access.c (GPL)*/
>      -/* Hironobu SUZUKI <[12]hironobu@h2np.net> */
>      -#include <stdio.h>
>      -#include <errno.h>
>      -#include <sys/stat.h>
>      -#include <sys/types.h>
>      -#include <fcntl.h>
>      -#include <unistd.h>
>      -#include <time.h>
>      -#include <stdlib.h>
>      -#define FAIL 0
>      -#define SUCCESS 1
>      -
>      -static int openlog[2] = { 0, 0 };
>      -
>      -#define MAXNUM 0x100000
>      -
>      -void open_read_close(char *fname);
>      -
>      -int nullfd;
>      -
>      -int main(int ac, char **av)
>      -{
>      -       int r;
>      -       char fname[1024];
>      -       time_t t;
>      -       int i;
>      -       int m;
>      -
>      -       if (ac != 2) {
>      -               printf("%s hex-style-filename \n", av[0]);
>      -               printf("ex) %s 00022300\n", av[0]);
>      -               exit(1);
>      -       }
>      -       sscanf(av[1], "%x", &m);
>      -       if (m < 1 || m > MAXNUM) {
>      -               printf("out of size %d\n", m);
>      -               exit(1);
>      -       }
>      -
>      -       time(&t);
>      -       srandom((unsigned int)getpid() ^
>      -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
>      -
>      -       if ((nullfd = open("/dev/null", O_WRONLY)) < 0) {
>      -               perror("/dev/null");
>      -               exit(1);
>      -       }
>      -
>      -       /* 00/00/00/00 */
>      -       for (i = 0; i < m; i++) {
>      -               r = random() % m;
>      -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
>      -                       ((r >> 16) & 0xFF),
>      -                       ((r >> 8) & 0xFF),
>      -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r &
>      0xFF));
>      -               open_read_close(fname);
>      -       }
>      -       close(nullfd);
>      -       printf("Success:\t%d\nFail:\t%d\n", openlog[SUCCESS],
>      openlog[FAIL]);
>      -       exit(0);
>      -}
>      -
>      -#define BUFS 8192
>      -void open_read_close(char *fname)
>      -{
>      -       int fd;
>      -       char buf[BUFS];
>      -       int c;
>      -
>      -       if ((fd = open(fname, O_RDONLY)) < 0) {
>      -               openlog[FAIL]++;
>      -               close(fd);
>      -               return;
>      -       }
>      -       openlog[SUCCESS]++;
>      -       while ((c = read(fd, buf, BUFS)) > 0) {
>      -               if (write(nullfd, buf, c) < 0) {
>      -                       perror("/dev/null");
>      -                       printf("Opened\t %d\nUnopend:\t%d\n",
>      openlog[SUCCESS],
>      -                              openlog[FAIL]);
>      -                       exit(1);
>      -               }
>      -       }
>      -       if (c < 0) {
>      -               perror(fname);
>      -               printf("Opened\t %d\nUnopend:\t%d\n",
>      openlog[SUCCESS],
>      -                      openlog[FAIL]);
>      -               exit(1);
>      -       }
>      -       close(fd);
>      -}
>      diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c
>      b/testcases/kernel/fs/fs-bench/random-del-create.c
>      deleted file mode 100644
>      index 345031f28..000000000
>      --- a/testcases/kernel/fs/fs-bench/random-del-create.c
>      +++ /dev/null
>      @@ -1,134 +0,0 @@
>      -/* random-del-create.c (GPL)*/
>      -/* Hironobu SUZUKI <[13]hironobu@h2np.net> */
>      -
>      -#include <stdio.h>
>      -#include <sys/stat.h>
>      -#include <sys/types.h>
>      -#include <fcntl.h>
>      -#include <unistd.h>
>      -#include <time.h>
>      -#include <stdlib.h>
>      -#define FAIL 0
>      -#define SUCCESS 1
>      -
>      -static int openlog[2] = { 0, 0 };
>      -
>      -#define MAXNUM 0x100000
>      -
>      -#define  MAXERROR 1024
>      -
>      -extern int box_muler(int, int);
>      -extern void create_or_delete(char *);
>      -
>      -int cfilecount = 0;
>      -int dfilecount = 0;
>      -int errorcount = 0;
>      -
>      -int main(int ac, char **av)
>      -{
>      -       int r;
>      -       char fname[1024];
>      -       time_t t;
>      -       int i;
>      -       int m;
>      -
>      -       if (ac != 2) {
>      -               printf("%s hex-style-filename \n", av[0]);
>      -               printf("ex) %s 00022300\n", av[0]);
>      -               exit(1);
>      -       }
>      -       sscanf(av[1], "%x", &m);
>      -       if (m < 1 || m > MAXNUM) {
>      -               printf("out of size %d\n", m);
>      -               exit(1);
>      -       }
>      -
>      -       time(&t);
>      -       srandom((unsigned int)getpid() ^
>      -               (((unsigned int)t << 16) | (unsigned int)t >> 16));
>      -
>      -       /* 00/00/00/00 */
>      -       for (i = 0; i < m; i++) {
>      -               r = random() % m;
>      -               sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
>      -                       ((r >> 16) & 0xFF),
>      -                       ((r >> 8) & 0xFF),
>      -                       ((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r &
>      0xFF));
>      -               create_or_delete(fname);
>      -       }
>      -       fprintf(stderr, "Total create files: %d\n", cfilecount);
>      -       fprintf(stderr, "Total delete files: %d\n", dfilecount);
>      -       fprintf(stderr, "Total error       : %d\n", errorcount);
>      -       exit(0);
>      -}
>      -
>      -#define MAXFSIZE (192*1024)
>      -#define AVEFSIZE (MAXFSIZE/2)
>      -#define POOLDISKSPACE (AVEFSIZE*128)
>      -
>      -static int disk_space_pool = 0;
>      -void create_or_delete(char *fname)
>      -{
>      -       int r;
>      -       int fsize;
>      -
>      -       r = (random() & 1);
>      -       if (r && disk_space_pool > POOLDISKSPACE) {
>      -               /* create */
>      -               create_file(fname);
>      -       } else {
>      -               delete_file(fname);
>      -       }
>      -       if ((errorcount > dfilecount || errorcount > cfilecount)
>      -           && (errorcount > MAXERROR)) {
>      -               fprintf(stderr, "too much error -- stop\n");
>      -               fprintf(stderr, "Total create files: %d\n",
>      cfilecount);
>      -               fprintf(stderr, "Total delete files: %d\n",
>      dfilecount);
>      -               fprintf(stderr, "Total error       : %d\n",
>      errorcount);
>      -               exit(1);
>      -       }
>      -}
>      -
>      -int create_file(char *filename)
>      -{
>      -       int fd;
>      -       int randomsize;
>      -       char wbuf[MAXFSIZE];
>      -       if ((fd = creat(filename, S_IRWXU)) < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
>      -               randomsize = MAXFSIZE;
>      -       }
>      -       if (write(fd, wbuf, randomsize) < 0) {
>      -               errorcount++;
>      -               close(fd);
>      -               return (-1);
>      -       }
>      -       cfilecount++;
>      -       disk_space_pool -= randomsize;
>      -       close(fd);
>      -       return 0;
>      -}
>      -
>      -#include <sys/stat.h>
>      -#include <unistd.h>
>      -
>      -int delete_file(char *filename)
>      -{
>      -       struct stat buf;
>      -       int st;
>      -       st = stat(filename, &buf);
>      -       if (st < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       disk_space_pool += buf.st_size;
>      -       if (unlink(filename) < 0) {
>      -               errorcount++;
>      -               return (-1);
>      -       }
>      -       dfilecount++;
>      -       return 0;
>      -}
>      --
>      2.38.1
> 
>    --
>    Regards,
>    Li Wang
> 
> References
> 
>    1. mailto:pvorel@suse.cz
>    2. https://github.com/linux-test-project/ltp/issues/994
>    3. mailto:chrubis@suse.cz
>    4. mailto:pvorel@suse.cz
>    5. http://env_pre.mk/
>    6. http://generic_leaf_target.mk/
>    7. mailto:hironobu@h2np.net
>    8. mailto:hironobu@h2np.net
>    9. http://h2np.net/tools/fs-bench-0.2.tar.gz
>   10. mailto:prakash.banu@wipro.com
>   11. mailto:hironobu@h2np.net
>   12. mailto:hironobu@h2np.net
>   13. mailto:hironobu@h2np.net


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
