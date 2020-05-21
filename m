From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 May 2020 15:16:04 +0200
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <20200520071630.mfash3ix2u4m7eb3@vireshk-i7>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
 <20200519121617.GA16008@yuki.lan>
 <20200520071630.mfash3ix2u4m7eb3@vireshk-i7>
Message-ID: <20200521131604.GB7833@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also in the settimeofday02 I would be inclined to just remove the clock
> > restoration code, since there is no way the tim will be changed unless
> > the kernel is buggy.
> 
> If I understand it correctly, you now suggested to get rid of the
> .restore_wallclock() flag from 02.c ? I think it is better to keep it as the
> kernel can be buggy and we must get back to a working state in such a case. So,
> I didn't remove it :)

If kernel is buggy, all bets are off and we do not guarantee to leave
the system in an usable state.

-- 
Cyril Hrubis
chrubis@suse.cz
