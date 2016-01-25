From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2016 13:28:04 +0100
Subject: [LTP] LTP release
In-Reply-To: <20160121174101.GD19851@rei.lan>
References: <20160121174101.GD19851@rei.lan>
Message-ID: <20160125122804.GC30655@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Can we do the release on Monday or Tuesday?

I've just pushed the cgroup_fj fix. Please have a look at it and ideally
run cgroup_fj the tests today, it should take less than hour.

The only two outstanding issues should now be fallocate04 and ROD with
redirection. I will have a look at the fallocate04 patch now, then try
to do something about the ROD redirection.

If nothing else shows up I will tag the git and do the release tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz
