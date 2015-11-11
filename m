From: Lei Li <rocklee_104@outlook.com>
Date: Wed, 11 Nov 2015 12:50:15 +0800
Subject: [LTP] [PATCH v2] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <1447056173-8979-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <563C94F5.9040803@oracle.com>
 <1447056173-8979-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <BLU436-SMTP34950324B1CC2CC1FCF1F3CF130@phx.gbl>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +mkswap_test "" "" "$TST_DEVICE"
> +mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
> +mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
> +mkswap_test "-c" "" "$TST_DEVICE"
> +mkswap_test "-p" "2048" "$TST_DEVICE"
> +mkswap_test "-L" "testswap" "$TST_DEVICE"
> +mkswap_test "-v1" "" "$TST_DEVICE"
> +mkswap_test "-U" "ffffffff-ffff-ffff-ffff-ffffffffffff" "$TST_DEVICE"

Hi again :-)
	This testcase changes UUID of a block device and will never
restore it. Swapon error occurs when there are two "ffffffff-
ffff-ffff-ffff-ffffffffffff" UUID in the system, for example, run this
testcase to test a block device firstly and then, test a loop device.

Maybe you should restore the UUID of the block device in cleanup().

Thanks
-- 
Rock Lee
rocklee_104@outlook.com
