From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Feb 2016 18:31:03 +0100
Subject: [LTP] [PATCH] df01: use the POSIX output format
In-Reply-To: <1455617283-3636-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1455617283-3636-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160217173103.GA16062@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've checked and even the busybox df supports -P so this should work
everywhere, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
