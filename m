From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Aug 2021 17:18:26 +0200
Subject: [LTP] [PATCH 1/3] syscalls/creat08: Convert to new API
In-Reply-To: <482bfc93-5be1-020d-b3d9-1101a3a32d5e@suse.cz>
References: <20210806154557.19551-1-mdoucha@suse.cz> <YRZ4TmJWcL8zJgg6@yuki>
 <97c36f43-f567-f384-0c55-4282ed1cd448@suse.cz>
 <YRaBPzw2Cv1Bo1Ag@yuki>
 <482bfc93-5be1-020d-b3d9-1101a3a32d5e@suse.cz>
Message-ID: <YRaNQvWy0uAnnlUU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> We can't pick just any group numbers. The test user (nobody) must be a
> >> member of the first group but not the other. Using nobody/nogroup is
> >> probably safe so for the second group we can just scan all existing
> >> groups and pick for example max(gid)+1.
> > 
> > I guess that simply git for nobody/nogroup + 1 should work well then.
> 
> If nobody/nogroup + 1 turns out to be root gid (or any group where root
> is an explicit member), then we may end up with false negatives in the
> last subtest.

The root GID is 0 by definition and on my machine root is a member of
bin group yet the test seems to work fine. I do not get how root having
the bin group (or nobody+1) in the list of supplementary groups will
interfere with the test.

-- 
Cyril Hrubis
chrubis@suse.cz
