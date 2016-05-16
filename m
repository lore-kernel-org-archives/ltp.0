From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 May 2016 14:47:11 +0200
Subject: [LTP] [RFC][PATCH 1/3] network: run network tests from
	network.sh
In-Reply-To: <20160516123103.GC6454@rei.lan>
References: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
 <20160516123103.GC6454@rei.lan>
Message-ID: <20160516124711.GD6454@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This does not say what is the reason for this change.
> 
> How is this better than runing runtest files from runltp?
> 
> You supposedly define a few variables in the script that starts the
> testcases rather than having a common script that is sourced at the
> start of the network testcases. Is there any other thing I'm missing?

Looking into the networkstress.sh and networktest.sh it starts ltp-pan
itself as well. So this more or less copies the functionality from there
to network.sh.

I would say that the defaults for variables should not be defined in the
script that runs selected (subset of) tests. That is because it should
be possible to run just the test script and expect it to have the same
defaults as when it's executed via the script. Why don't we stick the
defaults to test_net.sh and keep just the code that selects testcases
to run and start ltp-pan in the network.sh?

-- 
Cyril Hrubis
chrubis@suse.cz
