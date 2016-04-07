From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Apr 2016 16:23:58 +0200
Subject: [LTP] ltp_tbio kernel module fails to build with recent kernel
In-Reply-To: <57039FE1.6080401@free.fr>
References: <57039FE1.6080401@free.fr>
Message-ID: <20160407142357.GD16682@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like the test was broken by kernel commit:

commit 4f024f3797c43cb4b73cd2c50cec728842d0e49e
Author: Kent Overstreet <kmo@daterainc.com>
Date:   Fri Oct 11 15:44:27 2013 -0700

    block: Abstract out bvec iterator

    Immutable biovecs are going to require an explicit iterator. To
    implement immutable bvecs, a later patch is going to add a bi_bvec_done
    member to this struct; for now, this patch effectively just renames
    things.

That moves the a few things into separate structure, which has been added to linux-3.14.

And by:

commit ddad8dd0a162fde61646a627a3017c258601dc8a
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Jan 18 16:16:29 2015 +0100

    block: use blk_rq_map_user_iov to implement blk_rq_map_user

That removed the bio_map_user() which was only wrapper around bio_map_user_io()
which went in to linux-3.20.


These changes does not look particulary scary so it may be relatively easy to
adapt the module to work with newer kernels as well.

-- 
Cyril Hrubis
chrubis@suse.cz
