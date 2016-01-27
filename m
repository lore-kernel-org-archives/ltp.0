From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2016 17:11:23 +0100
Subject: [LTP] [PATCH 1/2] commands/lsmod: Added new testcase to test
 lsmod(8)
In-Reply-To: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160127161123.GC32032@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've moved the verify part to the test function since there is no need
to keep it separated for such simple test and simplified the awk part as
well. There is no need to use sed if we can do the match in the awk and
also awk can read file just fine, no need to use the cat to feed it to
stdin.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
