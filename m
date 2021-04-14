From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Apr 2021 15:32:08 +0200
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B5467@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B5467@dggeml531-mbx.china.huawei.com>
Message-ID: <YHbu2LpnYB2J2Ey7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> BTW I find that the testcase run passed on my local system, it seems
> that tst_* will not trig memory allocation:

This is not, by any means, a proof that the test is correct.

"Passed on my machine" is nothing but poor excuse.

I can easily write utterly broken code that will work fine on a single
machine and fail on anything else. Correctly written test depends on
valid assumptions we can make about the operation system the test is
supposed to run on.

-- 
Cyril Hrubis
chrubis@suse.cz
