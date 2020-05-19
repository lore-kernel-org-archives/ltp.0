From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 May 2020 14:16:17 +0200
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <20200519121617.GA16008@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
You can set the .restore_wallclock flag in the tst_test structure for
these two tests and remove the setup() and cleanup() as well.

Also in the settimeofday02 I would be inclined to just remove the clock
restoration code, since there is no way the tim will be changed unless
the kernel is buggy.

-- 
Cyril Hrubis
chrubis@suse.cz
