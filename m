From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Sep 2021 15:37:45 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YTi8qQOZU3NriZvZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I guess that this is another bug that should be fixed before the
release. I still think that the memory pollution is a best effort
operation and that we should be more conservative with the reserve. I
would go for a few percents of the free memory just to be extra sure
that we do not cause memory pressure.

If we go for 2% we will add following;

safety = MAX(safety, info.freeram / 50);

Also it looks like info.freeram is the same as MemFree: from
/proc/meminfo, I guess that this is not wrong, since memory that have
been used in buffers is dirty enough for our case.

-- 
Cyril Hrubis
chrubis@suse.cz
