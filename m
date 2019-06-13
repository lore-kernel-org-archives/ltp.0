From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 15:10:18 +0200
Subject: [LTP] [PATCH 1/2] inotify: Add SAFE_MYINOTIFY_INIT{,
	1}() helpers
In-Reply-To: <20190605072126.19856-1-pvorel@suse.cz>
References: <20190605072126.19856-1-pvorel@suse.cz>
Message-ID: <20190613131018.GA29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
These two patches are obviously OK.

Well I we were pedantic the licence change should be in a separate
patch, but I guess that it's fine as it is.

Also we should probably switch to the inotify_init() from sys/inotify.h
and drop the my from the functions and macros, but that could be done in
a subsequent patch.

-- 
Cyril Hrubis
chrubis@suse.cz
