From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 May 2021 11:11:50 +0200
Subject: [LTP] [PATCH 0/2 v2] syscalls/sendfile: Convert sendfile{08,
 09} to the new API
In-Reply-To: <YK0XBktEIyGkhAsT@pevik>
References: <20210520092449.162043-1-xieziyao@huawei.com>
 <YK0XBktEIyGkhAsT@pevik>
Message-ID: <YK4Q1iJz0/i4ZSxc@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> By accident, I changed
> off_t before_pos, after_pos;
> to:
> OFF_T before_pos, after_pos;
> 
> @Cyril: should it be reverted?

There is a define in the Makefile that defines OFF_T to off64_t for
_FILE_OFFSET_BITS=64 but that looks like a workaround for buggy libc.

The _FILE_OFFSET_BITS=64 should, when code is compiled on 32bit
platform, change the 32bit off_t to a 64bit off_t.

I.e. when you compile following:

int main(void)
{
        printf("%zu\n", sizeof(off_t));
        return 0;
}

on a 32bit (or with -m32) it should print 4
on a 32bit with -D_FILE_OFFSET_BITS=64 it should print 8
on a 64bit it should print 8 regardless

As far as I can tell we should remove the OFF_T handling from the
Makefile here instead.

-- 
Cyril Hrubis
chrubis@suse.cz
