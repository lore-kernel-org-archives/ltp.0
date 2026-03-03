Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E183EB365A
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 02:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772506581; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kFZo0LXabfoZF1p4YkT1c3GrchYDQsjgSH6UMbx/V2E=;
 b=W+AucHWw4HSpUAdm5cUlGJOhZX/GwzGy01iTE5YNY4kkANlvoaffUa8SQAyvbMd99Bx/u
 VcrEYsZC4umD601Puq9HKfna4u6jDIeCLmpEuPfaxdVXzLqo4xhQrh/UECUrMTlDfZtuDT3
 apyYGX4Vgw08Le2Vweu0qowmpHbyGmM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC9243D85B9
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 03:56:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 155043CB27C
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 03:55:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A5F31A0061D
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 03:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772506554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbeRh4lq+Il4OBylBVh6OxmZxiGMRvMS7BFkBiEcSyA=;
 b=VO83q5kRjRhVxS+oX/YBGFJp17Ur2VquGSL+l+PTiXjNdbQ5EzzvuFuw0Zad5dZ98mNciB
 Cym6u7GhEQOWhiabfEUalnakqUv4qTy0zIOhIHffG7+LCwxwji1g4rO/WfzYGkHAzonETA
 ejZMB/cGRhF2RLGgZpZNrDdJlV52nXs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-YCEoqHWGMtmvVhLUNYdpEA-1; Mon, 02 Mar 2026 21:55:53 -0500
X-MC-Unique: YCEoqHWGMtmvVhLUNYdpEA-1
X-Mimecast-MFC-AGG-ID: YCEoqHWGMtmvVhLUNYdpEA_1772506552
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae50463c39so16436705ad.1
 for <ltp@lists.linux.it>; Mon, 02 Mar 2026 18:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772506552; x=1773111352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbeRh4lq+Il4OBylBVh6OxmZxiGMRvMS7BFkBiEcSyA=;
 b=iigfYdDar/UMulwRO230KO7d81XXPHrwqfBhmS7U74Tp6FfpV2de2Cs3AMwzA1htl5
 HN3gLPPqNmPgg79J5LMaKG8IyVaGrJssznCxExjpyWq2xvvORxtg6f++q0aM/dkdbZfh
 FqH+S2ZzmzjFp5UVT3vrBbAJXcj8NccvueoCdXIl+zCQazKRXxdwV4YQ5xFAQzHvrVMI
 B6OQIdUsK4zpynfbocJHkz1Tx7+YBPTE7eIZz04QVakI7eZFOxZpp4gnw3vEypBAPTqb
 EgYJ4UwGGy9CCERxIzAwY4aT1rzkRvE3WzPKdkKib5uL9UOlUnKuf4LSMR4Y/V2a5WyQ
 7o3A==
X-Gm-Message-State: AOJu0Yx0dRLE2jVx2HxzsR3U3OrrxIMBlXsC7tpgznY36WeYpy7R68fO
 LYNmpVp6kXFRqUtfOLnLrEQBHQgTiiQkH9pRa7rXGKvl+Bog6X2JcNtXfd2GoXRBBBSZn33pjp4
 rpUyGx5LXowD0FQWjUXGrghi17x6hC6WQHaK4bbD1E2Ujz7q2Dp2e
X-Gm-Gg: ATEYQzyRdcsyQ8bS8W1YCYJOi5JP3Ie07PZDVOZosC74dBR1QxXBshBpMOlSrAPPIQs
 +7g2+vLDGIHN32yEGzhHB3NdZm6g23jJMfZeccBy9GzBYjWwV90dd4I4XreDV5dRlHMrHQuouJF
 XKFQlSXzPBEB47/+tcObS1q52h6ByFhQmNiGb6jgluqGljd7XQyCmskQTdVSBx2ccEZTY0K6bnU
 Ed+PKqWFrRANZg3Nq1sh1fcMe1t/UROiWuREfrdJBejlR9ZgKXRh9W0nDlO3zCvK9It0zgQ2UnA
 7bTrmT0yv9s0WGJMpi+BPcQv4QKU2KZw9NisRY909F8sMdIymdfWLlw7lU04ZPehvfmURwo0zvj
 3x8ok0dc4HmE5QELP
X-Received: by 2002:a17:902:e80c:b0:2ae:61db:7988 with SMTP id
 d9443c01a7336-2ae61db7c2fmr2200415ad.24.1772506552306; 
 Mon, 02 Mar 2026 18:55:52 -0800 (PST)
X-Received: by 2002:a17:902:e80c:b0:2ae:61db:7988 with SMTP id
 d9443c01a7336-2ae61db7c2fmr2200265ad.24.1772506551932; 
 Mon, 02 Mar 2026 18:55:51 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b9b32sm199722455ad.66.2026.03.02.18.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 18:55:50 -0800 (PST)
Date: Tue, 3 Mar 2026 10:55:48 +0800
To: andrea.cervesato@suse.com
Message-ID: <aaZNtH1HjVBughpE@redhat.com>
References: <20260301012808.15588-1-liwang@redhat.com>
 <69a5a89c.050a0220.1f2f98.0f58@mx.google.com>
 <aaZLS0XUd5z-0HmM@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aaZLS0XUd5z-0HmM@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPsu68ASx6Oth7UDOo53_q3_Y2HFvpwq1BNdhK9SOPM_1772506552
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Extend -D flag to support multiple debug
 levels
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Li Wang via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 03, 2026 at 10:45:31AM +0800, Li Wang wrote:
> On Mon, Mar 02, 2026 at 03:11:24PM +0000, Andrea Cervesato via ltp wrote:
> > Maybe we should also apply the same approach to the LTP_ENABLE_DEBUG
> > environment variables, otherwise we might support only 0/1 while using
> > it.
> > 
> > WDYT?
> 
> Sounds reasonable, LTP_ENABLE_DEBUG now should support '0, 1 or 2' and
> drop the 'y' option.

After thinking over, the 'y option could be reserved for those who are already
familiar with its usage, just like the '-D' option represents '-D1'.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
