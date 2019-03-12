From: Steve Muckle <smuckle@google.com>
Date: Tue, 12 Mar 2019 10:51:36 -0700
Subject: [LTP] [PATCH DRAFT] syscalls/stime: convert to new lib,
 use direct syscall
In-Reply-To: <5C80B40C.7070106@cn.fujitsu.com>
References: <20190202015923.189057-1-smuckle@google.com>
 <20190301144831.GA16823@rei> <5C80B40C.7070106@cn.fujitsu.com>
Message-ID: <25ed5f17-df8a-c7f3-1b75-e301dc9a7f12@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

On 03/06/2019 10:02 PM, Xiao Yang wrote:
> Hi Cyril, Steve
> 
> According to the source code of glibc, glibc implements stime() by
> __NR_settimeofday
> instead of __NR_stime, and some arches(e.g. x86_64) don't define
> __NR_stime directly.
> Therefore these updated tests will be skipped on some arches that don't
> define __NR_stime.
> 
> If glibc implements stime(), should we use it diectly?  If not, should
> we use __NR_stime or __NR_settimeofday?

I think both should be tested. Once Cyril's test multiplex addition goes 
into the test lib there probably needs to be an effort to revisit cases 
like these.

cheers,
Steve
