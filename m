From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 09:09:44 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_SETPRIORITY() && Drop
 redundant space
In-Reply-To: <1479375382-28964-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479375382-28964-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161122080944.GE5620@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I would rather see the whitespace cleanup in a separate patch. It's
harder to track what changes were done in a patch if it combines
unrelated changes.

And also this is 1/2, shouldn't there be a second patch that uses this?

-- 
Cyril Hrubis
chrubis@suse.cz
