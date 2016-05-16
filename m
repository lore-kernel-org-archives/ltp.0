From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 May 2016 14:31:03 +0200
Subject: [LTP] [RFC][PATCH 1/3] network: run network tests from
	network.sh
In-Reply-To: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
References: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160516123103.GC6454@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> * include network options from both networktests.sh and networkstress.sh
> * invoke ltp-pan inside network.sh
> * merge tcp_cmds_additions to tcp_cmds
> * remove not used tcp_cmds_(no)expect runtest files
> 
> All network tests can be run from a single script:
> e.g. to run 'tcp_cmds' test group
> 
> ENV_VARS ./network.sh -t
> 
> Also it is possible to define your own runtest file with '-f' option:
> 
> ENV_VARS ./network.sh -f runtest_file

This does not say what is the reason for this change.

How is this better than runing runtest files from runltp?

You supposedly define a few variables in the script that starts the
testcases rather than having a common script that is sourced at the
start of the network testcases. Is there any other thing I'm missing?

-- 
Cyril Hrubis
chrubis@suse.cz
