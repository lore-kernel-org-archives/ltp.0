Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5972BC83F25
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753106244; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=iPHhqXABMt5atCft2CziiqtNR3Ph1xnGtiJL9Nlhzpo=;
 b=cpJlOagOyhqr6zLxecwZPDK/ad0cgbwEglWiU/v6foFQX+waQI4g7qJ47WWyoGqmzvrfe
 huQj7/IHzZt+2R8vfpyuffPQmNQ7+Fv8JorwksdbcGE+auMB1wtopP4LkSg+OemFXM85mqV
 5fWzY4OXPlgSFVnSjXrEx7ITzYOb7nY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 628543CCB99
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 15:57:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31263C1CEA
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 15:57:02 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87011200978
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 15:57:01 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so31861025e9.1
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753106221; x=1753711021; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3fnKh22xCViaKFtjjWmgFlJmssDzkbdzcYIvlmSiPI=;
 b=Ik1w1SFBzywh1XsrdbrnzK0JELPUQtVJmiLt1tW66/l9/ZYNIZczu8XOBCPRvD79Wo
 1SA4RxOMCp57y3TZV2OMoTNcBi5wFUbSQ97ArpIc1p4xCKjkjKSxRuWfg6kFpSTLIkWS
 HnJ/wl8VVUMtCgP/53U0/CekuXTP+6Y4hkPwyM12ummUw3hvZzMEPQwE/sGjd4VXPQyJ
 XWPdbZkq2yERS53dkAmQXekPc0V/OutenhkpoDSnArvg7NgLMQcY2ouH/+swt4f6RFc4
 NTAjie20s43qjCInjzuc/i7r5w63b+0+P3hhVSP2F9b3M5oBeqyQftubw565gdZr0xaU
 VG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753106221; x=1753711021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3fnKh22xCViaKFtjjWmgFlJmssDzkbdzcYIvlmSiPI=;
 b=gJqkt4E4lI0TxaAtu11NXlZCpSUzUGu178KTJCRxhr51GyYG4lz1QRlOQO/nMwmX8V
 YqaLNUQllYTu/v/z9zPDmBul5xjm1pPpPYkGx8kG3ArCyGh/S1l2pAh3aMuytwYBGD6r
 Kqh5k2dRS0EMSRj26I+wv4XGjP5yp2urXQ6DSiO7oGCdlffIOO9lIOv/nDyTauZLFne1
 ZMr/JpTANlG05ek7W+EdTtJ0ZM//2vLhahLNN+KlwOWeyoOWjAYz6N4Rtv8kzfPT3Nj2
 eWI+QomoBzIm1KAnGpebZWMwUDCJl7fFcBx9XMOdvXSY4PcumAHaIewLKYjwGqRS54Zt
 OeSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQRS1lOjWWkCkTRSwBarFy/5vk2M7rv+gzTQ9KuRcmbcGdfr3FMLPXgVNaq47Z7KiwOdU=@lists.linux.it
X-Gm-Message-State: AOJu0YwgJow7cePqpbYYQ9eNoAP4k2NLZLxvl8RlB23qCjrAgvBT6RAh
 Vs2/ZsajT3UWFAXijr3XZJyGN4YOQzX18RErUHiOvyJxmXBPsujGPHIklQnXGeueD8aMIX+3VK1
 h26vS8XE=
