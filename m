From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Feb 2020 17:23:38 +0100
Subject: [LTP] [PATCH V2] syscalls/pidfd_open: Continue with rest of the
 tests on failure
In-Reply-To: <5E567BD2.302@cn.fujitsu.com>
References: <54a3d6fcef8cfed89a1e4f0b56717f56aa502293.1582611994.git.viresh.kumar@linaro.org>
 <2f579843fb1ff09cfaaa1b991b48437f525740b3.1582673499.git.viresh.kumar@linaro.org>
 <5E567BD2.302@cn.fujitsu.com>
Message-ID: <20200226162337.GB31170@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >   	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> >   		tc->name);
>   Acked-by: Xiao Yang <ice_yangxiao@163.com>

Sorry, missed that one.

-- 
Cyril Hrubis
chrubis@suse.cz
