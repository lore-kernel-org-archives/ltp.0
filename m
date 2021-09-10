From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Sep 2021 16:29:22 +0200
Subject: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
In-Reply-To: <287a9879ef8b3342cb88225e4e319733@suse.de>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
Message-ID: <YTtrwkSdUaQE/PnB@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It's a second test where we could use TST_EXP_FAIL_SILENT() if we had it 
> defined.

Well the main point we test is that the call fails so I would just use
TST_EXP_FAIL() that produces TPASS/TFAIL and the have additional check
if the groups were changed or not.

I can change the patche accordingly before applying if you agree.

-- 
Cyril Hrubis
chrubis@suse.cz
