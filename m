From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jul 2019 16:42:42 +0200
Subject: [LTP] [PATCH] *.sh: convert hardcoded python2 to python3
In-Reply-To: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
References: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
Message-ID: <20190725144241.GA4568@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yi,

> We had converted python2 to python3 for all *.py in commit
> 5a8408bc32f0eada5cbf65ac63d5cd2410f95249. But there are still hardcoded
> python2 in some scripts. Convert these python2 to python3.

good point. I thought that with 5a8408bc3 ("*.py : convert python2 to python3")
we just added python3 support while keeping python, but we really also changed
the shebang to python3.

Acked-by: Petr Vorel <pvorel@suse.cz>

I guess we should state in AC_ARG_WITH([python] that we target to python3.

But the real help would be to rewrite these scripts into shell, so it can be run
also on embedded devices or other systems, which doesn't have any python.

Kind regards,
Petr
