From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 14:52:06 +0100
Subject: [LTP] Invoking networking tests
In-Reply-To: <584E8F74.80308@oracle.com>
References: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
 <58494350.80404@oracle.com>
 <20161208173228.jixqv2xd6jqptz5i@dell5510>
 <584E8F74.80308@oracle.com>
Message-ID: <20161212135205.GA21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As far as I know there is no such feature in new shell library yet
> (tst_test.sh).

I will try to implement this until the next LTP release.

> It seems that it would be a good thing to have a timeout option in
> tst_rod() too.

That may be a good idea as well. We could fork() and watch for a timeout
in the tst_rod.c quite easily.

-- 
Cyril Hrubis
chrubis@suse.cz
