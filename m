Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFD0C982FE
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:30:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAF183E6CEE
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:30:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 706333E1D81
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:29:52 +0200 (CEST)
Received: from mail-pz2-x09.google.com (mail-pz2-x09.google.com
 [IPv6:2607:f8b0:4864:3b::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E78841400512
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:29:51 +0200 (CEST)
Received: by mail-pz2-x09.google.com with SMTP id
 41be03b00d2f7-cc51509689fso1338289a12.1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790087390; x=1790692190; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pI8XhrVKGqoSGzUd9OPbfxlLA8wdS7+2UUj+Eipon0o=;
 b=WXiyS6rE6RviucIldKzXoUHUWQW8qIo6Y/vguJBGjesYqIMs5fA2+LCYmqWt2LzoUM
 vRsfvLfzNWZ9b5JNkPTFyMJRGhmHK2lwLcEdMmUee+uB84rW9usKrGKdKw8Mutrm9vJm
 oubq/e/zyxSkMUJyyQTUcXa8/OO0NYjWpYG7oHKKt/SvQJjsWV0NxEgfM+abOSbraF3u
 3OBw4lb9cmjLlEYVXYRJZN8goACZv5I6l3PtEaPXV9qMjZsjx7iI9sn3tpTZbfEA+Bt3
 TWyocy4E7o+IP96HT52WCFf7J7ar6/E89ANHnzgmHSKDUIrzf+wCpzZ48wG8DhL/Yvmb
 xX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087390; x=1790692190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pI8XhrVKGqoSGzUd9OPbfxlLA8wdS7+2UUj+Eipon0o=;
 b=Ob7BdYi2om73MpaVsQLjdfOEfKaTD12/rdbQuqNyA/RlQwCerb+B2CTqurqsH/TPYv
 qwBbbG2yejS1/vKVpiNncCLU43mUE0rgVNJtoCmA2+ZdPrgRtIJMvpBnal+dElYL/Msg
 sieFmH5cpXH7YSmCLwyrLe2K2EF8nL4wdve3pUzFWC1w8OiJlhfaUgHkxAqtEYfZlvxF
 sgmoltjSZaYCeBZNdcTMt8UtAz6lN5Vxr7uUxfsTmhObJNWjIWrT6vRw+qjeLI7zXjCX
 4N25FQLYRKt/vZ6iBIYQ4L1hdGLoLIeZ14T2uKiFf7wrs4DbyBvHxKMAE1Ax3+KmKLlE
 kIpQ==
X-Gm-Message-State: AFuF++kYlrz3XB/4zn7rqV1mOScLVUOvS5sb93R4zUjnSh6thsHUAqRL
 bdIvP+t2zstsKqt4z68qG59qE4QT1eQNSkK+bZ6cvjxSW6RH1mmCR7B1
X-Gm-Gg: AYBFou2W+FaEq3nyYiBQDrebKNi/Ty6YU8dfbMwBSJDFRiZIycXSJ8d6OJRXJ9faZSy
 307mS0no012OOfhJPEdx06NhA+SPqQhM+rdwxnGi5QrisbcnDpb/QyQSUi8TwJtS8ttVtbTVoK1
 9BVApTEmzOb2+HWVIG4RFYvR51YI1qspvmSVp5P0hMxzJ00T/UZwMblJUNdTLOHs7dd7N0NYBiz
 C50Z6YD+TeY04r+YySUOgmD/5hoNMnzy6+xwOZmkrMs+LKDIjZrwSdGmJ2gu3hmS75hlHiSlFrb
 qmqBqAFiZ2+zpKQANuuk6+Ti8Kks1NBwpAD5ZY0Pykih8OP+mcfrstBPwO2WXsq+On7xJGv2G5o
 MhBIMhXRnphgytpyHJB1Sijn+abH6TOtZ8/sx92RoiF7sJUTK7E0uja3sZZQ1dV2jey1kNosbmB
 SBOZBku4gV0PqNwNl3jckAEMli8xkFkL3/s6GTE0CJbs2/x+zmK8RnNHrWpHDI5PVsOfrScgXl/
 CfFa8S0dcfXyJrrObgxxWxzR40rWae0FT0WqHcWQCjPS1QZUSaBDQvbD2hrE9b5ZXo2CccoV3o7
 AGYIVFBl
X-Received: by 2002:a05:6a20:d70f:b0:3dd:a008:dc40 with SMTP id
 adf61e73a8af0-3ddec7aef34mr2001762637.46.1790087389997; 
 Tue, 22 Sep 2026 07:29:49 -0700 (PDT)
Received: from
 runnervmlun5p.bt05ewgluiaerd5fsj3vbem1cg.xx.internal.cloudapp.net
 ([4.155.5.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756a18ddbsm1096146a12.7.2026.09.22.07.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:29:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Sep 2026 14:29:48 +0000
Message-ID: <20260922142948.9014-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922095126.2169599-1-pvorel@suse.cz>
References: <20260922095126.2169599-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] keyctl: Vendor struct keyctl_dh_params
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

Hi Petr,

On Tue Sep 22 11:51:25 2026 +0200, Petr Vorel wrote:
> keyctl: Vendor struct keyctl_dh_params

--- [PATCH 2/2] ---

> autotools: Move into configure.ac

The commit subject is missing the object of the move. Specify what is being
moved into configure.ac (e.g. "autotools: Move keyctl struct checks into
configure.ac").

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
