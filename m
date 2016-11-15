From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 15:20:49 +0100
Subject: [LTP] [PATCH 1/4] syscalls/getpriority01: Cleanup && Convert to
 new API
In-Reply-To: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161115142048.GE13947@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -			if (TEST_RETURN < 0 && TEST_ERRNO != 0) {

Since the default value for priorities is 0, I've changed this check to:

	if (TEST_RETURN != 0 || TEST_ERRNO != 0) {
		...
	}

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
