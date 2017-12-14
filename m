From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Dec 2017 14:45:31 +0300
Subject: [LTP] [PATCH 3/3] posix: aio_error: 2-1: initialize aio_reqprio
In-Reply-To: <20171213151056.GC19930@rei>
References: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1513079548-23022-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20171213151056.GC19930@rei>
Message-ID: <1949e7c4-428a-c1ac-27ff-8a8a5c70eda2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you. Will do this shortly.

On 12/13/2017 06:10 PM, Cyril Hrubis wrote:
> Hi!
>> aio_write() may fail if aio_reqprio is not properly initialized.
> 
> Here as well.
> 
