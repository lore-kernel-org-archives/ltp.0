From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Dec 2016 13:12:37 +0100
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying
	warnings
In-Reply-To: <1481504194-30726-1-git-send-email-ningx.han@intel.com>
References: <1481504194-30726-1-git-send-email-ningx.han@intel.com>
Message-ID: <20161215121237.GC29787@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -        userdel $TEST_USER1
> +        getent passwd $TEST_USER1 && userdel $TEST_USER1

Shouldn't we redirect the output from getent to /dev/null here?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
