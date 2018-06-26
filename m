From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 14:38:22 +0200
Subject: [LTP] [PATCH v2 2/8] tst_test.sh: Introduce TST_LIB_LOADED
In-Reply-To: <20180622151047.13002-3-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
 <20180622151047.13002-3-pvorel@suse.cz>
Message-ID: <20180626123822.GA5659@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This allows to detect whether library was loaded more than once.
> This is used by tst_net.sh (which is loaded more than once itself
> by tests macsec0{1,2}.sh).
> 
> + We don't waste time with multiple loading the library.

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
