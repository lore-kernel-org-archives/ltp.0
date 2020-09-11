From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Sep 2020 15:46:45 +0200
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
In-Reply-To: <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
 <20200911095314.GA9505@dell5510>
 <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
Message-ID: <20200911134645.GA4608@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > #include <libaio.h>
> 
> I didn't get any of these on my x86 box :(

That's because you have libaio-devel installed, we test all build
combinations with and without a few system libraries LTP depends on.

-- 
Cyril Hrubis
chrubis@suse.cz
