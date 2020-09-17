From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Sep 2020 14:46:04 +0200
Subject: [LTP] [PATCH V2 16/17] syscalls: utimensat: Reuse struct
 time64_variants
In-Reply-To: <a6291552ca99cc5014e98f685e82291bd9a1ecb5.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
 <a6291552ca99cc5014e98f685e82291bd9a1ecb5.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <20200917124604.GB2352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed the changes up to this point as this is a nice cleanup and
the changes are mostly mechanical so it's safe to apply before the
release, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
