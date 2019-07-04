From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Jul 2019 16:01:52 +0200
Subject: [LTP] [PATCH 2/3] lib/test.sh: TCONF needs to be counted
In-Reply-To: <20190628125205.GA48441@linux.alibaba.com>
References: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
 <5e8374fa7f4ea9d64cdfc39a2ca449761327c257.1559207183.git.caspar@casparzhang.com>
 <20190628125205.GA48441@linux.alibaba.com>
Message-ID: <20190704140152.GA11528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed thanks.

> Hi Cyril, is it ok to push 2/3 and 3/3 as they've got Li Wang's
> Reviewed-by, or do you have different opinion?

I've checked and these two changes actually unify behavior of the shell
libraries with the C libraries. We did miss the changes to the shell
libraries when we modified the C libraries, so this changes make perfect
sense.

-- 
Cyril Hrubis
chrubis@suse.cz
