From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 15:54:46 +0100
Subject: [LTP] [PATCH] max_map_count: Add judgment of abnormal situation
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038900ED@dggeml511-mbs.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038900ED@dggeml511-mbs.china.huawei.com>
Message-ID: <YEeMNhvwrrfZA0rD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

> > > When CommitLimit - Committed_AS < 128, there is no post processing,
> > > and the test will report "TBROK: Test haven't reported results".
Actually, I have problem for CommitLimit - Committed_AS < 5280
(depends on actual system).

But that means that even check for max_iters < 0 is not enough,
because while (max_maps <= max_iters) block should be run@least once
to avoid TBROK: Test haven't reported results!

max_maps is always 1024, thus how about this?

	max_maps = MAP_COUNT_DEFAULT;
+	if (max_iters < max_maps)
+		tst_brk(TCONF, "test requires more free memory");


> > You seems to exploring limits. Out of curiosity, which system / hw do you
> > test?

> We are testing linux on some different embedded systems whose hw resource is limited. 
Thanks for info.

Kind regards,
Petr
