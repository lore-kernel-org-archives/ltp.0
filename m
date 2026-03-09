Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553C7EFCD82
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773052004; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MFIECUjmIMiGQfvInZCkjmL9s/7hQsIWKGKHWFxuWYM=;
 b=Jlp7jHJx/UW5O0NQ+1nPBgOxz+Zf2DB8OvCK7Br1fJiJTfEbYMdbdVcMFPFKja1PrKr4h
 QcpOOEZR0YF4YiXGHvYMk/kWlB21/Bgwcs9dBQxb/3orXar4PsBKXg0W6xu89Lx842RZDGA
 lsXsDjA30CRnfnLAsEeTegeEQTbVT+U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F81E3DD46B
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 11:26:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C683C56FF
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:26:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 629C36007A0
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:26:19 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso17349465e9.3
 for <ltp@lists.linux.it>; Mon, 09 Mar 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773051978; x=1773656778; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AxGz6bn3e6hJNO2txmdmgToHU2g/fJJ3PsFhrhmSt9s=;
 b=f+HumSK1ETvxCVopXyu4PAok3DJj2jrz8l+BTXN6WYgtfo8BYyL+ieNPOy5DVGDh0x
 /MB3zfM9xtJy1ujsSeLNeYehDXX86IbEmZ2nVE989olhnflH0QK1qqVzUnb3yRiax+cd
 uCDMae0H3MfPdFzIXLD5C+uPad9xaqKz0fVHzzZdoUtfi1Pp9vFczEEgkPMJ8IwwmPSn
 USbMe30UtF6ZW8kTxBiBN09HCxKSN3GsmQ2nj/xKarMX2qUhkmSpgpitbz4joNKdrodC
 +Kzqb2tkm6rO+CXWByG/jBmN1DXnbbPSHk5U3Zy/xCwguQRCBlG63J+hV8vVvbG8AzeB
 guVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773051978; x=1773656778;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxGz6bn3e6hJNO2txmdmgToHU2g/fJJ3PsFhrhmSt9s=;
 b=xBdr6a6Lxtu8XxhqDgjpu0DXdbgjFa3CWLPFIvOZChAULeq3R8pLvKIOsKfpPa+NCI
 C4zv8GwfNaD1A1P83MRslMdC5Fzx2iSOWEVwpvvamwKEUp4bULEqi+bSNZHX2/oJJHez
 bIZ9YbIQreu/bIM8vx0NU8UUe39Agrk0u8fcqFACO/Glwnok31ESd/CMcyARPKw3tHfS
 8BTlAMgBh/i/DcEQ93aADrmY1gVaTUK8Kh7HXHUoBFHC4EHn7bGxT+E0torOIJ1fEKyB
 bm+3e1hwVi+Do4pYd30QlHfCSqiqhf6pE8GdjoSj7z89PU9Tsf4nDPMyLFIjdDdbyupE
 LM2Q==
X-Gm-Message-State: AOJu0YyoSnxsdrEgk1SSBtN/OBy9tnkZdsccWf7Jt8CCsA4Q1C7w7/sK
 rJESZR4EcEtMV+W3octCSnNaedi7Gi7wULFWiqec8NNraBb6N0OLLPotsqaTsV/HSy0FKafbCBs
 mKj4FY7w=
X-Gm-Gg: ATEYQzxaHWt2B19Bq5GrVfFl29ZA+LxmIDmAM48QBRL0mMOkDXtmCFjJlgqicScjgPc
 ZBb2ZsyyKaZNE/0lyxu2kupe3vEd4NMyXds0naFy6v54YOK81bmMptyK1pT1k/LAaPiz/154x0K
 tg/beOvKkxhdfmwuLiBLdkgVz0tw97YDMp5Ce2j1pF3rpdqvcyjjwt7tNJyL7jdoXKrnvScqJA9
 4ZtuI2OGD6FJxIpeG8LZ/WebS9Jl5IcV3iSLs3UO7eEnFfsyBtpOddbwUcUsSsJuwvjJSQuVLzW
 8Z4KbSbhBuV4/l7BujExjzUFVH1/kP20p8hzLw5H4buG2C92cmsjP+2Fsbl3GzHHdD1tNLj4eeu
 aZPTADgA467N3C6Wnmdq/ncZpgfT0A6hSsTxt0d97J6S+hM9aQJjbsRWUl9ZVkJJRep/1cEMXDS
 MCehH6zU73ZNPf6dkcHIAvWJ+BXptJ+kU2op3cy+hpuO9xbqK86yzLg5jHL1jdxtKnhiVyqgQ1b
 PODKHQUXNIVuHj7b7lFFr3RvbTJzusb7ci1HhRwU2jOmab/ROHlYRlaYDa8mC6K57OFeP/MIWmf
 Xg==
X-Received: by 2002:a05:600c:83c4:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-4853ff1d86emr10221015e9.1.1773051978199; 
 Mon, 09 Mar 2026 03:26:18 -0700 (PDT)
Received: from p200300ef2f4fc90095b004155bc2c2d8.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b0adasm232747835e9.10.2026.03.09.03.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:26:17 -0700 (PDT)
Message-ID: <69aea049.050a0220.6a40f.4138@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260309075946.28119-1-wegao@suse.com>
Date: Mon, 09 Mar 2026 10:26:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> +	/* Wait for asynchronous kworker threads to dispatch events */
> +	usleep(100000);
> +
>  	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
> +	read_len = consolidate_events(event_buf, read_len);

This doesn't sound correct. Instead of usleep() and "guessing" if data
is coming or not, we should poll() over the fd_notify and collect data
until BUF_SIZE. If data doesn't arrive, it means events were not
dispatched and test fails.

Remember that (in general) sleep operations hide test faults or bugs, as
it's explained in the ground rules guide:

https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html#why-is-sleep-in-tests-bad-then

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
