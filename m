Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71173C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782812444; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=95DaKstcXiPqoEaad69W1b6L8uKUC7ukdcAImgkv96E=;
 b=P8XDMWyNavs9HpS0WS5R9aszGHn3igu0OEcyanBSO5t0qMOhAr0OkfJtupW+upDRU7HpF
 V9OFJ1aGWZzxnPTJRAx9KOwkiKqTPFuQnpM8CKaINrzTfmpuTTSur4ul06UVzCjXLs1HzD6
 Df/sft23fUB74DYCPCjmnr7nBWQhTKU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96F343E4B38
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 895CA3C73A9
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:40:22 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92E091A004B3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:40:21 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49395888c7bso37794085e9.0
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782812421; x=1783417221; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UerJLKLt8B9K9GfPJMbhUuPK2ZQHAUQVN3+Tq/Hm6JQ=;
 b=d+lc6Kc3ioKm5YJdYAx7i8Tk6hKi93CiVj/znCgusYgbNRG902iLcTAXapG3LaL0Rx
 Z9versLPGdwWmiKYIYWp9OagQhfIbnqGnkBDXV9ps/Ao8GNP5KfeakNOEpB9mOFd5zwj
 VoXc4neLU61LCtSZChAqG0tDRTXZWnzxGGv6uf23gE9dM/YsFswuyaNABEXMLsa4dodt
 YXal1b3DrrSMyPNb2r93YIc5WScgKgx5H0QYEb/O9BfGoQbiZCVc+4HYxdmOQdsZU2GB
 g61vawixUrfVVJF5hLP6EIF4d5pz5sqgx9T60jfT954WPdriZOFVa3aCi3ofkqx/Ubu2
 oieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782812421; x=1783417221;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UerJLKLt8B9K9GfPJMbhUuPK2ZQHAUQVN3+Tq/Hm6JQ=;
 b=oOq7GFn0pjucIyw5IcwS060bA/Ssas/wTb3i8ipYabiBU5nVhLgHPNFeQj8JAtw9yU
 vv1nGoA4jtqV5a6qG4PEHHfd53ghzcpaN/roEDkDdV7xhHwqg/dziIOcloSJZaavC5nU
 NZKYe96bwAgsAsfTZnGRXWPDS77wpylEoSTudcm7nR86wYqbBtSNuUT+c50SvEvLc2BO
 puemiMGQGMA7v75r6zzLIjIJ2DkOtG7RVI6LdcO4iHXKz2OwIIbaef9sd461jGoQUf/R
 VbR5ZCZw+E3nYKdeo2tH8hY04qJt8fk3ONSvBilQGBE/fEeONrJAlCjAyN8nMmAYTt2W
 GMBg==
X-Gm-Message-State: AOJu0YwjfGcGEt+JiFtlMyVUJDz2cbWSAyOW+zSRrJWT0ybgsPzCDQex
 5QS05sB2H3nmPNRhdZpSyq9U0sBhRAW26cayYqYE4Qxo+oWHvXOgDrnaA5/FaXZOGGA=
X-Gm-Gg: AfdE7cmHYEbDZ81nHdlyZpb2HLzoa+2FSdH5WghEO6n7zXxSY6cg36Cyje/R7TlGLby
 jwWb0FJeH3ef79LkGzrL1Ak2yJ8LTpc2+wyipr1O+L8KOi38qkecoJ+z35JTC/a5yoo46qKZ9vq
 gpAGRn6sdcYkmKZD+iQmXGP0lLvD/AKU9LOPRW0eNMXSAt/mEHDNYTxjJW0nTSUyZOGug63G40e
 673hagYTnCMTW6vUvHJZ9SAZplwjkFkkSaBASFF5VBBjl2XLPUP24CS/O4vtqTQlwQMuU+Q8ntW
 ejUW1PDWjj/i0nvL+oZhyTJySb+O8NqBL819u8wnz/3Cr/ObFuB5/2dLzFLcHQ+ddUXSQlKawoD
 Bg/c5cdMGujdYbKCpxKuu9IHcLv8CJsoC+4WsdLxKqzS28NE9fx1xIuYqmTdSIOtW+Gj1GqlTNx
 Upc/oLj0gVKaTVMsJagqgvlxMC07x6mmi5qcqU0F7TlP33wW7emIH6C12tobkOhVd2WTDBKDV1r
 RfdOYJX7f27xdr5c2m94tifkxk5hzhyN0srMQOa1YlHMR9ZHkPzg69CgvE9SjLQi2k=
