Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5971CCD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780416626; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=KmnFcecuQIzR1KgFRsWgmsgd7CxusUY+OMHWtUKoiFT6SnkWnw+Buyi67ttdWPgR9nRrF
 hlVehNp8v7N3OzdihtYWeih8SCUAdQyPlnhf+o5Wnuo7RrZSfKnqj25iDHFudae8MKKbf5O
 D2xqAVmJmVhPKOOkLWg/KiNKb+0h7+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E7EA3E7234
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 18:10:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268933E4B69
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:10:03 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D75501A000A0
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:10:02 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2027309f8f.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780416602; x=1781021402; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=NbqRXBKOwqfOrer+BqP6tw/JVVXjNBAGjKBtvxjawNpz4tpAs+3hkvZdludDFGMAES
 ugkzROtiEwBC3FTfLy0EAdamUew0htwVAqSV5+BSPes470lEi3/qpsa0leOINS8zDcax
 iNR5P8q/4HxF24xg0dS0NxtNbNW5T61/sr7PUEN5oOV3zimbWrwJ2W4JDV81tfg/tlBv
 jgU0zQWmbvz2XxuMPV5D5afw8RprcBqKKj7kyNN+imePhj/o30HiG3bnrW37dqu9vlEY
 XOxEy+dXhBWPwt/d/3yLypLmFSpvzw270Q8MGuuWb42dAQRkrzM+K3lrCPr1XE/L9l4a
 Co1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780416602; x=1781021402;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=nvrFp+6Ej8nUgpptTAebELpppWcxzjuXjmVEqAmVrx2n0BPGxC+7m6AYOHyQC+psAl
 e40D5ZDbJ6DBig+0bHUKu1zPM5yJu08YYkl8gNhTgGSlSDrS/aiicw3yZ7/dZPbrrSbq
 YTYGsrHVzP9s4C1xnWX4TGS7jI1HhItycVx4+yiICng5bhVQD2E5uzBCEaJtWpp1P4O9
 ZRl85HqonhxbFlE1l6VezyWY4WwXbFAiBHiShW8+yvoRc7rRM3R32TRm03T6Rcy0MbLA
 JzY6t7FhuxHhpmrF1gougpQotyisUySlMExNAyf+D6ECcburPoSfHSIh1tsqmtZ7xqQB
 3WHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9144zMV3iBR8jVJJ2pH2kOlGis4RWpHUWZHMQSdUZaP8YiiuTasUftRYWRaPAumn6Hdgk=@lists.linux.it
X-Gm-Message-State: AOJu0YxGALyOLThFPnQhtWu2gNZFUDloHtW7bVoAeIk0mWqHj94gMGrz
 rhBKGlI+0K28M/HkesHyAl3JsSp6AKxjzThOqGBT9/cyOY5vmO5Pncu1wIdUKDykVTs=
X-Gm-Gg: Acq92OG2VGCZTZMfRXz9Zxdh8inOwN/YlEwgrWzBgAaERDPnOU3CJAEDUiWVzQM9Juh
 cA2b6ZxIp6j0pbtJy6MhBuQ6yYxYyhBCLQ8K+ZpCF2mLDKcsv67RuRKaY0hAZ2FCRjZ6FD6CSSm
 0f5tfWDNCFX+5kinnlo4rZXRZcdAHtCNNtHLIA86mP01yrDyqBGuGMxXXHX1PT/TJicWWqzd5Du
 +clfJ2na96LyS7BI5dijKVrV+ZS0TBtEK4noouRrr6ADPRox8qnZMSbYo96L9RBc663ulYO77GJ
 zyOBEO8kHV8ojDgue3dwoyxC9f60wzQZgnybG7KLhnp5sjNcNamvjxAK9hl3BgGIOIcmJ4nOQot
 TufJzuh1amIlX+DIq8OxlTizYlJ16+3j2DyomJu43kGAPS6NPnXKUBsxzqcaoXbhqmijUY7/HFl
 I76bPVuv+FbFJucTGBaJFszf5edvo3QcnrOJjNyBcKmcis9QiUmpX0BFjLrrlEIlg+o1zsy2QPo
 Psn1zXxJdM=
X-Received: by 2002:a05:6000:1a8c:b0:460:1a57:dd7c with SMTP id
 ffacd0b85a97d-4601a57de27mr6769571f8f.23.1780416602120; 
 Tue, 02 Jun 2026 09:10:02 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm229573f8f.35.2026.06.02.09.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:10:01 -0700 (PDT)
Message-ID: <6a1f0059.bb4da8e5.1599eb.6b54@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260524170316.3846-1-linuxtestproject.agent@gmail.com>
Date: Tue, 02 Jun 2026 16:10:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getpid: Link manpage in docparse comments
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
Cc: ltp@lists.linux.it, LTP AI
 Reviewer <ltp-ai@noreply.github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
