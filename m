From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 25 Jan 2016 13:47:38 +0300
Subject: [LTP] LTP release
In-Reply-To: <20160121174101.GD19851@rei.lan>
References: <20160121174101.GD19851@rei.lan>
Message-ID: <56A5FD4A.407@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 01/21/2016 08:41 PM, Cyril Hrubis wrote:
> Hi!
> Just now I'm testing last set of changes for cgroup_fj tests (in the end
> these were too bugy so I've did a partial rewrite) and once that is done
> and pushed the release is green from my side. Minus the ROD problem that
> I've posted earlier but that can be workarounded for the release.
>
> What is the status from the rest of you?
>
> Can we do the release on Monday or Tuesday?

There is fallocate04 test that is failing on UEK1 (kernel 2.6.32).
I think we need to apply Shuang's patch that fixes it:
[PATCH] syscall/fallocate04:skip test02 before kernel 2.6.38

fallocate() doesn't return EOPNOTSUPP errno there, but silently proceed with
FALLOC_FL_PUNCH_HOLE flag.

Thanks,
Alexey