X-Gm-Gg: ASbGncuohNbYPFusvkQ2mm4x8h9A8H1eGO/D/1IH0Klt/xy4QpRrjhwbf/isYkN10bX
 Kw0SJw7RLkTpP0FbHUxyKuQbTtSp0miyJsqDR/JCfLBeKb0Xqvk6rA5EeDsX1FagGd/1wTHzhn/
 Hxdgi6FUksrlvBiE7I6e8xxTGfJBbIjjvyDvW3LsMH35UJbFHan2XsnGerj6fqWHHH/aXity1Su
 Pr1rOdWuBKzDwcweJJ9jpsEIQYHo79427iI29vt4Mz5ZfmiFOk13/3OMx5/5WLZty8hi2lIyLxG
 2f/7IW5JmevBNQsCibbvjtH9Yj7YgF3pYxutmRQWSWnnJfxAS4URzJDOjdcCMiRJsFW3VhQALV2
 wtUmMCG0oE4/w9d1dN81xcrmRzGKi0R0QnzLFAxsJlqq/4eMPbdydsMpYMPL6fxULgAfU35gtpH
 vDYIf6lrM85OtYf414ZKp+G85xOrkmHTRq6OyjxVZIYkDl11DyuPZ4hs4+Zxn7zw==
X-Google-Smtp-Source: AGHT+IH5QpOjw3pAZQiITcI9tHhKl2Q/Ow5JVMoIze9SC9c4MG5BGzO5ER2LL9174k4Qvp1ylygvAQ==
X-Received: by 2002:a05:6000:2903:b0:3a4:f5f6:b4ab with SMTP id
 ffacd0b85a97d-3b60e523cc0mr14685757f8f.30.1753106220512; 
 Mon, 21 Jul 2025 06:57:00 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6d1cb8sm58903915ad.158.2025.07.21.06.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 06:57:00 -0700 (PDT)
Message-ID: <64694997-ff37-4a60-80cd-b780616bdf98@suse.com>
Date: Mon, 21 Jul 2025 15:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250718162928.71364-1-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250718162928.71364-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open14: Rewrite to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 7/18/25 6:29 PM, Martin Doucha wrote:
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/open/open14.c | 276 +++++++++++-------------
>   1 file changed, 131 insertions(+), 145 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
> index 3ecb7e4fb..41e274e69 100644
> --- a/testcases/kernel/syscalls/open/open14.c
> +++ b/testcases/kernel/syscalls/open/open14.c
> @@ -1,63 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - *
>    * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> - *
> + * Copyright (c) 2025 SUSE LLC <mdoucha@suse.cz>
>    */
>   
> -#define _GNU_SOURCE
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
> +/*\
> + * Check the functionality of O_TMPFILE flag for open() syscall.
It would be nice to add the 3 test cases in the description.
> + */
>   
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   #include "lapi/fcntl.h"
>   
> -char *TCID = "open14";
> -int TST_TOTAL = 3;
> -static ssize_t size;
> +#define FILE_COUNT 100
> +#define MNTPOINT "mntpoint"
> +
>   static char buf[1024];
> +static int fds[FILE_COUNT];
Since we are not using variants, we can initialize all items ad 
declaration without doing it inside the setup:

static char buf[1024] ={1};
static int fds[FILE_COUNT] = {-1};

But probably buf can be initialized using tst_rand_data.
> +static const ssize_t size = sizeof(buf);
Why not defining a macro with the size of the buf and use that one 
inside the code?

