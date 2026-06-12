Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B1FCD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781255199; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=G1+FNQEOHs8y/1gDhIKo1yTJ6iw5RUTDxIX2dddy/Ng=;
 b=hAf5eVOQyO/WAG7J6D7Tq/PEX0C4wxJ4t4phiZs8h1DeX/Dr9rz8TFGqxtb7Gb3Fvgmcu
 o5v9vKVCjG4U2CpNdj+7dHA0xlPSxtg5Sz83SZYv4yvz+eFmuNgMiddCym7YWuLJN7evsmc
 XXUVsZ6Juf0QW9i3t1Fbw08/b49TNEk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 954103C72E7
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:06:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABBF3C0528
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:06:20 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E3BD460062C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:06:19 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so459137f8f.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781255179; x=1781859979; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4S6XJYLYVpdnVYq8Qex3ccj/IQurzi6B7cEMHjTkhAQ=;
 b=ZOvUgzPEUijxFP7YbFfP7/XVLqEAtFP3EMo5yaE0WqE884NNQRJkWVDxfS+gRZkLWQ
 zNqDJtIYups/U5NxK0mGT/cr+GS5wNHtHOP+sYO3pVSRcdXW/Lb6oquZ42YjWZKy0W0T
 09Hmdgwn00TKuQWCJYN9YmgrxXMupplZw//SmnCTgvZAZkCycYtXLXfWunpYHst4qWxq
 GbIZ9wx7nCXSmpmIHWAcsI1XxkEd4pTAXYpCLFQBxg1VODU9lVkjmxP+ex4ZtNrPqu10
 Vi6qmnTVyFXgWQWkiRBzUWf7FcHnfnW5ZBfVkk6bCnfCkZlAmqQOND4deQe84TO5vNSG
 6K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255179; x=1781859979;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S6XJYLYVpdnVYq8Qex3ccj/IQurzi6B7cEMHjTkhAQ=;
 b=rxMPcgHb1ujievNIi7Fgsk6JhAXB39Ds0+jP2LmdZTA2DFyp3BW3iwRBRTOwV7El/+
 7GVfCOryKwnq/TqDk+bZRgnvFBgDcFl/ztnO9RQYiYNF1hMbTKFd9zB2gKXqerh4fog4
 T/0ZJ69nZiVSzG4/QW0b4Y9soT8GKBQlkQrEXc9o72wUhJarYZynPHL3l5R4aCkO3jHs
 KyAc5p704xWz9AN8afAROcVKSLdfGhw7QVXrx6br24Fby5DvB4z3pJ4jJ3gKxXzRg6Gj
 RRrlAVKVd9/gxBNuPB0lW6J/QQqiewgfULKug6alwalgpo56jxYRNftNuJkRJZde5BYl
 T0sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Gp+yL3YDm1bsNaWQRIdE5iePjzxdH0WfInaXbaX+K7RbL6kunQLcHTSW9cPnq4WmuGy0=@lists.linux.it
X-Gm-Message-State: AOJu0Yyk5U00HAMEfBzkMU6Hkj5D5XiEWHOSYudOdyqqFmxg1fnKjS3Q
 ULOdOAAPB2DefHdHB9YrqlZG1c1IQugkE4wM8yKfn41rtlZnRWtpObWDtJj17B8FmgY=
X-Gm-Gg: Acq92OHqLdl1PM+yzZVDu4RrZZDyfhfE4g9909qYEzRqjccZgBm4nvx/YGkOOIn5fjr
 yOzqMGDyTGcF8R6e9cS07C8AIyb+XWjx5q8jGMXFQivlVtWieLH/30h6xOjs79yPALbwzlIENc3
 JgMc12mYer+DwGIkeOE7J0QX6uJDMK+nOgsJ1G3atq1QDEonGL6AY8Zdu3BHyNGM+ldAWrpJL/p
 TzXOdc5BwIRvoMpTE2I75dzWYy8cBFC+6BvarRuJ+Cy9KMN9yMt4xhUfYE9woPCNfQ2eZKLbzKA
 15ug/X9ydDm8gU2f01RtehyfHOZv2TkFOoIuJdD+B/VHp7VAld2U5JJtl+LHNWxHmpp32ieGQXT
 WdlYJPvZ5Y69rI12ZzMtXsORo55t5ES4FOUveTy2Q1gCv/ipMZa9JfNR+VlHWYRtd3dfvwZCarn
 eMJ7J+tg+OGrQtg3UvQLWOuh1ilbr/4dihxylUWVIk1q/9hTGGa3l3w2/yCOEvdWIREIs40msOI
 zSzmySCN60ly54F449+ihWSEWxIZh9Gct3uSVkyGoFjMtRAjfiAoNBqTRTWNNjWP2hiVcUdF3rk
 Eg==
X-Received: by 2002:a05:6000:220d:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-4606da665e6mr2829656f8f.10.1781255179134; 
 Fri, 12 Jun 2026 02:06:19 -0700 (PDT)
Received: from p200300ef2f13eb00017f7d76deb7e8bb.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm4098387f8f.35.2026.06.12.02.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:06:18 -0700 (PDT)
Message-ID: <6a2bcc0a.bb4da8e5.d8214.30fe@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <aiggi35F7Iz0dMPN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Fri, 12 Jun 2026 09:06:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

maybe I reproduced it, but it would be nice to have the test output
as well. Also Kernel 7.1 is still in RC stage, so this patch must
wait kernel release before being considered valid.

The next time please add more information to the commit, so we know
exactly what kernel version is having issues, as well as the arch
and distro.


Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
