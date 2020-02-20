From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 20 Feb 2020 10:50:58 +0530
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <CAEemH2d9DmK3-1hNH4Y-L+qikN7GXPbtguM7q4AQ__9is2MoPA@mail.gmail.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2d9DmK3-1hNH4Y-L+qikN7GXPbtguM7q4AQ__9is2MoPA@mail.gmail.com>
Message-ID: <20200220052058.opgcrpnmk2clfrmh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-02-20, 13:10, Li Wang wrote:
> I have slightly thought to rename it as 'tst_is_mounted(const char *path)',
> but it also depends on other reviewer's opinion, I have no strong insist
> here.

I didn't apply much brain and just used the name you suggested last :)

Sure, we can name it anything we like. I also thought about
tst_verify_mount() though :)

-- 
viresh
