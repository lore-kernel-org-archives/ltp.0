Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51FBE77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736429768; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=XaNrHcLmIuXvrw1a0Uj+PMAK2yd0TcZM65WNIT9+MCE=;
 b=GTUWxE+HpiIs+w+nxQg1sOfuK+FCzNAzIHcSqt9EN+dn7/ghKyiekSvGmmchVohE0oYR/
 chenGrq2uj7cUvQ4rLSFx6/mo+CTdk18Q37tmd2XJGVRfjOVWS47ubszm9nwN+6IzZ9neie
 hd6ibfdnmuGekZLdNh0Sv4IkkjpCvp4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02AB83C215A
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:36:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89D3C3C1D33
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:35:47 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4509F2239D5
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:35:46 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so1347495f8f.0
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 05:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736429745; x=1737034545; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SA5Y3xtAVBrwFl1pS64nLysSFoasboFO6QXBBLP861w=;
 b=eZZSBMhvYRNzTWwYyy8WaFFP95BD12k13Si8pn5M6JGlhAfyhb3PQxpQ07/wRzy/qR
 0K3NxjdjPv9hFFcuUxWhqpYOABoQcy8mxipNzDeONWAMJ3g/m0lWMNc9XDVMROuHzEz1
 00eJnwZvFa2+e9l5A9OeH5D6RzDxe8B6AGdSCjQiv6CwLJTihv6zVgq4Bjf1eyF1dst/
 nHaWtDExeEj8fkkL3/slQuMgvFbWVj3TloGXDnAE4B0N/g4WUbaz3U6GCW7/lxDji5rx
 UEy+km1DY3WSgEMxSqCa0BscQXHj6VmHjWIw280ubn/SdQtNR5+uLBQmJfBKzyKGrvPY
 th+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736429745; x=1737034545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SA5Y3xtAVBrwFl1pS64nLysSFoasboFO6QXBBLP861w=;
 b=iyIJPPdsdNotR6c0kPK8J/dsUPj+WytP76jro5f1C8HF8aI51ngqCBv1pyhXB8PS2X
 JicnbSm/SW89idb1Zamsaw01yp60R7AZEWJwRc3EwXtYeMWiK2pEyhASn4q2k0E9zuUJ
 frgX8fvAs6gF+4BN2F5khKhpJc/VlLumPw7i60aRWwsuCiyBCDmr341UDhoU4NS948Bq
 U5esSHhNFDni+kpPqTYqwfI5C8sU2bcZKl8HMv2eezU2a+Gnhxg2KCBmAqKLE4kIplMD
 UO5ATvIx5Kw5P3sgxyzBb6Lv2JwbR/DX05YCKVZsW6c7+ETurreoOjvxCUx8hxH7FQea
 WJfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTJUmpdXkvbLtn6gFgxRKEKfibcsuuzcE3PXRD+S+Yz7b4ooCX7BqTPFbLcKKDSz9SE70=@lists.linux.it
X-Gm-Message-State: AOJu0YxTN+XuJLw6OTCDzvNF95KV2RHiJbnsZM/EsLTP5xKivF47hvXf
 F2Y0vTLHfj/2nxZe1QGewcNg32IbOV4jatw5QbVb/IujhvDhF+IYuHLXLnIzLy560lFqJsz9i2s
 n2jU=
X-Gm-Gg: ASbGncvcK9iPbyRznIYzj/TPJhyzZ+QAmVxCD8QNyOstGX1uSFnakRvj8/IFeCXgvlT
 DTsyUMVoYS1Gkhm/8jnZ0Zib/CKy0cbHe3dlhvk+FQGJ3XLgZXlWzxMyTIns2NBq9nUPaUytfwn
 vp/J7jWlZ9VZkUWSpHEYXP+92TjWc8U5Zb6sRRLN9g/96oVeNA9cH2mw0F10SOULbsKmSHqJdaB
 GUoD+6Hx2kWnKV97JIzMtPj8X3OpFv2UyaYo+mjjhP3zVTF25RPoURnQwF4o/251jY=
