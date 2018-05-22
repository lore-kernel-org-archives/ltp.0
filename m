From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 May 2018 12:54:22 +0200
Subject: [LTP] [PATCH] fs/read_all: Clear suplementary groups before
 droping privileges
In-Reply-To: <1526721740-8382-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180518170933.GA5094@rei>
 <1526721740-8382-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180522105422.GB27975@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added #include <grp.h> to the patch so that we get definition for
the setgrp() call and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
