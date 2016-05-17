From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 13:44:04 +0200
Subject: [LTP] [PATCH 1/2] syscalls/pipe01: Cleanup && convert to new
	API.
In-Reply-To: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160517114404.GA12051@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've cleaned up the test even more and pushed, thanks.

The test does not need temporary directory, the SAFE_* macros cannot
fail, etc..

-- 
Cyril Hrubis
chrubis@suse.cz
