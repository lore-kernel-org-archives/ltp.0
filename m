From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 09:38:41 +0100
Subject: [LTP] [PATCH][RFC] network: test_net.sh: allow to run tests on
 a single machine
In-Reply-To: <1479130404-31787-1-git-send-email-alexey.kodanev@oracle.com>
References: <1479130404-31787-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20161122083841.GA7048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When 'TST_USE_NETNS' environment variable is defined, test_net.sh
> will setup 'ltp_ns' netns and configure veth pair according to
> other LTP network variables. Then, each tst_rhost_run() call will
> be executed in the new netns on the same host.
> 
> Usage:
> TST_USE_NETNS=1... ./network.sh -i

Looks like a smart idea to me, the implementation looks ok as well. I
wonder if we should add these kind of network tests into default
scenario...

The patch misses any documentation though, it should be described
properly somewhere.

-- 
Cyril Hrubis
chrubis@suse.cz
