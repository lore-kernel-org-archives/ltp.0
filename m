From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Jan 2017 13:13:33 +0100
Subject: [LTP] [PATCH v2 4/4] syscalls/setpriority01: Use new user id to
 avoid messing system environment
In-Reply-To: <1481798997-2320-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20161215104356.GB29787@rei.suse.cz>
 <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1481798997-2320-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170104121333.GA7680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> setpriority(PRIO_USER, root_proc, prio) sets the priorities of
> all the root processes to the specified value, though this is
> kind of expected for the test, it impacts the system environment.
> 
> Create a new user and set it privileged, then test with the temp
> user id to ensure the test safety.

I've dropped all the capability stuff from the patch since the call to
setpriority() is now done in the main test process that runs under the
root. The child is create just so that we have a process whoose priority
will be changed.

Pushed with that change, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
