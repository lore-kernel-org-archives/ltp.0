From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jan 2017 10:57:52 +0100
Subject: [LTP] [PATCH 3/3] test_net.sh: netns as default in tst_rhost_run
In-Reply-To: <5375d1aa-9d0c-884d-6c54-03019847bd6d@oracle.com>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <20161221230422.26696-3-pvorel@suse.cz>
 <20170119175049.de6ocki7ebyxnbpa@x230>
 <5375d1aa-9d0c-884d-6c54-03019847bd6d@oracle.com>
Message-ID: <20170123095752.tu5m5qxte4gcb2x4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> With this patch, if user wants to use ssh (explicitly set this variable) but
> forgot
> to set remote host variable, the test will continue with netns and the user
> might not even notice it.
Right, this makes sense to have it this way.


Kind regards,
Petr
