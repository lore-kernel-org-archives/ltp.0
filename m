From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Jun 2021 10:03:14 +0200
Subject: [LTP] [PATCH 2/3] syscalls/sendfile: Convert sendfile06 to the
 new API
In-Reply-To: <YMurRVXwyvKXnkjj@pevik>
References: <20210603033611.15619-1-xieziyao@huawei.com>
 <20210603033611.15619-3-xieziyao@huawei.com>
 <YMurRVXwyvKXnkjj@pevik>
Message-ID: <YMxTQliOqBJsYZcu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 1. Convert sendfile06 to the new API with file descriptors instead
> > of socket descriptors.
> I wonder if this is ok, suppose yes, but better if other check.

In kernels before 2.6.33 out_fd had to be a socket. Kernel 2.6.33 went
out somewhere in 2010 which should be more than old enough.

-- 
Cyril Hrubis
chrubis@suse.cz
