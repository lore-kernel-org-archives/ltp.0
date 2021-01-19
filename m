From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 12:22:17 +0100
Subject: [LTP] [PATCH v3 2/2] cpuset_inherit: Remove redundant
 cpu_string assignment
In-Reply-To: <1610590728-15813-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <X/8ehCeZbWs6TIA4@yuki.lan>
 <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1610590728-15813-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YAbA6S02ishAYhzu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Since the previous patch has got this string from "/sys/devices/system/cpu/online"
> file, we don't need to assign value for cpu_string here. Remove it.

Obviously ok.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
