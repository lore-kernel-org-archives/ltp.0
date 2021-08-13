From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Aug 2021 17:33:33 +0200
Subject: [LTP] [PATCH 1/3] syscalls/creat08: Convert to new API
In-Reply-To: <YRaNQvWy0uAnnlUU@yuki>
References: <20210806154557.19551-1-mdoucha@suse.cz> <YRZ4TmJWcL8zJgg6@yuki>
 <97c36f43-f567-f384-0c55-4282ed1cd448@suse.cz> <YRaBPzw2Cv1Bo1Ag@yuki>
 <482bfc93-5be1-020d-b3d9-1101a3a32d5e@suse.cz> <YRaNQvWy0uAnnlUU@yuki>
Message-ID: <68c16d3e-09f6-568d-15e2-43685a0619a2@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13. 08. 21 17:18, Cyril Hrubis wrote:
>> If nobody/nogroup + 1 turns out to be root gid (or any group where root
>> is an explicit member), then we may end up with false negatives in the
>> last subtest.
> 
> The root GID is 0 by definition and on my machine root is a member of
> bin group yet the test seems to work fine. I do not get how root having
> the bin group (or nobody+1) in the list of supplementary groups will
> interfere with the test.

Simple: The last test case is checking whether root has an exception
from the setgid bit removal logic that fixed the CVE. This logic is not
applied when the file is being created by a member of the group which
owns the parent directory. If root happens to be an explicit member of
the second group, the last subtest will pass even when the kernel
doesn't apply the root exception properly.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
