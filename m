Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB6C83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751967951; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XhBu93Op2dm1qYGExy8ksEVGpoDmOIjgKUw2UpZmQxE=;
 b=nwVewR5sClUFv+A2Y/MxA3kW6pkvw5gtR85c6d5HtM8afOkdNOXRlip6fZtAarIxWh31Y
 Dl+4DlkkoXTq+zBsRakskkYv2Cj89UPpqD6pJIqy0lsgV1dJsp+LwAUr/m1fRf53Uz6EWZb
 FN95wiWXsmiRlM3jx+aB5/7P5PIdbcs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 747643CA1ED
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:45:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25CB53C65DA
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:45:28 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49405122B323
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:45:27 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so1900558f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751967927; x=1752572727; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N97GeIyflEGoqAZvkX3UeIFKYzI6R8Eq0b/IFBOLgfM=;
 b=KPQ78+7Yzb8e5AYjnJIOrHuIWB/8jdJoyK/uq2aKaQj36xsX4ccGrINquixUSzVrpZ
 nGLwEGcmmPQeU9dHXUG8BHgj60iOLdfRMI60ktO1EFYmHysqkpBx0J7D/7BWm8iZhi2G
 phT9KZBLrrbnPCZCDG8Dj428GGn5HDfFm60KEqW4WWE3eYwghQ9N5IjwGzW07on1Tnyw
 FCGK+J6XEEPxJqWBRTqMAfRSDeJ7k4FxawxIHqrS6MY40GPaGZOkpcp3BwkQ0O2uutPR
 e0xQPMf0VsqPQEBeS0ol/+lNo8rbr+juk2HHcjKgYu3vQTFv2kXB4fHeL+D7xWIK+l/p
 Do7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751967927; x=1752572727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N97GeIyflEGoqAZvkX3UeIFKYzI6R8Eq0b/IFBOLgfM=;
 b=dMsoaL0UjKo21VOwqtomzPrrwRvARYxkxwq2RcgL125vr6teYujc9xBZSTa7LfLYNE
 wIUQH3kzfmUf+ljrEBFYHZzS3SnDxtM++oiivUuw+ZOswnA48lPNDpLLA71TeX6vnKVs
 BLbZiJXGdESunEfAbePBlqomDYX38j3EFhDgo2AzU8OKQvWPww6Yt8tdusnwAjecYLzU
 YWevlDvtQASIGQTi2vTAnMS2QR4jsAtuH9b9B9s6i819aDJ6EcmTzKM0CaPLqTZx6PrP
 9C+B7qMKfjF1dcRcXYekQPV7r5EfAOxERoK5H4udGMdjKHwMNNE7lLLSWXt2tiT5p3O4
 syVA==
X-Gm-Message-State: AOJu0YwXn5vrpg5mwgrjga7zFv0E48OxrzF3BFWT6gw2uPmwkxmw7hbD
 pSdCYUxac0QJh2rteIJJFTuPQn8axE+RqmclOhCUi18QSuenthmg+5az3qfWHPfcnkJbdEWg34j
 zOgQ=
X-Gm-Gg: ASbGnctdFhvUgJPmRQ7HZHVSJ/qPFUNs6T4wXHeGKmNNqcXW0Z0wtTDu53vu2NTx8ja
 OwpGw4DrZmCPi7Rqd7siMWGeNxGQKzTO5l4+hx4do3INMi724tN/pH6Txegr9+eVOuYggsSs8cZ
 oZESqUc6XpuVzqzwF3Xa1YOWfANjnHYG1VWSSGcqo8MbVcbhombuJJyGKhhGTN7m7OdBtPdgLIh
 ICTYjqVk/KZVjcMZRkhxmzZRkZss9oDb3H4j2KKveqvnY1e+BZWQWHalzkqcSJRvJN5z6zz4373
 9NfDEeHTEOenmkB4HBhrOfZYb9SZdyRy49CJ0VD+FvM4VUMKd7eHrja7RAuJQA==
X-Google-Smtp-Source: AGHT+IGvqYKjkUxxo3+4cF4zOD1NOKGv53jVMBdYPhU5winFNTjUP8g9RwfCZwvADGXdgKzMICDl7w==
X-Received: by 2002:a5d:64e1:0:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b5ddeb0bb6mr1685179f8f.59.1751967926570; 
 Tue, 08 Jul 2025 02:45:26 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce359eadcsm11742470b3a.10.2025.07.08.02.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 02:45:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:44:47 -0400
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <aG2RT7_tgYolFqMC@MiWiFi-CR6608-srv>
References: <20250708071706.19639-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250708071706.19639-1-yangtiezhu@loongson.cn>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit not implemented
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