#define BUFSIZE 1024
>   static const ssize_t blocks_num = 4;
> -static struct stat st;
> -
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
>   
>   static void setup(void)
>   {
> -	tst_tmpdir();
> +	int i;
In c99 we can define int inside the for loop.
>   
> -	size = sizeof(buf);
> +	for (i = 0; i < FILE_COUNT; i++)
> +		fds[i] = -1;
>   
>   	memset(buf, 1, size);
> +	SAFE_CHDIR(MNTPOINT);
> +	fds[0] = open(".", O_TMPFILE | O_RDWR, 0600);
>   
> -	int fd = open(".", O_TMPFILE | O_RDWR, 0600);
> -
> -	if (fd == -1) {
> +	if (fds[0] == -1) {
>   		if (errno == EISDIR || errno == ENOTSUP)
> -			tst_brkm(TCONF, cleanup, "O_TMPFILE not supported");
> +			tst_brk(TCONF, "O_TMPFILE not supported");
>   
> -		tst_brkm(TBROK | TERRNO, cleanup, "open() failed");
> +		tst_brk(TBROK | TERRNO, "open() failed");
>   	}
>   
> -	SAFE_CLOSE(cleanup, fd);
> +	SAFE_CLOSE(fds[0]);
>   }
>   
>   static void write_file(int fd)
> @@ -65,183 +47,187 @@ static void write_file(int fd)
>   	int i;
>   
>   	for (i = 0; i < blocks_num; ++i)
> -		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, size);
> +		SAFE_WRITE(1, fd, buf, size);
>   }
>   
>   void test01(void)
>   {
> -	int fd;
> -	char path[PATH_MAX], tmp[PATH_MAX];
> -
> -	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
> -	fd = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR, 0600);
> -
> -	tst_resm(TINFO, "writing data to the file");
> -	write_file(fd);
> +	struct stat st;
> +	char path[PATH_MAX];
>   
> -	SAFE_FSTAT(cleanup, fd, &st);
> -	tst_resm(TINFO, "file size is '%li'", (long)st.st_size);
> +	tst_res(TINFO, "Testing creation and linking of single temp file");
> +	fds[0] = SAFE_OPEN(".", O_TMPFILE | O_RDWR, 0600);
> +	write_file(fds[0]);
> +	SAFE_FSTAT(fds[0], &st);
>   
>   	if (st.st_size != blocks_num * size) {
> -		tst_resm(TFAIL, "not expected size: '%li' != '%zu'",
> +		tst_res(TFAIL, "Unexpected test file size: %li != %zu",
>   			 (long)st.st_size, blocks_num * size);
> -		SAFE_CLOSE(cleanup, fd);
> -		return;
> +	} else {
> +		tst_res(TPASS, "Test file size is %li", (long)st.st_size);
>   	}
>   
> -	tst_resm(TINFO, "looking for the file in '.'");
> -	if (!tst_dir_is_empty(cleanup, ".", 1))
> -		tst_brkm(TFAIL, cleanup, "found a file, this is not expected");
> -	tst_resm(TINFO, "file not found, OK");
> +	if (!tst_dir_is_empty(".", 1))
> +		tst_res(TFAIL, "Test directory is not empty");
> +	else
> +		tst_res(TPASS, "Test directory is empty");
>   
> -	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> -	SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
> +	snprintf(path, PATH_MAX, "/proc/self/fd/%d", fds[0]);
> +	tst_res(TINFO, "Linking unnamed test file to 'tmpfile'");
> +	SAFE_LINKAT(AT_FDCWD, path, AT_FDCWD, "tmpfile", AT_SYMLINK_FOLLOW);
>   
> -	tst_resm(TINFO, "renaming '%s' -> 'tmpfile'", tmp);
> -	SAFE_LINKAT(cleanup, AT_FDCWD, path, AT_FDCWD, "tmpfile",
> -		    AT_SYMLINK_FOLLOW);
> -
> -	if (tst_dir_is_empty(cleanup, ".", 1))
> -		tst_brkm(TFAIL, cleanup, "file not found");
> +	if (tst_dir_is_empty(".", 1)) {
> +		tst_res(TFAIL, "Test directory is still empty");
> +		SAFE_CLOSE(fds[0]);
> +		return;
> +	}
>   
> -	SAFE_UNLINK(cleanup, "tmpfile");
> -	SAFE_CLOSE(cleanup, fd);
> +	if (access("tmpfile", F_OK)) {
> +		tst_res(TFAIL | TERRNO, "Linked test file not found");
> +		SAFE_CLOSE(fds[0]);
> +		return;
> +	}
>   
> -	tst_resm(TPASS, "single file tests passed");
> +	tst_res(TPASS, "Test file was linked correctly");
> +	SAFE_UNLINK("tmpfile");
> +	SAFE_CLOSE(fds[0]);
>   }
>   
> -static void read_file(int fd)
> +static int read_file(int fd)
>   {
>   	int i;
>   	char tmp[size];
>   
> -	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>   
>   	for (i = 0; i < blocks_num; ++i) {
> -		SAFE_READ(cleanup, 0, fd, tmp, size);
> -		if (memcmp(buf, tmp, size))
> -			tst_brkm(TFAIL, cleanup, "got unexepected data");
> +		SAFE_READ(0, fd, tmp, size);
> +
> +		if (memcmp(buf, tmp, size)) {
> +			tst_res(TFAIL, "got unexepected data");
> +			return 1;
> +		}
>   	}
> +
> +	return 0;
>   }
>   
>   static void test02(void)
>   {
> -	const int files_num = 100;
> -	int i, fd[files_num];
> +	int i, fails = 0;
>   	char path[PATH_MAX];
>   
> -	tst_resm(TINFO, "create files in multiple directories");
> -	for (i = 0; i < files_num; ++i) {
> +	tst_res(TINFO, "Testing temp files in multiple directories");
> +	for (i = 0; i < FILE_COUNT; ++i) {
>   		snprintf(path, PATH_MAX, "tst02_%d", i);
> -		SAFE_MKDIR(cleanup, path, 0700);
> -		SAFE_CHDIR(cleanup, path);
> -
> -		fd[i] = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR, 0600);
> +		SAFE_MKDIR(path, 0700);
> +		SAFE_CHDIR(path);
> +		fds[i] = SAFE_OPEN(".", O_TMPFILE | O_RDWR, 0600);
>   	}
>   
> -	tst_resm(TINFO, "removing test directories");
> -	for (i = files_num - 1; i >= 0; --i) {
> -		SAFE_CHDIR(cleanup, "..");
> +	tst_res(TINFO, "Removing test directories");
> +	for (i = FILE_COUNT - 1; i >= 0; --i) {
> +		SAFE_CHDIR("..");
>   		snprintf(path, PATH_MAX, "tst02_%d", i);
> -		SAFE_RMDIR(cleanup, path);
> +		SAFE_RMDIR(path);
>   	}
>   
> -	tst_resm(TINFO, "writing/reading temporary files");
> -	for (i = 0; i < files_num; ++i) {
> -		write_file(fd[i]);
> -		read_file(fd[i]);
> +	tst_res(TINFO, "Writing and reading temporary files");
> +	for (i = 0; i < FILE_COUNT; ++i) {
> +		write_file(fds[i]);
> +		fails += read_file(fds[i]);
>   	}
>   
> -	tst_resm(TINFO, "closing temporary files");
> -	for (i = 0; i < files_num; ++i)
> -		SAFE_CLOSE(cleanup, fd[i]);
> +	tst_res(TINFO, "Closing temporary files");
> +	for (i = 0; i < FILE_COUNT; ++i)
> +		SAFE_CLOSE(fds[i]);
>   
> -	tst_resm(TPASS, "multiple files tests passed");
> +	if (!fails)
> +		tst_res(TPASS, "Multiple files test passed");
>   }
>   
>   static void link_tmp_file(int fd)
>   {
>   	char path1[PATH_MAX], path2[PATH_MAX];
>   
> -	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
> -	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
> -
> -	SAFE_LINKAT(cleanup, AT_FDCWD, path1, AT_FDCWD, path2,
> -		    AT_SYMLINK_FOLLOW);
> +	snprintf(path1, PATH_MAX, "/proc/self/fd/%d", fd);
> +	snprintf(path2, PATH_MAX, "tmpfile_%d", fd);
> +	SAFE_LINKAT(AT_FDCWD, path1, AT_FDCWD, path2, AT_SYMLINK_FOLLOW);
>   }
>   
>   static void test03(void)
>   {
> -	const int files_num = 100;
>   	const mode_t test_perms[] = { 0, 07777, 001, 0755, 0644, 0440 };
>   
> -	int i, fd[files_num];
> +	int i, fails = 0;
>   	char path[PATH_MAX];
>   	struct stat st;
>   	mode_t mask = umask(0), perm;
>   
>   	umask(mask);
> +	tst_res(TINFO, "Testing linked temp files access mode");
>   
> -	tst_resm(TINFO, "create multiple directories, link files into them");
> -	tst_resm(TINFO, "and check file permissions");
> -	for (i = 0; i < files_num; ++i) {
> -
> +	for (i = 0; i < FILE_COUNT; ++i) {
>   		snprintf(path, PATH_MAX, "tst03_%d", i);
> -		SAFE_MKDIR(cleanup, path, 0700);
> -		SAFE_CHDIR(cleanup, path);
> +		SAFE_MKDIR(path, 0700);
> +		SAFE_CHDIR(path);
>   
>   		perm = test_perms[i % ARRAY_SIZE(test_perms)];
> -
> -		fd[i] = SAFE_OPEN(cleanup, ".", O_TMPFILE | O_RDWR, perm);
> -
> -		write_file(fd[i]);
> -		read_file(fd[i]);
> -
> -		link_tmp_file(fd[i]);
> -
> -		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> -
> -		SAFE_LSTAT(cleanup, path, &st);
> -
> -		mode_t exp_mode = perm & ~mask;
> -
> -		if ((st.st_mode & ~S_IFMT) != exp_mode) {
> -			tst_brkm(TFAIL, cleanup,
> -				"file mode read %o, but expected %o",
> -				st.st_mode & ~S_IFMT, exp_mode);
> +		fds[i] = SAFE_OPEN(".", O_TMPFILE | O_RDWR, perm);
> +		write_file(fds[i]);
> +		read_file(fds[i]);
> +		link_tmp_file(fds[i]);
> +
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fds[i]);
> +		SAFE_LSTAT(path, &st);
> +		perm &= ~mask;
> +
> +		if ((st.st_mode & ~S_IFMT) != perm) {
> +			tst_res(TFAIL, "Unexpected access mode: %04o != %04o",
> +				st.st_mode & ~S_IFMT, perm);
> +			fails++;
>   		}
>   	}
>   
> -	tst_resm(TINFO, "remove files, directories");
> -	for (i = files_num - 1; i >= 0; --i) {
> -		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
> -		SAFE_UNLINK(cleanup, path);
> -		SAFE_CLOSE(cleanup, fd[i]);
> +	if (!fails)
> +		tst_res(TPASS, "File access modes are correct");
> +
> +	tst_res(TINFO, "Removing files and directories");
>   
> -		SAFE_CHDIR(cleanup, "..");
> +	for (i = FILE_COUNT - 1; i >= 0; --i) {
> +		snprintf(path, PATH_MAX, "tmpfile_%d", fds[i]);
> +		SAFE_UNLINK(path);
> +		SAFE_CLOSE(fds[i]);
>   
> +		SAFE_CHDIR("..");
>   		snprintf(path, PATH_MAX, "tst03_%d", i);
> -		SAFE_RMDIR(cleanup, path);
> +		SAFE_RMDIR(path);
>   	}
> -
> -	tst_resm(TPASS, "file permission tests passed");
>   }
>   
> -int main(int ac, char *av[])
> +static void run(void)
>   {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	test01();
> +	test02();
> +	test03();
> +}
>   
> -	setup();
> +static void cleanup(void)
> +{
> +	int i;
>   
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -		test01();
> -		test02();
> -		test03();
> +	for (i = 0; i < FILE_COUNT; i++) {
> +		if (fds[i] >= 0)
> +			SAFE_CLOSE(fds[i]);
>   	}
>   
> -	cleanup();
> -	tst_exit();
> +	SAFE_CHDIR("..");
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1
We need .needs_root if we acquire a device.
> +};

The rest looks ok, but I'm wondering if we really need to call 
SAFE_CHDIR() so many times before SAFE_OPEN(".", ...) instead of passing 
the full path. We always obtain a file descriptor and in general we 
would like to reduce calls which are not 100% needed by the tests.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
