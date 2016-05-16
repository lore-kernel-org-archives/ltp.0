From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 May 2016 14:23:26 +0200
Subject: [LTP] [PATCH] syscalls/access01: Fix the test to run both under
 nobody and root
In-Reply-To: <1463368789-1403-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1463368789-1403-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160516122326.GB6454@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is workaround rather than a complete solution.

What I have in mind for the testcase is to add field to the test
structure that describes if the particular testcase is expected to run
under root or not. Then we can add a few testcases that tests that R and
W flags are ignored for root.

-- 
Cyril Hrubis
chrubis@suse.cz
