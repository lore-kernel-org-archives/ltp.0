From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Mar 2018 10:50:59 +0100
Subject: [LTP] [PATCH] openposix: mmap/21-1: use all bits set as the
 invalid flag
In-Reply-To: <1519896136-23271-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20180212151755.GA23827@rei>
 <1519896136-23271-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20180301095059.GA3838@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test is trying to trigger EINVAL by passing an invalid flags
> value to mmap(). Linux commit 50a8e840d050 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags")
> introduced a new flag (MAP_SHARED_VALIDATE) and that flag may not be the last one.
> 
> So instead of adding an 'if' for each new flag we use a value with all bits
> set (which is unlikely to be a valid flag).

Acked, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
