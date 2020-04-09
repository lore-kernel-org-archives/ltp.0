From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Apr 2020 10:22:10 +0200
Subject: [LTP] [PATCH] syscalls/clone301: Fix the test race this time
 for real
In-Reply-To: <877dyqyxq4.fsf@our.domain.is.not.set>
References: <20200408114007.4096-1-chrubis@suse.cz>
 <877dyqyxq4.fsf@our.domain.is.not.set>
Message-ID: <20200409082210.GB2828@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Maybe to be nice, we should use the exponential backoff function?

Let's add that in a separate patch to keep the git history clean.

I should have even split the original patch into two one that fixes a
problem and second one that adds the debug info, I guess that I will do
that before applying...

-- 
Cyril Hrubis
chrubis@suse.cz
