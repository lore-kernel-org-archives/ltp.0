Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B29CFD8765
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773752438; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0XDMJEdQTV3UWL6RG4689y2swBJtD6Kx83gG3nfJN6M=;
 b=fi+hgXgfy6UgcuIRnBoCJyflLqrn7vCX75WO0ZMufnle+TEeegnY43ahwy/tAjWx6tX/q
 YQL1KvDfQPkwI2AZn5d9v/biDkXn6kJnFBbQLwGE1Xth1LKl721+ZKSckQDF/zQQqlRdFEV
 4dSb6LLsMzjKl+AWjFL45glF7+ubVpE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7AEB3E485F
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 14:00:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992A63CC09C
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 14:00:13 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E317F1400B97
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 14:00:12 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so2221501f8f.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773752412; x=1774357212; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eJtLDTZ8MpIbpd+m+W6dvzF5yUeoRATMcp/VOo6lywE=;
 b=UC7Wr4RUt22QP2C4So8YRdV9xVIfKZYq77LxuZ4/P/lcjapw4/schuSeCCIqRDo1hP
 jqY0i4sxY8jd/Uqp93cQL1sw7G7BaWLr5J7IYVnvsjRzEpP7Xo7xsKNgXBDuhuHrzvNn
 pavaOJ5Ck7TzQMsb65pJjPMUYJfzG2/7Yv0S1XOB+lyDnOnTL4P7DgitIkXEgBquajt1
 YG8K8NoUlJspiMpyUzbM5SVbJ86e0boQFsz82VIfpF1pbrNfmi+4c5HMzGQtE06IKOjX
 pMh65t7AVmwN9JkjZrtRRwmGIt33LpKuIG1XrT+uevd5V5a5fiZdGxPxRfptf1rKg5aQ
 AwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773752412; x=1774357212;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJtLDTZ8MpIbpd+m+W6dvzF5yUeoRATMcp/VOo6lywE=;
 b=AURqWFRXkfM3TQulp0oeFH+MLoyhD2Sk9sF41/DQ28Ih1gyhseOR8QUKhPib4Igh0S
 8BqnT0tZi2oXINz393GP5Jho+iC74VNZcb2mdfq6v5bQZxfLNJwel8X0nBPAsiy9x+PP
 Sqh0F8L2b5KyN9QYKi7122ERZ2T8QGebInOOtafLlZIsERlxGEYBfPoFnODFtMlU0XAq
 FF35tHcZ+vjv7utC3/lcdILrc7af22d5gO2pPujLad/ZXnz29ycWjuhHWoHw02rZuPVP
 7LqmL5/6Ag4x/s803T/AZn05DrMwCTgCI1R4jfk/BCPwfZSKktyuZ4Qw8hWVAeqh4omT
 EprQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuGt8SoiL8WCwCRYgkJrfbj6yyNMomVLMo5DQR9ZViH1gfO0afGdlxrLfFf606dqdPYuI=@lists.linux.it
X-Gm-Message-State: AOJu0YyOOVUdi5yxyflyZnVFI8TUdlnZJfXgcy3enc3Bmjc1gy7Ln4Wt
 wRozjdEg62ZbdYOqFrCobz8YxCAk7aR/dWfZIth98TI0Qw0wbHrdYX/3fQ6qE6s3AHHQpNpy0wL
 98YRF3dk=
X-Gm-Gg: ATEYQzxHaP+6qia5fRO57irsgpc3Us393zhfJOKowOfulv8niTZFp2umn1u7JnILYAF
 JXfWDJG0tg7hifgsOqIOlD8HrkU46QJHXhhQ2gClCra2olhl8rvkDFfZu5zppKFFnMN75fTAECQ
 wm/o3RW0Db586uNx2pIK7CokwYPqWt5XIycxse4oXG8OQ3fuLX1xffsWFG67FvxwVenFYDDGK/W
 8ZUyPK/qcCnSpKZ7rQy220NhDePsY/hhon1dFh+78kMDlqTCsTxL9ArScEpZSsj5M2YJTACssx8
 yuCcmhsZryNU2yzmfhzGI1mr8LaaDhwJ0++hLm/CGSePaueLmZMPJYMWUXqtLDfyGiuQcdVPF6n
 Dsdy7zi5mYq6x1plocNcYhND3ZTQoQcqYQkyxveYgDj5f0q+OYEf/jKhWrgR8Nqb4zgqnt6j8KK
 xX1FEWGTaInzGdWRNKDMuMhpTW9M1SAphn63fZRK4=
X-Received: by 2002:a05:6000:290c:b0:43b:45d1:f449 with SMTP id
 ffacd0b85a97d-43b45d1f6d2mr12479319f8f.51.1773752412090; 
 Tue, 17 Mar 2026 06:00:12 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bb90sm53182737f8f.19.2026.03.17.06.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:00:11 -0700 (PDT)
Message-ID: <69b9505b.050a0220.133478.afd0@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260316122725.122719-3-japo@linux.ibm.com>
Date: Tue, 17 Mar 2026 13:00:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Sorry for jumping in a bit late, but...

> +static bool socket_xattr_supported;
> +
>  struct test_case {
>  	char *key;
> @@ -57,7 +60,16 @@ struct test_case {
>  	int flags;
>  	int exp_err;
>  	int needskeyset;
> +	void (*fix_errno)(struct test_case *tc);

Honestly I would have preferred a bool flag here instead of a function.
The code would have been more readable as:

static void verify_setxattr(unsigned int i)
{
..
    if (tc[i].check_xattr && socket_xattr_supported)
        tc->exp_err = 0;
..
}

And only 1 testcase would have been touched with `.check_xattr = 1`.

Also, please, always run `make check` before sending the patch. There are a
couple of issues to fix in the test description.

Same for the other patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
