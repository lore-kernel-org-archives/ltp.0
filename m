From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Aug 2021 13:38:21 +0200
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the
 device size
In-Reply-To: <d99456d3-c3d3-a180-7d0c-55bc3042e63c@jv-coder.de>
References: <20210730133155.31284-1-chrubis@suse.cz>
 <d99456d3-c3d3-a180-7d0c-55bc3042e63c@jv-coder.de>
Message-ID: <YQfZLXZznHjvlGJW@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is not enough. tst_acquire_device__ calls tst_acquire_loop_device, 
> that again has MAX(size, DEV_SIZE_MB).
> But it should be sage to substitute it for size ? size : DEV_SIZE_MB as 
> well.

Right, that was the old API function to get loop devices which was
called from old API testcases. Looks like there are no old API tests
that work with loop devices anymore, so this function should be removed
from the public API as well. I will send v2 patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
