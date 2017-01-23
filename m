From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 15:59:58 +0100
Subject: [LTP] [PATCH] cleanup shell test only if TST_NO_CLEANUP is not
 defined
In-Reply-To: <1482154880-4760-1-git-send-email-alexey.kodanev@oracle.com>
References: <1482154880-4760-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170123145958.GE25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Could be useful to debug a single test so it leaves the setup
> on the machine intact.

I do not think that this is useful enough to be included in the shell
library, but on the other hand it's just oneliner. Feel free to push it
if you find it useful.

-- 
Cyril Hrubis
chrubis@suse.cz
