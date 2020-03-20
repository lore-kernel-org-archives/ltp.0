From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Mar 2020 20:59:30 +0100
Subject: [LTP] [PATCH V7 10/10] syscalls/open_tree: New tests
In-Reply-To: <20200320043548.66orcumbq57wqyzt@vireshk-i7>
References: <6648a9106e367d370012c8ee1d0d81c369779ba8.1584014172.git.viresh.kumar@linaro.org>
 <928553e5fd3518fccb363fb8b6ad079ac3c75fd2.1584090119.git.viresh.kumar@linaro.org>
 <20200313124920.GC6597@rei.lan>
 <20200320043548.66orcumbq57wqyzt@vireshk-i7>
Message-ID: <20200320195930.GA4486@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Here as well, shouldn't we just set the .mount_device flag instead?
> 
> Hi,
> 
> Sorry but I am not sure what will happen by .mount_device here. From
> what I see from tst_test.c, that flag will end up calling SAFE_MOUNT()
> automatically, but what we are calling here is fsmount() and
> move_mount() instead.
> 
> Can you please elaborate a bit on that ? Thanks.

My point here is that most of the code just mounts the device and since
we are testing open_tree() there is no point in mounting the device with
the new mount API in the first half of the run() function, it should
work fine with the device mounted with the plain old mount(). Also we do
OPEN_TREE_CLONE here, so there is no point in mounting the filesystem in
the run() fucntion, moreover it will probably fail with the -i
parameter.

So I'm suggesting to remove the part that mounts the device in the first
half of the test and set the .mount_device flag instead.

-- 
Cyril Hrubis
chrubis@suse.cz
