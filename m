From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Apr 2017 17:52:27 +0200
Subject: [LTP] [PATCH] mtest01.c: Increase max_pids and check for array
 overflow.
In-Reply-To: <1492105560-10287-1-git-send-email-sellcey@caviumnetworks.com>
References: <1492105560-10287-1-git-send-email-sellcey@caviumnetworks.com>
Message-ID: <20170426155227.GB6165@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Applied, thanks.

While we could have fixed this more elegantly (this patch is band-aid
like fix) it's good enough to fix the memory corruption expecially since
we want to produce another release soon enough...

-- 
Cyril Hrubis
chrubis@suse.cz
