From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 10:29:37 +0200
Subject: [LTP] [PATCH] *.sh: convert hardcoded python2 to python3
In-Reply-To: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
References: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
Message-ID: <20190729082937.GA21940@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yi,

> We had converted python2 to python3 for all *.py in commit
> 5a8408bc32f0eada5cbf65ac63d5cd2410f95249. But there are still hardcoded
> python2 in some scripts. Convert these python2 to python3.

merged as it is (with slightly modified commit message).
Hope we manage to fix #547 [1] before python4 :).

Thanks for your patch.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/547
