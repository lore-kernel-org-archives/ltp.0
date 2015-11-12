From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2015 15:43:53 +0100
Subject: [LTP] [PATCH] cgroup_fj: add prefix ltp_ to subgroups
In-Reply-To: <1446473617-17331-1-git-send-email-chnyda@suse.com>
References: <1446473617-17331-1-git-send-email-chnyda@suse.com>
Message-ID: <20151112144353.GD19653@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add prefix "ltp_" to the subgroups to make sure
> the tests will not collide with anything else on the
> system.

I've changed also subgroup name in the cgroup_fj_release_agent and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
