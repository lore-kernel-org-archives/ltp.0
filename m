From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Jan 2016 19:46:06 +0100
Subject: [LTP] LTP release status
Message-ID: <20160114184606.GA30549@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As you may have seen from the commits to the LTP repo I've did a
numerous LTP builds and runs and fixed most of the problems I've found.

One of the last things on my TODO is to look at the cgroup_fj testcases.
Since some of them still fail on older distributions (and we have still
fixes waiting on ML) and evenmore they take a lot of time since they do
sleep 1 on numerous places (some of them looks pointless to me).

Anyway I will try to make most of the cgroup_fj testcases starting next
week and then I would like to finally proceed with the release.

Now the important part: if you haven't tried the latest LTP git yourself
please do so now and report any problems you find so that we have nice
stable release.

Also if there are any important fixes that you think should be part of
the release please let me know as well. I will have a look.

-- 
Cyril Hrubis
chrubis@suse.cz
