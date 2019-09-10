From: Xu, =?unknown-8bit?b?WWFuZy/lvpAg5p2o?= <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 10 Sep 2019 14:51:56 +0800
Subject: [LTP] LTP Release
In-Reply-To: <20190906130707.GA7515@rei.lan>
References: <20190906130707.GA7515@rei.lan>
Message-ID: <6f8e731c-6e60-0752-2dfe-399494b517b7@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/09/06 21:07, Cyril Hrubis wrote:

> Hi!
> As usually we should start prepare for a release somewhere at the end of
> the September.
>
> I will try to review as much patches as possible next week, then I would
> like to start the pre-release testing. So if there is something that
> really should go in before the release let me know.

Hi Cyril

I think my patch[1][2] to fix statx04 and ueven03 should be merged before the release.
Also my patch[3] to fix cgroup case should be reviewed if you have free time.

[1]https://patchwork.ozlabs.org/patch/1149792
[2]https://patchwork.ozlabs.org/patch/1158763
[3]https://patchwork.ozlabs.org/patch/1113680

Thanks
Yang Xu

>
> I would personally like to get the eBPF tests in, it would be nice if
> anyone could ack the v5.
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190910/5e36f5a6/attachment.htm>
