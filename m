From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jun 2017 13:40:37 +0200
Subject: [LTP] [PATCH] commands: fix unmatched installation path of
 datafiles
In-Reply-To: <1498794020-9569-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1498794020-9569-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170630114037.GB18305@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Both file01 and unzip01 fail due to unmatched installation
> path of datafiles.  It has been broken by:
> 
> commit f9a91c164ac52a4c91ff6aa9c156f110d04158d6
> Author: Li Wang <liwang@redhat.com>
> Date:   Wed May 24 15:18:31 2017 +0800
> 
> 	tst_tests.sh: set the shell TST_ID automatically
> 
> We need to change installation path of datafiles to fix it.

Good catch, but I would be happier if we simply renamed the testcases to
keep the test filenames constistent. Can you please post that patch
instead?

-- 
Cyril Hrubis
chrubis@suse.cz
