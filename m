From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 26 Jan 2016 12:57:24 +0300
Subject: [LTP] LTP release
In-Reply-To: <20160125122804.GC30655@rei.lan>
References: <20160121174101.GD19851@rei.lan> <20160125122804.GC30655@rei.lan>
Message-ID: <56A74304.8000404@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 01/25/2016 03:28 PM, Cyril Hrubis wrote:
> Hi!
>> Can we do the release on Monday or Tuesday?
>
> I've just pushed the cgroup_fj fix. Please have a look at it and ideally
> run cgroup_fj the tests today, it should take less than hour.

Executed cgroup_fj with an in-house sparc64 kernel - they all passed, 
and the current 4.1-based kernel in Linux for SPARC - the stress tests 
cause a panic (but it's a known not-yet-fixed issue in the kernel).

>
> The only two outstanding issues should now be fallocate04 and ROD with
> redirection. I will have a look at the fallocate04 patch now, then try
> to do something about the ROD redirection.
>
> If nothing else shows up I will tag the git and do the release tomorrow.
>
