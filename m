From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 15:20:59 +0100
Subject: [LTP] Invoking networking tests
In-Reply-To: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
References: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
Message-ID: <20161212142058.GC21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> How about testcases/lib/test_net.sh and testcases/lib/test.sh scripts? Not deprecated?
> 
> BTW: what is the purpose of testscripts/*.sh scripts, why it isn't everything integrated
> into runltp?

The runltp script is big and hairy ball of shell code. It has too many
parameters already etc. Hence I would not like adding more code there.
Maybe we should clean it up or create runltp2 later and possibly include
the network bits as well.

And the testscripts/ directory contains mostly poorly maintained or
unmaintained scripts (minus the network.sh script). Some of these should
be cleaned and moved to testcases/ some may be removed. I would like to
get rid of the directory eventually.

-- 
Cyril Hrubis
chrubis@suse.cz
