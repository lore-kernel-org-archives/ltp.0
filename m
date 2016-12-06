From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Dec 2016 09:54:36 +0100
Subject: [LTP] [PATCH v2 1/1] network/echo01: fix creating existing
 directory
In-Reply-To: <20161205193726.12547-1-pvorel@suse.cz>
References: <20161205193726.12547-1-pvorel@suse.cz>
Message-ID: <20161206085436.GB17241@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> $TCtmp directory is created by cmdlib.sh
> + cleanup: dont set $TCtmp (already set in tst_cleanup in cmdlib.sh)
     ^                                       ^
     setup                                   tst_setup

I've fixed these two and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
