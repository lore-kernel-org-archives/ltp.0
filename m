From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 14:41:54 +0200
Subject: [LTP] [PATCH 2/2] nfs05: rewrite the test,
 make use of new library
In-Reply-To: <576BD833.7020502@oracle.com>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
 <20160622123017.GC13962@rei.lan> <576BCE87.5070403@oracle.com>
 <20160623115438.GB19250@rei.lan> <576BD833.7020502@oracle.com>
Message-ID: <20160623124154.GA20300@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> And given the fact that we have close(fd) thereafter, should make it
> >> useless...
> > fsync() should cause the page caches to be written to the disk, close()
> > just frees the associated file descriptor and page caches are written on
> > background.
> In case of NFS?

Hmm, looks like in case of NFS the close() has the same effect as
fsync(). Didn't know that.

-- 
Cyril Hrubis
chrubis@suse.cz
