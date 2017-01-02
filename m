From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Jan 2017 13:31:42 +0100
Subject: [LTP] LTP release && Christmas && New year
In-Reply-To: <20161212132204.GA21779@rei.lan>
References: <20161212132204.GA21779@rei.lan>
Message-ID: <20170102123142.GD20636@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I will be on a time off since the next week so I propose to work on
> merging as many patches as possible this week. Then we will follow up
> with pre-release testing and freeze. I will join the effort once I
> return back to the work which will be Monday 2. 1. 2017. then we will do
> the release a week or two after that. Does that sound OK to everyone?

And I'm back. I will try to do something about implicit function
warnings on older distributions introduced by recent addition of
pread(), pwrite() and getpgid() into the safe macros header, then
do a few runs on different distros/hardware.

Is there anything that should be considered for a release?

I guess that we should merge the fix for aarch64 check in max_map_count
test.

-- 
Cyril Hrubis
chrubis@suse.cz
