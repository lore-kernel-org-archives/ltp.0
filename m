From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 5 May 2020 15:21:28 +0530
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <c63909b8-a666-bf56-c747-78eff8c138b3@163.com>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200430085742.1663-2-yangx.jy@cn.fujitsu.com>
 <20200504051107.edvfiqloegt3ak5o@vireshk-i7>
 <b74eac89-11fc-9a7c-c337-ffe6f19ec7b8@163.com>
 <20200505033507.oerhoby6aif3leea@vireshk-i7>
 <c63909b8-a666-bf56-c747-78eff8c138b3@163.com>
Message-ID: <20200505095128.rc5epchamxcx44pp@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05-05-20, 17:30, Xiao Yang wrote:
> I think TEST() is surplus because fd and TERRNO is enough to finish check
> point.
> 
> It is not an important change and I will keep it if you and Cyril prefer to
> use TEST().


> It is just a possible situation? for example:
> 
> Upstream kernel introduces btrfs filesystem long long ago but the kernel
> 
> of RHEL8 drops btrfs filesystem because of some reasons.

I will let Cyril decide on these :)

Thanks Xiao.

-- 
viresh
