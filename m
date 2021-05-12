From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 16:01:26 +0200
Subject: [LTP] syscalls/mallinfo01 test is broken
In-Reply-To: <9d5d4dc9-ab51-7218-23f3-2ec835210fcf@suse.cz>
References: <9d5d4dc9-ab51-7218-23f3-2ec835210fcf@suse.cz>
Message-ID: <YJvftrFCueG3TXPf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> the mallinfo01 test is failing on some of our test machines because it
> makes wrong assumptions about how malloc() and free() will change the
> number of free chunks (ordblks). I recommend we remove the test from
> runfiles before the upcoming release and fix it later because part of
> the test scenario needs major redesign.

I've started some pre-release testruns and I've seen some failures as
well. I guess that removing it from runtest file and fixing it after
release sounds sane at this point.

-- 
Cyril Hrubis
chrubis@suse.cz
