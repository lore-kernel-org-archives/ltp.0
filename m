From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Nov 2016 14:33:12 +0100
Subject: [LTP] [PATCH] runalltests.sh: remove obsolete data from Makefile
In-Reply-To: <1479117309-3611-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1479117309-3611-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161114133312.GC25055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Installation failed because runalltests.sh has been removed in:

I've added a removal of mention of the script in INSTALL and doc/,
changed commit message accordingly and pushed, thanks.

FYI: I've also added a follow up commit that removes obsolete scripts
     that were depending on the runalltests.sh script.

-- 
Cyril Hrubis
chrubis@suse.cz
