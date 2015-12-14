From: Cedric Hnyda <chnyda@suse.com>
Date: Mon, 14 Dec 2015 11:07:20 +0100
Subject: [LTP] [PATCH] cgroup_fj/cgroup_fj_stress.sh: Fix failures on
 cgroup unmounted case
In-Reply-To: <1450079865-4596-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1450079865-4596-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <566E94D8.9060807@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 12/14/2015 08:57 AM, Guangwen Feng wrote:
> Test fails when cgroup subsystem is not mounted beforehand because of
> the misused "mounted" in setup(), which doesn't represent the current
> mount status exactly but the mount status before the test, so fix this.

Thank you, you are right.
In previous kernel versions, it was possible to mount cgroups several times.
So actually the best solution would be to remove the option to mount them
several times.
I will send a patch to correct this.

Best,
Cedric

-- 
Cedric Hnyda