X-Google-Smtp-Source: AGHT+IGzENnTH92wBBLmAZNdYPmbjr6g9PCBBVl3La2b3IPzU0HEZPPsa1dhqiiXWpHQz796fHKYdQ==
X-Received: by 2002:a05:6000:2a1:b0:38a:8f77:52 with SMTP id
 ffacd0b85a97d-38a8f7704d8mr2264620f8f.30.1736429745390; 
 Thu, 09 Jan 2025 05:35:45 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c990sm1871474f8f.56.2025.01.09.05.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 05:35:45 -0800 (PST)
Message-ID: <a8437881-a652-4847-9907-41922126bece@suse.com>
Date: Thu, 9 Jan 2025 14:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250109132334.212281-1-pvorel@suse.cz>
 <20250109132334.212281-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250109132334.212281-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] macros: Add basic docs
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

Hi Petr,

thanks for this documentation. It's really needed.

On 1/9/25 14:23, Petr Vorel wrote:
> Describe all "public" macros.
> Move variables to the top.
> Add header to the sphinx doc.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> * I also wanted to document extern variables, but I haven't found a proper
>    syntax.
>
> * TPASS/TFAIL cross reference is a bit verbose. I'd like to have some
>    helper for it, but creating extension is overkill.
>
> extern long TST_RET;
> extern void *TST_RET_PTR;
> extern int TST_ERR;
> extern int TST_PASS;
>
>
>   doc/developers/api_c_tests.rst |   1 +
>   include/tst_test_macros.h      | 257 ++++++++++++++++++++++++++++++++-
>   2 files changed, 251 insertions(+), 7 deletions(-)
>
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index 46f5d3360b..515d843c00 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -11,6 +11,7 @@ Core LTP API
>   ------------
>   .. kernel-doc:: ../../include/tst_res_flags.h
>   .. kernel-doc:: ../../include/tst_test.h
> +.. kernel-doc:: ../../include/tst_test_macros.h
>   
>   Capabilities
>   ------------
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index b2b446b70c..2e8d88b1b7 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -1,7 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2015-2024 Cyril Hrubis <chrubis@suse.cz>
> - * Copyright (c) Linux Test Project, 2021-2022
> + * Copyright (c) Linux Test Project, 2021-2024
> + */
> +
> +/**
> + * DOC: tst_test_macros.h -- helpers for testing syscalls
>    */
Is this really needed?
>   
>   #ifndef TST_TEST_MACROS_H__
> @@ -9,6 +13,18 @@
>   
>   #include <stdbool.h>
>   
> +extern long TST_RET;
> +extern void *TST_RET_PTR;
> +extern int TST_ERR;
> +extern int TST_PASS;
> +
> +/**
> + * TEST() - Test syscall which return long (most of syscalls).
> + *
> + * @SCALL: Tested syscall.
> + *
> + * Sets TST_RET and TST_ERR.
> + */
>   #define TEST(SCALL) \
>   	do { \
>   		errno = 0; \
> @@ -16,12 +32,13 @@
>   		TST_ERR = errno; \
>   	} while (0)
>   
> -extern long TST_RET;
> -extern int TST_ERR;
> -extern int TST_PASS;
> -
> -extern void *TST_RET_PTR;
> -
> +/**
> + * TESTPTR() - Test syscall which returns void pointer.
> + *
> + * @SCALL: Tested syscall.
> + *
> + * Sets TST_RET_PTR and TST_ERR.
> + */
>   #define TESTPTR(SCALL) \
>   	do { \
>   		errno = 0; \
> @@ -74,6 +91,12 @@ extern void *TST_RET_PTR;
>   		TST_RET;                                                       \
>   	})
>   
> +/**
> + * TST_EXP_POSITIVE() - Test syscall, expect return value >= 0.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_POSITIVE(SCALL, ...)                                           \
>   	({                                                                     \
>   		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
> @@ -86,8 +109,22 @@ extern void *TST_RET_PTR;
>   		TST_RET;                                                       \
>   	})
>   
> +/**
> + * TST_EXP_FD_SILENT() - Test syscall to return a file descriptor, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_FD() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
>   
> +/**
> + * TST_EXP_FD() - Test syscall to return a file descriptor.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_FD(SCALL, ...)                                                 \
>   	({                                                                     \
>   		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
> @@ -99,6 +136,18 @@ extern void *TST_RET_PTR;
>   		TST_RET;                                                       \
>   	})
>   
> +/**
> + * TST_EXP_FD_OR_FAIL() - Test syscall to return file descriptor or fail with
> + * expected errno.
> + *
> + * @SCALL: Tested syscall.
> + * @ERRNO: Expected errno or 0.
> + * @...: A printf-like parameters.
> + *
> + * Expect a file descriptor if errno is 0 otherwise fail with expected errno.
> + *
> + * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
> + */
>   #define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
>   	({                                                                     \
>   		if (ERRNO)                                                     \
> @@ -109,8 +158,22 @@ extern void *TST_RET_PTR;
>   		TST_RET;                                                       \
>   	})
>   
> +/**
> + * TST_EXP_PID_SILENT() - Test syscall to return PID, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_PID() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
>   
> +/**
> + * TST_EXP_PID() - Test syscall to return PID.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_PID(SCALL, ...)                                                \
>   	({                                                                     \
>   		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
> @@ -138,8 +201,24 @@ extern void *TST_RET_PTR;
>   		                                                               \
>   	} while (0)
>   
> +/**
> + * TST_EXP_VAL_SILENT() - Test syscall to return specified value, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @VAL: Expected return value.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_VAL() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
>   
> +/**
> + * TST_EXP_VAL() - Test syscall to return specified value.
> + *
> + * @SCALL: Tested syscall.
> + * @VAL: Expected return value.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_VAL(SCALL, VAL, ...)                                           \
>   	do {                                                                   \
>   		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
> @@ -171,8 +250,22 @@ extern void *TST_RET_PTR;
>                                                                                  \
>   	} while (0)
>   
> +/**
> + * TST_EXP_PASS_SILENT() - Test syscall to return 0, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_PASS() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
>   
> +/**
> + * TST_EXP_PASS() - Test syscall to return 0.
> + *
> + * @SCALL: Tested syscall.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_PASS(SCALL, ...)                                               \
>   	do {                                                                   \
>   		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
> @@ -263,6 +356,15 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL() - Test syscall to fail with expected errno.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * For syscalls which valid return value is 0.
> + */
>   #define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -270,6 +372,14 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>                                     ##__VA_ARGS__);                              \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL_ARR() - Test syscall to fail with expected errnos.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERRS: Array of expected errnos.
> + * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                   \
>   		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
>   				  EXP_ERRS_CNT, ##__VA_ARGS__);
> @@ -286,6 +396,15 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
>   		                  EXP_ERRS_CNT, ##__VA_ARGS__);
>   
> +/**
> + * TST_EXP_FAIL_PTR_NULL() - Test syscall to fail with expected errno and return a NULL pointer.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * Unlike most of macros it sets TST_RET_PTR instead of TST_RET.
> + */
>   #define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                          \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -293,12 +412,31 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL_PTR_NULL_ARR() - Test syscall to fail with expected errnos and return a NULL pointer.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERRS: Array of expected errnos.
> + * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
> + * @...: A printf-like parameters.
> + *
> + * Unlike most of macros it sets TST_RET_PTR instead of TST_RET.
> + */
>   #define TST_EXP_FAIL_PTR_NULL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
>   	do {                                                                   \
>   		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
>   			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL_PTR_VOID() - Test syscall to fail with expected errno and return a void pointer.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * Unlike most of macros it sets TST_RET_PTR instead of TST_RET.
> + */
>   #define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                         \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -306,12 +444,31 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL_PTR_VOID_ARR() - Test syscall to fail with expected errnos and return a void pointer.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERRS: Array of expected errnos.
> + * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
> + * @...: A printf-like parameters.
> + *
> + * Unlike most of macros it sets TST_RET_PTR instead of TST_RET.
> + */
>   #define TST_EXP_FAIL_PTR_VOID_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
>   	do {                                                                   \
>   		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
>   			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL2() - Test syscall to fail with expected errno.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * For syscalls which valid return value is >= 0.
> + */
>   #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -319,6 +476,15 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>                                     ##__VA_ARGS__);                              \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL_SILENT() - Test syscall to fail with expected errno, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_FAIL() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_FAIL_SILENT(SCALL, EXP_ERR, ...)                               \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -326,6 +492,15 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
>   	} while (0)
>   
> +/**
> + * TST_EXP_FAIL2_SILENT() - Test syscall to fail with expected errno, silent variant.
> + *
> + * @SCALL: Tested syscall.
> + * @EXP_ERR: Expected errno.
> + * @...: A printf-like parameters.
> + *
> + * Unlike TST_EXP_FAIL2() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_FAIL2_SILENT(SCALL, EXP_ERR, ...)                              \
>   	do {                                                                   \
>   		int tst_exp_err__ = EXP_ERR;                                   \
> @@ -333,6 +508,12 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
>   	} while (0)
>   
> +/**
> + * TST_EXP_EXPR() - Check for expected expression.
> + *
> + * @EXPR: Expression to be tested.
> + * @...: A printf-like parameters.
> + */
>   #define TST_EXP_EXPR(EXPR, ...)                                              \
>          tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
>                   TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
> @@ -352,6 +533,12 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   	}                                                                      \
>   } while (0)
>   
> +/**
> + * TST_EXP_EQ_LI() - Compare two long long values.
> + *
> + * @VAL_A: long long value A.
> + * @VAL_B: long long value B.
> + */
>   #define TST_EXP_EQ_LI(VAL_A, VAL_B) do {                                       \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli");   \
>   								               \
> @@ -362,9 +549,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   	}                                                                      \
>   } while (0)
>   
> +/**
> + * TST_EXP_EQ_LI_SILENT() - Compare two long long values, silent variant.
> + *
> + * @VAL_A: long long value A.
> + * @VAL_B: long long value B.
> + *
> + * Unlike TST_EXP_EQ_LI() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_EQ_LI_SILENT(VAL_A, VAL_B) \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
>   
> +/**
> + * TST_EXP_EQ_LU() - Compare two unsigned long long values.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + */
>   #define TST_EXP_EQ_LU(VAL_A, VAL_B) do {                                       \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
>   								               \
> @@ -375,9 +576,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   	}                                                                      \
>   } while (0)
>   
> +/**
> + * TST_EXP_EQ_LU_SILENT() - Compare two unsigned long long values, silent variant.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + *
> + * Unlike TST_EXP_EQ_LU() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_EQ_LU_SILENT(VAL_A, VAL_B) \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
>   
> +/**
> + * TST_EXP_EQ_SZ() - Compare two unsigned size_t values.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + */
>   #define TST_EXP_EQ_SZ(VAL_A, VAL_B) do {                                       \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu");       \
>   								               \
> @@ -388,9 +603,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   	}                                                                      \
>   } while (0)
>   
> +/**
> + * TST_EXP_EQ_SZ_SILENT() - Compare two unsigned size_t values, silent variant.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + *
> + * Unlike TST_EXP_EQ_SZ() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_EQ_SZ_SILENT(VAL_A, VAL_B) \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
>   
> +/**
> + * TST_EXP_EQ_SSZ() - Compare two unsigned ssize_t values.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + */
>   #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) do {                                      \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zi");       \
>   								               \
> @@ -401,9 +630,23 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   	}                                                                      \
>   } while (0)
>   
> +/**
> + * TST_EXP_EQ_SSZ_SILENT() - Compare two unsigned ssize_t values, silent variant.
> + *
> + * @VAL_A: unsigned long long value A.
> + * @VAL_B: unsigned long long value B.
> + *
> + * Unlike TST_EXP_EQ_SSZ() does not print :c:enum:`TPASS <tst_res_flags>` on success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
> + */
>   #define TST_EXP_EQ_SSZ_SILENT(VAL_A, VAL_B) \
>   	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
>   
> +/**
> + * TST_EXP_EQ_STR() - Compare two strings.
> + *
> + * @STR_A: string to compare.
> + * @STR_B: string to compare.
> + */
>   #define TST_EXP_EQ_STR(STR_A, STR_B) do {                                      \
>   	TST_PASS = strcmp(STR_A, STR_B) == 0;                                  \
>                                                                                  \

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
