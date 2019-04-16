From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Apr 2019 17:00:15 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify15: verify fid for dirent
 events
In-Reply-To: <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <2934be190caaaf4bb75caffd731d34711fbf1c61.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416142959.GC20437@rei>
 <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
Message-ID: <20190416150015.GA22754@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Can put this code into an header in the fanotify/ directory along with
> > the event_t structure definiton so that we do not carry two copies of
> > nearly identical code.
> 
> Correct, but I would rather leave the event_t structure private to the test
> because it may have other fields in future tests of similar pattern...
> 
> >
> > If we passed a pointer to the event_t structure instead of the index we
> > can call this function in a loop in the get_object_stats() in
> > fanotify13, right?
> >
> 
> ...so I'd prefer to pass a pointer to fsid and file_handle to helper instead,
> something like:
> void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid, and
> struct file_handle *handle)

Sounds good to me as well.

-- 
Cyril Hrubis
chrubis@suse.cz
