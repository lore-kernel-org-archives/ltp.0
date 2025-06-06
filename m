Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B96C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749209535; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WuWwqmfbk1bY4+Ljn6TLvz2KVino2JORRohtFGu6YB4=;
 b=H/TfnBCy5C4Gy8NyvwIaya2uZsJfY9Xog9BI+yJsud5/ZI4Oz4k5ezTUw4k80pgHoT3Pf
 gJyotxqIWVTFtnn3Hz4MeeOpApnCQZU5w6Q0M6rt6ssGG9ChqUG+butFEb2foCgNQtkkAAv
 rLOExwBNTAAfu2lfmF+N66BkcCxhZqw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D34C3C9B4E
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:32:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3193C064C
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:31:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5714C600799
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:31:52 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so25694005e9.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749209511; x=1749814311; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+LhjK4e4O730DxjuA7DgNJPOHcGtUCxzkcjzqYm9zI=;
 b=OCyT2o12rh0kB8LyUs9q0tHLkB4cAUB1wIz3XedJPIXK0qhLL9ObC/VVmOUmorn1w8
 PX/eepVEAwI0U9YDAt22RV3YcReWWXKqu6/nAHpI74sfAKNG+mfRud4h8H7NaYxkcEBr
 y8PRtVdAnvX9063ox9ivOW9xBAaKjX2GiDHAIJ9kMVBBIf1bbXVvreD91Fme5rebW9jg
 wdlc9+r988Er8BQOxsAvANFjz4kDX/H0V8U3BTwuLTPNpgtaD8y7WF0UAjeLHn8IWSlv
 sqDzl4ULVCw4BI7qPLLdlZx+VxsCQEGSzOtK2S0yp2XH6jH80CJS+jZTYJJFk0vvFLtc
 UwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749209511; x=1749814311;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B+LhjK4e4O730DxjuA7DgNJPOHcGtUCxzkcjzqYm9zI=;
 b=RJpDKbG5Z6IJTeQVy8NlTVTrsh/mfDAxWZ+r4n3nNXh5DPaTwtgc6huJjw6JQnCEir
 1hTV9oYClE9E6AAQahh3cAQbc92IP3LWXZm3VHe56IB6XEf/mcDoud7fskN1atmkMxVN
 NBcZnHBBzVmDF4WiwFcfmPU+2efa2NPN3VxgfTWPVzl9sGznYfMxY/wzjKnyrrBKp45Z
 95UTlypVMYw4aM+CG3g4r9bL/lylB4GIOZ+fpl+yIvT83V6L3z4Q8QQ8e+WrcreIDFv+
 byA3w147tbqXE8AG7ujuGEf1Q4Xhm17SAsGci+67sD/eN5V+PwLTdRA60Gt4bYkiQgR3
 dYew==
X-Gm-Message-State: AOJu0Yw05TbTMWkffTeDX3LJVuYSXugdi9LxXmkTisBPhJ+NprDLqGhJ
 V02uEweGMI+pmhYGDZObAKJ3PZSZWb/j6/t6zxuu+Cwm4GqKr/GKxaAnxWwK0pCxglk=
X-Gm-Gg: ASbGncuyd27GfAvivX8bgp0Zw/Ox3NrTQxxmt5MSQApmj4y5PlD+I+w+1NB4G+vJ6fm
 wr20Ssjywy458q8aLKBXPT7ruR7QP0QGM0wZjDtKfWfsjelo2PUirK4Y/c4TG2HxRMV1lRDLnva
 F745CAYSop94blnrMGBhSc5uKv3DciK3BwKPDhwXPVPrC2NVyFzZPei59+6x52ATAaJmevnsfCe
 0Xy5dBlM2GneqjcQufofvPvcdLoSeWOrTNlq4+PRH5SPfrJ3WTQWhMkopcuZ9Cw68rSYw5qQVra
 ZSGIHm3Sded3JjwCWNgWYFBL4dZyDKL7BoRO6g==
X-Google-Smtp-Source: AGHT+IHH37p2G/ErWh264yaUQefYhoqO2zY8/bO+LAqCuwpuN4j+kgrItRnbyonIf9ARkKZwBlUW9A==
X-Received: by 2002:a05:6000:2f88:b0:3a4:dd63:4adf with SMTP id
 ffacd0b85a97d-3a5319a2f10mr2687365f8f.34.1749209511520; 
 Fri, 06 Jun 2025 04:31:51 -0700 (PDT)
Received: from localhost ([189.99.236.12]) by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-530e6427aefsm915892e0c.42.2025.06.06.04.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 04:31:51 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 06 Jun 2025 08:31:48 -0300
Message-Id: <DAFF0QSC0XFW.12UHYZ9YEBXPT@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-4-0b5cff90c21c@suse.com>
 <20250606112720.GC1289709@pevik>
In-Reply-To: <20250606112720.GC1289709@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/8] syscalls/mknod04: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri Jun 6, 2025 at 8:27 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
> ...
>> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
>
> Similarly, to what I noted to mknod03.c in v4:
> https://lore.kernel.org/ltp/20250605073231.GC1190804@pevik/

Exactly!

>
> Originally here was also S_IFIFO (used for both mkdir() and mknod()). Although
> the tests "works" IMHO we should use mknod() with S_IFIFO (and I believe it's
> not needed for mkdir().
>
>> -#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO
>
>> +#define MODE_RWX 0777
> But you omit it.
>
>> +#define MODE_SGID (S_ISGID | 0777)
> ...
>> -		/*
>> -		 * TEST CASE CONDITION:
>> -		 *  Attempt to create a filesystem node on a directory
>> -		 *  with group id (sgid) bit set such that,
>> -		 *  the node created by mknod(2) should not have group id
>> -		 *  (sgid) bit set and node's gid should be equal to the
>> -		 *  effective gid of the process.
>> -		 */
>> -		TEST(mknod(node_name, MODE_RWX, 0));
>> +	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
>
> I vote for following diff (no need to repost).

Thanks!

>
> Kind regards,
> Petr
>
> +++ testcases/kernel/syscalls/mknod/mknod04.c
> @@ -17,6 +17,7 @@
>  #include "tst_test.h"
>  
>  #define MODE_RWX 0777
> +#define MODE_FIFO (S_IFIFO | 0777)
>  #define MODE_SGID (S_ISGID | 0777)
>  
>  #define TEMP_DIR "testdir"
> @@ -29,7 +30,7 @@ static void run(void)
>  {
>  	struct stat buf;
>  
> -	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
> +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO, 0);
>  
>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, 0);

Can you please also apply this one:

diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index 4b7e9577266e..34611b57ee92 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -18,6 +18,7 @@
 
 #define MODE_RWX 0777
 #define MODE_SGID (S_ISGID | 0777)
+#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)
 
 #define TEMP_DIR "testdir"
 #define TEMP_NODE TEMP_DIR "/testnode"
@@ -29,7 +30,7 @@ static void run(void)
 {
 	struct stat buf;
 
-	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
+	SAFE_MKNOD(TEMP_NODE, MODE_FIFO_SGID, 0);
 
 	SAFE_STAT(TEMP_NODE, &buf);
 	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, S_ISGID);

Thanks a lot,
RBM

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
