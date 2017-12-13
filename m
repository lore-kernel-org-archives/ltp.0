From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Dec 2017 16:10:33 +0100
Subject: [LTP] [PATCH 2/3] posix: aio_cancel: 5-1, 6-1,
 7-1: initialize aio_reqprio
In-Reply-To: <1513079548-23022-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1513079548-23022-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20171213151032.GB19930@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> aiocb is allocated via malloc(), which does not clear the memory.
> aio_write() may fail with EINVAL if aio_reqprio is not properly
> initialized.

The manual pages suggests to zero the whole structure before use either
by using calloc() or with memset(), can we do that instead please?

-- 
Cyril Hrubis
chrubis@suse.cz