X-Received: by 2002:a05:600c:1908:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-493b8289df9mr43536395e9.10.1782812420415; 
 Tue, 30 Jun 2026 02:40:20 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8c66c15sm57722055e9.2.2026.06.30.02.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 02:40:20 -0700 (PDT)
Message-ID: <6a438f04.117c96fe.17e125.74f9@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260623113422.188364-2-piotr.kubaj@intel.com>
Date: Tue, 30 Jun 2026 09:40:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> +#include "tst_test.h"
> +
> +#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"
> +
> +static bool have_dvfs, have_fivr, have_dlvr;
> +
> +static const char * const fivr_nodes[] = {
> +	RFIM_ROOT "/fivr/vco_ref_code_lo",
> +	RFIM_ROOT "/fivr/vco_ref_code_hi",
> +	RFIM_ROOT "/fivr/spread_spectrum_pct",
> +	RFIM_ROOT "/fivr/spread_spectrum_clk_enable",
> +	RFIM_ROOT "/fivr/rfi_vco_ref_code",
> +	RFIM_ROOT "/fivr/fivr_fffc_rev",
> +	NULL
> +};
> +
> +static const char * const ro_dvfs_nodes[] = {
> +	RFIM_ROOT "/dvfs/ddr_data_rate_point_0",
> +	RFIM_ROOT "/dvfs/ddr_data_rate_point_1",
> +	RFIM_ROOT "/dvfs/ddr_data_rate_point_2",
> +	RFIM_ROOT "/dvfs/ddr_data_rate_point_3",
> +	RFIM_ROOT "/dvfs/ddr_data_rate",
> +	NULL
> +};
> +
> +static const char * const ro_dlvr_nodes[] = {
> +	RFIM_ROOT "/dlvr/dlvr_hardware_rev",
> +	RFIM_ROOT "/dlvr/dlvr_freq_mhz",
> +	RFIM_ROOT "/dlvr/dlvr_pll_busy",
> +	NULL
> +};
> +
> +static const char * const rw_dlvr_nodes[] = {
> +	RFIM_ROOT "/dlvr/dlvr_freq_select",
> +	RFIM_ROOT "/dlvr/dlvr_rfim_enable",
> +	RFIM_ROOT "/dlvr/dlvr_spread_spectrum_pct",
> +	RFIM_ROOT "/dlvr/dlvr_control_mode",
> +	RFIM_ROOT "/dlvr/dlvr_control_lock",
> +	NULL
> +};
> +
> +static const char * const rw_dvfs_nodes[] = {
> +	RFIM_ROOT "/dvfs/rfi_restriction_run_busy",
> +	RFIM_ROOT "/dvfs/rfi_restriction_err_code",
> +	RFIM_ROOT "/dvfs/rfi_restriction_data_rate_base",
> +	RFIM_ROOT "/dvfs/rfi_restriction_data_rate",
> +	RFIM_ROOT "/dvfs/rfi_restriction",
> +	RFIM_ROOT "/dvfs/rfi_disable",
> +	NULL
> +};

I was thinking that we can make it easier now. Instead of verifying
RW on different functions, we can simply create a .tcase structure
where we assign to each sysfs patch a specific read or write flag.
And according to that, we simply make a check inside the run()
function.

static struct tcase {
	const char *path;
  int read;
  int write;
} tcases[] = {
  ...
};

static run(unsigned int i)
{
	static struct *tc = &tcases[i];

  if (tc->read && !tc->write) {
    /* open with read -> pass */
    /* open with write -> fail */
  } else if (!tc->read && tc->write) {
    /* open with read -> fail */
    /* open with write -> pass */
  } else if (tc->read && tc->write) {
    /* open with read/write -> pass */
  } else {
    /* TBROK */
  }
}

Something like this. Feel free to optimize it, it's just a draft.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
