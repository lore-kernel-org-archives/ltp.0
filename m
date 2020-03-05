From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Mar 2020 18:21:42 +0100
Subject: [LTP] [PATCH] hugeshmctl01: Revert "hugeshmctl: Use loop from
 the API"
In-Reply-To: <1583402023-22461-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583402023-22461-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200305172142.GA24302@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

I'm sorry for introducing a regression.
Thank you for a report and fixing the test.
I'd personally prefer to keep .tcnt = ARRAY_SIZE(tcases),
that's why I sent patch which just fixes this issue,
but maybe others will prefer to keep loop in test_hugeshmctl()
as it was before my change.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1249779/
