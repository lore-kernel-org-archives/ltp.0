From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Nov 2016 12:39:03 +0100
Subject: [LTP] [PATCH] memcg_control_test.sh:incorrect test result and a
 pipe issue
In-Reply-To: <582D7289.6090303@oracle.com>
References: <1478166145-5177-1-git-send-email-shuang.qiu@oracle.com>
 <20161103110026.GC27513@rei.lan> <581B44C6.5090808@oracle.com>
 <582D7289.6090303@oracle.com>
Message-ID: <20161121113902.GA25334@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Moreover I was looking at the test recently and I would say that the
> >> best solution would be to remove it completely, since the same function
> >> should be covered by the memcg functional testcases. So the best bet
> >> here would be to check that it's covered by functional tests, if not add
> >> missing pieces to functional tests and get rid of this mess.
> > Ok,I will also check the functional test.
> I think this testcase can be covered by memcg_use_hierarchy in 
> functional testcases.
> Maybe we can add a sub case in memcg_use_hierarchy test that check the 
> parent limit for memsw.limit_in_bytes.

Both sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