On Tue, Jul 08, 2025 at 03:17:06PM +0800, Tiezhu Yang wrote:
> In the Linux kernel, LoongArch uses the generic syscall table which
> is defined in include/uapi/asm-generic/unistd.h, and also there is
> no __ARCH_WANT_SET_GET_RLIMIT in arch/loongarch/include/asm/unistd.h,
> so __NR_getrlimit is not implemented on LoongArch.
> 
> That is to say, getrlimit are superseded with prlimit64. There is no
> need to compare the return value and errno about the syscall numbers
> __NR_prlimit64 and __NR_getrlimit, just check this case and then skip
> the test.
> 
> Without this patch:
> 
> $ /opt/ltp/testcases/bin/getrlimit03
> ...
> getrlimit03.c:102: TFAIL: __NR_prlimit64(0) returned 0 (SUCCESS) but __NR_getrlimit(0) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(1) returned 0 (SUCCESS) but __NR_getrlimit(1) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(2) returned 0 (SUCCESS) but __NR_getrlimit(2) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(3) returned 0 (SUCCESS) but __NR_getrlimit(3) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(4) returned 0 (SUCCESS) but __NR_getrlimit(4) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(5) returned 0 (SUCCESS) but __NR_getrlimit(5) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(6) returned 0 (SUCCESS) but __NR_getrlimit(6) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(7) returned 0 (SUCCESS) but __NR_getrlimit(7) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(8) returned 0 (SUCCESS) but __NR_getrlimit(8) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(9) returned 0 (SUCCESS) but __NR_getrlimit(9) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(10) returned 0 (SUCCESS) but __NR_getrlimit(10) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(11) returned 0 (SUCCESS) but __NR_getrlimit(11) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(12) returned 0 (SUCCESS) but __NR_getrlimit(12) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(13) returned 0 (SUCCESS) but __NR_getrlimit(13) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(14) returned 0 (SUCCESS) but __NR_getrlimit(14) returned -1 (ENOSYS)
> getrlimit03.c:102: TFAIL: __NR_prlimit64(15) returned 0 (SUCCESS) but __NR_getrlimit(15) returned -1 (ENOSYS)
> 
> Summary:
> passed   0
> failed   16
> broken   0
> skipped  0
> warnings 0
> 
> With this patch:
> 
> $ /opt/ltp/testcases/bin/getrlimit03
> ...
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> getrlimit03.c:167: TCONF: __NR_getrlimit not implemented: ENOSYS (38)
> 
> Summary:
> passed   0
> failed   0
> broken   0
> skipped  16
> warnings 0
> 
> How to reproduce:
> 
> git clone https://github.com/linux-test-project/ltp.git
> cd ltp
> make autotools
> ./configure
> make all
> sudo make install
> /opt/ltp/testcases/bin/getrlimit03
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  testcases/kernel/syscalls/getrlimit/getrlimit03.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> index 604082ccf..2d79057da 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> @@ -162,6 +162,11 @@ static void run(unsigned int resource)
>  	errno = 0;
>  	ret_ul = getrlimit_ulong(resource, &rlim_ul);
>  	errno_ul = errno;
> +	if (errno_ul == ENOSYS) {
> +		tst_res(TCONF | TERRNO,
> +			"%s not implemented", __NR_getrlimit_ulong_str);
> +		return;
> +	}

Maybe following change can fix your issue since tst_syscall will
handle ENOSYS. You can have a try, thanks.

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 604082ccf..aad27a402 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -77,7 +77,7 @@ struct rlimit_ulong {

 static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
 {
-       return syscall(__NR_getrlimit_ulong, resource, rlim);
+       return tst_syscall(__NR_getrlimit_ulong, resource, rlim);
 }

 const long RLIM_INFINITY_L = LONG_MAX;
@@ -90,7 +90,7 @@ struct rlimit_long {

 static int getrlimit_long(int resource, struct rlimit_long *rlim)
 {
-       return syscall(__NR_getrlimit, resource, rlim);
+       return tst_syscall(__NR_getrlimit, resource, rlim);
 }
 #endif


>  
>  	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno_ul,
>  			   __NR_getrlimit_ulong_str) ||
> -- 
> 2.48.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
