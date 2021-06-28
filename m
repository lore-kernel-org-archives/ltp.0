From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Jun 2021 15:08:39 +0200
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
References: <20210628033002.GA1469@andestech.com>
 <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
Message-ID: <YNnJ18Q+cqb8zM5K@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I would like a short comment close to the syncs. When I converted 
> cpuset_regression_test.sh, I would have removed the sync in there, if 
> there wouldn't have been any comment.
> Most of the time syncs are not required and just added by paranoid 
> developers, but if there is a real reason, I think it should be stated 
> in a comment.

Sounds reasonable to me, can we please add a comment there?

-- 
Cyril Hrubis
chrubis@suse.cz
