From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Dec 2017 16:10:57 +0100
Subject: [LTP] [PATCH 3/3] posix: aio_error: 2-1: initialize aio_reqprio
In-Reply-To: <1513079548-23022-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1513079548-23022-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20171213151056.GC19930@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> aio_write() may fail if aio_reqprio is not properly initialized.

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
