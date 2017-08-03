From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Aug 2017 16:47:20 +0200
Subject: [LTP] [PATCH] mem/ksm: fix two errors in ksm06.c
In-Reply-To: <20170802083802.8706-1-liwang@redhat.com>
References: <20170802083802.8706-1-liwang@redhat.com>
Message-ID: <20170803144720.GB15519@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the default value of 'run', 'sleep_millisecs' and 'merge_across_nodes' are
> equal 0, that would be failed to recover them in cleanup(), because they are
> not satisfy with the condition(should '> 0', but '== 0') in comparing.

Ah, missed that. Thanks for the fix, applied.

-- 
Cyril Hrubis
chrubis@suse.cz
