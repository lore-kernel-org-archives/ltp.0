From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 16 Sep 2016 11:22:03 +0300
Subject: [LTP] LTP Release
In-Reply-To: <20160914112947.GA7366@rei>
References: <20160914112947.GA7366@rei>
Message-ID: <57DBABAB.2020702@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 09/14/2016 02:29 PM, Cyril Hrubis wrote:
> Hi!
> I'm more or less finished with pre-release testing. What is the status
> for the rest of you?

Tried the latest master in my sparc setup. Didn't observe any unexpected
failures/issues. Though I use a relatively old kernel, so many test
cases finish with TCONF.

> 
> I guess that we slould fix the lsmod test failing on NFS before the
> release.

I will not be able to proceed with lsmod + NFSv4, since I'll be on
vacation next week. If nobody objects, I'd not treat this as a blocker,
and fix it sometimes after the release.

> 
> Anything else? Can we proceed with the release later this week?
> 
