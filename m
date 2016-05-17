From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 15:53:45 +0200
Subject: [LTP] [PATCH v2 1/3] network: merge
 networktests.sh/networkstress.sh into network.sh
In-Reply-To: <573B1822.3030601@oracle.com>
References: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
 <20160517122908.GC12051@rei.lan> <573B1822.3030601@oracle.com>
Message-ID: <20160517135345.GF12051@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But if we don't source test.sh we will break some dependencies between 
> test_net.sh and test.sh,
> e.g. variables like this one:
> 
> export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
> 
> It might call tst_brkm/tst_resm...

Ah, missed that one. Then we should go with the v2.

> BTW, if we already using tst_* functions from test.sh, may be we could
> replace network.sh's 'echo' commands there too?

Hmm, that may be a bit confusing since that would make the output look
like an output from a testcase.

-- 
Cyril Hrubis
chrubis@suse.cz
