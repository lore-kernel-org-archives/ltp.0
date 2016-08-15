From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 17:49:03 +0200
Subject: [LTP] [PATCH 4/8] syscalls/waitpid: make reap_children() fail
 if errno is not ECHILD
In-Reply-To: <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160815154903.GH20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
