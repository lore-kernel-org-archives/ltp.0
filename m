Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C22EC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 14:07:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B88A73CA956
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 16:07:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352093CA8EE
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 16:07:25 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6541C1000DD8
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 16:07:23 +0200 (CEST)
Received: from [10.40.40.184] (unknown [91.26.40.236])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A5A09A344C;
 Thu, 14 Jul 2022 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1657807642; bh=0rqLcro1L01b477Ha7K8INVy/Txc11oR+zleh9dUk/k=;
 h=Message-ID:Date:MIME-Version:Subject:From:To;
 b=Nr5uKa2cgVRmXSZFp4/7mMKYlsylOdw81qBLfKiRVbUoPyRmWPTwl08ynSf6jCHv6
 1pXPhPsVaASs1W6iU119KM+ABqb/MbO/L5JczNm4bzDPt8lpQ5KfHpgOhwu/BYv7C1
 ZEiwsyOhus4/uqN2glMOXkj9FlSTQYvSw9Fz6PtE=
Message-ID: <c93e7189-7a11-cce8-7a74-9c241886db1b@jv-coder.de>
Date: Thu, 14 Jul 2022 16:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it, pvorel@suse.cz
References: <20220627072709.709035-1-lkml@jv-coder.de>
In-Reply-To: <20220627072709.709035-1-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] net_stress: Fix usage of variables from tst_net.sh
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

did you miss this patch (and the other one for memcg/functional with the
same type of bug)?

Joerg

Am 6/27/2022 um 9:27 AM schrieb Joerg Vehlow:
> From: Joerg Vehlow <joerg.vehlow@aox.de>
> 
> These tests use variables (NS_TIMES, IP_TOTAL, ROUTE_TOTAL
> and IF_UPDOWN_TIMES) from tst_net.sh, before sourcing it.
> 
> Fixes: 04021637f4749a4797bf105862c45fe07374a161 ("tst_test.sh: Cleanup getopts usage")
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
> ---
>  testcases/network/stress/interface/if-addr-adddel.sh    | 7 ++++---
>  testcases/network/stress/interface/if-addr-addlarge.sh  | 7 ++++---
>  testcases/network/stress/interface/if-route-adddel.sh   | 5 +++--
>  testcases/network/stress/interface/if-route-addlarge.sh | 5 +++--
>  testcases/network/stress/interface/if-updown.sh         | 5 +++--
>  testcases/network/stress/interface/if4-addr-change.sh   | 4 +++-
>  6 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/network/stress/interface/if-addr-adddel.sh b/testcases/network/stress/interface/if-addr-adddel.sh
> index cb453e612..0750501f0 100755
> --- a/testcases/network/stress/interface/if-addr-adddel.sh
> +++ b/testcases/network/stress/interface/if-addr-adddel.sh
> @@ -7,9 +7,6 @@
>  
>  IF_CMD='ifconfig'
>  
> -# The interval of the check interface activity
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> -
>  test_body()
>  {
>  	local cmd="$CMD"
> @@ -89,4 +86,8 @@ test_body()
>  }
>  
>  . if-lib.sh
> +
> +# The interval of the check interface activity
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> +
>  tst_run
> diff --git a/testcases/network/stress/interface/if-addr-addlarge.sh b/testcases/network/stress/interface/if-addr-addlarge.sh
> index 3c876c17d..d0759c86b 100755
> --- a/testcases/network/stress/interface/if-addr-addlarge.sh
> +++ b/testcases/network/stress/interface/if-addr-addlarge.sh
> @@ -7,9 +7,6 @@
>  
>  IF_CMD='ifconfig'
>  
> -# The interval of the check interface activity
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
> -
>  test_body()
>  {
>  	local cmd="$CMD"
> @@ -110,4 +107,8 @@ test_body()
>  }
>  
>  . if-lib.sh
> +
> +# The interval of the check interface activity
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
> +
>  tst_run
> diff --git a/testcases/network/stress/interface/if-route-adddel.sh b/testcases/network/stress/interface/if-route-adddel.sh
> index b50da268a..51445e4f7 100755
> --- a/testcases/network/stress/interface/if-route-adddel.sh
> +++ b/testcases/network/stress/interface/if-route-adddel.sh
> @@ -7,8 +7,6 @@
>  
>  IF_CMD='route'
>  
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> -
>  test_body()
>  {
>  	local cmd="$CMD"
> @@ -64,4 +62,7 @@ test_body()
>  }
>  
>  . if-lib.sh
> +
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> +
>  tst_run
> diff --git a/testcases/network/stress/interface/if-route-addlarge.sh b/testcases/network/stress/interface/if-route-addlarge.sh
> index 7d09d1216..355b6b4ab 100755
> --- a/testcases/network/stress/interface/if-route-addlarge.sh
> +++ b/testcases/network/stress/interface/if-route-addlarge.sh
> @@ -7,8 +7,6 @@
>  
>  IF_CMD='route'
>  
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
> -
>  test_body()
>  {
>  	local cmd="$CMD"
> @@ -76,4 +74,7 @@ test_body()
>  }
>  
>  . if-lib.sh
> +
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
> +
>  tst_run
> diff --git a/testcases/network/stress/interface/if-updown.sh b/testcases/network/stress/interface/if-updown.sh
> index 9a5709c85..71c78d785 100755
> --- a/testcases/network/stress/interface/if-updown.sh
> +++ b/testcases/network/stress/interface/if-updown.sh
> @@ -8,8 +8,6 @@
>  IF_CMD='ifconfig'
>  TST_CLEANUP="if_cleanup_restore"
>  
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
> -
>  test_body()
>  {
>  	local cmd="$CMD"
> @@ -47,4 +45,7 @@ test_body()
>  }
>  
>  . if-lib.sh
> +
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
> +
>  tst_run
> diff --git a/testcases/network/stress/interface/if4-addr-change.sh b/testcases/network/stress/interface/if4-addr-change.sh
> index b9ece2af9..f162e6a51 100755
> --- a/testcases/network/stress/interface/if4-addr-change.sh
> +++ b/testcases/network/stress/interface/if4-addr-change.sh
> @@ -9,7 +9,6 @@ TST_CLEANUP="do_cleanup"
>  TST_TESTFUNC="test_body"
>  TST_NEEDS_CMDS="ifconfig"
>  
> -CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
>  # Maximum host portion of the IPv4 address on the local host
>  LHOST_IPV4_HOST_MAX="254"
>  
> @@ -61,4 +60,7 @@ test_body()
>  }
>  
>  . tst_net.sh
> +
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> +
>  tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
