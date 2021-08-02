From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Aug 2021 13:43:34 +0200
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the
 device size
In-Reply-To: <YQfZLXZznHjvlGJW@yuki>
References: <20210730133155.31284-1-chrubis@suse.cz>
 <d99456d3-c3d3-a180-7d0c-55bc3042e63c@jv-coder.de>
 <YQfZLXZznHjvlGJW@yuki>
Message-ID: <YQfaZsdzHbPrhCV0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This is not enough. tst_acquire_device__ calls tst_acquire_loop_device, 
> > that again has MAX(size, DEV_SIZE_MB).
> > But it should be sage to substitute it for size ? size : DEV_SIZE_MB as 
> > well.
> 
> Right, that was the old API function to get loop devices which was
> called from old API testcases. Looks like there are no old API tests
> that work with loop devices anymore, so this function should be removed
> from the public API as well. I will send v2 patchset.

Uff, that was tst_acquire_device_() not tst_acquire_loop_device() and
tst_acquire_device_() is still in use.

I'm really looking forward to a day where we can finally remove the old
API from the library...

-- 
Cyril Hrubis
chrubis@suse.cz
