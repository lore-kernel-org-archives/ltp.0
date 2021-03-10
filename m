From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 11:26:11 +0100
Subject: [LTP] [PATCH] max_map_count: Add judgment of abnormal situation
In-Reply-To: <20210310020348.2077-1-zhaogongyi@huawei.com>
References: <20210310020348.2077-1-zhaogongyi@huawei.com>
Message-ID: <YEiew7jO9oduJU8K@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> When max_iters < max_maps, there is no post processing,
> and the test will report "TBROK: Test haven't reported results".
Thanks, merged!

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---------------
> v1->v2: modify comparison span of the judgment.
> ---------------
FYI: about these 3 lines below Signed-off-by: text should go under ---
and both --------------- are not needed. Not important, just in that way this
info won't endup in the commit message (anything below --- is not going to be in
the commit message).

Kind regards,
Petr
