From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Aug 2021 16:15:39 +0200
Subject: [LTP] [PATCH 1/3] syscalls/creat08: Convert to new API
In-Reply-To: <YRZ4TmJWcL8zJgg6@yuki>
References: <20210806154557.19551-1-mdoucha@suse.cz> <YRZ4TmJWcL8zJgg6@yuki>
Message-ID: <97c36f43-f567-f384-0c55-4282ed1cd448@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13. 08. 21 15:49, Cyril Hrubis wrote:
> Hi!
> Btw, it looks that this is one of the test failing on tubmbleweed, it
> looks like the "bin" group is no longer present on the system.
> 
> Can't we just pick two non-zero numbers for the groupids instead of
> trying to resolve whatever groups are supposed to be on the system?
> 
> We may as well add an library API to request one or two group ids to the
> test library so that they are hardcoded only in a single place.
> 
> See:
> https://progress.opensuse.org/issues/96644
> https://openqa.opensuse.org/tests/1872454

The test passes on regular Tumbleweed, the ticket you've linked is about
JeOS. Yes, this needs to be fixed but I'd leave it to a separate
patchset. The rewrite isn't breaking anything that isn't already broken.
But you can drop the CVE test patch and I'll resubmit it with the new
patchset.

Latest Tumbleweed tests:
https://openqa.opensuse.org/tests/1873051#step/open10/8
https://openqa.opensuse.org/tests/1873529#step/open10/8

We can't pick just any group numbers. The test user (nobody) must be a
member of the first group but not the other. Using nobody/nogroup is
probably safe so for the second group we can just scan all existing
groups and pick for example max(gid)+1.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
