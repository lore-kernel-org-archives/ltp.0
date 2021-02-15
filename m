From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Feb 2021 10:27:25 +0100
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
In-Reply-To: <f4ee229f-ea33-cbdd-5dbe-889e16629ed1@jv-coder.de>
References: <20210125131746.74630-1-lkml@jv-coder.de>
 <e573f919-8205-40e2-5187-49bff0983872@jv-coder.de>
 <YBG4hFVo5wdaFnPa@pevik>
 <f4ee229f-ea33-cbdd-5dbe-889e16629ed1@jv-coder.de>
Message-ID: <YCo+fdFmRJwu2UFE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> I'd like to submit some more patches on top of this.

You probably noticed some failures (on 5.10.14 openSUSE kernel):

memcg_stat_rss, memcg_subgroup_charge, memcg_move_charge_at_immigrate, memcg_stat:
TBROK: timed out on memory.usage_in_bytes
=> maybe just timeout?

memcg_max_usage_in_bytes
memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 126976, 0 expected

memcg_usage_in_bytes
memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4325376, 4194304 expected
memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, 4194304 expected

Tests which needs further cleanup/rewrite (less important than fixing previous)
testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
testcases/kernel/controllers/memcg/control/memcg_control_test.sh

Kind regards,
Petr
