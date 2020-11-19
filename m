From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 12:38:16 +0100
Subject: [LTP] [PATCH] realtime/m4: Re-add define for robust mutexattr
 APIs
In-Reply-To: <20201119095227.921830-1-lkml@jv-coder.de>
References: <20201119095227.921830-1-lkml@jv-coder.de>
Message-ID: <20201119113816.GH2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The code switched to the POSIX variants later on so I wonder if we even
need this configure check or if we can remove the ifdefs from the
testcases completely.

-- 
Cyril Hrubis
chrubis@suse.cz
